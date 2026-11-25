/**
 * @file    demo.h
 * @brief   所有外设 demo 的统一入口声明
 *
 *  用法: 打开 user/main.c, 只改一行
 *
 *      #define APP_SEL   3
 *
 *  然后 make。每个宏值对应下表中的一行, 全部 *_demo() 都**不返回**
 *  (内部死循环), 想换例子就重新编译/烧写, 或者按板上的复位键。
 *
 *--------------------------------------------------------------------
 *  APP_SEL   目录                         函数                外设 / 说明
 *--------------------------------------------------------------------
 *    0   driver/AXI_LCD_DMA        axi_lcd_dma_demo()   AXI-LCD + AXI-DMA 综合演示
 *    1   driver/AXI_LCD_DMA        touch_trail_demo()   触摸轨迹 (AXI-LCD 画黑底白线)
 *    2   driver/AXI_LCD_DMA        ddr_test_demo()      DDR3 1GB 读写测试
 *    3   driver/GPIO               gpio_led_demo()      拨码->LED + 共阳数码管计数
 *    4   driver/GPIO               gpio_mode_demo()     拨码/矩阵键盘/点阵/数码管 综合轮询
 *    5   driver/TIMER              timer_irq_demo()     定时器中断 + 数码管动态扫描
 *    -   (已移除)                   --                   --
 *    7   driver/PWM                pwm_motor_demo()     PWM 直流电机正反转
 *    8   driver/STEP_MOTOR         step_motor_demo()    步进电机八拍驱动
 *    9   driver/UART               uart_irq_demo()      串口中断收发
 *   10   driver/INTC               intc_btn_demo()      按键中断 (电平/边沿三种方式)
 *   11   driver/DMA                apb_dma_demo()       APB DMA 四种传输通路
 *   12   driver/SPI                spi_adc_demo()       SPI0 + ADC128S102 中断采样
 *   13   driver/SPI                spi_dac_demo()       SPI1 + TLV5618A 中断输出
 *   14   driver/ADCDAC             adc9280_demo()       ADC9280: APB 直读 / APB-DMA 搬入 APB RAM
 *   15   driver/ADCDAC             dac9708_demo()       DAC9708 波形输出
 *   16   driver/AT24C64            at24c64_demo()       EEPROM(AT24C64) 读写
 *   17   driver/RTC                rtc_demo()           RTC(SD3078) 读时间
 *   18   driver/DDR                ddram_demo()         DDR3 存储读写 (0x4000_0000)
 *   19   driver/DDR                ram_demo()           片内 SRAM 读写 (0x300F_0000)
 *   20   driver/LCD                lcd_test_demo()      AXI-LCD 画线 / 显示数字
 *   21   driver/LCD                lcd_pic_demo()       AXI-LCD 画位图 (小企鹅, 4x)
 *   22   driver/LCD                lcd_pass_demo()      AXI-LCD 自检 (色块/边框/网格)
 *   23   driver/LCD                touch_demo()         AXI-LCD + 触摸坐标 (int7)
 *   24   driver/APB_USB            usb_demo()           USB(FT232H) PC<->板 回显测试
 *   25   driver/APB_USB            usb_kbd_demo()       USB 键盘+数码管联动(配 usb_kbd_gui)
 *--------------------------------------------------------------------
 *  以下 26~34 是教材 11.5 节的九个实验任务, 硬件在 D:\LA132_SoC_HW_EXP,
 *  必须烧 exp_array_spi / exp_iic_spi 两个 bit 之一 (见每行末的工程要求):
 *
 *   26   driver/exp_intc16        intc16_demo()        16 路 INTC 自检   [两工程都有]
 *   27   driver/exp_kbd_scan      kbd_scan_demo()     矩阵键盘软件扫描   [需 ARRAY, 无 EXP_KBD]
 *   28   driver/exp_led_flow      led_flow_demo()      8 路 LED 流水灯    [两工程都有]
 *   29   driver/exp_rtc_clock     rtc_clock_demo()     数码管实时时钟     [需 IIC]
 *   30   driver/exp_scope         lcd_scope_demo()     LCD 简易示波器     [需 EXP_SPI_STREAM]
 *   31   driver/exp_apb_kbd       apb_kbd_demo()       APB 键盘控制器     [需 EXP_KBD]
 *   32   driver/exp_dot_matrix    dot_matrix_demo()    LED 点阵控制器     [需 EXP_DOT]
 *   33   driver/exp_touch_multi   touch_multi_demo()   多点触摸           [需 EXP_TOUCH_MULTI]
 *   34   driver/exp_spi_stream    spi_stream_demo()    流式 SPI + DMA     [需 EXP_SPI_STREAM]
 *--------------------------------------------------------------------
 *
 *  注意:
 *    - 全部 demo 用的都是**新的 AXI-LCD** (配置 0x2000_0000,
 *      显存 DDR3 0x4000_0000)。老的 APB-LCD (0x5200_0000) 在本版 bit 里
 *      已经移除, 原来的 4 个 lcd/touch 例程已改写成 lcd_gfx 接口。
 *    - 需要画图的 demo (0/1/20/21/22/23) 统一走
 *      driver/AXI_LCD_DMA/lcd_gfx.c 提供的 gfx_xxx() 接口。
 *    - 带中断的 demo (5/9/10/12/13/23) 内部会调用 intc_irq_init()
 *      把异常入口重设到 0x1C001000, 不要漏。
 */
