/*
 * @Author: WorkBuddy
 * @Date:   2026-11-02
 * @Description: APB USB (FT232H 245-FIFO) 驱动, 寄存器模型见 usb.h / main.h 第 15 节
 * @Version: V1.0.0.261102
 */

#include "APB_USB/usb.h"

void usb_init(void)
{
    /* 硬件上电后 FIFO 自动复位 (挂在 apb_prstn 上), 没有任何可配置寄存器。
     * 这里读一次状态: 一是防空读优化掉寄存器访问, 二是如果 USB_DATA 通路
     * 坏了 (bit 里 usb 没接好 / 地址错), 这次访问会暴露问题。 */
    (void)usb_status();
}

unsigned int usb_status(void)
{
    return *usb_ctrl;
}

int usb_rx_ready(void)
{
    return (*usb_ctrl & USB_ST_RX_RDY) ? 1 : 0;
}

int usb_tx_full(void)
{
    return (*usb_ctrl & USB_ST_TX_FULL) ? 1 : 0;
}

int usb_read_byte(void)
{
    /* !! 读 USB_DATA 会从 RX FIFO 弹出 1 字节, 空读得到的是 FIFO dout
     * 的旧值 (垃圾), 所以必须先判 bit0 再读。 */
    if (!usb_rx_ready())
        return -1;
    return (int)(*usb_data & 0xFFu);
}

int usb_write_byte(unsigned char c)
{
    unsigned int guard = 0;

    /* TX FIFO 64 深, PC 侧 FT232H 在收的时候 rxf/txf 握手几个周期就腾位。
     * 这里给一个有界等待: 正常情况几乎不等待, PC 不收则超时丢弃,
     * 返回 -1 让上层计数, 绝不死等 (否则 60MHz 域一停 CPU 就卡住)。 */
    while (usb_tx_full() && guard < USB_TX_WAIT_MAX)
        guard++;

    if (usb_tx_full())
        return -1;

    *usb_data = (unsigned int)c;    /* 低 8 位有效, 高位硬件忽略 */
    return 0;
}

int usb_write_str(const char *s)
{
    int n = 0;

    while (*s != '\0') {
        if (usb_write_byte((unsigned char)*s) != 0)
            break;
        s++;
        n++;
    }
    return n;
}
