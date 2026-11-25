/*
 * @Author: yx
 * @Date: 2025-02-20
 * @LastEditors: WorkBuddy
 * @LastEditTime: 2026-10-31
 * @Description: putchar 库函数 (printf 的最终出口)
 * @Version: V1.0.2.261031
 *
 * ★ 2026-10-31 修串口乱码:
 *   原实现是
 *       while ((*uart_ctrl & 0x8) == 0x8) ;   // 等 bit3 = "发送忙"
 *       *uart_data = ch;
 *   但 uart_top.v 里 UART_CTRL **读回的是状态字**:
 *       assign status = {6'b0, tx_full, !rx_empty};
 *   也就是 bit0 = 接收非空, bit1 = 发送 FIFO 满, **bit3 恒为 0**。
 *   于是这个 while 永远不成立 -> 完全不判满 -> printf 连着发十几个
 *   字节就把 16 深的发送 FIFO 顶满, 之后的字符被 APB 写卡住或丢掉,
 *   串口到手就是缺字、串码。
 *
 *   现在统一走 driver/UART/uart.c 的 uart_putc(), 它判的是 bit1
 *   (UART_ST_TX_FULL), 而且整个工程只有这一处写发送寄存器,
 *   顺序和节流都集中管理。
 */

#include "putchar.h"
#include "main.h"

int _putchar(int ch)
{
    uart_putc((unsigned char)ch);
    return 0;
}
