/**
 * @file    demo_axi_lcd_dma.c
 * @brief   AXI LCD + AXI DMA 演示程序 (LA132 裸机)
 *
 *  本文件已随工程一起放在 sw/driver/AXI_LCD_DMA/ 下,
 *  Makefile 里 SRCDIR = find driver/ 会自动把该目录纳入编译,
 *  因此**不需要改 Makefile**。只需在 user/main.c 里声明并调用:
 *
 *      void axi_lcd_dma_demo(void);
 *      ...
 *      axi_lcd_dma_demo();
 *
 *  地址 (与 hw/config.vh 一致):
 *      AXI-DMAC 配置寄存器  0x2001_0000
 *      AXI-LCD  配置寄存器  0x2000_0000
 *      DDR3 / LCD 显存      0x4000_0000
 *      (旧 APB DMA 仍在 0x910E_0000, 由 driver/DMA/dma.c 使用, 互不干扰)
 *
 *  演示流程:
 *      [1] CPU 直接画 8 条色带           —— 验证 像素 <-> 显存 映射
 *      [2] DMA 行拷贝 + 回读比对         —— 验证 DMAC 读写 DDR
 *      [3] 标定图 (calibration figure)   —— 一次性判定画面朝向 / 居中 / 是否裁切
 *      [4] 双缓冲扫掠动画                —— 验证 帧同步 + 连续 DMA 填充
 *
 *====================================================================
 *  V3.0 变更说明 —— 修「[3] 白框 / [4] 动画 效果不对」
 *====================================================================
 *  上板(V2.1)后的现象与原因:
 *
 *  1) [3] 的白框画在 [1] 的 8 条色带上, 而 s_bar[0] 恰好是 WHITE
 *     -> 左边框与左上角方块落在白色条上, 完全看不见, 看起来"框是断的"。
 *     改法: [3] 先用 DMA 把整屏刷成深灰, 再画白色几何, 对比度拉满。
 *
 *  2) [4] 的换色表 s_cycle[0] = WHITE, 而且**每一步都整屏换一次色**
 *     -> 每 500 ms 一次 2 Hz 全屏频闪: 观感刺眼, 而且轮到白色那一步
 *        外框 + 白条在纯白底上全部隐形, 只剩一片白。
 *        真正想表达的"条在动"反而被频闪盖住了。
 *     改法: 底色**每扫完一整轮才换一次**(约 3 秒), 不再频闪。
 *
 *  3) 前景与底色可能同色 -> 改为按底色亮度自动挑黑或白 (BT.601),
 *     任何底色上外框与移动条都清晰可见。
 *
 *  4) 条宽 24 px 在 4.3" 屏上太细, 每步 40 px 与屏宽 800 不整除
 *     (gcd(40,772)=4), 回绕点会漂移。改法: 条宽 40 px,
 *     每步 20 px, 40 步正好扫完 800 px —— 整除, 无漂移。
 *
 *  5) ★ 关键: 上板实测(手机竖拍视频 + 亮度网格量化)发现 LCD 亮区
 *     宽:高 ≈ 0.5 ~ 0.55, 而 RTL 驱动的是 800x480 (宽:高 = 1.67)。
 *     也就是说**画面扫到玻璃上的朝向与作图坐标系很可能差 90 度**
 *     (面板竖装, 或面板原生 480x800 被当成 800x480 驱动)。
 *     这会让"白色竖条"看起来是横条、"外框"位置也对不上预期 ——
 *     单靠改配色解决不了, 必须先把这个几何关系测准。
 *     改法: [3] 换成**标定图**: 四个角的方块尺寸各不相同
 *     (左上 96 > 右上 64 > 右下 40 > 左下 20, 顺时针递减),
 *     正中央十字 + 中心点, 上边缘一排 6 个刻度块。
 *     看一眼 (或拍一张) 就能确定:
 *         - 有没有被旋转 90 / 180 度
 *         - 有没有被镜像
 *         - 有没有被裁掉边缘 (外框是否闭合)
 *         - 画面是否居中
 *     确定之后, 只要把下面 DEMO_ROT 设成对应值即可(预留), 或者
 *     调整 RTL 的 H/V 时序参数。
 *==================================================================*/

