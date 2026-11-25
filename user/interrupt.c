/*
 * @Author: yx
 * @Date: 2025-01-15
 * @LastEditors: WorkBuddy
 * @LastEditTime: 2026-10-31
 * @Description: 中断/异常基础函数 + INTC 8 根线的分发
 * @Version: V1.2.0.261031
 *
 * 2026-10-31 重构说明
 * -------------------
 * 原来这个文件里塞了 timer_handler / spi_adc_handler / spi_dac_handler /
 * apb_dma_handler / touch_handler / gpio*_handler / btn*_handler 一共十几个
 * 处理函数, 每个都只为某一个例程服务, 而且依赖 main.h 里定义的 static
 * 变量 (disp_buffer / dac_data / timer_int_num ...)。
 *
 * 现在把这些处理函数全部下沉到各自的 demo 里 (driver/<外设>/demo_*.c),
 * 本文件只保留:
 *   1) CSR/全局中断的几条汇编包装
 *   2) INTC 8 根线的函数指针表 + 分发 (start.S 调用)
 *   3) UART 的默认处理函数 (读空接收 FIFO)
 * 这样换 demo 不用改汇编, 也不会出现符号重名。
 */

#include "interrupt.h"
#include "main.h"

void EnableInt(void)
{
    asm volatile(
        "li.w $r12, 0x4;\n"
        "csrxchg $r12, $r12, 0x0;\n" ::: "$r12");
}
void Write_INT_EENTRY(void)
{
    asm volatile(
        "li.w $r12, 0x1c001000;\n"
        "csrwr $r12, 0xc;\n" ::: "$r12");
}
void Enable_LA_Globl_Int(void)
{
    asm volatile(
        "li.w $r12, 0x4;\n"
        "csrxchg $r12, $r12, 0x0;\n" ::: "$r12");
}

void Disable_LA_Globl_Int(void)
{
    asm volatile(
        "li.w $r12, 0x4;\n"
        "csrxchg $r0, $r12, 0x0;\n" ::: "$r12");
}
void Enable_LA_Local_Int(unsigned int irq_num)
{
    /* 注意 clobber 必须把 $r13 也列上: 上面两条 asm 用了 r12 和 r13。
     * 原来只写了 "$r12", 编译器可能把某个活变量放在 r13 里, 被这里
     * 悄悄改掉 —— 这类 bug 表现为"开完中断回来某个变量就变了"。 */
    asm volatile(
        "addi.w $r12, $r0,1;\n"
        "addi.w $r13, %0,2;\n"
        "sll.w $r12, $r12,$r13;\n"
        "csrxchg $r12, $r12, 0x4;\n" ::"r"(irq_num) : "$r12", "$r13");
}
void Disable_LA_Local_Int(unsigned int irq_num)
{
    asm volatile(
        "addi.w $r12, $r0,1;\n"
        "addi.w $r13, %0,2;\n"
        "sll.w $r12, $r12,$r13;\n"
        "csrxchg $r0, $r12, 0x4;\n" ::"r"(irq_num) : "$r12", "$r13");
}
void Set_LA_VS(unsigned int vs_num)
{
    asm volatile(
        "addi.w $r12, %0,0;"
        "slli.w $r12, $r12,16;\n"
        "csrxchg $r12, $r12, 0x4;\n" ::"r"(vs_num) : "$r12");
}

/**
 * @description: 打开 INTC 中断所需的四步 (等价于原来 main() 里的 4 行)
 */
void intc_irq_init(void)
{
    Write_INT_EENTRY();       /* 异常入口必须在 0x1C001000, 否则中断一跳就跑飞 */
    Set_LA_VS(0);
    Enable_LA_Local_Int(4);   /* HWI4 = INTC 输出 */
    Enable_LA_Globl_Int();
}

/*====================================================================
 *  INTC 16 根线的分发 (2026-11-23 由 8 路扩到 16 路)
 *    start.S:  先从 INT_OUT 里找最低的挂起位算出 n (0~15),
 *              再 bl intc_irq_dispatch(n); n==0 时直接调 uart_handler
 *==================================================================*/
static irq_handler_t s_irq_hook[16] = { 0 };

void intc_irq_attach(unsigned int irq, irq_handler_t fn)
{
    if (irq < 16u) {
        s_irq_hook[irq] = fn;
    }
}

void intc_irq_detach(unsigned int irq)
{
    if (irq < 16u) {
        s_irq_hook[irq] = 0;
    }
}

void intc_irq_dispatch(unsigned int irq)
{
    if ((irq < 16u) && (s_irq_hook[irq] != 0)) {
        s_irq_hook[irq]();
    }
}

/*====================================================================
 *  UART 中断 (INTC 线 0, start.S 固定调用)
 *
 *  ★ 电平方式的自我保护 (2026-10-31 加)
 *    one_int_gen.v 里电平模式是  int_out = int_en & !(int_pol ^ int_in),
 *    也就是**请求直接跟随电平**, 不做任何锁存。只要 RX FIFO 里还有
 *    一个字节没读掉, uart_irq 就一直是 1, 退出中断后立刻再进 —— 实测
 *    曾经 40 秒内累积 488 万次中断, 主循环被完全饿死 (串口只剩心跳,
 *    打字没反应)。
 *
 *    所以这里用"进中断先屏蔽本线、读完再打开":
 *      屏蔽期间无论 FIFO 还剩多少, 都不会重入;
 *      读完确认空了再打开, 正常就继续收, 异常也不会把 CPU 卡死。
 *    万一读满 64 个还非空 (硬件状态位异常), 就永久关掉这条线并转成
 *    主循环轮询 —— 宁可少一次"中断演示", 也不能让主循环停摆。
 *==================================================================*/
void uart_handler(void)
{
    int guard = 0;
    unsigned int en;

    uart_irq_count_inc();

    en = *intc_int_en;
    *intc_int_en = en & ~0x01u;         /* 先屏蔽 INTC 线 0 */

    /* 中断里必须把接收 FIFO 读空。顺序必须是 "先判非空, 再读 data":
     * uart_top.v 的 apb_pready 对 data 读是 (rx_done || !rx_empty) && rd,
     * FIFO 空的时候读一次 data, pready 永远不拉高, AXI2APB 桥会在
     * state 2 死等 reg_ready_1 —— 整个 CPU 卡死在这条 ld.w 上。 */
    while (((*uart_ctrl & UART_ST_RX_RDY) != 0u) && (guard++ < 64)) {
        uart_rx_push((unsigned char)(*uart_data));
    }

    if ((*uart_ctrl & UART_ST_RX_RDY) != 0u) {
        /* 读了 64 个还是非空: 硬件状态位异常, 放弃中断方式。
         * uart_irq_rx_mode(0) 让主循环 uart_getchar_nb() 直接读硬件 FIFO,
         * 串口还能继续用, 只是变成轮询。 */
        uart_irq_rx_mode(0);
        return;                          /* 不恢复使能 = 关闭这条线 */
    }

    *intc_int_en = en;                   /* 恢复原来的使能状态 */
}
