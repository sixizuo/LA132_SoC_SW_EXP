/**
 * @file    demo_apb_dma.c
 * @brief   APB DMA 四种传输通路演示 (查询方式 / 中断方式)
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 * @LastEdit: 2026-11-02  v6:
 *             1) 每完成一次传输回菜单等用户重新选择 (v2)
 *             2) 硬件已改 (2026-11-02): uart_top 空 FIFO 读立即响应并返回 0x00;
 *                apb_bridge 对未译码地址接 dummy slave 立即响应
 *             3) UART 源的两个模式回到 "一次搬 16 字节" (v5)
 *             4) v6: 新增 UART_STAT(0x08) = RX FIFO 字节个数, 模式 3/4 改成
 *                "等到 RX FIFO 里真的攒够 16 个字节" 才启动 DMA。v5 用固定
 *                delay_ms(3000) 猜输入时间, 敲得慢时 3 秒只进来 8 个, DMA 就
 *                带着 8 个 0x00 提前结束了。现在不会提前, 只会等。
 *
 * 来源: user/DMA_Polling_INT.c_back_up
 *
 * 交互 (v6, 菜单驱动):
 *   上电 / 每完成一次 DMA 传输后, 串口都重新打印菜单并阻塞等待选择:
 *       1 = MEM  -> MEM    (一次搬 16 字节)
 *       2 = MEM  -> UART   (一次搬 16 字节, 串口打印 ABCDEFGHIJKLMNOP)
 *       3 = UART -> MEM    (连续敲 16 个字符, 收满即搬, 一次搬 16 字节)
 *       4 = UART -> UART   (连续敲 16 个字符, 收满即搬, 一次搬 16 字节, 回显)
 *       i = 在 "查询 polling" / "中断 interrupt" 之间切换 (切完重打菜单)
 *
 * 为什么 UART 源现在可以"一次搬 16 字节"(重要):
 *   1) 硬件侧 (2026-11-02 改的):
 *      - uart_top.v: 读 UART_DATA 时 RX FIFO 空**也**立即给 apb_pready, 数据返回
 *        0x00; 读指针由 uart_rfifo 内部保护, 空读不推进、不破坏 FIFO.
 *      - uart_top.v + uart_rfifo.v: 新增 UART_STAT(0x08), 读回 RX FIFO 里当前
 *        的字节个数 (0~16), 由 w_ptr-r_ptr 差值算出, 不新增状态寄存器.
 *      - apb_bridge.sv: 未译码地址交给 dummy slave (apb_dummy_slave.sv),
 *        ACCESS 阶段一拍响应, 读回 0、写丢弃; 另有 4096 拍超时兜底.
 *      => 总线不会因为"读空"或"地址空洞"挂死, 更不会把超时补回的旧数据当成
 *         有效字节. 所以 DMA 连读 16 次是安全的: 有数据的读真实字节, 空的读
 *         0x00, 绝不会再出现"同一个字符被重复搬 16 次".
 *   2) 软件侧 (本文件): 先轮询 UART_STAT 确认 RX FIFO 里已经有 16 个字节,
 *      再启动一次 16 字节 DMA. 敲得再慢也不会提前开搬, 也不会出现"只敲 8 个
 *      就结束". 万一超过 60 秒还没敲够, 打印 rx=x/16 后放弃这一轮.
 *
 * 寄存器 (main.h):
 *   dma_src_addr_base 0x300E0000   源地址
 *   dma_dst_addr_base 0x300E0004   目的地址
 *   dma_number        0x300E0008   传输字节数 (实际搬 number 个)
 *   dma_cr_sr         0x300E000C   bit0 = BUSY (写 1 启动), bit1 = 写 1 清中断
 *   dma_cfg           0x300E0010   见下 (依据 dma_top.v 的真实位定义)
 *   dma_int           0x300F0100   DMA 结束标志
 *
 *   dma_cfg 真实位定义 (dma_top.v: 'h10 写入 {int_en,dst_inc,src_inc,word_len}):
 *      bit[4]    int_en      1 = 传输结束产生中断
 *      bit[3]    dst_inc     1 = 目的地址自增
 *      bit[2]    src_inc     1 = 源地址自增
 *      bit[1:0]  word_len    00 = 字节, 01 = 半字, 其它 = 字
 *   常用取值: 0x0C = 字节 + 双自增 (MEM->MEM)
 *             0x04 = 字节 + 源自增 (MEM->FIFO)
 *             0x00 = 字节 + 都不自增 (FIFO->FIFO)
 *   注意: 所谓 "四种通路" 并不是 dma_cfg 里的通道号, 而是 "源/目的地址 +
 *         自增方式" 的组合, 硬件只有一条搬运通路。
 *
 * 现象 (选 1): 串口打印 0x300F0040 处的 16 个字节,
 *             内容应是 0x41 0x42 ... 0x50 (A~P)。
 */