#include "axi_lcd.h"
#include "axi_dma.h"
#include "PRINTF/printf.h"
#include "LA_TIMER/latimer.h"

/*--------------------------------------------------------------------
 * DDR3 存储布局 (字节地址)
 *   FB0 : 0x4000_0000 ~ 0x4017_6FFF   一帧 1 536 000 B (0x17_7000)
 *   FB1 : 0x4018_0000 ~ 0x402F_6FFF   第二缓冲, 与 FB0 不重叠
 *   图案: 0x2040_0000                 见 axi_dma.h 的 AXI_DMA_MEMSET_BUF
 *------------------------------------------------------------------*/
#define DEMO_FB0            0x40000000u
#define DEMO_FB1            0x40180000u
#define DEMO_FB_BYTES       AXI_LCD_FB_BYTES

#define DEMO_W              ((int)AXI_LCD_WIDTH)    /* 800 */
#define DEMO_H              ((int)AXI_LCD_HEIGHT)   /* 480 */

/* [3] 标定图底色: 深灰 —— 既不是纯黑(便于分辨"没显示"与"画了深底"),
 * 又能让白色几何有最大对比度 */
#define DEMO_CAL_BG         AXI_LCD_RGB(0x14, 0x14, 0x18)

/*--------------------------------------------------------------------
 * [4] 动画参数
 *   DEMO_SWEEP_STEPS * DEMO_BAR_STEP 必须正好等于屏宽 (800),
 *   这样每一轮都精确扫满一整屏, 没有回绕漂移 (下面有静态断言)。
 *------------------------------------------------------------------*/
#define DEMO_SWEEP_STEPS    40      /* 一轮 = 40 步 */
#define DEMO_BAR_STEP       20      /* 每步右移 20 像素 */
#define DEMO_BAR_W          40      /* 条宽 40 像素 */
#define DEMO_STEP_MS        300      /* 每一步额外等待 (DMA 本身还要几十 ms) */

typedef char demo_sweep_must_fit[(DEMO_SWEEP_STEPS * DEMO_BAR_STEP == (int)AXI_LCD_WIDTH)
                                 ? 1 : -1];

/* 换色表: 特意不含 BLACK —— 任何时刻停下来都不会是黑屏 */
static const uint32_t s_cycle[7] = {
    AXI_LCD_WHITE, AXI_LCD_CYAN,  AXI_LCD_MAGENTA, AXI_LCD_YELLOW,
    AXI_LCD_RED,   AXI_LCD_GREEN, AXI_LCD_BLUE
};
#define DEMO_CYCLE_N        ((int)(sizeof(s_cycle) / sizeof(s_cycle[0])))

/* [1] 的 8 条色带, 每条 100 像素宽 (校验 像素-显存 映射) */
static const uint32_t s_bar[8] = {
    AXI_LCD_WHITE, AXI_LCD_YELLOW, AXI_LCD_CYAN,  AXI_LCD_GREEN,
    AXI_LCD_MAGENTA, AXI_LCD_RED,  AXI_LCD_BLUE,  AXI_LCD_BLACK
};

/*--------------------------------------------------------------------
 * 显存小工具
 *------------------------------------------------------------------*/
static inline void fb_put(uint32_t base, int x, int y, uint32_t rgb888)
{
    *(volatile uint32_t *)(base + (((uint32_t)y * AXI_LCD_WIDTH + (uint32_t)x) << 2))
        = (rgb888 & 0x00FFFFFFu);
}

