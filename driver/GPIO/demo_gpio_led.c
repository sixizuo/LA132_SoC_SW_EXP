/**
 * @file    demo_gpio_led.c
 * @brief   GPIO 基础例程: 拨码开关 -> LED, 同时 4 位数码管秒表计数
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/gpio_interrupt_polling.c.bak (2026-10-31 上板验证通过)
 *
 * 硬件:
 *   gpioa[7:0]  拨码开关 SW1~SW8       (输入, dir=1)
 *   gpioa[31:24] LED D1~D8             (输出, dir=0)
 *   gpiob[23:16] 数码管位选 an         (3-8 译码器, 只能送 0~7 序号)
 *   gpiob[31:24] 数码管段选 seg        (a,b,c,d,e,f,g,dp)
 *
 * 数码管是**共阳极**, 段码取反、全灭 0xFF、先消隐再换位,
 * 细节都封装在 driver/GPIO/seg7.c, 这里只管调用。
 *
 * 现象:
 *   - 拨动拨码开关, 对应 LED 立刻跟着变 (1 s 同步一次)
 *   - 数码管每秒 +1, 0000 -> 9999 循环
 *   - 串口每秒打印一行当前值
 */
#include "main.h"
#include "GPIO/seg7.h"

void gpio_led_demo(void)
{
    unsigned int num  = 0;      /* 4 位显示值 */
    unsigned int tick = 0;      /* 1 s 节拍计数 */
    int          p;

    /* 方向: 1 = 输入, 0 = 输出。
     *   0x00fff0ff -> [7:0] 拨码输入, [31:24] LED 输出,
     *   中间两个字节沿用原例程(本 demo 不用) */
    *gpioa_dir = 0x00fff0ff;

    seg7_init();                /* gpiob[31:16] 配成输出并清屏 */
    seg7_set_value(num);

    printf("gpio: sw = gpioa[7:0], led = gpioa[31:24]\r\n");
    printf("seg7: an = gpiob[23:16] (3-8 decoder, 0~3), seg = gpiob[31:24]\r\n");
    printf("seg7: COMMON ANODE -> segment code inverted, all-off = 0xFF\r\n");

    for (;;) {
        /* 动态扫描: 4 位轮流点亮, 每位 2 ms -> 整屏刷新约 125 Hz */
        for (p = 0; p < 4; p++) {
            seg7_scan();
            delay_ms(2);
        }

        /* 1 s 节拍: 一轮扫描 4 x 2 ms = 8 ms, 125 轮 = 1 s */
        tick++;
        if (tick >= 125) {
            unsigned int sw = (unsigned int)(*gpioa_sw);

            tick = 0;
            *gpioa_led = (unsigned char)sw;     /* 拨码 -> LED */

            printf("[DISP] %04d  sw=0x%02x\r\n", num, sw);

            num = (num + 1u) % 10000u;
            seg7_set_value(num);
        }
    }
}