#include "main.h"

#define DMA_SRAM_SRC   0x300F0000u        /* 片内 SRAM 源区 16 字节 */
#define DMA_SRAM_DST   0x300F0040u        /* 片内 SRAM 目的区        */
#define DMA_LEN        16u                /* 每轮搬 16 字节          */
#define DMA_IRQ_LINE   4u                 /* INTC 第 4 根线          */
#define DMA_UART_RX    0x30010000u        /* UART RX FIFO (读)       */
#define DMA_UART_TX    0x30010000u        /* UART TX FIFO (写)       */

static volatile int s_dma_done = 0;

/* DMA 传输结束中断 */
static void dma_isr(void)
{
    *dma_cr_sr    = 0x2;                  /* 清 DMA 中断 */
    *dma_int      = 0x00;
    *intc_int_clr = (1u << DMA_IRQ_LINE);
    s_dma_done    = 1;
}

static void dma_show_dst(void)
{
    int i;
    volatile unsigned char *p = (volatile unsigned char *)DMA_SRAM_DST;

    printf("  0x%08x :", (unsigned int)DMA_SRAM_DST);
    for (i = 0; i < (int)DMA_LEN; i++) {
        printf(" %02x", p[i]);
    }
    printf("\r\n");
}

/*--------------------------------------------------------------------
 *  打开/关闭 DMA 结束中断 (INTC 第 4 线, 电平方式)
 *------------------------------------------------------------------*/
static void dma_int_enable(int on)
{
    if (on) {
        *intc_int_en   |= (1u << DMA_IRQ_LINE);
        *intc_int_pol  |= (1u << DMA_IRQ_LINE);
        *intc_int_edge &= ~(1u << DMA_IRQ_LINE);
    } else {
        *intc_int_en &= ~(1u << DMA_IRQ_LINE);
    }
}

/*--------------------------------------------------------------------
 *  配置并启动一次传输, 然后等它结束 (查询 / 中断)
 *  src/dst : 源/目的地址   cfg : dma_cfg 低 5 位 (不含中断位)
 *  n       : 传输字节数
 *  返回 1 = 完成, 0 = 中断方式下超时
 *------------------------------------------------------------------*/
static int dma_run_one(unsigned int src, unsigned int dst, unsigned int cfg,
                       unsigned int n, int int_mode)
{
    unsigned int guard;

    /* 等上一条搬完 */
    while ((*dma_cr_sr & 0x1) != 0) {
        ;
    }

    *dma_src_addr_base = src;
    *dma_dst_addr_base = dst;
    *dma_cfg           = cfg | (int_mode ? 0x10u : 0x00u);
    *dma_number        = n;

    dma_int_enable(int_mode);

    s_dma_done = 0;
    *dma_cr_sr = 0x1;                     /* 启动 */

    if (int_mode) {
        guard = 0;
        while (!s_dma_done && (++guard < 2000000u)) {
            ;
        }
        return (int)s_dma_done;
    }

    while ((*dma_cr_sr & 0x1) != 0) {     /* 查询 BUSY */
        ;
    }
    return 1;
}

