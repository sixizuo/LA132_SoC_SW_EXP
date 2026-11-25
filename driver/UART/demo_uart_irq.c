/**
 * @file    demo_uart_irq.c
 * @brief   串口中断收发: 中断收 + 主循环回显, 带行缓冲/回退/自检命令
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/main.c_uart_irq_vs_0
 *
 *====================================================================
 *  为什么以前的版本在 APP_SEL=9 上串口输出是乱码?
 *====================================================================
 *  三个原因叠在一起, 前两个在 RTL 里能直接看到:
 *
 *  【1】printf 判"发送满"判错了位  —— 乱码的主因
 *      uart_top.v:
 *          assign status = {6'b0, tx_full, !rx_empty};
 *          `UART_CTRL : prdata = status;      // 读 ctrl = 读状态字
 *      所以读 0x30010004 得到的:
 *          bit0 = 接收 FIFO 非空
 *          bit1 = 发送 FIFO 满 (深度 16)
 *          bit3 **永远是 0**
 *      而 bsp/PRINTF/putchar.c 原来写的是
 *          while ((*uart_ctrl & 0x8) == 0x8) ;   // 等 bit3
 *      这个 while 一次都进不去 -> 完全不看 FIFO 满不满 ->
 *      连着 printf 十几、几十个字节 (本 demo 开头的 banner 就是),
 *      16 深的发送 FIFO 立刻被顶满, 后面的字节要么被 APB 写卡住,
 *      要么直接丢, 终端收到的就是缺字/串码 —— 也就是"乱码"。
 *
 *  【2】中断和主循环抢同一个接收 FIFO  —— 卡死/错位
 *      原 uart_handler 是
 *          do { c = *uart_data; ... } while (*uart_ctrl & 1);
 *      先读后判。而 data 读的 apb_pready 是
 *          (rx_done || !rx_empty) && rd
 *      FIFO 空着读一次, pready 永不拉高, AXI2APB 桥在 state 2 死等,
 *      整个 CPU 卡死。什么时候会"空着进中断"? 主循环
 *      uart_getchar_nb() 也去读硬件 FIFO: 主循环看到非空 ->
 *      中断抢先把字节取走 -> 主循环再读就是空的。电平中断 +
 *      双重读取, 这个竞态随打字随时可能发生。
 *      现在的做法: 先判非空再读 (interrupt.c), 并且开了中断接收后
 *      主循环只用环形缓冲 (uart_irq_rx_mode(1)), 不碰硬件。
 *
 *  【3】在中断里 printf  —— 拖长中断
 *      115200 下一个字符 ~87 us, 中断里打印会把中断拉长几十倍,
 *      期间 FIFO 又有新字节进来, 叠在一起更容易丢/串。
 *      现在中断只做"读空 FIFO + 塞环形缓冲", 打印全在主循环。
 *
 *====================================================================
 *  ★ 接收(__RX__)曾整体晚采 1 位 —— 已在 RTL 修掉, 实测 bad=0
 *====================================================================
 *  【修复前实测】(2026-10-31, PC 连发 "test\r\n"/"status\r\n"/"count\r\n")
 *      字节数一个不少(6/6、8/8、7/7 全收到), 但**每个命令只有第 1 个
 *      字符是对的, 后面全是固定错值**, 三次测试完全一样:
 *          发 "test"    收  t [B2][B9][BA][86][85]
 *          发 "status"  收  s [B0][BA][BA][B9][86][85]
 *          发 "count"   收  c [EF][BA][B7][BA][86][85]
 *      把所有错值套进同一个公式, 5 个字节全中:
 *          收到 = (发出 >> 1) | 0x80
 *          'e' 0x65 -> 0xB2    's' 0x73 -> 0xB9    't' 0x74 -> 0xBA
 *          CR  0x0D -> 0x86    LF  0x0A -> 0x85
 *      即读到的 8 位其实是 "b1..b7 + 停止位", 是**确定性的采样点错位**,
 *      不是噪声、不是丢字节。
 *
 *  【根因】apb_uart/uart_rx.v 的状态机算法问题
 *      进 START_ST 时 b_reg=0, 判据却是 "b_reg == 3" 才转 DATA_ST,
 *      所以 START 段要数满 4 个 b_tick(正好 1 bit); 进 DATA_ST 后又数
 *      4 个 b_tick 才采第 1 个数据位。合起来
 *          start 沿 + 8 tick = +2 bit      (应该是 +1.5 bit, b0 中心)
 *      而 b0 的窗口是 [+1 bit, +2 bit), 采样点正好压在 b0/b1 边界上。
 *      板上一位 = 4 tick = 4*70 clk @32MHz = 8.75us (114286 baud),
 *      PC 一位 = 8.68us (115200), 板子慢 0.79%; 2 bit 的 17.50us 已经
 *      越过 PC 侧 b1 起点 17.36us -> 采样点稳稳落进 b1。
 *
 *  【修法, 已实施】uart_rx.v 里 START_ST 的判据 3 -> 1
 *      只数 2 个 tick(0.5 bit)就转 DATA_ST, 采样序列变成
 *          +0.5/+1.5/.../+9.5 bit
 *      全部落在每一位正中。不动 baudgen, 不影响发送方向, 一行改动。
 *
 *  【修复后实测】(2026-10-31, 新 bit)
 *      test / status / count 三条命令全部正确回显;
 *      count 报 "rx total=20 printable=15 bad=0 (0%) -> RX clean";
 *      再发 64 字节长串, bad 仍为 0, drop=0。
 *
 *  本 demo 保留"可见诊断"设计, 以后再出问题能一眼看出来:
 *      · 收到不可打印字节(0x00~0x1F, 0x7F~0xFF) 立刻打印 [XX]
 *      · 心跳里带 bad= 计数, 能直接看误码率
 *
 *====================================================================
 *  现象
 *====================================================================
 *  上电打印 banner 和 "ready";
 *  敲任意键 -> 原样回显, 同时最低位 LED 翻转;
 *           如果是误码字节, 回显 [XX] (十六进制原值);
 *  回车 -> 提交一行, 支持命令:
 *      help    打印帮助
 *      status  打印 UART 状态寄存器 (验证 bit 定义)
 *      test    连续打印 3 行 64 字符, 检查 TX 不丢字
 *      count   打印收字节总数 / 可打印数 / 误码数 / 回车数
 *    其他内容原样回报 "(echo: xxx)"
 *  每秒一个 "." 心跳; 每 5 秒换行报告统计。
 */
