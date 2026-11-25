/**
 * @file    demo_intc16.c
 * @brief   11.5 实验一: 16 路中断控制器 (intc_top16) 的软件测试
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应硬件: hw/peripheral/exp_intc16/intc_top16.v
 * 对应工程: exp_array_spi / exp_iic_spi (两者都定义了 EXP_INTC16)
 *
 * 与老 8 路版本的差别只有位宽: 寄存器偏移完全不变
 *   0x00 EN / 0x04 POL / 0x08 EDGE / 0x0C CLR / 0x10 SET / 0x14 OUT
 * 所以老 demo (APP_SEL=10, 只操作 bit5/bit6) 一行不改也能跑。
 *
 * 测试内容:
 *   阶段 1  逐位自检 (不开全局中断, 纯轮询)
 *           for i = 0..15: SET=1<<i -> OUT 只该有一位; CLR=1<<i -> OUT 归 0
 *           顺带验证 "写 0xFFFF 读回 0xFFFF" 说明 16 位寄存器真的可写。
 *   阶段 2  中断投递 (开全局中断)
 *           16 路只有一根线进 CPU, 软件靠读 OUT 定位。
 *           给 int_14 / int_15 挂处理函数, 先 SET 一路, 再两路同时 SET,
 *           确认 dispatch 能取到 14/15 这两条"新增的"线 (老 start.S 只
 *           认 0~7, 若没改汇编这里会一直进中断但不计数)。
 *   阶段 3  真实中断源: 键盘 (int_11) / 点阵 (int_12) / SPI 流 (int_13)
 *           只打印 OUT 的实际取值, 不强制要求有输入 —— 方便在没有扩展板
 *           时也能判断"这三位没有被别的东西误拉高"。
 *
 * 现象: 串口打印一张逐位测试表 + 中断计数, 全绿时最后打印 ALL PASS。
 */
#include "main.h"
#include "interrupt.h"

#define INTC16_MASK   0x0000FFFFu

static volatile unsigned int s_irq14 = 0;
static volatile unsigned int s_irq15 = 0;
static unsigned int s_fail = 0;

/*--------------------------------------------------------------------
 *  两个"软件强制"线的处理函数 (教材表 11-7 的 int_14 / int_15)
 *  ISR 里必须清自己那一位, 否则 one_int_gen 的边沿锁存会一直有效,
 *  退出中断立刻重入 —— 表现为主循环再也不动。
 *------------------------------------------------------------------*/
static void isr14(void)
{
    *intc_int_clr = (1u << 14);
    s_irq14++;
}

static void isr15(void)
{
    *intc_int_clr = (1u << 15);
    s_irq15++;
}

/*--------------------------------------------------------------------
 *  阶段 1: 逐位写 SET / 读 OUT / 写 CLR
 *------------------------------------------------------------------*/
static void self_test_bits(void)
{
    unsigned int i, out;

    printf("\r\n-- phase 1: per-bit SET/CLR (polling, no global irq) --\r\n");
    printf("   bit |  SET->OUT | after CLR\r\n");

    /* 边沿方式 + 高有效, 全部使能: 这样 INT_SET 写进去就是一个挂起位 */
    *intc_int_en   = INTC16_MASK;
    *intc_int_pol  = INTC16_MASK;
    *intc_int_edge = INTC16_MASK;
    *intc_int_clr  = INTC16_MASK;

    for (i = 0; i < 16u; i++) {
        *intc_int_clr = INTC16_MASK;             /* 先保证干净 */
        *intc_int_set = (1u << i);

        out = *intc_int_out & INTC16_MASK;
        printf("   %2u |   0x%04x   |", i, out);

        if (out != (1u << i)) {
            printf("  <-- FAIL (expect 0x%04x)\r\n", (1u << i));
            s_fail++;
        } else {
            printf(" ok\r\n");
        }

        *intc_int_clr = (1u << i);
        out = *intc_int_out & INTC16_MASK;
        if (out != 0u) {
            printf("        !! CLR 之后 OUT 仍是 0x%04x\r\n", out);
            s_fail++;
        }
    }

    /* 16 位可写性: 写全 1 读回全 1, 再清掉 */
    *intc_int_en = 0x0000FFFFu;
    if ((*intc_int_en & INTC16_MASK) != INTC16_MASK) {
        printf("   !! EN 写 0xFFFF 读回 0x%08x, 16 位没接全?\r\n", *intc_int_en);
        s_fail++;
    } else {
        printf("   EN 回读 0x%04x (16 位可写) ok\r\n", *intc_int_en & INTC16_MASK);
    }
    *intc_int_clr = INTC16_MASK;
    *intc_int_en  = 0u;
}

