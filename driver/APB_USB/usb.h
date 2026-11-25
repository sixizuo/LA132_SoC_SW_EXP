/*
 * @Author: WorkBuddy
 * @Date:   2026-11-02
 * @Description: APB USB (FT232H 245-FIFO) 驱动头文件
 * @Version: V1.0.0.261102
 */

#ifndef _USB_H_
#define _USB_H_

#include "main.h"

/*
 *  硬件模型 (hw/peripheral/apb_usb/usb_top.v + usb_rw.v):
 *
 *      CPU/APB (32MHz)                     FT232H (60MHz)
 *      usb_data(写) --> TX FIFO(64) --> usb_rw --> usb_data 引脚 --> PC
 *      usb_data(读) <-- RX FIFO(64) <-- usb_rw <-- usb_data 引脚 <-- PC
 *
 *  两个 FIFO 都是 8bit x 64, 跨时钟域 (写侧 APB 32MHz, 读侧 USB 60MHz),
 *  由 usb_rw 状态机按 FT232H 的 rxf#/txf# 握手自动搬运, 软件只管:
 *      - 写 USB_DATA  = 把 1 字节交给 TX FIFO (先看 bit1 防 full)
 *      - 读 USB_CTRL  = 状态 {30'b0, tx_full, !rx_empty}
 *      - 读 USB_DATA  = 从 RX FIFO 弹 1 字节 (先看 bit0 防空读)
 *
 *  注意:
 *    - usb_irq = RX 非空 (电平), 本版 bit 没接 INTC, 只能轮询;
 *    - PC 侧要把 FT232H 配成 Sync 245 FIFO 模式 (板子出厂已配好),
 *      PC 不收数据时 TX FIFO 会满, usb_write_byte 带有界等待+丢弃;
 *    - 本驱动不做任何阻塞等待 (usb_write_byte 的保护等待除外)。
 */

/* TX FIFO 满时的保护等待上限 (循环数)。@32MHz 约 200000 次 = 6ms。
 * FT232H 正常收数据时几个周期就腾出空位; 超时说明 PC 侧没在收。 */
#define USB_TX_WAIT_MAX   200000u

/*--------------------------------------------------------------------
 *  基础操作
 *------------------------------------------------------------------*/
void         usb_init(void);        /* 无需配置, 读一次状态防呆        */
unsigned int usb_status(void);      /* 原始 USB_CTRL 状态字            */
int          usb_rx_ready(void);    /* 1 = RX FIFO 有数据              */
int          usb_tx_full(void);     /* 1 = TX FIFO 满                  */
int          usb_read_byte(void);   /* -1 = 空; 否则返回 0~255         */
int          usb_write_byte(unsigned char c);
                                    /* 0 = 已推入; -1 = 满, 丢弃       */
int          usb_write_str(const char *s);
                                    /* 逐字节写, 返回成功写入的字节数  */

#endif /* _USB_H_ */