#include "main.h"

/*====================================================================
 *  接收方式开关
 *    0 = 主循环轮询 (默认)
 *    1 = INTC 线 0 中断
 *
 *  ★ 为什么默认改成轮询 (2026-10-31 实测结论)
 *    INTC 的 one_int_gen.v 对面电平中断的处理有两个硬伤:
 *      1) 边沿模式下 `count` 只在第一个上升沿置 1, 且那个沿只喂 count
 *         不置 int_lt -> **第一个边沿被吞掉**, 之后要等第二次边沿。
 *         实测设 int_edge=1 后 rx 恒为 0, 一个字节都收不到。
 *      2) 电平模式下 int_out 直接跟随 int_in, 一旦 RX FIFO 里有残留
 *         字节没被读掉, 请求就永远挂着 -> 中断风暴 (实测 40 秒内累积
 *         488 万次中断), 主循环被饿死。
 *    而 UART 本身非常适合轮询: status.bit0 是组合输出 (assign status =
 *    {6'b0, tx_full, !rx_empty}), 读 ctrl 无副作用 (pready 无条件拉高);
 *    接收 FIFO 深 16, 115200 下一字 87 us, 16 字 = 1.4 ms 缓冲,
 *    主循环 1 ms 轮询一次绝对够。所以默认用轮询, 稳且不丢字。
 *
 *    把下面这个宏改成 1 即可切回中断方式 (interrupt.c 里的
 *    uart_handler 已加"进中断先屏蔽该线、读完再打开、读不掉就永久
 *    关线转轮询"的自愈保护, 不会再出现无法退出的风暴)。
 *==================================================================*/
#define UART_RX_USE_IRQ 0

#define LINE_MAX        64