/*--------------------------------------------------------------------
 *  阶段 2: 中断投递 —— 验证 start.S 的新分发能取到 8~15
 *------------------------------------------------------------------*/
static void test_delivery(void)
{
    unsigned int i;

    printf("\r\n-- phase 2: irq delivery on int_14 / int_15 --\r\n");

    intc_irq_init();                     /* EBase / VS / HWI4 / IE */

    *intc_int_pol  = INTC16_MASK;
    *intc_int_edge = (1u << 14) | (1u << 15);
    *intc_int_en   = (1u << 14) | (1u << 15);

    intc_irq_attach(14, isr14);
    intc_irq_attach(15, isr15);

    *intc_int_set = (1u << 14);
    for (i = 0; i < 2000u; i++) {        /* 等中断进来, 不要 delay_ms 太粗 */
        if (s_irq14) break;
        delay_us(10);
    }
    printf("   SET bit14 : irq14=%u irq15=%u OUT=0x%04x %s\r\n",
           s_irq14, s_irq15, *intc_int_out & INTC16_MASK,
           (s_irq14 == 1u && s_irq15 == 0u) ? "ok" : "<-- FAIL");
    if (!(s_irq14 == 1u && s_irq15 == 0u)) s_fail++;

    *intc_int_set = (1u << 15);
    for (i = 0; i < 2000u; i++) {
        if (s_irq15) break;
        delay_us(10);
    }
    printf("   SET bit15 : irq14=%u irq15=%u OUT=0x%04x %s\r\n",
           s_irq14, s_irq15, *intc_int_out & INTC16_MASK,
           (s_irq15 == 1u) ? "ok" : "<-- FAIL");
    if (s_irq15 != 1u) s_fail++;

    /* 两路同时挂起: 一根线进 CPU, 处理完 14 之后应该再来一次 15 */
    s_irq14 = 0; s_irq15 = 0;
    *intc_int_set = (1u << 14) | (1u << 15);
    for (i = 0; i < 4000u; i++) {
        if (s_irq14 && s_irq15) break;
        delay_us(10);
    }
    printf("   SET 14+15 : irq14=%u irq15=%u OUT=0x%04x %s\r\n",
           s_irq14, s_irq15, *intc_int_out & INTC16_MASK,
           (s_irq14 && s_irq15) ? "ok" : "<-- FAIL");
    if (!(s_irq14 && s_irq15)) s_fail++;

    *intc_int_en = 0u;
}

/*--------------------------------------------------------------------
 *  阶段 3: 看一眼真实中断源那几位的实际电平
 *------------------------------------------------------------------*/
static void show_real_sources(void)
{
    unsigned int out;

    *intc_int_en   = INTC16_MASK;
    *intc_int_pol  = INTC16_MASK;
    *intc_int_edge = 0u;                  /* 电平方式, 直接看引脚电平 */

    out = *intc_int_out & INTC16_MASK;
    printf("\r\n-- phase 3: real sources (level mode) --\r\n");
    printf("   OUT = 0x%04x\r\n", out);
    printf("   int_0 UART rx=%u  int_5 K1=%u  int_6 K2=%u\r\n",
           (out >> 0) & 1u, (out >> 5) & 1u, (out >> 6) & 1u);
    printf("   int_11 kbd=%u int_12 dot=%u int_13 spis=%u (无操作时应为 0)\r\n",
           (out >> 11) & 1u, (out >> 12) & 1u, (out >> 13) & 1u);

    *intc_int_edge = INTC16_MASK;
    *intc_int_clr  = INTC16_MASK;
    /* 看完就全部关掉: 电平方式下只要有一路输入还是高 (比如手按着 K1),
     * 而软件又没给它挂处理函数, 就会变成中断风暴把主循环饿死。 */
    *intc_int_en   = 0u;
}

void intc16_demo(void)
{
    printf("exp1: 16-line interrupt controller test\r\n");
    printf("INTC @ 0x30020000, EN/POL/EDGE/CLR/SET/OUT = 16 bit\r\n");

    self_test_bits();
    test_delivery();
    show_real_sources();

    printf("\r\n==== INTC16 SELFTEST: %s (%u error%s) ====\r\n",
           s_fail ? "FAIL" : "PASS", s_fail, s_fail > 1u ? "s" : "");

    for (;;) {
        delay_s(1);
        printf("[INT16] OUT=0x%04x en=0x%04x  irq14=%u irq15=%u\r\n",
               *intc_int_out & INTC16_MASK,
               *intc_int_en  & INTC16_MASK,
               s_irq14, s_irq15);
    }
}
