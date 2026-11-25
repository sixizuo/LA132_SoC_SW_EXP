/*
 * @Author: yx
 * @Date: 2024-10-13
 * @LastEditors: WorkBuddy
 * @LastEditTime: 2026-10-31
 * @Description: 串口头文件
 * @Version: V1.1.0.261031
 */

#ifndef _UART_H_
#define _UART_H_

#ifdef __cplusplus
extern "C"
{
#endif

void uart_init(int baudrate, int odd);
void uart_interrupt_init(void);

/* ---- 发送 ----
 * uart_putc()  : 阻塞发送 1 字节, 正确等 TX FIFO 有空位 (判 UART_ST_TX_FULL)
 * uart_puts()  : 发送字符串
 * 说明: printf -> _putchar -> uart_putc, 所以 printf 的发送顺序是有保证的。
 */
void uart_putc(unsigned char c);
void uart_puts(const char *s);

/* ---- 中断接收模式开关 ----
 * uart_irq_rx_mode(1) 之后, 硬件 RX FIFO 只允许 uart_handler 读,
 * uart_getchar_nb() 只从环形缓冲取 (返回 -1 表示没数据)。
 * 为什么必须这样: 主循环和中断同时读同一个 FIFO 时, 一旦
 *   主循环看到"非空" -> 中断抢先把字节读走 -> 主循环再去读空的
 *   FIFO, apb_pready 不拉高 -> 总线卡死。
 */
void uart_irq_rx_mode(int on);

/* ---- 字符收发 ----
 * uart_read_char()      : 阻塞等一个字节 (纯轮询, 不依赖中断)
 * uart_read_bcd_char()  : 读 1~2 个 ASCII 数字并转成 BCD (回车结束)
 * uart_getchar_nb()     : 非阻塞, 无数据返回 -1
 * uart_rx_ready()       : 接收缓冲里有多少字节
 * uart_rx_push()        : 由 uart_handler (中断) 调用, 把字节塞进缓冲
 *
 * 说明: 原来 uart_read_char / uart_read_bcd_char 是在每个 .c 备份文件里
 * 各写一份的, 多个文件同时参与编译必然重定义。现在统一放这里。
 */
unsigned char uart_read_char(void);
unsigned char uart_read_bcd_char(void);
int           uart_getchar_nb(void);
int           uart_rx_ready(void);
void          uart_rx_push(unsigned char c);
void          uart_rx_flush(void);

/* ---- 诊断计数 ----
 * uart_rx_irq_count()  : 进过多少次 UART 中断
 * uart_rx_drop_count() : 因为环形缓冲满而丢掉的字节数
 * uart_putc_drop()     : 因为 TX FIFO 长时间满而丢弃的字节数
 * 排查"收到一个字节就死"时, 让心跳带上这几个数, 一眼看出是
 * 没进中断 / 进了中断但没退出 / 发送侧被丢。
 */
unsigned int  uart_rx_irq_count(void);
unsigned int  uart_rx_drop_count(void);
unsigned int  uart_putc_drop(void);
void          uart_irq_count_inc(void);   /* 由 uart_handler 调用 */

#ifdef __cplusplus
}
#endif

#endif // _UART_H_
