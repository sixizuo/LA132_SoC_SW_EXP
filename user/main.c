/**
 * @file    main.c
 * @brief   yunxiao_LA132_SoC_AC850_Irq —— 多例程统一入口
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * ====================================================================
 *  换例程**只改下面这一行**, 然后 make + 烧写。
 *  所有例程的源码都在 driver/<外设>/demo_*.c, 说明见 driver/demo.h
 *  与 driver/<外设>/demo_*.c 文件头。
 * ====================================================================
 */
#include "main.h"
#include "demo.h"

/*--------------------------------------------------------------------
 *  选择要跑的例子 (取值 0 ~ 25):
 *
 *    0  AXI-LCD + AXI-DMA 综合演示        12 SPI0 + ADC128S102 中断采样
 *    1  触摸轨迹 (AXI-LCD 黑底白线)       13 SPI1 + TLV5618A  中断输出
 *    2  DDR3 1GB 读写测试                 14 ADC9280 FIFO 采样
 *    3  拨码->LED + 共阳数码管计数        15 DAC9708 波形输出
 *    4  拨码/矩阵键盘/点阵/数码管         16 EEPROM(AT24C64) 读写
 *    5  定时器中断 + 数码管扫描           17 RTC 读时间
 *    6  (已删除)                         18 DDR3 读写 (0x4000_0000)
 *    7  PWM 直流电机正反转                19 片内 SRAM 读写 (0x300F_0000)
 *    8  步进电机八拍                      20 AXI-LCD 画线/数字/文字
 *    9  串口中断收发                      21 AXI-LCD 位图 (小企鹅)
 *   10  按键中断 (上升沿触发方式)           22 AXI-LCD 自检 (色块/边框/网格)
 *   11  APB DMA 四种传输通路              23 AXI-LCD + 触摸坐标
 *                                         24 USB(FT232H) PC<->板 回显
 *------------------------------------------------------------------*/
#ifndef APP_SEL
#define APP_SEL   27
#endif

/*--------------------------------------------------------------------
 *  编译期检查: 宏写错时直接报错, 免得烧进去白屏还以为是硬件问题
 *------------------------------------------------------------------*/
#if (APP_SEL < 0) || (APP_SEL > 34)
#error "APP_SEL 超出范围, 只能是 0 ~ 34 (见 driver/demo.h 的对照表)"
#endif