static char         s_line[LINE_MAX];
static int          s_len = 0;
static int          s_led = 0;

/* 累计收到的字节数 (只用于显示, 不参与逻辑) */
static unsigned int s_rx_total = 0;

/* 接收质量统计: 用来量化 RX 误码率
 *   s_rx_print : 落在 0x20~0x7E 的可打印字符
 *   s_rx_bad   : 其余值 (0x00~0x1F / 0x7F~0xFF), 基本都是位采样误码
 *   s_rx_cr    : 被识别成行结束 (\r / \n) 的次数
 * 正常通信时 s_rx_bad 应该恒为 0; 它一旦上涨就说明 RX 有位错误。 */
static unsigned int s_rx_print = 0;
static unsigned int s_rx_bad   = 0;
static unsigned int s_rx_cr    = 0;

/* 硬件级诊断: 主循环每次看到 status.bit0=1 就 +1。
 * 它跟 s_rx_total 的区别是: 
 *   s_rx_seen  证明"硬件 FIFO 里确实进过字节" (RX 引脚/波特率 OK)
 *   s_rx_total 证明"软件确实把它取出来了"     (驱动逻辑 OK)
 * 两个数一对, 就能分清是"串口线没数据"还是"程序没读到"。 */
static unsigned int s_rx_seen = 0;

/** 打一个字节的十六进制 (不依赖 printf 的 %02X 宽度支持) */
static void put_hex2(unsigned int v)
{
    const char *hx = "0123456789ABCDEF";

    uart_putc((unsigned char)hx[(v >> 4) & 0x0Fu]);
    uart_putc((unsigned char)hx[v & 0x0Fu]);
}

static int str_eq(const char *a, const char *b)
{
    while (*a != '\0' && *b != '\0') {
        if (*a != *b) {
            return 0;
        }
        a++;
        b++;
    }
    return (*a == '\0' && *b == '\0');
}

static void print_status(void)
{
    unsigned int st = *uart_ctrl;

    /* 串口输出一律用 ASCII: 终端如果是 GBK 编码, 发 UTF-8 中文会显示成
     * 一堆乱码, 排查问题时容易把"编码问题"误判成"串口丢字节"。 */
    printf("UART status = 0x%08x\r\n", st);
    printf("  bit0 RX FIFO not-empty = %d\r\n", (int)(st & UART_ST_RX_RDY));
    printf("  bit1 TX FIFO full      = %d\r\n", (int)((st >> 1) & 1u));
    printf("  bit3 (old code: TX busy) = %d  <- always 0\r\n", (int)((st >> 3) & 1u));
}

static void print_help(void)
{
    printf("commands: help | status | test | count | fault\r\n");
}

/** 访问"不存在的地址" —— 验证 apb_bridge 的超时保护
 *
 *  地址怎么选 (很重要, 选错就测不到东西):
 *    · 0x4000_0000 ~ 0x7FFF_FFFF  -> DDR3 (mask 0xC000_0000), 是真器件。
 *      旧版这条命令用 0x5200_0000, 正好落在 DDR 里, 读写都成功, 看着像
 *      "保护生效"其实什么都没测到。
 *    · 0x2000_0000 / 0x2001_0000  -> AXI-LCD / AXI-DMAC 64KB 窗口。
 *    · 其余地址                    -> 全部送 APB 桥。
 *      其中 APB 段只译码 0x3000_0000~0x3010_FFFF 和 0x3200_0000 /
 *      0x3300_0000 (见 apb_addr.svh)。所以 **0x3020_0000** 会进 APB 桥,
 *      但没有任何 slave 命中 s_psel -> 旧的 apb_bridge 永远等不到 pready,
 *      AXI2APB 停在 state 2, CPU 死等 -> 整机停机, 连 LALINK 都进不去。
 *      修复后: 4096 clk (128us @32MHz) 强制完成, 读回 0, CPU 继续跑。
 *
 *  判据: 这条命令打完以后心跳还在 = 超时保护生效; 并且紧接着对
 *  0x5200_0000 (真 DDR) 读写仍正常 = 保护不会误伤正常访问。
 *  注意 rresp 恒为 OKAY (设计如此), 读空洞返回 0 而不是总线错误 ——
 *  目的是"不死等", 不是"报警"。
 *
 *  ★ 第二个坑 (2026-10-31 实测): 只在 apb_bridge 里加计数器还不够 ——
 *  godson_mcu_cpu.v 的 A_apb_mux_cpu 例化**从来没接 apb_clk / apb_rstn**
 *  (综合报 Synth 8-7071 / 8-7023: 声明 18 个连接只给了 16 个)。没有时钟的
 *  always_ff 被整段优化掉, 网表里 to_cnt 一个单元都没有 -> 加了等于没加,
 *  地址照样把整机打死。补上 .apb_clk(clock) / .apb_rstn(resetn) 后才生效。
 *  判断"改动到底进没进芯片"的办法: open_checkpoint 后
 *      get_cells -hier -filter {NAME =~ *to_cnt*}
 *  另外"跨过时钟但要数拍"的模块一律像这样检查, 别只看综合成功。
 *
 *  本版实测 (bit godson_mcu_top_1031_apbtime.bit):
 *      [1] 0x3020_0000  read -> 0, 写丢弃, 心跳继续
 *      [2] 0x5200_0000  DDR  w/r -> 0xa5a5a5a5, 正常访问不受影响
 *      连跑 3 次 fault 仍 alive, rx/bad 统计不变
 */
