/**
 * @file    demo_intc_btn_demo.c
 * @brief   按键中断: INTC 第 5/6/7 根线, 三种触发方式
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/main.c_intc_btn_int_initial_3_modes (+ interrupt.c 里的
 *       btn0/1/2_handler)
 *
 * 三种触发方式只要改下面三个寄存器:
 *   边沿 + 正极性 (point mode, 本 demo 默认):
 *       *intc_int_edge = 0x00e0; *intc_int_en = 0x00e0; *intc_int_pol = 0x00e0;
 *   电平 + 高电平 (level mode):
 *       *intc_int_edge = 0x0000; *intc_int_en = 0x00e0; *intc_int_pol = 0x00e0;
 *   电平 + 低电平 (level mode, 按下为低):
 *       *intc_int_edge = 0x0000; *intc_int_en = 0x00e0; *intc_int_pol = 0x0000;
 *
 * 注意: 电平方式下按键必须带硬件上拉, 而且 ISR 里必须清中断, 否则松手
 *       之前会反复进入。这里 ISR 里写 *intc_int_clr 清对应位。
 *
 * 现象: 按 K1/K2/K3, LED 的 D1/D2/D3 分别翻转, 串口每秒打印按键次数。
 */
#include "main.h"

#define BTN_IRQ_BASE   5u         /* 第 5 根线 = 第 1 个按键 */

static volatile unsigned int s_cnt[2] = { 0, 0 };

/* 中断里只做"清中断 + 翻转 LED + 计数", 不 printf:
 * 115200 下一个字符约 87us, 在 ISR 里打印会把中断拖得很长。 */
static void btn_isr(unsigned int n)
{
    unsigned int line = BTN_IRQ_BASE + n;

    *intc_int_clr = (1u << line);          /* 清 INTC 中断标志 */
    *gpioa_led   ^= (unsigned char)(1u << n);
    s_cnt[n]++;
}

static void btn0_isr(void) { btn_isr(0); }
static void btn1_isr(void) { btn_isr(1); }

void intc_btn_demo(void)
{
    unsigned int last0 = 0xFFFFFFFFu, last1 = 0xFFFFFFFFu, last2 = 0xFFFFFFFFu;

    *gpioa_dir = 0x00fff0ff;               /* LED = 输出 */
    *gpioa_led = 0xff;

    intc_irq_init();

    /* point mode: 第 6~5 根线, 正边沿触发 */
    *intc_int_edge = 0x0060;
    *intc_int_en   = 0x0060;
    *intc_int_pol  = 0x0060;

    intc_irq_attach(5, btn0_isr);
    intc_irq_attach(6, btn1_isr);
 
    printf("intc btn demo: irq 5/6, rising edge, LED1~2 follow\r\n");

    for (;;) {
        if (s_cnt[0] != last0 || s_cnt[1] != last1 ) {
            last0 = s_cnt[0];
            last1 = s_cnt[1];
            printf("[BTN] K1=%u  K2=%u  \r\n", last0, last1);
        }
        delay_ms(100);
    }
}
