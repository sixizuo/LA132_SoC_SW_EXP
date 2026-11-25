/**
 * @file    demo_led_flow.c
 * @brief   11.5 实验三: 8 路 LED 流水灯 (定时器节拍 + 花样状态机)
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应工程: exp_array_spi / exp_iic_spi 都可以 (只用到 gpioa[31:24] 的 LED)
 *
 * 设计要求 (教材 11.5 实验三):
 *   1) 8 种花样: 单点左移 / 单点右移 / 双点对开 / 累加填充 /
 *                累减清空 / 霹雳闪烁 / 半亮交替 / 全亮呼吸
 *   2) 节拍由 1 ms 定时器中断累计, 默认 100 ms 一变, 可切 50/100/200/500
 *   3) K1 切下一种, K2 反向, 串口打印花样名和节拍
 *   4) 全程不用 delay_ms 控制节奏  ← 本文件里 delay_ms 一次都没出现
 *
 * 实现要点:
 *   - 花样不是"用循环跑一遍", 而是"第 n 拍输出什么"的纯函数,
 *     这样节拍改变时不需要重入任意位置的状态, 也不会越界。
 *   - 累加/累减/霹雳都用一个 0~8 的 step 计数器, 不用 % 和除法,
 *     避免编译器去链 libgcc 的 32 位除法。
 *   - 呼吸花样不走"拍"的逻辑: 它每个 1 ms 都要改一次输出 (软件 PWM),
 *     所以在 ISR 里单独一个分支处理。
 *
 * 现象: LED 先单点左移, 每 100 ms 走一位; 按 K1/K2 换花样, 串口打印
 *       "PAT 3/8 累加填充  interval=100ms"。
 */
#include "main.h"
#include "interrupt.h"

#define LED_BYTE        3            /* gpioa[31:24] = LED D1~D8 */
#define TIMER_IRQ       1u           /* 定时器 = INTC 第 1 根线 */
#define KEY1_IRQ        5u           /* K1 = 第 5 根线 */
#define KEY2_IRQ        6u           /* K2 = 第 6 根线 */
#define TIMER_CMP       32000u       /* 1 ms @32 MHz */

static const char *const s_pat_name[8] = {
    "shift-left", "shift-right", "double-open", "fill-up",
    "fill-down",  "blink-bolt",  "half-alt",    "breath"
};

static volatile unsigned int  s_ms;          /* 1 ms 计数 */
static volatile unsigned int  s_interval = 100u;
static volatile unsigned int  s_beat;        /* 拍计数 */
static volatile unsigned int  s_beat_ms;     /* 上一次换拍的 ms */
static volatile unsigned char s_pat;         /* 当前花样 0~7 */
static volatile unsigned char s_step;        /* 累加类花样的 0~8 步 */
static volatile unsigned char s_changed = 1; /* 主循环打印用 */
static volatile unsigned char s_led;

/*--------------------------------------------------------------------
 *  第 pat 种花样在第 beat 拍该输出什么 (纯函数, 无状态)
 *------------------------------------------------------------------*/
static unsigned char pattern_at(unsigned char pat, volatile unsigned char *step)
{
    unsigned char s = *step;
    unsigned char v;

    switch (pat) {
        case 0:                                   /* 单点左移 */
            v = (unsigned char)(1u << (s & 7u));
            break;
        case 1:                                   /* 单点右移 */
            v = (unsigned char)(0x80u >> (s & 7u));
            break;
        case 2:                                   /* 双点对开 */
            v = (unsigned char)((1u << (s & 3u)) | (0x80u >> (s & 3u)));
            break;
        case 3:                                   /* 累加填充: 1,3,7..FF */
            v = (s >= 8u) ? 0xFFu : (unsigned char)((1u << (s + 1u)) - 1u);
            break;
        case 4:                                   /* 累减清空: FE,FC,F8..00 */
            v = (s >= 8u) ? 0x00u : (unsigned char)~(unsigned char)((1u << (s + 1u)) - 1u);
            break;
        case 5:                                   /* 霹雳: 填充 + 每 3 拍全灭 */
            /* 不用 s % 3u: 避免链接 libgcc 的 32 位取模, 直接列出三拍 */
            v = ((s == 2u) || (s == 5u) || (s == 8u)) ? 0x00u
                                 : (unsigned char)((1u << (s + 1u)) - 1u);
            break;
        case 6:                                   /* 半亮交替 */
            v = (s & 1u) ? 0xF0u : 0x0Fu;
            break;
        default:                                  /* 呼吸由 ISR 单独处理 */
            v = s_led;
            break;
    }

    /* 步进并回绕: 8 种花样统一用 0~8 循环, 6 号用 0~1 */
    if (pat == 6u) {
        s = (unsigned char)((s + 1u) & 1u);
    } else if (pat == 5u) {
        s = (unsigned char)((s >= 8u) ? 0u : (s + 1u));
    } else {
        s = (unsigned char)((s >= 8u) ? 0u : (s + 1u));
    }
    *step = s;

    return v;
}