#define FAULT_ADDR_HOLE 0x30200000u   /* APB 段内、无 slave 译码 */
#define FAULT_ADDR_DDR  0x52000000u   /* DDR 窗口内、真器件 */

static void print_fault_test(void)
{
    volatile unsigned int *p = (volatile unsigned int *)FAULT_ADDR_HOLE;
    volatile unsigned int *q = (volatile unsigned int *)FAULT_ADDR_DDR;
    unsigned int v;

    printf("[1] APB hole @ 0x%08x (no slave decodes)\r\n", FAULT_ADDR_HOLE);
    printf("    read  -> 0x%08x\r\n", *p);
    *p = 0x12345678u;
    v = *p;
    printf("    w/r   -> 0x%08x (expect 00000000)\r\n", v);

    printf("[2] DDR      @ 0x%08x (real device)\r\n", FAULT_ADDR_DDR);
    *q = 0xa5a5a5a5u;
    v = *q;
    printf("    w/r   -> 0x%08x (expect a5a5a5a5)\r\n", v);

    printf("alive -> APB timeout works, normal access intact\r\n");
}

/** 接收质量统计: bad 恒 0 说明 RX 通路完全可靠 */
static void print_rx_stat(void)
{
    unsigned int pct = 0;

    if (s_rx_total != 0u) {
        pct = (s_rx_bad * 100u) / s_rx_total;
    }
    printf("rx total = %u, printable = %u, bad = %u (%u%%), cr = %u\r\n",
           s_rx_total, s_rx_print, s_rx_bad, pct, s_rx_cr);
    if (s_rx_bad == 0u) {
        printf("  -> RX clean\r\n");
    } else {
        printf("  -> RX bit errors: uart_rx samples at a fixed offset\r\n");
        printf("     because baudgen is free-running (see file header)\r\n");
    }
}

/** 连打 3 行 64 字符: 只要有一处丢/串, 一眼就能看出来 */
static void print_test_pattern(void)
{
    const char *p = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz<>";
    int i, n;
    int len = 0;

    while (p[len] != '\0') {
        len++;
    }

    for (n = 0; n < 3; n++) {
        for (i = 0; i < len; i++) {
            uart_putc((unsigned char)p[i]);
        }
        uart_puts("\r\n");
    }
}

/** 提交一行命令 */
static void run_line(void)
{
    if (s_len == 0) {
        return;
    }
    s_line[s_len] = '\0';

    if (str_eq(s_line, "help")) {
        print_help();
    } else if (str_eq(s_line, "status")) {
        print_status();
    } else if (str_eq(s_line, "test")) {
        print_test_pattern();
    } else if (str_eq(s_line, "count")) {
        print_rx_stat();
    } else if (str_eq(s_line, "fault")) {
        print_fault_test();
    } else {
        printf("(echo: ");
        uart_puts(s_line);
        printf(")\r\n");
    }
    s_len = 0;
}

