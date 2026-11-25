/**
 * @file    demo_ddram.c
 * @brief   DDR3 存储空间读写 (0x4000_0000, 1 GB)
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/ddram_test.c_backup
 *
 * 改动:
 *   - 老例程写完读一遍就 return, 现在写完读一遍, 休息 1 秒换一组数据继续,
 *     可以长时间观察稳定性 (DDR 是整机最容易出问题的地方)。
 *   - 打印间隔由 100 ms 改 10 ms, 一轮 256 个字约 2.6 秒。
 *
 * 注意: 0x4000_0000 同时是 AXI-LCD 的显存。如果当前 bit 里 LCD 正在扫描,
 *       往这里写数据会让屏幕花掉, 这是正常的, 不是 DDR 坏了。
 *
 * 现象: 串口打印 0x40000000 + i 处的值, 应等于 i (+ 轮次)。
 */
#include "main.h"

#define DDR_TEST_WORDS   256

void ddram_demo(void)
{
    int i;
    unsigned int round = 0;
    unsigned int expect;

    printf("ddram demo: base 0x%08x, %d words per round\r\n",
           (unsigned int)ddr_base, DDR_TEST_WORDS);

    for (;;) {
        printf("---- round %u : write ----\r\n", round);

        for (i = 0; i < DDR_TEST_WORDS; i++) {
            *(ddr_base + i) = (int)(i + (int)round);
        }

        printf("---- round %u : read  ----\r\n", round);

        for (i = 0; i < DDR_TEST_WORDS; i++) {
            expect = (unsigned int)(i + (int)round);
            printf("  [0x%08x] = %d", (unsigned int)(ddr_base + i),
                   *(ddr_base + i));
            if ((unsigned int)*(ddr_base + i) != expect) {
                printf("   MISMATCH (expect %u)", expect);
            }
            printf("\r\n");
            delay_ms(10);
        }

        round++;
        delay_s(1);
    }
}