/* 软件 PWM 呼吸: 每 1 ms 更新, 亮度 0~7 以 8 ms 为一级上下走 */
static unsigned char breath_at(unsigned int ms)
{
    unsigned int ph = (ms >> 3) & 0x0Fu;
    unsigned int lv = (ph < 8u) ? ph : (15u - ph);
    unsigned int sub = ms & 0x07u;

    return (sub < lv) ? 0xFFu : 0x00u;
}

/*--------------------------------------------------------------------
 *  1 ms 定时器中断: 只做"计数 + 算输出 + 写 LED 字节"
 *------------------------------------------------------------------*/
static void led_timer_isr(void)
{
    unsigned char v;

    s_ms++;

    if (s_pat == 7u) {
        v = breath_at(s_ms);
    } else if ((unsigned int)(s_ms - s_beat_ms) >= s_interval) {
        s_beat_ms = s_ms;
        s_beat++;
        v = pattern_at(s_pat, &s_step);
        s_led = v;
    } else {
        v = s_led;
    }

    GPIOA_OUT(LED_BYTE) = v;

    *timer_cfg    = *timer_cfg;
    *intc_int_clr = (1u << TIMER_IRQ);
}

/* K1 / K2: 只改"当前花样", 打印留给主循环 */
static void key1_isr(void)
{
    s_pat   = (unsigned char)((s_pat + 1u) & 7u);
    s_step  = 0;
    s_beat  = 0;
    s_changed = 1;
    *intc_int_clr = (1u << KEY1_IRQ);
}

static void key2_isr(void)
{
    s_pat   = (unsigned char)((s_pat + 7u) & 7u);
    s_step  = 0;
    s_beat  = 0;
    s_changed = 1;
    *intc_int_clr = (1u << KEY2_IRQ);
}

void led_flow_demo(void)
{
    unsigned int last_pat = 0xFFu, last_int = 0;

    printf("exp3: 8-bit LED flow, 8 patterns, beat from 1ms timer\r\n");
    printf("  K1 = next pattern, K2 = prev, serial '1'..'4' = 50/100/200/500 ms\r\n");

    GPIOA_DIR(LED_BYTE) = 0x00;
    GPIOA_OUT(LED_BYTE) = 0x00;

    intc_irq_init();

    *intc_int_en   = (1u << TIMER_IRQ);
    *intc_int_pol  = (1u << TIMER_IRQ);
    *intc_int_edge = 0x0000;
    intc_irq_attach(TIMER_IRQ, led_timer_isr);

    /* K1/K2: 上升沿, 边沿方式 */
    *intc_int_pol  |= (1u << KEY1_IRQ) | (1u << KEY2_IRQ);
    *intc_int_edge |= (1u << KEY1_IRQ) | (1u << KEY2_IRQ);
    *intc_int_en   |= (1u << KEY1_IRQ) | (1u << KEY2_IRQ);
    intc_irq_attach(KEY1_IRQ, key1_isr);
    intc_irq_attach(KEY2_IRQ, key2_isr);

    *timer_cfg = 0x00000006;
    *timer_cnt = 0;
    *timer_cmp = TIMER_CMP;
    *timer_stp = TIMER_CMP;
    *timer_cfg |= 0x00000001;

    for (;;) {
        int c = uart_getchar_nb();

        if (c >= '1' && c <= '4') {
            static const unsigned int tab[4] = { 50u, 100u, 200u, 500u };
            s_interval = tab[c - '1'];
            s_beat_ms  = s_ms;
            s_changed  = 1;
        }

        if (s_changed || s_pat != last_pat || s_interval != last_int) {
            s_changed = 0;
            last_pat  = s_pat;
            last_int  = s_interval;
            printf("PAT %u/8  %-12s interval=%ums beat=%u\r\n",
                   (unsigned int)s_pat + 1u, s_pat_name[s_pat & 7u],
                   s_interval, s_beat);
        }
    }
}