void uart_irq_demo(void)
{
    int c;
    unsigned int ms = 0;
    unsigned int sec = 0;

    /* ---------- 1. 状态自检 ---------- */
    printf("\r\n---- UART IRQ demo ----\r\n");
    print_status();

    /* ---------- 2. 打开中断接收 ---------- */
    /* 上电/复位瞬间串口线上会有几十个噪声字节自己跑进 RX FIFO,
     * 不清掉的话 rx 计数一上来就是几十, 看起来像"收到了垃圾"。
     * 这里按"先判非空再读"把硬件 FIFO 倒空 (空读会把 APB 挂死),
     * 再用 uart_rx_flush() 把软件环也清干净。 */
    {
        int n = 0;
        while (((*uart_ctrl & UART_ST_RX_RDY) != 0u) && (n++ < 64)) {
            (void)(*uart_data);
        }
    }
    uart_rx_flush();
    s_rx_total = 0;
    s_rx_seen  = 0;
    s_rx_print = 0;
    s_rx_bad   = 0;
    s_rx_cr    = 0;

#if UART_RX_USE_IRQ
    uart_irq_rx_mode(1);        /* 硬件 FIFO 交给 uart_handler 独占 */

    intc_irq_init();            /* EBase / VS / HWI4 / 全局 IE */
    *intc_int_en   = 0x0001;    /* INTC 线 0 = UART */
    *intc_int_pol  = 0x0001;    /* 高有效 (uart_irq = !rx_empty) */
    *intc_int_edge = 0x0000;    /* **电平**方式, 边沿模式会吞第一个沿 */
#else
    uart_irq_rx_mode(0);        /* 主循环直接轮询硬件 FIFO */
#endif

    /* LED 低 8 位做输出, 每收到一个字节翻转最低位 */
    *gpioa_dir = 0x00fff0ff;
    *gpioa_led = 0x00;

    printf("ready. type `help` + Enter; bad bytes show as [XX]\r\n");
    printf("rx mode = %s (change UART_RX_USE_IRQ in demo_uart_irq.c)\r\n",
           UART_RX_USE_IRQ ? "IRQ" : "polling");

    /* ---------- 3. 主循环: 只从环形缓冲取, 不碰硬件 FIFO ---------- */
    for (;;) {
        while ((c = uart_getchar_nb()) >= 0) {
            s_rx_total++;

            if (c == '\r' || c == '\n') {
                s_rx_cr++;
                uart_puts("\r\n");
                run_line();
            } else if (c == 0x7f || c == '\b') {
                if (s_len > 0) {
                    s_len--;
                    uart_puts("\b \b");     /* 回退: 退格 + 空格 + 退格 */
                }
            } else if (c >= 0x20 && c < 0x7f) {
                s_rx_print++;
                if (s_len < (LINE_MAX - 1)) {
                    s_line[s_len++] = (char)c;
                    uart_putc((unsigned char)c);   /* 逐字回显, 直接写 UART */
                }
            } else {
                /* 不可打印字节 = 极可能是 RX 位采样误码。
                 * 直接把它以 [XX] 打出来, 让误码"看得见":
                 * 正常通信时这里永远不会进; 一旦频繁出现,
                 * 就是 uart_rx 采样点偏移导致的位错误。 */
                s_rx_bad++;
                uart_putc('[');
                put_hex2((unsigned int)c);
                uart_putc(']');
            }

            s_led ^= 1;
            *gpioa_led = (unsigned char)s_led;
        }

        /* 心跳: 1 ms 粒度累加, 不阻塞等待, 打字不会被卡住 */
        delay_ms(1);

        /* 顺带采一次硬件状态: 这一行就是"RX 到底有没有进数据"的铁证 */
        if ((*uart_ctrl & UART_ST_RX_RDY) != 0u) {
            s_rx_seen++;
        }

        if (++ms >= 1000) {
            ms = 0;
            uart_putc('.');
            if (++sec >= 5) {
                sec = 0;
                /* seen = 硬件非空的采样次数; rx = 实际取出的字节数;
                 * bad = 解码成非可打印字节的个数 (RX 误码, 正常应为 0);
                 * st = 当前 status (bit0 非空 / bit1 发送满);
                 * irq = 进过几次中断 (轮询模式下应恒为 0);
                 * drop = 环形缓冲满丢的字节; pdrop = 发送侧超时丢弃 */
                printf("\r\n[hb rx=%u bad=%u seen=%u st=0x%02x irq=%u drop=%u pdrop=%u]\r\n",
                       s_rx_total,
                       s_rx_bad,
                       s_rx_seen,
                       (unsigned int)(*uart_ctrl & 0x03u),
                       uart_rx_irq_count(),
                       uart_rx_drop_count(),
                       uart_putc_drop());
            }
        }
    }
}

