/**
 * @file    demo_ddr_test.c
 * @brief   DDR3 1GB 存储空间读写测试
 *
 * ====================================================================
 *  测试对象
 * ====================================================================
 *  DDR3 窗口: CPU 地址 0x4000_0000 ~ 0x7FFF_FFFF (1GB, S3 从属口,
 *  MIG DataWidth=32 / 30bit 地址, 2 x MT41K256M16)。
 *
 *  ⚠ 注意: 测试会**破坏整块 DDR 内容**, 包括 LCD 显存 (FB0=0x4000_0000,
 *  FB1=0x4018_0000)、图案缓冲 (0x4040_0000) 和 axi_dma_memset 的图案
 *  缓存 (0x4040_0000, 其 s_pat_valid 会因此失效)。本 demo **不启动
 *  LCD**, 测完死循环; 要跑显示/触摸 demo 请重新上电 (main.c 换 APP_SEL)。
 *
 * ====================================================================
 *  测试项目 (由浅入深, 每项打印 PASS/FAIL 与耗时)
 * ====================================================================
 *   T0  DMA 版本检查 + 计时器自校准 (rdtimel 计数, 32768 tick/s)
 *   T1  数据线测试    —— 固定地址铺全 0/全 1/0xA5/0x5A/走步 1/走步 0,
 *                         读回比对。抓数据位粘连/断线。
 *   T2  地址线测试    —— 在 0 与每个 2^i 偏移 (i=2..28) 及末字写唯一标记,
 *                         全部写完后再统一读回。抓地址位译码错误/别名。
 *   T3  稀疏覆盖测试  —— 每 1MB 块首/中/尾三字写"地址相关"图案并读回,
 *                         1024 块全覆盖。抓 bank/row 粗粒度译码错误。
 *   T4  DMA 通路测试  —— axi_dma_memcpy 搬 4MB, 抽验 + 报带宽 (KB/s)。
 *   T5  全量覆盖测试  —— (DDR_T_FULL_TEST=1 时) 整个 1GB CPU 逐字写
 *                         地址相关图案 -> 读回; 再取反图案跑一遍。
 *                         每 64MB 打一次进度与耗时。
 *
 *  出错时打印 [ERR/tx] 行 (地址 / 期望 / 实际), 最多报 DDR_T_ERR_MAX 条
 *  就不再刷屏, 但计数继续累计。
 *
 * ====================================================================
 *  结果判读
 * ====================================================================
 *  全部 PASS -> DDR3 控制器 + 颗粒 + 焊接都正常;
 *  T1 挂     -> 数据线 (DQ/DM) 问题, 出错 bit 的规律能定位到具体 DQ;
 *  T2 挂     -> 地址译码问题 (表现为"地址 A 写的数据出现在地址 B");
 *  T3/T5 挂  -> 大概率时序裕量/训练问题, 换温度电压复现更有说服力;
 *  T4 挂但 T1~T3 过 -> AXI-DMAC 通路问题, 与颗粒无关。
 */

#include "demo_ddr_test.h"

#include "PRINTF/printf.h"
#include "LA_TIMER/latimer.h"
#include "axi_dma.h"

/*====================================================================
 *  1. 可调参数
 *==================================================================*/
#define DDR_T_BASE          0x40000000u     /* DDR 窗口基址 */
#define DDR_T_SIZE          0x40000000u     /* 1GB */
#define DDR_T_END           (DDR_T_BASE + DDR_T_SIZE)

#define DDR_T_FULL_TEST     0               /* 1 = 跑 T5 全量覆盖 (需几分钟) */
#define DDR_T_ERR_MAX       40              /* 每项最多打印的错误条数 */
#define DDR_T_PROG_STEP_MB  64              /* T5 每 64MB 报一次进度 */

/* DMA 通路测试参数 */
#define DDR_T_DMA_LEN       (4u * 1024u * 1024u)    /* 4MB */
#define DDR_T_DMA_SRC       (DDR_T_BASE + 0x01000000u)
#define DDR_T_DMA_DST       (DDR_T_BASE + 0x02000000u)

/* 别名探测参数 */
#define DDR_T_ALIAS_OFF     0x00080000u     /* 512KB —— 首轮故障实测的别名偏移 */
#define DDR_T_ALIAS_STEP    0x00010000u     /* 64KB  —— 扫描步长 */
#define DDR_T_MIRROR_OFF    0x20000000u     /* 512MB —— 半区镜像探测偏移 */

/* 系统计数频率: 实测 delay_ms(500) = 16 000 044 tick -> 32 MHz */
#define DDR_T_TICK_HZ       32000000u