/*--------------------------------------------------------------------
 *  打印菜单并等待用户选择 (返回 '1'~'4')
 *  等待期间可以敲 'i' 切换 查询/中断 方式, 切换后重打菜单继续等
 *------------------------------------------------------------------*/
static unsigned char dma_wait_choice(int *int_mode)
{
    int c;

    for (;;) {
        printf("\r\n-------------- APB DMA --------------\r\n");
        printf("  1 : MEM  -> MEM    (16 bytes at once)\r\n");
        printf("  2 : MEM  -> UART   (16 bytes at once)\r\n");
        printf("  3 : UART -> MEM    (type 16 chars -> 16 bytes at once)\r\n");
        printf("  4 : UART -> UART   (type 16 chars -> 16 bytes at once)\r\n");
        printf("  i : switch mode (now: %s)\r\n",
               *int_mode ? "INTERRUPT" : "POLLING");
        printf("please input 1~4 : ");

        for (;;) {
            c = uart_getchar_nb();
            if (c < 0)
                continue;                 /* 无输入: 继续等 */

            if (c >= '1' && c <= '4') {
                printf("%c\r\n", c);      /* 回显所选项 */
                return (unsigned char)c;
            }
            if (c == 'i' || c == 'I') {
                *int_mode = !*int_mode;
                printf("\r\n[DMA] transfer mode = %s\r\n",
                       *int_mode ? "INTERRUPT" : "POLLING");
                break;                    /* 重打菜单 */
            }
            if (c == '\r' || c == '\n' || c == ' ' || c == '\t')
                continue;                 /* 忽略回车/空白 */
            printf("\r\n[?] '%c' invalid, please input 1~4\r\n", c);
        }
    }
}

/*--------------------------------------------------------------------
 *  模式 1 / 2: 源端数据本来就是齐的, 一次搬 16 字节
 *------------------------------------------------------------------*/
static void dma_mem_mode(unsigned char mode, int int_mode)
{
    int i;
    unsigned int src, dst, cfg;
    const char *name;

    /* 源区填 A..P, 目的区先清 0 */
    for (i = 0; i < (int)DMA_LEN; i++) {
        *(volatile unsigned char *)(DMA_SRAM_SRC + i) = (unsigned char)(0x41 + i);
        *(volatile unsigned char *)(DMA_SRAM_DST + i) = 0x00;
    }

    if (mode == '1') {
        src  = DMA_SRAM_SRC;
        dst  = DMA_SRAM_DST;
        cfg  = 0x0C;                      /* 字节, 源/目的双自增 */
        name = "memory -> memory";
    } else {
        src  = DMA_SRAM_SRC;
        dst  = DMA_UART_TX;               /* 写 TX FIFO */
        cfg  = 0x04;                      /* 字节, 源自增, 目的不自增 */
        name = "memory -> uart";
    }

    printf("[DMA] start: %s, %u bytes, %s\r\n",
           name, DMA_LEN, int_mode ? "interrupt" : "polling");

    if (!dma_run_one(src, dst, cfg, DMA_LEN, int_mode)) {
        printf("[DMA] interrupt done = 0 (timeout)\r\n");
    } else if (int_mode) {
        printf("[DMA] interrupt done = 1\r\n");
    } else {
        printf("[DMA] polling done\r\n");
    }
}

/*--------------------------------------------------------------------
 *  模式 3 / 4: 源是 UART RX FIFO —— 收满 16 个字节后一次搬 16 字节 (v6)
 *
 *  硬件前提 (2026-11-02 已改):
 *    uart_top 读 UART_DATA 时 RX FIFO 空也立即给 pready, 返回 0x00;
 *    读指针由 uart_rfifo 内部保护, 空读不会推进/破坏 FIFO.
 *    新增 UART_STAT(0x08) 读回 RX FIFO 里的字节个数 (0~16).
 *
 *  软件流程 (v6: 用 UART_STAT 判断"收够了", 不再用固定延时猜):
 *    1) 清掉 RX FIFO 里上一轮的残留
 *    2) 轮询 UART_STAT, 直到 count >= 16 (边等边把 rx=x/16 刷在同一行)
 *       敲得慢就一直等, 绝不提前开搬 —— 这是 v5 "只敲 8 个就结束" 的根因
 *    3) 启动一次 16 字节 DMA, 把 FIFO 里 16 个字节全部搬走
 *    超时 60 秒没敲够则打印 rx=x/16 放弃本轮, 回菜单.
 *------------------------------------------------------------------*/
