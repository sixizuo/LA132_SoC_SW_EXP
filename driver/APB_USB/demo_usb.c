/*
 * @Author: WorkBuddy
 * @Date:   2026-11-02
 * @Description: APP_SEL 24 —— APB USB (FT232H 245-FIFO) PC<->板 回显测试
 * @Version: V1.0.0.261102
 *
 * ====================================================================
 *  硬件前提 (2026-11-02 起):
 *    USB 外设挂 APB id16 = 0x3010_0000 (USB_DATA=+0, USB_CTRL=+4),
 *    对应 bit 是 godson_mcu_top_1102_usb.bit 及之后版本。**更老的 bit
 *    里 usb_psel 悬空, 本 demo 会退化成"访问 APB 空洞"**, 表现为
 *    status 读到 0 / 命令无响应 —— 先确认 bit 版本。
 *
 *  测试拓扑:
 *      PC [FT232H Sync245] <--usb_data/60MHz--> usb_rw <--> FIFO <--> APB
 *      PC [USB-UART COMx]  <--------------------------> APB UART (控制台)
 *
 *  板上没有 USB 自环, 所以"回显"必须由 PC 端配合: PC 向 FT232H 写数据,
 *  板子原样写回 TX FIFO, PC 读回比对。PC 侧可用 FTDI D2XX 的
 *  Sync 245 FIFO 模式 (FT_SetBitMode(0,0x40)), 任何串口助手不行 ——
 *  FT232H 的 FIFO 口不是串口。
 *
 *  串口命令 (在 UART 控制台敲):
 *      help    命令列表
 *      status  打印 USB_CTRL 状态与统计
 *      count   打印 rx/tx/bad/drop 计数
 *      test    发送 64 字节可打印图案到 USB TX (供 PC 侧比对)
 *      flush   打印后清统计
 *
 *  统计说明:
 *      rx   = 从 PC 收到的字节 (含 bad)
 *      tx   = 成功推入 TX FIFO 的字节
 *      bad  = 收到的不可打印字节 (0x00-0x1F, 0x7F-0xFF), 会在串口打 [XX]
 *      drop = TX FIFO 满超时被丢的字节 (PC 没在收或收得太慢)
 *      心跳 [hb ...] 每 ~2s 一次, st 是 USB_CTRL 原始状态字
 * ====================================================================
 */

#include "main.h"
#include "demo.h"
#include "APB_USB/usb.h"

/*--------------------------------------------------------------------
 *  统计
 *------------------------------------------------------------------*/
static volatile unsigned int s_rx  = 0;   /* 收到总字节       */
static volatile unsigned int s_tx  = 0;   /* 成功回发字节     */
static volatile unsigned int s_bad = 0;   /* 不可打印字节     */
static volatile unsigned int s_drop = 0;  /* TX 满被丢字节    */

static unsigned int s_hb = 0;             /* 心跳分频计数     */

#define HB_PERIOD   3000000u             /* 空转主环 ~2s 一拍 */

static int is_printable(int c)
{
    return (c >= 0x20 && c <= 0x7E);
}

static void print_help(void)
{
    printf("commands: help | status | count | test | flush\r\n");
}

static void print_status(void)
{
    unsigned int st = usb_status();

    printf("USB status = 0x%08x\r\n", st);
    printf("  bit0 RX not-empty (data from PC) = %d\r\n", st & 0x1u);
    printf("  bit1 TX full (PC not draining)   = %d\r\n", (st >> 1) & 0x1u);
    printf("  rx=%u tx=%u bad=%u drop=%u\r\n", s_rx, s_tx, s_bad, s_drop);
}

static void print_count(void)
{
    printf("usb rx total = %u, echoed = %u, bad = %u, tx drop = %u\r\n",
           s_rx, s_tx, s_bad, s_drop);
    if (s_bad == 0 && s_rx > 0)
        printf("  -> RX clean\r\n");
}

static void do_usb_test(void)
{
    /* 64 字节可打印图案, 正好等于 TX FIFO 深度, 检查 full 处理 */
    static const char *pat = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz<>";
    int i, ok = 0;

    printf("sending 64-byte pattern to USB TX ...\r\n");
    for (i = 0; pat[i] != '\0'; i++) {
        if (usb_write_byte((unsigned char)pat[i]) == 0)
            ok++;
        else
            s_drop++;
    }
    printf("accepted %d/64 (drop=%u). PC side: read 64 bytes & compare\r\n",
           ok, s_drop);
    s_tx += (unsigned int)ok;
}

/*--------------------------------------------------------------------
 *  串口命令行 (非阻塞, 与 UART demo 同套路)
 *------------------------------------------------------------------*/
#define LINE_BUF  32
static char s_line[LINE_BUF];
static unsigned int s_len = 0;

static int str_eq(const char *a, const char *b)
{
    while (*a != '\0' && *b != '\0') {
        if (*a != *b)
            return 0;
        a++;
        b++;
    }
    return (*a == '\0' && *b == '\0');
}

static void uart_line_reset(void)
{
    s_len = 0;
}

static void uart_poll(void)
{
    int c = uart_getchar_nb();

    if (c < 0)
        return;

    if (c == '\r' || c == '\n') {
        s_line[s_len] = '\0';
        if (s_len > 0) {
            printf("\r\n");
            if      (str_eq(s_line, "help"))   print_help();
            else if (str_eq(s_line, "status")) print_status();
            else if (str_eq(s_line, "count"))  print_count();
            else if (str_eq(s_line, "test"))   do_usb_test();
            else if (str_eq(s_line, "flush"))  { s_rx = s_tx = s_bad = s_drop = 0;
                                                 printf("stats cleared\r\n"); }
            else               printf("unknown cmd: %s\r\n", s_line);
            uart_line_reset();
        }
        return;
    }

    if (is_printable(c)) {
        if (s_len < LINE_BUF - 1)
            s_line[s_len++] = (char)c;
        /* 不回显, 串口终端本地回显即可, 避免和心跳搅在一起 */
    }
    /* 其余字符忽略 */
}

/*--------------------------------------------------------------------
 *  USB 主循环: 收到什么回什么
 *------------------------------------------------------------------*/
static void usb_poll(void)
{
    int guard;

    /* 一次最多清 64 字节 (RX FIFO 深度), 防止这一帧把心跳饿死 */
    for (guard = 0; guard < 64; guard++) {
        int c;

        if (!usb_rx_ready())
            break;

        c = usb_read_byte();
        if (c < 0)
            break;

        s_rx++;

        if (!is_printable(c)) {
            s_bad++;
            printf("[%02X]", c);            /* 误码可见, 与 uart demo 一致 */
        }

        if (usb_write_byte((unsigned char)c) == 0)
            s_tx++;
        else
            s_drop++;
    }
}

/*--------------------------------------------------------------------
 *  入口 (不返回)
 *------------------------------------------------------------------*/
void usb_demo(void)
{
    usb_init();

    printf("\r\n---- APB USB demo ----\r\n");
    printf("USB base = 0x%08x (FT232H sync-245, PC<->board echo)\r\n",
           usb_base);
    print_status();
    printf("ready. PC: write via FT232H -> board echoes back.\r\n");
    printf("UART console: type `help` + Enter\r\n");

    for (;;) {
        usb_poll();
        uart_poll();

        if (++s_hb >= HB_PERIOD) {
            s_hb = 0;
            printf("[hb rx=%u tx=%u bad=%u drop=%u st=0x%x]\r\n",
                   s_rx, s_tx, s_bad, s_drop, usb_status());
        }
    }
}