/*====================================================================
 *  2. 基础工具
 *==================================================================*/
static uint32_t err_total = 0;              /* 全测试累计错误 */

static inline uint32_t rd32(uint32_t addr)
{
    return *(volatile uint32_t *)addr;
}

static inline void wr32(uint32_t addr, uint32_t val)
{
    *(volatile uint32_t *)addr = val;
}

/** 地址相关测试图案: 两条异或/加法扰动, 行列位都会翻动 */
static inline uint32_t ddr_pat(uint32_t addr)
{
    return (addr ^ 0x5A5A5A5Au) + 0x12345678u;
}

/** 32MHz 计数 -> "x.y 秒" (纯 32 位: 32000 tick = 1 ms) */
static void print_sec(uint32_t ticks)
{
    uint32_t ms = ticks / (DDR_T_TICK_HZ / 1000u);
    printf("%d.%d s", (int)(ms / 1000u), (int)((ms % 1000u) / 100u));
}

/** 比对一字, 不匹配则报错 (限流刷屏) */
static void chk_word(uint32_t addr, uint32_t exp, uint32_t got,
                     const char *tag, uint32_t *err_cnt)
{
    if (got == exp) {
        return;
    }
    (*err_cnt)++;
    err_total++;
    if (*err_cnt <= DDR_T_ERR_MAX) {
        printf("  [ERR/%s] @0x%08x  期望 0x%08x  实际 0x%08x\r\n",
               tag, (unsigned int)addr, (unsigned int)exp, (unsigned int)got);
    }
}

/** 测试项收尾: 打印 PASS/FAIL + 耗时 + 错误数 */
static void report(const char *name, uint32_t ticks, uint32_t err_cnt)
{
    printf("  => %s : %s  (耗时 ", name,
           (err_cnt == 0u) ? "PASS" : "FAIL");
    print_sec(ticks);
    printf(", 错误 %d 字)\r\n", (int)err_cnt);
}

/*====================================================================
 *  3. 各测试项 (返回耗时, 错误数经指针传出)
 *==================================================================*/

/** T1 数据线测试: 固定地址铺各种图案读回比对 */
static uint32_t t1_data_bus(uint32_t *err_out)
{
    static const uint32_t fixed_pats[] = {
        0x00000000u, 0xFFFFFFFFu,
        0xAAAAAAAAu, 0x55555555u,
        0xA5A5A5A5u, 0x5A5A5A5Au,
        0x00FF00FFu, 0xFF00FF00u,
        0x0000FFFFu, 0xFFFF0000u,
    };
    const uint32_t addr = DDR_T_BASE + 0x100u;      /* 避开块边界 */
    uint32_t err = 0, i;
    TIMER_COUNT tc;

    start_count(&tc);

    for (i = 0u; i < sizeof(fixed_pats) / sizeof(fixed_pats[0]); i++) {
        wr32(addr, fixed_pats[i]);
        chk_word(addr, fixed_pats[i], rd32(addr), "T1", &err);
    }
    /* 走步 1: bit0..31 依次置 1 —— 单个 DQ 粘连/断线立刻现形 */
    for (i = 0u; i < 32u; i++) {
        uint32_t p = 1u << i;
        wr32(addr, p);
        chk_word(addr, p, rd32(addr), "T1", &err);
    }
    /* 走步 0: bit0..31 依次清 0 */
    for (i = 0u; i < 32u; i++) {
        uint32_t p = ~(1u << i);
        wr32(addr, p);
        chk_word(addr, p, rd32(addr), "T1", &err);
    }

    *err_out = err;
    return stop_count(&tc);
}

/** T2 地址线测试: 2 的幂偏移写唯一标记, 写完统一读回 (两阶段抓别名) */
static uint32_t t2_addr_bus(uint32_t *err_out)
{
    uint32_t offs[32];
    uint32_t n_offs = 0;
    uint32_t err = 0, i;
    TIMER_COUNT tc;

    offs[n_offs++] = 0u;                            /* 基址 (字偏移) */
    /* 1GB = 2^30 字节 = 2^28 字; 字偏移只能用 2^2..2^27,
     * 2^28 字 = 字节 0x4000_0000 已经跑出 DDR 窗口 (会打到别的从设备!) */
    for (i = 2u; i <= 27u; i++) {
        offs[n_offs++] = (1u << i);
    }
    offs[n_offs++] = (DDR_T_SIZE / 4u) - 1u;        /* 末字 */

    start_count(&tc);

    /* 阶段 1: 全部写入 (标记 = ~字偏移, 天然唯一) */
    for (i = 0u; i < n_offs; i++) {
        wr32(DDR_T_BASE + (offs[i] << 2), ~offs[i]);
    }
    /* 阶段 2: 统一读回 —— 地址线短路/别名会让后写的顶掉先写的 */
    for (i = 0u; i < n_offs; i++) {
        uint32_t a = DDR_T_BASE + (offs[i] << 2);
        chk_word(a, ~offs[i], rd32(a), "T2", &err);
    }

    *err_out = err;
    return stop_count(&tc);
}