/*====================================================================
 *  附: 接收错位的 RTL 修复记录 (已实施, 已出 bit, 已实测)
 *====================================================================
 *  文件: src_ascii/hw/peripheral/apb_uart/uart_rx.v
 *  (备份 uart_rx.v.bak_20261031)
 *
 *  原代码 (START_ST 分支):
 *          START_ST: begin
 *              if (b_tick) begin
 *                  if (b_reg == 3) begin        // ← 数满 4 tick = 1 bit
 *                      next_state = DATA_ST;
 *                      b_next = 4'b0;
 *                      count_next = 3'b0;
 *                  end else begin
 *                      b_next = b_reg + 1'b1;
 *                  end
 *              end
 *          end
 *
 *  改成:
 *                  if (b_reg == 1) begin        // ★ 3 -> 1, 数 2 tick = 0.5 bit
 *
 *  为什么: b_reg 从 0 起, 数到 3 需要 4 个 b_tick; DATA_ST 里又数 4 个
 *  才采第一位, 于是第一位落在 start 沿 +2 bit (b0/b1 边界)。改成 1 之后
 *  START 段只占 0.5 bit, 第一位落在 +1.5 bit = b0 正中, 之后每隔一整位
 *  采样一次, 依次是 b1..b7、停止位的正中。
 *
 *  改动影响面: 只影响接收采样时刻。发送走 uart_tx/b_tick, 完全不碰;
 *  baudgen、fifo、apb 接口都不用动。0.79% 的波特率偏差在采样点居中后
 *  累积到第 8 位只有 0.067 bit, 余量充足。
 *
 *  验证:
 *    1) iverilog 对比仿真, 新旧两版同时收 "test\r\n" —— 新版 6/6 全对,
 *       老版复现出 0xB4 (相当于板上看到的整体移位);
 *    2) 出 bit (LA132_DDR_LCD_1g, non-project 流程) 后烧板实测:
 *       test / status / count 全部正确, bad=0, drop=0。
 *
 *  注意: 这块板子的 bit 里同时固化了本程序 (coe/apb_write.coe 由
 *  build/la132_demo.bin 生成), 下载 bit 即自动运行, 不需要再用
 *  openocd 下载。详细原因见下方"coe 启动"说明。
 *==================================================================*/

/*====================================================================
 *  附: 为什么程序被固化进 bit 的 coe 里
 *====================================================================
 *  flash BRAM (blk_mem_gen_0, 32Kx32 @0x1C000000) 每次配置 FPGA 都从
 *  coe/apb_write.coe 预加载。原来那份 coe 是**按旧地址映射编译的**老
 *  程序, 一上电就去访问 0x5200_0000 (新工程里这个地址已经没有从设备),
 *  AXI 总线被挂死, 连 LALINK 都进不去调试模式:
 *      Warn : target was in unknown state when halt was requested
 *      Error: Failed to enter Debug Mode!
 *  把 coe 换成当前 bin 之后:
 *      · 上电即跑当前程序, 不再有跑飞风险;
 *      · 下载 bit 就等于下载程序, 不需要 openocd 那一步;
 *      · 串口、心跳、命令全部正常。
 *  重新生成 coe 用 coe/gen_coe.sh (小端 32 位字, 见脚本内注释)。
 *  代价: 改完软件要重新出一次 bit (综合+实现约 20 分钟)。
 *==================================================================*/
