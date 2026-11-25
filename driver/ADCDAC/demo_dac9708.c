/**
 * @file    demo_dac9708.c
 * @brief   DAC9708 波形发生器: 先往波形 RAM 写 32K 点, 再启动 DDS 输出
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/dac9708.c_backup
 *
 * 寄存器 (main.h):
 *   dac_9708_div        0x300C0000  时钟分频
 *   dac_9708_en         0x300C0004  使能输出
 *   dac_9708_fword      0x300C0008  频率控制字 (步进)
 *   dac_9708_pword      0x300C000C  相位控制字
 *   dac_9708_aword      0x300C0010  幅度控制字
 *   dac_9708_data_base  0x300C8000  波形 RAM (0x8000 字节)
 *
 * 老例程写的是 (0..0x7FFF) 的锯齿波, 频率控制字 32 表示每个采样点
 * 地址 +32, 所以一个周期 = 0x8000/32 = 1024 点。
 *
 * 现象: 示波器量 DAC 输出, 能看到约 1024 点的锯齿波。
 */
#include "main.h"

#define DAC_RAM_SIZE   0x8000

void dac9708_demo(void)
{
    int i;
    unsigned int tick = 0;

    printf("dac9708 demo: fill %d points, fword=32 -> 1024 pts/cycle\r\n",
           DAC_RAM_SIZE);

    /* 先填锯齿波 */
   for(int j = 0; j < 256; j++) {
         {
            for (i = 0; i < DAC_RAM_SIZE/256; i++)
            *(dac_9708_data_base + i + j*DAC_RAM_SIZE/256) = j;
        }
     }
    
    *dac_9708_div   = 2;
    *dac_9708_fword = 1;  /* 步进 = 1 -> 0x8000/1 个点/周期 */
    *dac_9708_pword = 0;
    *dac_9708_aword = 0;
    *dac_9708_en    = 0x1;             /* 启动输出 */
while (1) {
        /* 频率控制字从 1..255, 步进越大, 周期越短, 频率越高 */
        for (int i=1;i<256;i++) {
            *dac_9708_fword = i; 
            delay_s(1);
            if (++tick % 10u == 0u) {
                printf("[DAC9708] running %u s\r\n", tick);
            }
        }
    }
    for (int i=1;i<256;i++) {
        *dac_9708_fword = i; 
        delay_s(5);
        if (++tick % 10u == 0u) {
            printf("[DAC9708] running %u s\r\n", tick);
        }
    }
}
