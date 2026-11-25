/**
 * @file    demo_spi_dac.c
 * @brief   SPI1 + TLV5618A 双通道 12 位 DAC, 中断方式连续输出递增码
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/dac_spi_irq_vs_0.c_backup + interrupt.c 的 spi_dac_handler()
 *
 * 改动:
 *   1) 中断处理搬进本文件, 用 intc_irq_attach(2, ...) 挂载 ——
 *      与 SPI-ADC 共用 INTC 第 2 根线, 挂不同的函数即可, 不再符号冲突。
 *   2) dac_data 从 main.h 的 static 变量改为本文件的 static,
 *      避免每个包含 main.h 的 .c 各有一份。
 *
 * TLV5618A 的一条命令是 2 字节:
 *   bit15..14 = 00 快速模式 / 01 快速+掉电
 *   本 demo 用 slow 模式 (bit15..12 = 前缀):
 *     0x5xxx -> 写 DAC-B 的缓冲寄存器
 *     0xCxxx -> 写 DAC-A 并同时把缓冲里的值更新到 B
 *   所以先发 B (0x5000|data), 再发 A (0xC000|data), 两路同时更新。
 *
 * 寄存器 (main.h): spi_spcr / spi_sper / spi_softcs / spi_data / spi_spsr
 *
 * 现象: 用示波器量 DAC 输出, 应看到 0 -> 4095 的阶梯波;
 *       串口每 256 次打印一次当前码值。
 */
#include "main.h"

#define SPI_DAC_IRQ_LINE  2u
#define SPI_CS_DAC_ON     0b11010010    /* spi1 片选拉低 (选中) */
#define SPI_CS_DAC_OFF    0b11110010    /* spi1 片选拉高 (释放) */

static volatile unsigned int s_dac_data = 0;

/* 等 SPI 传输完成 (bit2), 带超时防死等 */
static void spi_wait_idle(void)
{
    unsigned int guard = 0;

    while (!(*spi_spsr & 0x04) && (++guard < 100000u)) {
        ;
    }
}

/* 同时写 A/B 两路 (slow mode) */
static void dac_write_ab(unsigned int value)
{
    unsigned int data_a = (dac_a_slow_second_prefix | (value & 0x0FFFu));
    unsigned int data_b = (dac_b_slow_first_prefix  | (value & 0x0FFFu));

    /* B: 只写缓冲寄存器 */
    *spi_softcs = SPI_CS_DAC_ON;
    *spi_data   = (unsigned char)(data_b >> 8);
    *spi_data   = (unsigned char)(data_b);
    spi_wait_idle();
    *spi_softcs = SPI_CS_DAC_OFF;

    /* A: 写 A 寄存器, 同时把缓冲里的值更新到 B */
    *spi_softcs = SPI_CS_DAC_ON;
    *spi_data   = (unsigned char)(data_a >> 8);
    *spi_data   = (unsigned char)(data_a);
    spi_wait_idle();
    *spi_softcs = SPI_CS_DAC_OFF;
}

static void spi_dac_isr(void)
{
    *spi_spsr = *spi_spsr;            /* 清 SPI 中断 */

    s_dac_data = (s_dac_data + 1u) & 0x0FFFu;
    dac_write_ab(s_dac_data);

    *intc_int_clr = (1u << SPI_DAC_IRQ_LINE);   /* 清 INTC 挂起位 */
}

void spi_dac_demo(void)
{
    unsigned int last_print = 0;

    intc_irq_init();

    *intc_int_en   = (1u << SPI_DAC_IRQ_LINE);
    *intc_int_pol  = (1u << SPI_DAC_IRQ_LINE);
    *intc_int_edge = 0x0000;

    /* SPI1: 使能中断/接口/主设备, sclk 空闲高, 下降沿采样 */
    *spi_spcr   = 0xD8;
    *spi_sper   = 0x40;
    *spi_softcs = SPI_CS_DAC_OFF;

    intc_irq_attach(SPI_DAC_IRQ_LINE, spi_dac_isr);

    printf("spi dac demo: SPI1 + TLV5618A, irq line %u\r\n", SPI_DAC_IRQ_LINE);

    dac_write_ab(0);                  /* 先输出 0 */

    for (;;) {
        delay_ms(100);
        if ((s_dac_data / 256u) != last_print) {
            last_print = s_dac_data / 256u;
            printf("[DAC] code = %u\r\n", s_dac_data);
        }
    }
}