/** 细节打印限流 —— 超过 DDR_T_ERR_MAX 条后只计数不再打印 */
static uint32_t dbg_printed = 0;
static uint32_t g_first_alias = 0;          /* T3 里第一个别名地址, 供 T3c 精测 */

static inline int dbg_allow(void)
{
    if (dbg_printed < DDR_T_ERR_MAX) {
        dbg_printed++;
        return 1;
    }
    dbg_printed++;
    return 0;
}

/**
 * T3 逐块诊断: 每 1MB 块首(a0)/中(am, +512KB)/尾(a1) 三字。
 * 与旧版只"写三字再读三字"不同, 这里**每写一个字立刻回读**, 并在写 am/a1
 * 之后**回头再读 a0**, 从而把两类故障分开:
 *   - 丢写 (lost): 写完立刻读就不对      -> 写通路/数据线问题
 *   - 别名 (alias): 写别的字把 a0 顶掉   -> 地址译码/别名问题 (本次实测就是这种)
 */
static uint32_t t3_block_diag(uint32_t *lost_out, uint32_t *alias_out)
{
    const uint32_t n_blocks = DDR_T_SIZE >> 20;     /* 1024 块 */
    uint32_t lost = 0, alias = 0, blk;
    TIMER_COUNT tc;

    start_count(&tc);
    for (blk = 0u; blk < n_blocks; blk++) {
        uint32_t a0 = DDR_T_BASE + (blk << 20);
        uint32_t am = a0 + 0x00080000u;             /* 块中间 (+512KB) */
        uint32_t a1 = a0 + 0x000FFFC0u;             /* 块内最后一个字 */
        uint32_t p0 = ddr_pat(a0);
        uint32_t pm = ddr_pat(am);
        uint32_t p1 = ddr_pat(a1);

        /* --- 首字: 写后立刻读 --- */
        wr32(a0, p0);
        if (rd32(a0) != p0) {
            lost++;
            if (dbg_allow()) {
                printf("  [丢写] @0x%08x 期望 0x%08x 实际 0x%08x\r\n",
                       (unsigned int)a0, (unsigned int)p0, (unsigned int)rd32(a0));
            }
        }

        /* --- 中间字: 写后回读自己 + 回头查 a0 是否被顶掉 --- */
        wr32(am, pm);
        if (rd32(am) != pm) {
            lost++;
            if (dbg_allow()) {
                printf("  [丢写] @0x%08x 期望 0x%08x 实际 0x%08x\r\n",
                       (unsigned int)am, (unsigned int)pm, (unsigned int)rd32(am));
            }
        }
        if (rd32(a0) != p0) {                       /* ★ 关键判据 */
            uint32_t q = ~p0;

            alias++;
            if (g_first_alias == 0u) {
                g_first_alias = a0;                 /* 记下来给 T3c 精测 */
            }
            if (dbg_allow()) {
                printf("  [别名] a0=0x%08x 被 am=0x%08x 顶掉 (读回 0x%08x)\r\n",
                       (unsigned int)a0, (unsigned int)am, (unsigned int)rd32(a0));
            }
            /* 反向验证: 再往 a0 写一个新值, 若 am 跟着变 = 真别名(同一块存储);
             * 若 am 不变 = 只是"读到了相邻行缓冲的内容", 属 DRAM 时序/行切换问题 */
            wr32(a0, q);
            if (dbg_allow()) {
                if (rd32(am) == q) {
                    printf("        -> 反写 a0 后 am 也变成 0x%08x: 真别名 (同一存储)\r\n",
                           (unsigned int)q);
                } else {
                    printf("        -> 反写 a0 后 am 仍是 0x%08x: 仅读错, 疑似行缓冲/时序\r\n",
                           (unsigned int)rd32(am));
                }
            }
            wr32(a0, p0);                           /* 恢复, 免得影响后续判据 */
        }

        /* --- 尾字: 同上 --- */
        wr32(a1, p1);
        if (rd32(a1) != p1) {
            lost++;
            if (dbg_allow()) {
                printf("  [丢写] @0x%08x 期望 0x%08x 实际 0x%08x\r\n",
                       (unsigned int)a1, (unsigned int)p1, (unsigned int)rd32(a1));
            }
        }
        if (rd32(a0) != p0) {
            alias++;
        }
    }

    *lost_out  = lost;
    *alias_out = alias;
    return stop_count(&tc);
}

