/*
 * @Author: yx
 * @Date: 2024-10-13
 * @LastEditors: WorkBuddy
 * @LastEditTime: 2026-10-31
 * @Description: 串口库函数
 * @Version: V1.1.0.261031
 */

#include "uart.h"
#include "main.h"

/*====================================================================
 *  诊断计数器 (2026-10-31 加)
 *  排查"收到一个字节就死"时, 让心跳带上这几个数, 一眼区分:
 *    没进中断 / 进了中断但没退出 / 发送侧被丢字节
 *==================================================================*/
static volatile unsigned int s_irq_cnt  = 0;   /* UART 中断次数 */
static volatile unsigned int s_rx_drop  = 0;   /* 环形缓冲满丢字节 */
static volatile unsigned int s_putc_drop = 0;  /* TX 满超时丢字节 */

unsigned int uart_rx_irq_count(void)  { return s_irq_cnt;   }
unsigned int uart_rx_drop_count(void) { return s_rx_drop;   }
unsigned int uart_putc_drop(void)     { return s_putc_drop; }

void uart_irq_count_inc(void)
{
    s_irq_cnt++;
}

/**
 * @description: 串口中断初始化 (打开 INTC 第 0 根线)
 * @return {*}
 */
void uart_interrupt_init(void) {
    *intc_int_en |= 0x01;
}

/**
 * @description: 串口波特率初始化
 *   2026-10-30 新增。原工程只有 uart_interrupt_init(), 没有任何地方
 *   设置波特率, 于是 RTL 的 baudgen.v 一直停在复位默认值:
 *       baudtick_ctrl = 00 -> 832 分频 -> 9600 bps
 *   而终端按 115200 收, 整帧采样错位, 看起来像"程序跑飞/串口没输出"。
 *   必须在第一次 printf 之前调用。
 *
 *   baudgen.v 的分频表:
 *       00 -> 832 -> 9600      01 -> 416 -> 19200
 *       10 -> 208 -> 38400     11 ->  69 -> 115200
 *   uart_ctrl(0x30010004): bit[1:0] 选波特率, bit2 = 校验位使能
 *
 * @param {int} baudrate 9600 / 19200 / 38400 / 115200
 * @param {int} odd      0 = 偶校验(默认), 1 = 奇校验
 */
void uart_init(int baudrate, int odd)
{
    unsigned int sel;

    switch (baudrate) {
        case 19200:  sel = UART_BAUD_19200; break;
        case 38400:  sel = UART_BAUD_38400; break;
        case 115200: sel = UART_BAUD_115200; break;
        case 9600:
        default:     sel = UART_BAUD_9600; break;
    }
    *uart_ctrl = (sel & 0x3u) | (odd ? UART_PARITY_EN : 0u);

    /* ---- 切完分频必须等一小会儿再发第一个字节 ----
     * baudgen.v 是 "count_reg 数到 counting_targets 归零" 的结构:
     *   assign count_next = (count_reg == counting_targets) ? 0 : count_reg + 1;
     * 复位后 baudtick_ctrl = 00 -> target 832。如果程序在 count_reg
     * 已经数到 (比如) 500 的时候把 target 改成 69, 由于 69 != count_reg,
     * 它必须一路数到 832 才归零, 这期间的 b_tick 是停的, 之后才按
     * 69 的节奏走。这段时间里发出的第一个字节位宽是错的, 终端解出来
     * 就是乱码 —— 也就是上电后第一行 printf 变成 "C??????j" 那种。
     * 等 ~3 ms (32000 个空转 @32MHz) 覆盖最坏情况(832 周期≈26us)+余量。
     * 这里不用 delay_ms, 免得 uart.c 反过来依赖定时器驱动。 */
    {
        volatile unsigned int i;
        for (i = 0; i < 32000u; i++) {
            ;
        }
    }

    /* ---- 冲刷 TX 通道 (2026-10-31 实测补充) ----
     * 光等待还不够: 实测切到 115200 之后, 最先发出去的 3 个字节仍然按
     * 旧的 9600 节奏走, 终端按 115200 解出来就是每行开头那串 "C??????j"
     * (9600 的 1 个字节能被 115200 解成 12 个乱字符, 3 字节正好 36 个)。
     * 因为 baudgen 的 b_tick 是"count_reg 数到 target 才产生", 切换瞬间
     * tx 正在移位的那一位会被拉长, 后面 3 个字节的位宽都错。
     *
     * 做法: 先灌 4 个 0x00 把"坏节奏"用掉 (NUL 在终端上不可见, 不脏屏),
     * 等发送 FIFO 排空再返回。这样调用者发出的第一个真实字符一定是
     * 新波特率 —— 上电 banner 的第一行就是干净的。
     * 注意: 写 data 的前提是 TX FIFO 不满 (满时写 pready 不拉高会卡总线),
     * 所以每次都先等 bit1 清零, 并带超时兜底。 */
    {
        int k;
        unsigned int g;

        for (k = 0; k < 4; k++) {
            g = 0;
            while (((*uart_ctrl & UART_ST_TX_FULL) != 0u) && (++g < 200000u)) {
                ;
            }
            *uart_data = 0x00u;
        }
        g = 0;
        while (((*uart_ctrl & UART_ST_TX_FULL) != 0u) && (++g < 200000u)) {
            ;
        }
    }
}