static inline uint32_t fb_get(uint32_t base, int x, int y)
{
    return *(volatile uint32_t *)(base + (((uint32_t)y * AXI_LCD_WIDTH + (uint32_t)x) << 2))
           & 0x00FFFFFFu;
}

/**
 * 按底色亮度挑前景色 (BT.601 整数加权), 保证任何底色上都看得清。
 * 亮底 -> 黑字, 暗底 -> 白字。
 */
static uint32_t fg_on(uint32_t bg)
{
    uint32_t r = (bg >> 16) & 0xFFu;
    uint32_t g = (bg >>  8) & 0xFFu;
    uint32_t b =  bg        & 0xFFu;
    uint32_t y = (r * 299u + g * 587u + b * 114u) / 1000u;

    return (y >= 140u) ? AXI_LCD_BLACK : AXI_LCD_WHITE;
}

/** 填一个矩形 (自动裁剪到屏幕内, 越界不写) */
static void draw_rect(uint32_t base, int x0, int y0, int w, int h, uint32_t c)
{
    int x, y;

    for (y = y0; y < y0 + h; y++) {
        if (y < 0 || y >= DEMO_H) {
            continue;
        }
        for (x = x0; x < x0 + w; x++) {
            if (x < 0 || x >= DEMO_W) {
                continue;
            }
            fb_put(base, x, y, c);
        }
    }
}

/** 闭合外框, 线宽 t 像素 */
static void draw_frame(uint32_t base, uint32_t c, int t)
{
    draw_rect(base, 0, 0, DEMO_W, t, c);                    /* 上 */
    draw_rect(base, 0, DEMO_H - t, DEMO_W, t, c);           /* 下 */
    draw_rect(base, 0, 0, t, DEMO_H, c);                    /* 左 */
    draw_rect(base, DEMO_W - t, 0, t, DEMO_H, c);           /* 右 */
}

/** 竖直粗条 (画在外框内侧, 不破坏外框闭合) */
static void draw_vbar(uint32_t base, int x0, int w, uint32_t c)
{
    draw_rect(base, x0, 6, w, DEMO_H - 12, c);
}

/*--------------------------------------------------------------------
 * [1] 8 条色带
 *------------------------------------------------------------------*/
static void draw_bars(uint32_t base)
{
    int x, y;

    for (x = 0; x < DEMO_W; x++) {
        uint32_t c = s_bar[(x / 100) & 7];
        for (y = 0; y < DEMO_H; y++) {
            fb_put(base, x, y, c);
        }
    }
}

/*--------------------------------------------------------------------
 * [3] 标定图
 *   判读方法 (按"屏幕上看"的顺序念一遍):
 *     外框    : 四条边都闭合 = 边缘没被裁
 *     四角方块: 左上最大(96) > 右上(64) > 右下(40) > 左下(20)
 *               顺时针递减 —— 若不按这个顺序, 说明画面被旋转或镜像
 *     中心     : 正中央一个白十字 + 中心点
 *     上边刻度 : 6 个刻度块, 中心 x = 150..650 (间隔 100), 整排对称于中线
 *------------------------------------------------------------------*/
