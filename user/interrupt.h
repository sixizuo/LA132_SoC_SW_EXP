/*
 * @Author: yx
 * @Date: 2025-01-15
 * @LastEditors: WorkBuddy
 * @LastEditTime: 2026-10-31
 * @Description: 中断/异常相关接口
 * @Version: V1.2.0.261031
 *
 * 变更 (2026-10-31):
 *   start.S 的 intc_irq_1~7 改成"取中断号 -> 调 intc_irq_dispatch(n)",
 *   具体处理函数由各个 demo 用 intc_irq_attach(n, fn) 现场挂上去。
 *   这样 22 个 demo 里同时存在多个用到同一条 INTC 线的例子
 *   (比如 SPI-ADC 和 SPI-DAC 都用 intc 2) 也不会出现符号重名,
 *   而且不必为了换一个 demo 去改汇编。
 */
#ifndef _INTERRUPT_H
#define _INTERRUPT_H

#ifdef __cplusplus
extern "C" {
#endif

/* ---------------- CSR / 全局中断 ---------------- */
void EnableInt(void);              /* 只置 CRMD.IE, 不开 HWI 掩码 */
void Write_INT_EENTRY(void);       /* EBase = 0x1C001000 (异常入口)   */
void Enable_LA_Globl_Int(void);    /* CRMD.IE = 1                     */
void Disable_LA_Globl_Int(void);   /* CRMD.IE = 0                     */
void Enable_LA_Local_Int(unsigned int irq_num);  /* 打开 HWI irq_num  */
void Disable_LA_Local_Int(unsigned int irq_num); /* 关闭 HWI irq_num  */
void Set_LA_VS(unsigned int vs_num);             /* ECFG.VS          */

/**
 * 一套完整的"打开 INTC 中断"的动作, 相当于原先 main() 里那 4 行:
 *      Write_INT_EENTRY(); Set_LA_VS(0); Enable_LA_Local_Int(4); Enable_LA_Globl_Int();
 * 其中 HWI4 就是 INTC 的输出。
 */
void intc_irq_init(void);

/* ---------------- INTC 16 根线的处理函数挂载 ---------------- */
typedef void (*irq_handler_t)(void);

/**
 * @brief 把处理函数挂到 INTC 的第 irq 根线上 (0~15)
 * @note  irq 0 (UART) 在 start.S 里固定调用 uart_handler, 这里一般不挂
 *        16 路中断源的分配见教材表 11-7:
 *        8=AXI-DMAC 9=USB 10=AXI-LCD 11=矩阵键盘 12=点阵 13=SPI 流
 */
void intc_irq_attach(unsigned int irq, irq_handler_t fn);
void intc_irq_detach(unsigned int irq);

/** @brief 由 start.S 调用: 分发第 irq 根线的中断 */
void intc_irq_dispatch(unsigned int irq);

/* ---------------- 默认的 UART 中断处理 ---------------- */
/** 读空接收 FIFO (RTL 里 uart_irq = !rx_empty, 是电平中断, 不读空会中断风暴) */
void uart_handler(void);

#ifdef __cplusplus
}
#endif

#endif /* _INTERRUPT_H */
