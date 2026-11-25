/**
 * @file    demo_apb_kbd.c
 * @brief   11.5 实验六: APB 矩阵键盘控制器 (0x3005_0000) 的查询与中断测试
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应硬件: hw/peripheral/exp_kbd/apb_kbd.v
 * 对应工程: exp_array_spi  (必须: EXP_KBD 宏)
 *           !! 该 bit 里 gpio19~16 / gpio11~8 被控制器独占, 所以
 *              APP_SEL=27 (软件扫描) 不能在这个 bit 上跑, 二者互斥。
 *
 * 测试内容:
 *   1) 版本 = 0x4B42_0001, 复位值 (CTRL=0, DEBOUNCE=8, KEYMAP 恒等)
 *   2) 中断方式: CTRL = EN|IRQEN, ISR 读 KEY 清标志, 键值经队列交主循环打印
 *   3) 按住不放只上报一次 (硬件保证: 松手前不再进 S_HIT)
 *   4) 查询方式: 关掉 IRQEN, 只读 STATUS/KEY
 *   5) KEYMAP 重映射: 把 16 个键改成 ASCII '0'~'F'
 *   6) 扫描周期: CTRL[3:2] 改 2 ms, 串口能看出确认变慢
 *
 * 串口命令 (主循环解析):
 *   'q' 中断/查询方式切换
 *   'm' 重映射 (恒等 <-> ASCII)
 *   '1'..'4' 扫描周期 1/2/5/10 ms
 *   'c' 清键值 + 溢出
 *
 * 现象: 依次按 16 个键, 串口打印 KEY=0..15 (或 KEY='0'..'F' 重映射后);
 *       按住 3 秒只打一行; 每秒一行 [HB]。
 */
#include "main.h"
#include "interrupt.h"
#include "GPIO/seg7.h"

#define KBD_IRQ_LINE    11u          /* 教材表 11-7: int_11 = 矩阵键盘 */

static const char s_hex[16] = { '0','1','2','3','4','5','6','7',
                                '8','9','A','B','C','D','E','F' };

/* 队列 */
static volatile unsigned char s_q[16];
static volatile unsigned char s_qh, s_qt;

static void q_push(unsigned char v)
{
    unsigned char n = (unsigned char)((s_qh + 1u) & 0x0Fu);
    if (n == s_qt) return;
    s_q[s_qh] = v;
    s_qh = n;
}

static int q_pop(void)
{
    unsigned char v;
    if (s_qh == s_qt) return -1;
    v = s_q[s_qt];
    s_qt = (unsigned char)((s_qt + 1u) & 0x0Fu);
    return (int)v;
}

static volatile unsigned int s_irq_cnt;

/* 中断方式: 读 KEY 会清 key_valid, 同时让 kbd_irq 不再为高。
 * 2026-11-25 修: 还必须写 INTC 的 INT_CLR —— 边沿模式下 int_lt 锁存后
 * 只认 INT_CLR, 不清的话 int_out 一直为高, ISR 出口立刻重进, 程序卡死。 */
static void kbd_isr(void)
{
    unsigned int k = kbd_key;                  /* 读 KEY = 取键值 + 清标志 */

    *intc_int_clr = (1u << KBD_IRQ_LINE);      /* 清 INTC 边沿锁存 */

    if (k != 0xFFu) {
        q_push((unsigned char)k);
        s_irq_cnt++;
    }
}

static void print_ctrl(const char *tag, unsigned int c)
{
    static const char *const per[4] = { "1ms", "2ms", "5ms", "10ms" };

    printf("%s CTRL=0x%08x en=%u irqen=%u period=%s\r\n", tag, c,
           (c >> 0) & 1u, (c >> 1) & 1u, per[(c >> 2) & 3u]);
}