/**
 * T3b 全 1GB 别名扫描: 以 64KB 为步长, 在 addr 写 P、在 addr+512KB 写 ~P,
 * 回来读 addr —— 若读到 ~P 说明两者是同一块物理存储 (512KB 别名)。
 * 用来精确圈出故障窗口边界 (T3 只测 1MB 网格, 会漏掉窗口内的细节)。
 */
static uint32_t t3b_alias_scan(uint32_t *cnt_out)
{
    uint32_t addr, n = 0, shown = 0;
    const uint32_t step = DDR_T_ALIAS_STEP;
    const uint32_t off  = DDR_T_ALIAS_OFF;
    TIMER_COUNT tc;

    start_count(&tc);
    for (addr = DDR_T_BASE; addr + off < DDR_T_END; addr += step) {
        uint32_t p = addr ^ 0xC0DE0000u;

        wr32(addr, p);
        wr32(addr + off, ~p);
        if (rd32(addr) != p) {
            n++;
            if (shown < 24u) {
                shown++;
                printf("  [别名] 0x%08x <- 0x%08x (读回 0x%08x, 期望 0x%08x)\r\n",
                       (unsigned int)addr, (unsigned int)(addr + off),
                       (unsigned int)rd32(addr), (unsigned int)p);
            }
        }
    }
    *cnt_out = n;
    return stop_count(&tc);
}

/**
 * T3c 别名偏移实测: 在 base 写一个唯一值, 然后在 base+4KB .. base+2MB 内
 * 逐 4KB 找同一个值的落点。找到的偏移就是"地址别名粒度"的实测值,
 * 直接告诉我们哪个地址位没被译码 (如 0x80000 = 512KB = 地址 bit19)。
 */
static uint32_t t3c_probe(uint32_t base, uint32_t *off_out, uint32_t *cnt_out)
{
    uint32_t o, n = 0, first = 0;
    uint32_t q = base ^ 0xA110A110u;
    TIMER_COUNT tc;

    start_count(&tc);
    wr32(base, q);
    for (o = 0x1000u; o <= 0x00200000u; o += 0x1000u) {
        if (rd32(base + o) == q) {
            n++;
            if (first == 0u) {
                first = o;
            }
        }
    }
    *off_out = first;
    *cnt_out = n;
    return stop_count(&tc);
}

/**
 * T6 半区镜像探测: 写低半区若干点, 读 +256MB / +512MB 对应地址。
 * 若读出同一个值, 说明物理容量不足, 高半区是低半区的镜像。
 */
static uint32_t t6_mirror(uint32_t *cnt_out)
{
    uint32_t a, n = 0, shown = 0;
    TIMER_COUNT tc;

    start_count(&tc);
    for (a = DDR_T_BASE; a < DDR_T_BASE + DDR_T_MIRROR_OFF; a += 0x01000000u) {
        uint32_t p = 0x4D495252u ^ a;               /* 'MIRR' ^ 地址, 唯一 */
        wr32(a, p);
        if (rd32(a + DDR_T_MIRROR_OFF) == p) {      /* +512MB 镜像? */
            n++;
            if (shown < 8u) {
                shown++;
                printf("  [镜像] 0x%08x 与 0x%08x 同源 (+512MB)\r\n",
                       (unsigned int)a, (unsigned int)(a + DDR_T_MIRROR_OFF));
            }
        }
    }
    *cnt_out = n;
    return stop_count(&tc);
}

/*====================================================================
 *  T7 故障区精细测绘 (2026-10-21 新增)
 *--------------------------------------------------------------------
 *  上板现象: 0x5C00_0000~0x5CFF_FFFF 与 0x7C00_0000~0x7CFF_FFFF 两段
 *  16MB 里, (addr, addr+512KB) 指向同一份存储。
 *
 *  按 MIG BANK_ROW_COLUMN (DataWidth=32 / BL8) 的地址拆分:
 *      burst   = addr[4:0]        (32 字节)
 *      bank    = addr[7:5]
 *      row     = addr[22:8]       (15 位)
 *      col[9:3]= addr[29:23]      (7 位, 每级 8MB)
 *  换算:
 *      0x1C00_0000 (448MB) -> col[9:3]=56  (物理列 448~455)
 *      0x1C08_0000         -> row=2048, col=56
 *      0x1C10_0000         -> row=4096, col=56
 *      两窗口 = col 56/57 与 120/121, 共同点 col[8:4]=0b11100
 *      +512KB  = row +2048      (row[11])
 *
 *  T7 要回答三件事:
 *    a) 是"写的覆盖"(真别名) 还是"读的错位"(单向)?
 *    b) 同一 col 组内 512KB 步进的 16 个 row 折叠成什么样?
 *    c) 换 DMA 访问同一对地址, 是否同样出错 (分离 CPU/MMU 与 DDR)?
 *==================================================================*/