#ifndef _DEMO_H_
#define _DEMO_H_

#ifdef __cplusplus
extern "C" {
#endif

/* ---- 0 ~ 2 : AXI-LCD / AXI-DMA / DDR3 ---- */
void axi_lcd_dma_demo(void);
void touch_trail_demo(void);
void ddr_test_demo(void);

/* ---- GPIO ---- */
void gpio_led_demo(void);      /* 3  拨码->LED + 数码管计数 */
void gpio_mode_demo(void);     /* 4  各种 GPIO 外设综合轮询 */

/* ---- 定时器 / PWM / 步进电机 ---- */
void timer_irq_demo(void);     /* 5 */
/* 6 号  已删除 */
void pwm_motor_demo(void);     /* 7 */
void step_motor_demo(void);    /* 8 */

/* ---- 串口 / 中断控制器 ---- */
void uart_irq_demo(void);      /* 9 */
void intc_btn_demo(void);      /* 10 */

/* ---- DMA ---- */
void apb_dma_demo(void);       /* 11 */

/* ---- SPI 及挂在 SPI 上的 ADC/DAC ---- */
void spi_adc_demo(void);       /* 12 ADC128S102 */
void spi_dac_demo(void);       /* 13 TLV5618A */

/* ---- 并行 ADC / DDS DAC ---- */
void adc9280_demo(void);       /* 14 */
void dac9708_demo(void);       /* 15 */

/* ---- I2C 器件 ---- */
void at24c64_demo(void);       /* 16 */
void rtc_demo(void);           /* 17 */

/* ---- 存储器 ---- */
void ddram_demo(void);         /* 18 DDR3 */
void ram_demo(void);           /* 19 片内 SRAM */

/* ---- LCD (AXI-LCD) / 触摸 ---- */
void lcd_test_demo(void);      /* 20 画线 + 数字 + 文字 */
void lcd_pic_demo(void);       /* 21 位图 (小企鹅) */
void lcd_pass_demo(void);      /* 22 自检: 色块/边框/网格/四角 */
void touch_demo(void);         /* 23 触摸坐标显示 */

/* ---- APB USB (FT232H 245-FIFO) ---- */
void usb_demo(void);           /* 24 PC<->板 USB 回显测试 */
void usb_kbd_demo(void);       /* 25 USB 键盘+数码管联动 (配 PC 端 usb_kbd_gui) */

/* ---- 11.5 节实验 (26~34, 需要 exp_array_spi / exp_iic_spi 的 bit) ---- */
void intc16_demo(void);        /* 26 16 路中断控制器自检 */
void kbd_scan_demo(void);      /* 27 矩阵键盘软件扫描 (中断里扫 + 消抖) */
void led_flow_demo(void);      /* 28 8 路 LED 流水灯, 8 种花样 */
void rtc_clock_demo(void);     /* 29 数码管实时时钟 + PCF8563 对时 */
void lcd_scope_demo(void);     /* 30 LCD 显示 SPI AD 波形 */
void apb_kbd_demo(void);       /* 31 APB 矩阵键盘控制器 (查询/中断) */
void dot_matrix_demo(void);    /* 32 LED 点阵控制器 */
void touch_multi_demo(void);   /* 33 多点触摸坐标采集 */
void spi_stream_demo(void);    /* 34 FIFO 型 SPI AD/DA + DMA */

#ifdef __cplusplus
}
#endif

#endif /* _DEMO_H_ */