void apb_kbd_demo(void)
{
    unsigned int v, st, ctrl;
    unsigned int query_mode = 0;
    unsigned int ident_map  = 1;
    unsigned int loop_cnt   = 0;

    printf("exp6: APB keypad controller @0x%08x\r\n", kbd_base);

    v = kbd_version;
    printf("VERSION = 0x%08x (expect 0x4b420001) %s\r\n", v,
           (v == 0x4B420001u) ? "ok" : "<-- FAIL");
    printf("reset: CTRL=0x%08x DEBOUNCE=%u KEYMAP0=0x%08x\r\n",
           kbd_ctrl, kbd_debounce, kbd_keymap0);

    /* 数码管顺便显示键值, 但 seg7 与点阵共用 gpiob 高 16 位,
     * 本工程没启用 EXP_DOT, 所以可以放心用。 */
    seg7_init();
    seg7_set_chars("----", 4);

    intc_irq_init();
    *intc_int_pol  |= (1u << KBD_IRQ_LINE);
    *intc_int_edge |= (1u << KBD_IRQ_LINE);    /* 脉冲 -> 边沿锁存 */
    *intc_int_en   |= (1u << KBD_IRQ_LINE);
    intc_irq_attach(KBD_IRQ_LINE, kbd_isr);

    kbd_debounce = 8;
    kbd_ctrl     = KBD_CTRL_EN | KBD_CTRL_IRQEN;
    print_ctrl("start", kbd_ctrl);

    for (;;) {
        int c = uart_getchar_nb();
        int k;

        if (c == 'q') {
            query_mode = !query_mode;
            ctrl = kbd_ctrl;
            if (query_mode) {
                ctrl &= ~KBD_CTRL_IRQEN;       /* 只查询 */
            } else {
                ctrl |=  KBD_CTRL_IRQEN;
            }
            kbd_ctrl = ctrl;
            print_ctrl(query_mode ? "-> query" : "-> irq", kbd_ctrl);
        } else if (c == 'm') {
            ident_map = !ident_map;
            if (ident_map) {
                kbd_keymap0 = 0x03020100u;
                kbd_keymap1 = 0x07060504u;
                kbd_keymap2 = 0x0b0a0908u;
                kbd_keymap3 = 0x0f0e0d0cu;
                printf("[MAP] identity (0x00~0x0f)\r\n");
            } else {
                /* 0~9 -> ASCII '0'~'9', 10~15 -> 'A'~'F' */
                kbd_keymap0 = 0x33323130u;
                kbd_keymap1 = 0x37363534u;
                kbd_keymap2 = 0x42413938u;
                kbd_keymap3 = 0x46454443u;
                printf("[MAP] ascii ('0'~'F')\r\n");
            }
        } else if (c >= '1' && c <= '4') {
            ctrl = kbd_ctrl;
            ctrl = (ctrl & ~(3u << 2)) | ((unsigned int)(c - '1') << 2);
            kbd_ctrl = ctrl;
            print_ctrl("-> period", kbd_ctrl);
        } else if (c == 'c') {
            kbd_ctrl = kbd_ctrl | KBD_CTRL_CLRKEY;
            kbd_ctrl = kbd_ctrl & ~KBD_CTRL_CLRKEY;
            s_qh = s_qt = 0;
            printf("[CLR] key value + overflow cleared\r\n");
        }

        if (query_mode) {
            st = kbd_status;
            if (st & KBD_ST_KEYVALID) {
                k = (int)kbd_key;              /* 读 KEY 清 valid */
                if (k != 0xFF) q_push((unsigned char)k);
            }
        }

        k = q_pop();
        if (k >= 0) {
            char s[2];
            if (ident_map) {
                printf("KEY=%d  (raw 0x%02x)\r\n", k, (unsigned int)k);
            } else {
                printf("KEY=%c  (ascii 0x%02x)\r\n", (char)k, (unsigned int)k);
            }
            s[0] = (ident_map && k < 16) ? s_hex[k] : (char)k;
            s[1] = 0;
            seg7_set_chars(s, 1);
        }

        /* 每 5 ms 轮一次: 查询方式下这个轮询间隔就是按键响应的上限,
         * 中断方式下它只影响队列的取空速度。每 200 次 (~1 s) 打一行心跳,
         * 顺带把 RAW 打出来 (行号应在 0~3 循环、列线全 1)。 */
        if (++loop_cnt >= 200u) {
            loop_cnt = 0;
            printf("[HB] irq=%u mode=%s RAW=0x%08x STATUS=0x%08x\r\n",
                   s_irq_cnt, query_mode ? "query" : "irq",
                   kbd_raw, kbd_status);
        }
        delay_ms(5);
    }
}