#define T7_A      0x5C000000u       /* 第一个故障窗口的代表地址 */
#define T7_OFF    0x00080000u       /* 512KB = 该 col 组内 row 方向 +2048 */

/** T7a 方向判别: 区分"写覆盖(真别名)"与"读错位" */
static void t7a_direction(void)
{
    uint32_t a = T7_A;
    uint32_t b = T7_A + T7_OFF;
    uint32_t ra, rb;

    printf("\r\n[T7a] 方向判别 a=0x%08x  b=a+512KB=0x%08x\r\n",
           (unsigned int)a, (unsigned int)b);

    wr32(a, 0xAAAA0001u);
    wr32(b, 0xBBBB0002u);
    ra = rd32(a);
    rb = rd32(b);
    printf("  写 a=AAAA0001, b=BBBB0002 -> rd(a)=0x%08x  rd(b)=0x%08x\r\n",
           (unsigned int)ra, (unsigned int)rb);
    if (ra == 0xAAAA0001u) {
        printf("    判读: a 正常 (b 的写没有影响 a)\r\n");
    } else if (ra == 0xBBBB0002u) {
        printf("    判读: a 读到 b 的值 -> 两者同一存储\r\n");
    } else {
        printf("    判读: a 读到其它值 (丢写/数据错)\r\n");
    }

    /* 只重写 a, 看 b 是否跟着变: 变 => 双向别名, 不变 => 单向 */
    wr32(a, 0xCCCC0003u);
    rb = rd32(b);
    printf("  再只写 a=CCCC0003 -> rd(b)=0x%08x  %s\r\n",
           (unsigned int)rb,
           (rb == 0xCCCC0003u) ? "b 跟着变 => 双向真别名"
                               : "b 未变 => 单向");
}

/** T7b row 方向折叠测绘: col 组内 512KB x16 (8MB) 各写序号, 再读回 */
static void t7b_fold(void)
{
    uint32_t k, got;

    printf("\r\n[T7b] col 组内 512KB x16 (8MB) 写序号后读回\r\n");
    printf("  写:");

    for (k = 0u; k < 16u; k++) {
        wr32(T7_A + k * T7_OFF, 0x50000000u + k);
    }

    printf(" 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15\r\n  读:");
    for (k = 0u; k < 16u; k++) {
        got = rd32(T7_A + k * T7_OFF);
        if ((got >= 0x50000000u) && (got <= 0x5000000Fu)) {
            printf(" %d", (int)(got - 0x50000000u));
        } else {
            printf(" X");
        }
    }
    printf("\r\n  (理想为 0..15 原样; 重复的数字就是折叠关系)\r\n");
}

/** T7c 别名段边界扫描 (64KB 步长, 只打印连续坏段, 不刷屏) */
static void t7c_bounds(uint32_t from, uint32_t span)
{
    uint32_t addr;
    uint32_t end = from + span;
    uint32_t seg = 0u, n = 0u;

    printf("\r\n[T7c] 扫描 0x%08x ~ 0x%08x (64KB 步长)\r\n",
           (unsigned int)from, (unsigned int)(end - 1u));

    for (addr = from; addr + T7_OFF < end; addr += 0x10000u) {
        uint32_t p = addr ^ 0xC0DE0000u;

        wr32(addr, p);
        wr32(addr + T7_OFF, ~p);
        if (rd32(addr) != p) {
            if (n == 0u) {
                seg = addr;
            }
            n++;
        } else if (n != 0u) {
            printf("    坏段 0x%08x ~ 0x%08x  共 %d KB\r\n",
                   (unsigned int)seg, (unsigned int)(addr - 1u), (int)(n * 64u));
            n = 0u;
        }
    }
    if (n != 0u) {
        printf("    坏段 0x%08x ~ 0x%08x  共 %d KB\r\n",
               (unsigned int)seg, (unsigned int)(end - 1u), (int)(n * 64u));
    }
}