static void draw_calib(uint32_t base)
{
    const uint32_t fg = AXI_LCD_WHITE;
    int i;

    /* 1) 闭合外框, 5 像素 —— 四条边都闭合 = 边缘没被裁 */
    draw_frame(base, fg, 5);

    /* 2) 四角方块, 尺寸按顺时针递减 96 > 64 > 40 > 20
     *    —— 判画面有没有被旋转 / 镜像: 从左上按顺时针念一遍尺寸即可 */
    draw_rect(base, 8,              8,               96, 96, fg);   /* 左上 最大 */
    draw_rect(base, DEMO_W - 8 - 64, 8,               64, 64, fg);   /* 右上 */
    draw_rect(base, DEMO_W - 8 - 40, DEMO_H - 8 - 40, 40, 40, fg);   /* 右下 */
    draw_rect(base, 8,              DEMO_H - 8 - 20, 20, 20, fg);   /* 左下 最小 */

    /* 3) 中心十字 + 中心点 —— 判居中 */
    draw_rect(base, DEMO_W / 2 - 60, DEMO_H / 2 - 1, 121, 3, fg);
    draw_rect(base, DEMO_W / 2 - 1, DEMO_H / 2 - 60, 3, 121, fg);
    draw_rect(base, DEMO_W / 2 - 5, DEMO_H / 2 - 5, 11, 11, fg);

    /* 4) 上边缘刻度尺: 6 个 20x30 刻度块, 整排以屏幕中线 x = 400 对称
     *    中心 x = 150 / 250 / 350 / 450 / 550 / 650 (间隔 100)
     *    首块左边缘 x=140 —— 距左上角 96px 方块(右边缘 x=104) 有 36px 空隙
     *    末块右边缘 x=660 —— 距右上角 64px 方块(左边缘 x=728) 有 68px 空隙
     *    判读: 整排刻度中心应与屏幕中线、中心十字的竖线共线 */
    for (i = 0; i < 6; i++) {
        draw_rect(base, 140 + i * 100, 14, 20, 30, fg);
    }
}

/* 比对两个地址各自第 0 行的前 n 个字, 返回第一个不同的横坐标 (-1 = 全同) */
static int cmp_row0(uint32_t src, uint32_t dst, int n)
{
    int i;

    for (i = 0; i < n; i++) {
        if (fb_get(src, i, 0) != fb_get(dst, i, 0)) {
            return i;
        }
    }
    return -1;
}

/*====================================================================
 *  演示主流程
 *==================================================================*/
