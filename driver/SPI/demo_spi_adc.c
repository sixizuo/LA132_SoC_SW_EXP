/**
 * @file    demo_spi_adc.c
 * @brief   SPI0 + ADC128S102 8 通道 12 位 ADC, 中断方式连续采样
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/adc_spi_irq_vs_0.c_backup + interrupt.c 的 spi_adc_handler()
 *
 * 改动:
 *   1) 中断处理从 user/interrupt.c 搬到本文件, 用 intc_irq_attach(2, ...) 挂载;
 *      原来 SPI-ADC 和 SPI-DAC 两个例程都要用 INTC 第 2 根线, 处理函数
 *      都叫 spi_*_handler 的话没法同时存在, 现在用运行期挂载解决。
 *   2) ISR 末尾补了 *intc_int_clr, 否则 INTC 的挂起位不清会反复进中断。
 *
 * 寄存器 (main.h):
 *   spi_spcr   0x300A0000  0xDC = 中断使能|接口使能|主设备|sclk 空闲高|上升沿采样|分频
 *   spi_sper   0x300A000C  0x40 = 收 1 个数据就产生中断
 *   spi_softcs 0x300A0014  0xE1 = 片选 SPI0
 *   spi_data   0x300A0008  写一次发一字节; 读一次取一字节
 *   spi_spsr   0x300A0004  bit2 = 传输完成 (读它清中断)
 *
 * 时序: 发 2 个字节 (高 8 位 + 低 8 位) 启动通道 0 转换,
 *       转换结果通过中断读回 2 字节 -> 12 位采样值。
 *
 * 现象: 串口连续打印 adc_data (0x000~0xFFF), 拧电位器数值跟着变。
 */
#include "main.h"

#define SPI_ADC_IRQ_LINE  2u

static void spi_adc_isr(void)
{
    unsigned int  hi, lo;
    unsigned int  value;

    *spi_spsr = *spi_spsr;            /* 读 spsr 清 SPI 中断 */

    hi = (unsigned int)(*spi_data);   /* 高 8 位 */
    lo = (unsigned int)(*spi_data);   /* 低 8 位 */
    value = ((hi & 0xFFu) << 8) | (lo & 0xFFu);

    printf("[ADC] 0x%03x (%u mV)\r\n", value, (value * 3300u) / 4096u);

    /* 立刻发起下一次通道 0 转换 */
    *spi_data = 0x00;
    *spi_data = 0x00;

    *intc_int_clr = (1u << SPI_ADC_IRQ_LINE);
}

void spi_adc_demo(void)
{
    unsigned int tick = 0;

    intc_irq_init();

    /* INTC 第 2 根线 (SPI) */
    *intc_int_en   = (1u << SPI_ADC_IRQ_LINE);
    *intc_int_pol  = (1u << SPI_ADC_IRQ_LINE);
    *intc_int_edge = 0x0000;

    /* SPI0: 使能中断/接口/主设备, sclk 空闲高, 上升沿采样, 分频 2 */
    *spi_spcr   = 0xDC;
    *spi_sper   = 0x40;               /* 收 1 个数据产生中断 */
    *spi_softcs = 0xE1;               /* 选中并使能 SPI0 */

    intc_irq_attach(SPI_ADC_IRQ_LINE, spi_adc_isr);

    printf("spi adc demo: SPI0 + ADC128S102, irq line %u\r\n", SPI_ADC_IRQ_LINE);

    /* 启动通道 0 转换 */
    *spi_data = 0x00;
    *spi_data = 0x00;

    for (;;) {
        delay_ms(100);
        if (++tick >= 50) {           /* 每 5 秒一个心跳, 说明主循环没被中断卡住 */
            tick = 0;
            printf(".");
        }
    }
}