/** T7d DMA 交叉验证: 由 DMA 写这对地址, 再由 CPU 读 -> 分离 CPU/MMU 与 DDR */
static void t7d_dma(void)
{
    uint32_t i;
    const uint32_t src1 = 0x41000000u;          /* 正常区, 作 DMA 源 */
    const uint32_t src2 = 0x41002000u;
    volatile uint32_t *p1 = (volatile uint32_t *)src1;
    volatile uint32_t *p2 = (volatile uint32_t *)src2;
    uint32_t ra;

    printf("\r\n[T7d] DMA 交叉验证 (DMA 写故障区, CPU 读)\r\n");

    for (i = 0u; i < 1024u; i++) {
        p1[i] = 0x11111111u;
        p2[i] = 0x22222222u;
    }

    if ((axi_dma_memcpy(src1, T7_A,          4096u, AXI_DMA_DTYPE_WORD) != AXI_DMA_OK) ||
        (axi_dma_memcpy(src2, T7_A + T7_OFF, 4096u, AXI_DMA_DTYPE_WORD) != AXI_DMA_OK)) {
        printf("  !! DMA 搬运失败, 本项跳过\r\n");
        return;
    }

    printf("  DMA 已写: a <- 0x11111111, b <- 0x22222222\r\n");
    ra = rd32(T7_A);
    printf("  CPU 读 a = 0x%08x  %s\r\n", (unsigned int)ra,
           (ra == 0x11111111u) ? "正常 (DMA 也没问题)"
         : ((ra == 0x22222222u) ? "<- 仍是 b 的值 => DDR/MIG 侧别名"
                                : "其它值"));
}

/** T4 DMA 通路测试: CPU 铺 4MB -> DMA 搬运 -> 抽验 + 带宽 */
static uint32_t t4_dma(uint32_t *err_out)
{
    uint32_t err = 0, i;
    TIMER_COUNT tc;
    uint32_t ticks;

    printf("  源 0x%08x -> 目的 0x%08x, %d KB\r\n",
           (unsigned int)DDR_T_DMA_SRC, (unsigned int)DDR_T_DMA_DST,
           (int)(DDR_T_DMA_LEN / 1024u));

    /* 源区铺地址相关图案 (CPU 写) */
    start_count(&tc);
    for (i = 0u; i < DDR_T_DMA_LEN / 4u; i++) {
        uint32_t a = DDR_T_DMA_SRC + (i << 2);
        wr32(a, ddr_pat(a));
    }
    ticks = stop_count(&tc);
    printf("  CPU 铺 4MB 耗时 ");
    print_sec(ticks);
    printf(" (含写带宽参考)\r\n");

    /* DMA 搬运 + 计时 -> 带宽 */
    start_count(&tc);
    if (axi_dma_memcpy(DDR_T_DMA_SRC, DDR_T_DMA_DST, DDR_T_DMA_LEN,
                       AXI_DMA_DTYPE_WORD) != AXI_DMA_OK) {
        printf("  [ERR/T4] axi_dma_memcpy 失败!\r\n");
        err++;
        err_total++;
    }
    ticks = stop_count(&tc);

    if (err == 0u && ticks > 0u) {
        /* KB/s = (bytes/1024) * TICK_HZ / ticks —— 纯 32 位:
         * 4096KB * 32768 = 134217728 < 2^31, 不溢出 (避免 64 位除法) */
        uint32_t kbps = (DDR_T_DMA_LEN / 1024u) * DDR_T_TICK_HZ / ticks;
        printf("  DMA 搬 4MB 耗时 ");
        print_sec(ticks);
        printf(", 带宽约 %d KB/s\r\n", (int)kbps);
    }

    /* 抽验: 每 256KB 抽 1 字 (与源比对) */
    if (err == 0u) {
        for (i = 0u; i < DDR_T_DMA_LEN / 4u; i += 65536u) {
            uint32_t src_a = DDR_T_DMA_SRC + (i << 2);
            uint32_t dst_a = DDR_T_DMA_DST + (i << 2);
            chk_word(dst_a, rd32(src_a), rd32(dst_a), "T4", &err);
        }
    }

    *err_out = err;
    return 0u;                                      /* 耗时已分段打印 */
}

