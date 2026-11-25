/**
 * @file    demo_ram.c
 * @brief   片内 SRAM 窗口读写 (0x300F_0000, 16 KB)
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/main.c_RAM_test
 *
 * 改动: 老例程写完读一遍就结束, 现在循环 + 换数据, 方便长时间比对。
 *
 * 注意: 这块 0x300F_0000 是 CPU 侧的数据窗口 (dbus), **不能取指**,
 *       也不能当 DMA 的 work area 给 openocd 用 (会跑飞)。
 *       这里只做数据读写, 是安全的。
 *
 * 现象: 串口打印 [0x300F0000 + 4i] = i (+ 轮次), 全部一致。
 */
#include "main.h"

#define RAM_TEST_WORDS   256

void ram_demo(void)
{
    int i;
    unsigned int round = 0;
    unsigned int expect;

    printf("ram demo: base 0x%08x, %d words per round\r\n",
           (unsigned int)ram_base, RAM_TEST_WORDS);

    for (;;) {
        for (i = 0; i < RAM_TEST_WORDS; i++) {
            *(ram_base + i) = (int)(i + (int)round);
        }

        for (i = 0; i < RAM_TEST_WORDS; i++) {
            expect = (unsigned int)(i + (int)round);
            printf("  [0x%08x] = %d", (unsigned int)(ram_base + i),
                   *(ram_base + i));
            if ((unsigned int)*(ram_base + i) != expect) {
                printf("   MISMATCH (expect %u)", expect);
            }
            printf("\r\n");
            delay_ms(1);
        }

        round++;
        delay_s(1);
    }
}