static void dma_uart_mode(unsigned char mode, int int_mode)
{
    int i, n, last;
    unsigned int dst, cfg, waited;
    const char *name = (mode == '3') ? "uart -> memory" : "uart -> uart";

    /* 目的区先清 0, 便于观察 UART->MEM 落点 */
    for (i = 0; i < (int)DMA_LEN; i++) {
        *(volatile unsigned char *)(DMA_SRAM_DST + i) = 0x00;
    }

    /* 1) 清掉 RX FIFO 残留 (读空返回 0x00, 不推进指针, 安全) */
    while ((*uart_ctrl & UART_ST_RX_RDY) != 0u) {
        (void)*(volatile unsigned char *)DMA_UART_RX;
    }

    printf("[DMA] start: %s, %u bytes at once, %s\r\n",
           name, DMA_LEN, int_mode ? "interrupt" : "polling");
    printf("[DMA] please type %u characters (level shown below, no Enter)\r\n",
           DMA_LEN);

    /* 2) 等 RX FIFO 真的攒够 16 个字节 (FIFO 深 16) */
    n    = 0;
    last = -1;
    waited = 0;
    while ((n = (int)(*uart_stat & UART_RX_CNT_MASK)) < (int)DMA_LEN) {
        if (n != last) {                       /* 只在个数变化时刷同一行 */
            printf("\r  rx=%2d/%u ", n, DMA_LEN);
            last = n;
        }
        if (waited >= 600u) {                  /* 600 * 100ms = 60s */
            printf("\r\n[DMA] timeout: rx=%d/%u, aborted\r\n", n, DMA_LEN);
            return;
        }
        delay_ms(100u);
        waited++;
    }
    printf("\r  rx=%2d/%u  <- ready\r\n", n, DMA_LEN);

    /* 3) 一次搬 16 字节 */
    if (mode == '3') {
        dst = DMA_SRAM_DST;
        cfg = 0x08;                 /* 源不自增(读同一 RX FIFO), 目的自增 */
    } else {
        dst = DMA_UART_TX;          /* 16 次都写 TX DATA */
        cfg = 0x00;                 /* 源/目的都不自增 */
    }

    printf("[DMA] go: %u bytes, src=0x%08X dst=0x%08X cfg=0x%02X\r\n",
           DMA_LEN, DMA_UART_RX, dst, cfg);

    if (!dma_run_one(DMA_UART_RX, dst, cfg, DMA_LEN, int_mode)) {
        printf("[DMA] %s done = 0 (timeout)\r\n",
               int_mode ? "interrupt" : "polling");
        return;
    }

    if (int_mode)
        printf("[DMA] interrupt done = 1 (%u bytes in one transfer)\r\n", DMA_LEN);
    else
        printf("[DMA] polling done (%u bytes in one transfer)\r\n", DMA_LEN);
}

void apb_dma_demo(void)
{
    unsigned char mode;
    int int_mode = 0;

    intc_irq_init();
    intc_irq_attach(DMA_IRQ_LINE, dma_isr);

    printf("apb dma demo: one round per choice, menu is shown after each.\r\n");

    for (;;) {
        /* ---- 1) 出菜单, 等用户选这一轮做哪种传输 ---- */
        mode = dma_wait_choice(&int_mode);

        /* ---- 2) 配置并启动这一轮传输 ---- */
        if (mode == '1' || mode == '2')
            dma_mem_mode(mode, int_mode);
        else
            dma_uart_mode(mode, int_mode);

        /* ---- 3) 回读结果, 回到菜单等他选下一轮 ---- */
        dma_show_dst();
        printf("[DMA] transfer finished.\r\n");
    }
}