/** T5 全量覆盖: 整个 1GB 写地址相关图案 -> 读回; 再取反一遍 */
static uint32_t t5_full(uint32_t *err_out)
{
    uint32_t err = 0, pass, addr;
    TIMER_COUNT tc;
    uint32_t total_ticks = 0;
    const uint32_t step_mask = ((uint32_t)DDR_T_PROG_STEP_MB << 20) - 1u;

    for (pass = 0u; pass < 2u; pass++) {
        uint32_t inv = (pass == 0u) ? 0u : 0xFFFFFFFFu;

        printf("  第 %d 遍 (%s图案): 写 -> 读回\r\n",
               (int)(pass + 1), (inv ? "取反" : "正相"));

        /* ---- 写 ---- */
        start_count(&tc);
        for (addr = DDR_T_BASE; addr < DDR_T_END; addr += 4u) {
            wr32(addr, ddr_pat(addr) ^ inv);
            if (((addr - DDR_T_BASE) & step_mask) == 0u &&
                addr != DDR_T_BASE) {
                printf("    写到 0x%08x  (累计 ", (unsigned int)addr);
                print_sec(stop_count(&tc));
                printf(")\r\n");
            }
        }
        /* ---- 读 ---- */
        for (addr = DDR_T_BASE; addr < DDR_T_END; addr += 4u) {
            chk_word(addr, ddr_pat(addr) ^ inv, rd32(addr), "T5", &err);
            if (((addr - DDR_T_BASE) & step_mask) == 0u &&
                addr != DDR_T_BASE && err <= DDR_T_ERR_MAX) {
                printf("    读到 0x%08x  (累计 ", (unsigned int)addr);
                print_sec(stop_count(&tc));
                printf(")\r\n");
            }
        }
        total_ticks += stop_count(&tc);
    }

    *err_out = err;
    return total_ticks;
}

/*====================================================================
 *  4. 入口
 *==================================================================*/
