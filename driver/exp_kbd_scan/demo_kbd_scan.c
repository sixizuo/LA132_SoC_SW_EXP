/**
 * @file    demo_kbd_scan.c
 * @brief   11.5 实验二: 矩阵键盘中断方式输入 (纯软件扫描, 不动硬件)
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应工程: exp_array_spi (需要 J8 的矩阵键盘; 该工程没启用 EXP_KBD,
 *           引脚仍归 GPIO, 所以扫描完全在软件里做)
 *           若工程启用了 EXP_KBD, 引脚被 apb_kbd 独占, 请改用
 *           APP_SEL=31 (driver/exp_apb_kbd), 两者不能同时跑。
 *
 * 硬件:  gpioa[19:16] 行驱动 (输出, 低有效选中该行)
 *        gpioa[11:8]  列采样 (输入, 板上上拉, 按下为低)
 *
 * 设计要求 (教材 11.5 实验二):
 *   1) 扫描在中断里做, 主循环不得用 delay 轮询扫描
 *   2) 扫描周期 1 ms, 连续 8 次采样一致才确认 (消抖 8 ms)
 *   3) 键值 0~15 映射成 0~9 / A~F, 串口输出 "KEY=7" 这样一行
 *   4) 按住不放只输出一次, 松开后才能触发下一次
 *   5) ISR 里不 printf, 键值经 16 项环形队列交给主循环
 *
 * 实现要点:
 *   - 1 ms 中断一次扫一行, 4 ms 扫完一轮 (比"一次扫四行"更省中断时间)
 *   - 一轮得到一个 16 位位图 (bit = row*4 + col, 1 = 按下), 整轮比较
 *     一次, 而不是逐行比较 —— 逐行比较会把同一行里切换的键当成抖动
 *   - 键盘是机械触点, 抖动在"按下"和"松开"两个方向都有, 所以两个方向
 *     都用同一个 8 轮计数
 *
 * 现象: 依次按 16 个键, 串口打印 KEY=0 .. KEY=F; 按住 3 秒只打一行;
 *       每秒还有一行心跳 "[HB] ...", 说明主循环没被扫描阻塞。
 */
#include "main.h"
#include "GPIO/seg7.h"
#include "interrupt.h"

#define KBD_SCAN_IRQ     1u        /* 定时器占 INTC 第 1 根线 */
#define KBD_PERIOD_US    1000u     /* 1 ms 一扫 */
#define KBD_TIMER_CMP    32000u    /* 32 MHz * 1 ms */
#define KBD_DEB_ROUNDS   8u        /* 连续 8 轮一致 */

/* 行驱动字节 = gpioa[23:16]; 行在 bit[19:16] (低 4 位) */
#define KBD_ROW_BYTE     2
#define KBD_COL_BYTE     1

static const char s_key_char[16] = {
    '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'
};

/* ---- 环形队列 (单生产者 ISR / 单消费者主循环) ---- */
static volatile unsigned char s_q[16];
static volatile unsigned char s_q_head, s_q_tail;

static void q_push(unsigned char v)
{
    unsigned char nxt = (unsigned char)((s_q_head + 1u) & 0x0Fu);

    if (nxt == s_q_tail) {
        return;                          /* 满: 丢新值, 不覆盖未读数据 */
    }
    s_q[s_q_head] = v;
    s_q_head = nxt;
}

static int q_pop(void)
{
    unsigned char v;

    if (s_q_head == s_q_tail) {
        return -1;
    }
    v = s_q[s_q_tail];
    s_q_tail = (unsigned char)((s_q_tail + 1u) & 0x0Fu);
    return (int)v;
}

/* ---- 扫描状态 (ISR 与主循环共享, 都带 volatile) ---- */
static volatile unsigned char s_row;          /* 当前扫描行 0~3 */
static volatile unsigned short s_bits;        /* 本轮已采到的位图 */
static volatile unsigned short s_stable;      /* 上一轮完整位图 */
static volatile unsigned char s_deb;          /* 连续一致轮数 */
static volatile unsigned char s_hold;         /* 1 = 已上报, 等松手 */
static volatile unsigned int  s_irq_cnt;      /* 进了多少次中断 */
static volatile unsigned int  s_ms;           /* 毫秒计数 (主循环心跳用) */

/* 位图里找第一个按下的键, 没有返回 -1 */
static int bits_first(unsigned short b)
{
    int i;

    for (i = 0; i < 16; i++) {
        if (b & (1u << i)) {
            return i;
        }
    }
    return -1;
}