/*====================================================================
 *  发送
 *
 *  ★ 这里判的是 **bit1 = TX FIFO 满**, 不是 bit3。
 *    uart_top.v 里 UART_CTRL 读回的是
 *        status = {6'b0, tx_full, !rx_empty}
 *    即 bit0 = 接收非空, bit1 = 发送满, bit3 **恒为 0**。
 *    老代码 (bsp/PRINTF/putchar.c) 写的是 `while (*uart_ctrl & 0x8)`,
 *    条件永远不成立 -> 根本不判满 -> 连发 16 字节以上的 printf 会把
 *    发送 FIFO 顶满, 之后的字符要么被 APB 写挂住, 要么直接丢 ->
 *    串口上看到的就是缺字/串码 (乱码)。
 *==================================================================*/
void uart_putc(unsigned char c)
{
    unsigned int guard = 0;

    /* 判 bit1 = TX FIFO 满。加 guard 是防死锁:
     * uart_top.v 里写 data 的 apb_pready 是 `!tx_full && wr`,
     * 万一 tx_full 停在 1 (tx 侧异常), 无限等 + 强写都会把
     * AXI2APB 桥挂死, 整个 CPU 停住 —— 表现为"发一串字符后死机"。
     * 超时就直接丢弃这个字节, 宁可少一个字, 也不能卡死总线。
     *
     * 上限取 200000(与 uart_init 一致的量级): 开机头几百毫秒里
     * baudgen 可能还在从 9600 往 115200 过渡, 一个字节要 1 ms 才
     * 腾得出位置, 20000 次(约十几毫秒)有时不够, 实测会丢掉 banner
     * 里的十几个字节 (心跳 pdrop=12)。放到 200000 次(约 0.1 s)
     * 既能等过过渡期, 又不会真的挂死。 */
    while ((*uart_ctrl & UART_ST_TX_FULL) != 0u) {
        if (++guard > 200000u) {
            s_putc_drop++;
            return;                 /* 丢弃, 不写 data */
        }
    }
    *uart_data = (unsigned int)c;
}

void uart_puts(const char *s)
{
    if (s == 0) {
        return;
    }
    while (*s != '\0') {
        uart_putc((unsigned char)*s);
        s++;
    }
}

/*====================================================================
 *  接收缓冲 (64 字节环)
 *  中断处理 uart_handler() 里 push, 主循环里 getchar;
 *  不开中断时 uart_getchar_nb() 也会直接轮询硬件。
 *==================================================================*/
#define UART_RX_BUF_SIZE 64

static unsigned char s_rx_buf[UART_RX_BUF_SIZE];
static volatile int  s_rx_head = 0;   /* 写入位置 (中断里改) */
static volatile int  s_rx_tail = 0;   /* 读出位置 (主循环改) */

/* 1 = 中断接收模式: 硬件 FIFO 归 uart_handler 独占, 主循环只读环形缓冲 */
static volatile int  s_irq_rx_mode = 0;

void uart_irq_rx_mode(int on)
{
    s_irq_rx_mode = (on != 0);
}

void uart_rx_push(unsigned char c)
{
    int next = (s_rx_head + 1) % UART_RX_BUF_SIZE;

    if (next != s_rx_tail) {          /* 满了就丢弃最新字节 */
        s_rx_buf[s_rx_head] = c;
        s_rx_head = next;
    } else {
        s_rx_drop++;
    }
}

int uart_rx_ready(void)
{
    int n = s_rx_head - s_rx_tail;

    if (n < 0) {
        n += UART_RX_BUF_SIZE;
    }
    return n;
}

void uart_rx_flush(void)
{
    s_rx_tail = s_rx_head;
}

/**
 * @description: 从 UART 接口读取一个字符 (阻塞, 纯轮询)
 *   注意: 只在**不开接收中断**时用, 和 uart_handler 抢会卡总线
 */
unsigned char uart_read_char(void)
{
    while ((*uart_ctrl & UART_ST_RX_RDY) == 0u)
        ;
    return (unsigned char)(*uart_data);
}

/**
 * @description: 读 1~2 个 ASCII 数字, 转成 BCD (以回车结束)
 */
unsigned char uart_read_bcd_char(void)
{
    unsigned char c1, c0;
    unsigned char bcd;

    c1 = uart_read_char();
    c0 = uart_read_char();
    if (c0 == 0x0d) {
        bcd = c1 - 0x30;
    } else {
        bcd = (c1 - 0x30) * 16 + c0 - 0x30;
    }
    return bcd;
}

/**
 * @description: 非阻塞取一个字符, 没有数据返回 -1
 *   先看中断填好的环; 环空时:
 *     - 没开中断接收 -> 直接读硬件 FIFO
 *     - 开了中断接收 -> 返回 -1 (硬件 FIFO 归中断独占,
 *       否则"主循环看到非空 -> 中断抢走 -> 主循环读空 FIFO"会把总线卡死)
 */
int uart_getchar_nb(void)
{
    int c;

    if (s_rx_head != s_rx_tail) {
        c = s_rx_buf[s_rx_tail];
        s_rx_tail = (s_rx_tail + 1) % UART_RX_BUF_SIZE;
        return c;
    }
    if (s_irq_rx_mode) {
        return -1;
    }
    if ((*uart_ctrl & UART_ST_RX_RDY) != 0u) {
        return (int)(unsigned char)(*uart_data);
    }
    return -1;
}