void ddr_test_demo(void)
{
    uint32_t err1 = 0, err2 = 0, lost3 = 0, alias3 = 0;
    uint32_t alias3b = 0, mirror6 = 0, err4 = 0, err5 = 0;
    uint32_t t;
    TIMER_COUNT tc;

    (void)err5;                         /* T5 关闭时不使用 */

    printf("\r\n==== DDR3 1GB 读写测试 ====\r\n");
    printf("窗口 0x%08x ~ 0x%08x (%d MB)\r\n",
           (unsigned int)DDR_T_BASE, (unsigned int)(DDR_T_END - 1u),
           (int)(DDR_T_SIZE >> 20));
    printf("警告: 测试破坏 DDR 全部内容 (显存/图案缓冲), 本程序不启动 LCD。\r\n");
    printf("要跑显示/触摸 demo 请改 main.c 的 APP_SEL 后重新编译烧写。\r\n");

    /* ---- T0: DMA 自检 + 计时校准 ---- */
    printf("\r\n[T0] DMA 版本 = 0x%08x (expect 0x%08x) %s\r\n",
           (unsigned int)axi_dma_get_version(),
           (unsigned int)AXI_DMA_VER_EXPECT,
           (axi_dma_get_version() == AXI_DMA_VER_EXPECT) ? "OK" : "!! 不匹配");
    start_count(&tc);
    delay_ms(500);
    t = stop_count(&tc);
    printf("     计时校准: delay_ms(500) = %d tick (32MHz 时约 16 000 000)\r\n",
           (int)t);

    /* ---- T1: 数据线 ---- */
    printf("\r\n[T1] 数据线测试 (固定地址, 10 种固定图案 + 走步 1/0)...\r\n");
    t = t1_data_bus(&err1);
    report("T1 数据线", t, err1);

    /* ---- T2: 地址线 ---- */
    printf("\r\n[T2] 地址线测试 (0 与 2^i 偏移 + 末字, 唯一标记两阶段)...\r\n");
    t = t2_addr_bus(&err2);
    report("T2 地址线", t, err2);

    /* ---- T3: 逐块写读诊断 (丢写 / 别名 分开计数) ---- */
    printf("\r\n[T3] 逐块诊断 (1024 个 1MB 块, 每写一字立即回读, 并回头查首字)...\r\n");
    t = t3_block_diag(&lost3, &alias3);
    printf("  => T3 逐块诊断 : 丢写 %d 字, 别名 %d 字  (耗时 ",
           (int)lost3, (int)alias3);
    print_sec(t);
    printf(")\r\n");
    err_total += lost3 + alias3;

    /* ---- T3b: 全 1GB 512KB 别名扫描 (64KB 步长) ---- */
    printf("\r\n[T3b] 全 1GB 512KB 别名扫描 (步长 64KB, 共 %d 点)...\r\n",
           (int)(DDR_T_SIZE / DDR_T_ALIAS_STEP));
    t = t3b_alias_scan(&alias3b);
    printf("  => T3b 512KB 别名 : %s  (别名点 %d 个, 耗时 ",
           (alias3b == 0u) ? "PASS" : "FAIL", (int)alias3b);
    print_sec(t);
    printf(")\r\n");
    err_total += alias3b;

    /* ---- T3c: 别名偏移实测 (只在 T3 找到别名时做) ---- */
    if (g_first_alias != 0u) {
        uint32_t off = 0, cnt = 0;

        printf("\r\n[T3c] 别名偏移实测: 在 0x%08x 写唯一值, 扫 +4KB..+2MB ...\r\n",
               (unsigned int)g_first_alias);
        t = t3c_probe(g_first_alias, &off, &cnt);
        if (off != 0u) {
            int bit = 0;
            uint32_t v = off;
            while ((v >>= 1) != 0u) { bit++; }      /* 手算 log2, 避免 __builtin_clz */
            printf("  => 同一数据出现在 +0x%x (%d KB) 处, 共 %d 个落点 (耗时 ",
                   (unsigned int)off, (int)(off / 1024u), (int)cnt);
            print_sec(t);
            printf(")\r\n");
            printf("     ★ 别名偏移 0x%x 说明地址 bit%d 没被 DDR 译码\r\n",
                   (unsigned int)off, bit);
        } else {
            printf("  => 未找到副本 (耗时 ");
            print_sec(t);
            printf(")\r\n");
        }
    }

    /* ---- T6: 半区镜像探测 ---- */
    printf("\r\n[T6] 半区镜像探测 (+512MB 对应地址是否同源)...\r\n");
    t = t6_mirror(&mirror6);
    printf("  => T6 半区镜像 : %s  (镜像点 %d 个, 耗时 ",
           (mirror6 == 0u) ? "PASS(无镜像)" : "FAIL(存在镜像)", (int)mirror6);
    print_sec(t);
    printf(")\r\n");
    err_total += mirror6;

    /* ---- T7: 故障区精细测绘 ---- */
    printf("\r\n==== T7 故障区精细测绘 (0x5C000000 / 0x7C000000 两段 16MB) ====\r\n");
    t7a_direction();
    t7b_fold();
    t7c_bounds(0x58000000u, 0x08000000u);        /* 0x5800_0000 ~ 0x5FFF_FFFF */
    t7c_bounds(0x78000000u, 0x08000000u);        /* 0x7800_0000 ~ 0x7FFF_FFFF */
    t7d_dma();

    /* ---- T4: DMA 通路 ---- */
    printf("\r\n[T4] DMA 通路测试...\r\n");
    (void)t4_dma(&err4);
    report("T4 DMA 通路", 0u, err4);

    /* ---- T5: 全量覆盖 (可选) ---- */
#if DDR_T_FULL_TEST
    printf("\r\n[T5] 全量覆盖测试 (1GB x 正相/取反 两遍, 需几分钟)...\r\n");
    t = t5_full(&err5);
    report("T5 全量覆盖", t, err5);
#else
    printf("\r\n[T5] 全量覆盖测试已关闭 (DDR_T_FULL_TEST=0)\r\n");
#endif

    /* ---- 总结 ---- */
    printf("\r\n==== DDR3 测试总结 ====\r\n");
    printf("  T1  数据线      : %s\r\n", (err1 == 0u) ? "PASS" : "FAIL");
    printf("  T2  地址线      : %s\r\n", (err2 == 0u) ? "PASS" : "FAIL");
    printf("  T3  逐块诊断    : 丢写 %d / 别名 %d\r\n", (int)lost3, (int)alias3);
    printf("  T3b 512KB 别名  : %d 点\r\n", (int)alias3b);
    printf("  T6  半区镜像    : %d 点\r\n", (int)mirror6);
    printf("  T4  DMA 通路    : %s\r\n", (err4 == 0u) ? "PASS" : "FAIL");
#if DDR_T_FULL_TEST
    printf("  T5  全量覆盖    : %s\r\n", (err5 == 0u) ? "PASS" : "FAIL");
#endif
    printf("  累计错误 %d 处\r\n", (int)err_total);
    if (err_total == 0u) {
        printf(">>> 全部通过: DDR3 1GB 读写正常!\r\n");
    } else if (lost3 == 0u && (alias3 != 0u || alias3b != 0u)) {
        printf(">>> 全是【别名】类故障: 写 A 的数据出现在 A+512KB。\r\n");
        printf("    说明某个地址位 (512KB = bit19) 没被 DDR 译码, 不是数据线坏。\r\n");
        printf("    重点查: MIG 的 Row/Col/Bank 配置与颗粒型号是否一致、\r\n");
        printf("            该地址位对应的 PCB 走线 (A4) 与焊点。\r\n");
    } else {
        printf(">>> 存在错误, 按 [丢写]/[别名] 行的 地址/期望/实际 定位。\r\n");
    }

    while (1) { ; }
}
