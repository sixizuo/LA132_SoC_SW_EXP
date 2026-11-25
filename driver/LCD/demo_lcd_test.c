/**
 * @file    demo_lcd_test.c
 * @brief   AXI-LCD 基本画图: 三条横线 + 数字 + 一串字符
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/lcd_test.c_back_up
 * 变更 (2026-10-31): 原来走**老的 APB-LCD (0x5200_0000)**, 本版 FPGA 里
 *       lcd_top 已经换成 AXI-LCD (0x2000_0000 配置 + DDR3 0x4000_0000 显存),
 *       老驱动一个函数都用不了, 所以改用 lcd_gfx (driver/AXI_LCD_DMA) 重画。
 *       现象与原来一致: 屏上三条横线 + 数字 324, 另加了标题文字。
 *
 * 现象:
 *   屏上 y=5/15/25 三条 3 像素高的横线 (蓝/绿/红),
 *   (20,35) 处显示绿色数字 324,
 *   (20,60) 处一行标题 "AXI-LCD 800x480 RGB888";
 *   串口每秒一个点。
 */
#include "main.h"
#include "AXI_LCD_DMA/lcd_gfx.h"

void lcd_test_demo(void)
{
    unsigned int tick = 0;
    int rc;

    printf("lcd test demo: AXI-LCD @ 0x%08x, fb = 0x%08x, %dx%d\r\n",
           0x20000000u, GFX_FB0, GFX_W, GFX_H);

    rc = gfx_init(GFX_FB0);
    printf("gfx_init rc = %d, LCD ID = 0x%08x (expect 0x%08x)\r\n",
           rc, gfx_lcd_id(), 0x4384u);
    if (rc != 0) {
        printf("!! AXI-LCD 没响应, 检查 bit 里是否例化了 axi_lcd\r\n");
        for (;;) {
            delay_s(1);
            printf(".");
        }
    }

    gfx_clear(GFX_BLACK);

    gfx_thick_hline(0,  5, GFX_W, 3, GFX_BLUE);
    gfx_thick_hline(0, 15, GFX_W, 3, GFX_GREEN);
    gfx_thick_hline(0, 25, GFX_W, 3, GFX_RED);

    gfx_num(20, 35, 324, 3, GFX_GREEN, GFX_BLACK);

    gfx_str(20, 60, "AXI-LCD 800x480 RGB888", GFX_WHITE, GFX_BLACK);
    gfx_str(20, 80, "fb @ 0x40000000 (DDR3)", GFX_YELLOW, GFX_BLACK);

    /* 右下角画一个参考框, 方便判断坐标方向/是否裁切 */
    gfx_rect(GFX_W - 120, GFX_H - 60, 100, 40, GFX_CYAN);

    printf("three lines at y=5/15/25, number 324 at (20,35)\r\n");

    for (;;) {
        delay_s(1);
        printf(".");
        (void)tick;
    }
}