int main(void)
{
    /*----------------------------------------------------------------
     * 串口必须先定波特率: baudgen.v 的 baudtick_ctrl 复位值是 00 ->
     * 832 分频 -> 9600, 而终端按 115200 收, 就是一片乱码, 看上去像
     * "程序跑飞"。必须在第一次 printf 之前配置。
     *--------------------------------------------------------------*/
    uart_init(115200, 0);

    printf("\r\n==============================================\r\n");
    printf("  LA132  demo  APP_SEL = %d\r\n", APP_SEL);
    printf("==============================================\r\n");

#if   APP_SEL == 0
    printf("[APP] 0  AXI-LCD + AXI-DMA\r\n");
    axi_lcd_dma_demo();

#elif APP_SEL == 1
    printf("[APP] 1  touch trail (AXI-LCD)\r\n");
    touch_trail_demo();

#elif APP_SEL == 2
    printf("[APP] 2  DDR3 1GB read/write test\r\n");
    ddr_test_demo();

#elif APP_SEL == 3
    printf("[APP] 3  GPIO: switch->LED + 7-seg counter\r\n");
    gpio_led_demo();

#elif APP_SEL == 4
    printf("[APP] 4  GPIO: switch / keypad / dot-matrix / 7-seg\r\n");
    gpio_mode_demo();

#elif APP_SEL == 5
    printf("[APP] 5  timer interrupt + 7-seg scan\r\n");
    timer_irq_demo();

#elif APP_SEL == 6
#error "APP_SEL=6 的蜂鸣器示例已删除: 本实验箱没有 BEEP (PWM 模块也未使能), 请选其它编号"

#elif APP_SEL == 7
    printf("[APP] 7  PWM DC motor forward/reverse\r\n");
    pwm_motor_demo();

#elif APP_SEL == 8
    printf("[APP] 8  step motor (8-beat)\r\n");
    step_motor_demo();

#elif APP_SEL == 9
    printf("[APP] 9  UART interrupt echo\r\n");
    uart_irq_demo();

#elif APP_SEL == 10
    printf("[APP] 10 INTC button interrupt\r\n");
    intc_btn_demo();

#elif APP_SEL == 11
    printf("[APP] 11 APB DMA 4 transfer modes\r\n");
    apb_dma_demo();

#elif APP_SEL == 12
    printf("[APP] 12 SPI0 + ADC128S102 (irq)\r\n");
    spi_adc_demo();

#elif APP_SEL == 13
    printf("[APP] 13 SPI1 + TLV5618A DAC (irq)\r\n");
    spi_dac_demo();

#elif APP_SEL == 14
    printf("[APP] 14 ADC9280 FIFO capture\r\n");
    adc9280_demo();

#elif APP_SEL == 15
    printf("[APP] 15 DAC9708 waveform\r\n");
    dac9708_demo();

#elif APP_SEL == 16
    printf("[APP] 16 EEPROM AT24C64\r\n");
    at24c64_demo();

#elif APP_SEL == 17
    printf("[APP] 17 RTC read time\r\n");
    rtc_demo();

#elif APP_SEL == 18
    printf("[APP] 18 DDR3 (0x40000000) read/write\r\n");
    ddram_demo();

#elif APP_SEL == 19
    printf("[APP] 19 on-chip SRAM (0x300F0000) read/write\r\n");
    ram_demo();

#elif APP_SEL == 20
    printf("[APP] 20 AXI-LCD lines + number\r\n");
    lcd_test_demo();

#elif APP_SEL == 21
    printf("[APP] 21 AXI-LCD bitmap\r\n");
    lcd_pic_demo();

#elif APP_SEL == 22
    printf("[APP] 22 AXI-LCD self test\r\n");
    lcd_pass_demo();

#elif APP_SEL == 23
    printf("[APP] 23 AXI-LCD + touch coordinates\r\n");
    touch_demo();

#elif APP_SEL == 24
    printf("[APP] 24 APB USB (FT232H) echo test\r\n");
    usb_demo();

#elif APP_SEL == 25
    printf("[APP] 25 APB USB kbd + vseg (PC GUI pair)\r\n");
    usb_kbd_demo();

/*--------------------------------------------------------------------
 *  26~34: 教材 11.5 节的九个实验任务, 需要 exp_array_spi / exp_iic_spi
 *  两个 bit 之一。每个 demo 的文件头写了它依赖哪个宏, 见 driver/demo.h
 *------------------------------------------------------------------*/
#elif APP_SEL == 26
    printf("[APP] 26 exp1  16-line INTC selftest\r\n");
    intc16_demo();

#elif APP_SEL == 27
    printf("[APP] 27 exp2  4x4 keypad scanned in timer ISR\r\n");
    kbd_scan_demo();

#elif APP_SEL == 28
    printf("[APP] 28 exp3  8-bit LED flow (8 patterns)\r\n");
    led_flow_demo();

#elif APP_SEL == 29
    printf("[APP] 29 exp4  7-seg real time clock + RTC\r\n");
    rtc_clock_demo();

#elif APP_SEL == 30
    printf("[APP] 30 exp5  LCD scope (SPI AD)\r\n");
    lcd_scope_demo();

#elif APP_SEL == 31
    printf("[APP] 31 exp6  APB keypad controller\r\n");
    apb_kbd_demo();

#elif APP_SEL == 32
    printf("[APP] 32 exp7  LED dot matrix controller\r\n");
    dot_matrix_demo();

#elif APP_SEL == 33
    printf("[APP] 33 exp8  multi-touch (GT911)\r\n");
    touch_multi_demo();

#elif APP_SEL == 34
    printf("[APP] 34 exp9  streaming SPI AD/DA + DMA\r\n");
    spi_stream_demo();
#endif

    /* 上面的 demo 都不返回, 这里只是兜底 */
    for (;;) {
        ;
    }

    return 0;
}