/*--------------------------------------------------------------------
 *  1 ms 中断: 扫一行 + 消抖 + 入队。全程不 printf。
 *------------------------------------------------------------------*/
static void kbd_scan_isr(void)
{
    unsigned char nib, col, out;
    unsigned short round;

    s_irq_cnt++;
    s_ms++;

    /* 1) 驱动当前行 (只改 bit[19:16], 同字节的高 4 位要保留) */
    out = (unsigned char)(GPIOA_OUT(KBD_ROW_BYTE) & 0xF0u);
    out |= (unsigned char)(~(1u << s_row) & 0x0Fu);
    GPIOA_OUT(KBD_ROW_BYTE) = out;

    /* 2) 等引脚稳定 (行驱动经光耦/长排线, 几微秒就够) */
    delay_us(5);

    /* 3) 采样列线, 低有效 */
    nib = (unsigned char)(GPIOA_IN(KBD_COL_BYTE) & 0x0Fu);
    for (col = 0; col < 4u; col++) {
        if ((nib & (1u << col)) == 0u) {
            s_bits |= (unsigned short)(1u << (s_row * 4u + col));
        }
    }

    s_row++;
    if (s_row < 4u) {
        goto kbd_isr_exit;                /* 一轮还没扫完 */
    }

    /* 4) 一轮结束: 整轮比较 + 消抖计数 */
    s_row  = 0;
    round  = s_bits;
    s_bits = 0;

    if (round == s_stable) {
        if (s_deb < 0xFFu) s_deb++;
    } else {
        s_stable = round;
        s_deb    = 0;
    }

    /* 5) 连续 8 轮一致 -> 确认 */
    if (s_deb >= (KBD_DEB_ROUNDS - 1u)) {
        int k = bits_first(s_stable);

        if (k >= 0 && !s_hold) {
            q_push((unsigned char)k);      /* 只入队, 不打印 */
            s_hold = 1u;
        } else if (k < 0 && s_hold) {
            s_hold = 0u;                   /* 松手, 允许下一次 */
        }
    }

kbd_isr_exit:
    *timer_cfg    = *timer_cfg;            /* 读 cfg 清定时器中断 */
    *intc_int_clr = (1u << KBD_SCAN_IRQ);
}

void kbd_scan_demo(void)
{
    unsigned int last_hb = 0;
    unsigned int n = 0;

    printf("exp2: 4x4 keypad, scanned in 1ms timer ISR (debounce %u rounds)\r\n",
           KBD_DEB_ROUNDS);
    printf("rows = gpioa[19:16] out, cols = gpioa[11:8] in (pull-up)\r\n");

    /* 方向: 1 = 输入, 0 = 输出 */
    GPIOA_DIR(KBD_COL_BYTE) = 0xFF;        /* 列: 输入 */
    GPIOA_DIR(KBD_ROW_BYTE) = 0x00;        /* 行: 输出 */
    GPIOA_OUT(KBD_ROW_BYTE) = 0x0F;        /* 全高 = 不选中任何行 */

    seg7_init();                           /* 数码管显示最近键值, 不需要可去掉 */

    intc_irq_init();
    *intc_int_en   = (1u << KBD_SCAN_IRQ);
    *intc_int_pol  = (1u << KBD_SCAN_IRQ);
    *intc_int_edge = 0x0000;               /* 定时器是电平中断 */
    intc_irq_attach(KBD_SCAN_IRQ, kbd_scan_isr);

    *timer_cfg = 0x00000006;
    *timer_cnt = 0;
    *timer_cmp = KBD_TIMER_CMP;
    *timer_stp = KBD_TIMER_CMP;
    *timer_cfg |= 0x00000001;

    for (;;) {
        int k = q_pop();

        if (k >= 0) {
            char s[4];
            s[0] = s_key_char[k];
            s[1] = 0;
            seg7_set_chars(s, 1);          /* 最右一位显示键码 */
            printf("KEY=%d (%c)\r\n", k, s_key_char[k]);
            n++;
        }

        /* 心跳: 每秒一行, 若扫描阻塞了主循环这里就会变慢 */
        if (s_ms - last_hb >= 1000u) {
            last_hb = s_ms;
            printf("[HB] keys=%u irq=%u  (1s)\r\n", n, s_irq_cnt);
        }
    }
}
