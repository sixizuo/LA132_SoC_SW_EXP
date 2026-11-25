/**
 * @file    demo_timer_irq.c
 * @brief   定时器中断 + 数码管动态扫描
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/main.c_timer_irq_vs_0
 *
 * 改动:
 *   1) 中断服务函数原来放在 user/interrupt.c 的 timer_handler(), 依赖
 *      main.h 里的 static 变量; 现在搬到本文件, 用 intc_irq_attach(1, ...)
 *      挂到 INTC 第 1 根线。
 *   2) 老例程写 `*gpiob_dir = 0xff00ff00` 想配 seg/an 为输出, 但本板
 *      dir 是 1=输入、0=输出, 那样写恰好把 seg 配成了输入。这里用
 *      seg7_init() 统一处理。
 *   3) 中断里原来直接读 disp_buffer 拼 gpiob_out, 现在改为调用
 *      seg7_scan(), 消隐/换位/段码的顺序和 APP_SEL=3 完全一致。
 *
 * 现象:
 *   - 数码管每秒 +1 (由定时器中断驱动扫描, 不用主循环延时)
 *   - 串口每秒打印一次秒计数
 */
#include "main.h"
#include "GPIO/seg7.h"

#define TIMER_IRQ_LINE   1u        /* INTC 第 1 根线 */
#define TIMER_PERIOD     32000u    /* 32 MHz 下约 1 ms */

static volatile unsigned int s_ms  = 0;   /* 毫秒计数 */
static volatile unsigned int s_sec = 0;   /* 秒计数   */

static void timer_isr(void)
{
    seg7_scan();                  /* 每 1 ms 扫一位 -> 4 位刷新 250 Hz */

    if (++s_ms >= 1000u) {
        s_ms = 0;
        s_sec++;
        seg7_set_value(s_sec);    /* 数码管显示秒数 */
    }

    *timer_cfg    = *timer_cfg;   /* 读 cfg 清定时器中断 */
    *intc_int_clr = (1u << TIMER_IRQ_LINE);
}

void timer_irq_demo(void)
{
    unsigned int last = 0xFFFFFFFFu;

    intc_irq_init();              /* EBase / VS / HWI4 / IE */

    /* INTC 第 1 根线: 高电平触发, 电平方式 */
    *intc_int_en   = (1u << TIMER_IRQ_LINE);
    *intc_int_pol  = (1u << TIMER_IRQ_LINE);
    *intc_int_edge = 0x0000;

    seg7_init();
    seg7_set_value(0);

    intc_irq_attach(TIMER_IRQ_LINE, timer_isr);

    /* 定时器: 停止 -> 周期模式 + 中断使能 -> 计数/比较值 -> 启动 */
    *timer_cfg = 0x00000006;
    *timer_cnt = 0x00000000;
    *timer_cmp = TIMER_PERIOD;
    *timer_stp = TIMER_PERIOD;
    *timer_cfg |= 0x00000001;

    printf("timer: cfg=0x%08x cmp=%u (about 1 ms @32MHz)\r\n",
           *timer_cfg, TIMER_PERIOD);

    for (;;) {
        if (s_sec != last) {
            last = s_sec;
            printf("[TIMER] %u s\r\n", s_sec);
        }
    }
}