void axi_lcd_dma_demo(void)
{
    int      step, ncol, bad, bar_x, prog_w;
    int      rc;
    uint32_t st, cur, back, color, fg;

    printf("\r\n==== AXI LCD + AXI DMA demo (V3.0) ====\r\n");

    /* ---------------- (0) 自检 ---------------- */
    printf("LCD ID      = 0x%08x (expect 0x%08x)\r\n",
           axi_lcd_read(AXI_LCD_REG_ID), AXI_LCD_ID_EXPECT);
    printf("LCD RES     = 0x%08x (H=%d, V=%d)\r\n",
           axi_lcd_get_res(), DEMO_W, DEMO_H);
    printf("LCD FB_SIZE = %d bytes\r\n", (int)axi_lcd_get_fb_bytes());
    printf("DMA VER     = 0x%08x (expect 0x%08x)\r\n",
           axi_dma_get_version(), AXI_DMA_VER_EXPECT);

    if (axi_lcd_probe() != 0) {
        printf("!! LCD probe failed, abort\r\n");
        return;
    }
    if (axi_dma_get_version() != AXI_DMA_VER_EXPECT) {
        printf("!! AXI DMAC not found, abort\r\n");
        return;
    }

    /* ---------------- (1) 8 条色带 ---------------- */
    printf("\r\n[1] CPU draw 8 color bars -> FB0 @ 0x%08x\r\n", DEMO_FB0);
    draw_bars(DEMO_FB0);
    printf("    pixel(  0,0) = 0x%08x (expect WHITE 0x%08x)\r\n",
           fb_get(DEMO_FB0, 0, 0), AXI_LCD_WHITE);
    printf("    pixel(200,0) = 0x%08x (expect CYAN  0x%08x)\r\n",
           fb_get(DEMO_FB0, 200, 0), AXI_LCD_CYAN);
    printf("    pixel(799,0) = 0x%08x (expect BLACK 0x%08x)\r\n",
           fb_get(DEMO_FB0, 799, 0), AXI_LCD_BLACK);

    /* ---------------- (2) 启动 LCD ---------------- */
    axi_lcd_set_fmt(AXI_LCD_FMT_RGB888);
    axi_lcd_set_fb(DEMO_FB0);
    /* 注意: 当前 RTL 里 REG_CTRL[7:4] 是保留位, 真正生效的启动阈值是
     * 模块参数 PREFILL (例化为 256 字), 这里写 8 只是让控制字好看,
     * 不改变行为 —— 详见 axi_lcd.h 里本函数的说明 */
    axi_lcd_set_prefill_thresh(8);
    axi_lcd_clear_status();
    axi_lcd_start();
    printf("    LCD started: CTRL = 0x%08x\r\n",
           axi_lcd_read(AXI_LCD_REG_CTRL));

    delay_ms(200);
    st = axi_lcd_get_status();
    printf("    LCD STATUS = 0x%08x  fill=%d  frame=%d  underrun=%d\r\n",
           st,
           (int)((st & AXI_LCD_ST_FILL_MSK) >> AXI_LCD_ST_FILL_POS),
           (st & AXI_LCD_ST_FRAME)    ? 1 : 0,
           (st & AXI_LCD_ST_UNDERRUN) ? 1 : 0);

    printf("    >>> 现在屏上应是 8 条色带 (每条 100 像素宽):\r\n");
    printf("        白 黄 青 绿 品红 红 蓝 黑\r\n");
    printf("        停 3 秒。完全看不到 = 像素通路有问题, 与 DMA/显存无关。\r\n");
    delay_s(3);

    /* ---------------- (3) DMA 行拷贝 + 回读校验 ---------------- */
    printf("\r\n[2] DMA copy row0 -> row240 (%d bytes)\r\n", (int)(AXI_LCD_WIDTH * 4u));
    rc = axi_dma_memcpy(DEMO_FB0,
                        DEMO_FB0 + (240u * AXI_LCD_WIDTH * 4u),
                        AXI_LCD_WIDTH * 4u,
                        AXI_DMA_DTYPE_WORD);
    printf("    rc = %d, done = %d bytes\r\n",
           rc, (int)axi_dma_get_done_bytes());

    bad = cmp_row0(DEMO_FB0, DEMO_FB0 + (240u * AXI_LCD_WIDTH * 4u), DEMO_W);
    if (bad < 0) {
        printf("    PASS: row240 == row0 (%d words all match)\r\n", DEMO_W);
    } else {
        printf("    FAIL: first mismatch at x=%d (row0=0x%08x row240=0x%08x)\r\n",
               bad, fb_get(DEMO_FB0, bad, 0),
               fb_get(DEMO_FB0 + (240u * AXI_LCD_WIDTH * 4u), bad, 0));
    }
    printf("    >>> 屏上第 240 行应与第 0 行完全相同\r\n");
    delay_s(2);

    /* ---------------- (4) 标定图 ---------------- */
    printf("\r\n[3] calibration figure (deep-grey bg + white geometry)\r\n");
    rc = axi_dma_memset(DEMO_FB0, DEMO_CAL_BG, DEMO_FB_BYTES);
    printf("    DMA fill bg: rc = %d, done = %d bytes\r\n",
           rc, (int)axi_dma_get_done_bytes());
    draw_calib(DEMO_FB0);
    printf("    >>> 请看屏幕, 按下面 5 条逐条核对:\r\n");
    printf("        (a) 白色外框四条边是否都闭合 (有没有被裁掉)\r\n");
    printf("        (b) 四角方块 左上(96) > 右上(64) > 右下(40) > 左下(20),\r\n");
    printf("            从左上顺时针念下来尺寸应递减;\r\n");
    printf("            顺序不对 = 画面被旋转或被镜像\r\n");
    printf("        (c) 正中央是否有一个白十字 + 中心点\r\n");
    printf("        (d) 上边缘是否有 6 个刻度块, 整排以中线对称\r\n");
    printf("            (中心 x = 150/250/350/450/550/650), 且首块不与左上角方块粘连\r\n");
    printf("        (e) 画面是否居中, 有没有整体偏移\r\n");
    printf("        (a)~(e) 有任何一条不符, 说明画面被旋转/镜像/裁切,\r\n");
    printf("        请把屏幕拍一张照发我, 我据此定坐标变换。\r\n");
    delay_s(8);

    /* ---------------- (5) 扫掠动画 ---------------- */
    printf("\r\n[4] double-buffered sweep animation\r\n");
    printf("    FB0 = 0x%08x   FB1 = 0x%08x\r\n", DEMO_FB0, DEMO_FB1);
    printf("    底色每 %d 步(约 %d ms)换一次, 不再整屏频闪;\r\n",
           DEMO_SWEEP_STEPS, DEMO_SWEEP_STEPS * DEMO_STEP_MS);
    printf("    前景色按底色亮度自动取黑/白, 任何底色上都看得清;\r\n");
    printf("    %d px 宽的条每步右移 %d px, 每轮正好扫满一整屏\r\n",
           DEMO_BAR_W, DEMO_BAR_STEP);
    printf("    底部进度条显示本轮扫掠进度。动画不结束, 复位键可重来\r\n\r\n");

    ncol = DEMO_CYCLE_N;
    cur  = 0u;                       /* 当前正在被扫描的是 FB0 */

    for (step = 0; ; step++) {
        int sweep_i = step % DEMO_SWEEP_STEPS;

        /* 画到"后台"那块显存 */
        back  = (cur == 0u) ? DEMO_FB1 : DEMO_FB0;
        color = s_cycle[(step / DEMO_SWEEP_STEPS) % ncol];
        fg    = fg_on(color);

        /* 整屏刷底色 —— 同一颜色在 40 步里复用, memset 内部的图案缓冲
         * 缓存会把 32KB 的 CPU 铺写省掉 */
        rc = axi_dma_memset(back, color, DEMO_FB_BYTES);
        if (rc != AXI_DMA_OK) {
            printf("!! DMA memset failed at step=%d (rc=%d)\r\n", step, rc);
            break;
        }

        /* DMA 写进去的颜色回读校验 (抽 1 个点, 够快) */
        if (fb_get(back, 400, 240) != (color & 0x00FFFFFFu)) {
            printf("!! DMA write verify failed: got 0x%08x expect 0x%08x\r\n",
                   fb_get(back, 400, 240), color);
            break;
        }

        /* 移动条 + 底部进度条, 外框最后画以保证任何时刻都是闭合矩形 */
        bar_x = sweep_i * DEMO_BAR_STEP;
        draw_vbar(back, bar_x, DEMO_BAR_W, fg);

        prog_w = (int)(((uint32_t)(bar_x + DEMO_BAR_W) * (uint32_t)(DEMO_W - 40))
                       / (uint32_t)DEMO_W);
        draw_rect(back, 20, DEMO_H - 40, prog_w, 10, fg);    /* 本轮扫掠进度 */

        draw_frame(back, fg, 5);

        /* 等一个帧边界再切显存基址: 接缝只落在帧首, 且只有预取
         * 环形缓冲那么大 (512 字 ≈ 0.64 行), 基本看不出来 */
        if (axi_lcd_wait_frame(4000000u) != 0) {
            printf("!! wait_frame timeout at step=%d\r\n", step);
        }
        axi_lcd_set_fb(back);
        cur ^= 1u;

        if ((step < 3) || (sweep_i == 0)) {
            st = axi_lcd_get_status();
            printf("    step %4d  color=0x%08x  fg=0x%08x  bar_x=%3d  underrun=%d  fill=%d\r\n",
                   step, color, fg, bar_x,
                   (st & AXI_LCD_ST_UNDERRUN) ? 1 : 0,
                   (int)((st & AXI_LCD_ST_FILL_MSK) >> AXI_LCD_ST_FILL_POS));
        }

        delay_ms(DEMO_STEP_MS);
    }

    printf("demo stopped.\r\n");
    while (1) {
        ;
    }
}
