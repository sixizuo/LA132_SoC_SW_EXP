/**
 * @file    demo_lcd_pass.c
 * @brief   AXI-LCD 自检: 整屏色块 -> 白框/网格/坐标原点 -> 文字
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/lcd_pass.c_backup (lcd_test0)
 * 变更 (2026-10-31): 由老 APB-LCD (0x5200_0000) 改为 AXI-LCD
 *       (0x2000_0000 + DDR3 0x4000_0000 显存)。原来的 lcd_test0 只刷四种
 *       纯色, 判断不了"边缘有没有被裁掉", 这里补上白框/四角方块/中心十字,
 *       一次就能看出画面是否完整、朝向是否正常。
 *
 * 用途: 怀疑屏或排线有问题时先跑这个 —— 不依赖字库和触摸, 只看纯色与几何。
 *
 * 现象:
 *   [1] 蓝/绿/红/白 整屏各停 0.6 s, 再刷黑
 *   [2] 白框贴满四边, 每 100 像素一条灰网格线, 四角 40x40 白方块,
 *       中心十字 + 中心点
 *   [3] 屏幕上方显示 "LCD PASS 800x480", 下方显示显存基址
 *   串口每一步都有打印, 每秒一个点。
 */
#include "main.h"
#include "AXI_LCD_DMA/lcd_gfx.h"

static void draw_grid(uint32_t c)
{
    int i;

    for (i = 100; i < GFX_W; i += 100) {
        gfx_vline(i, 0, GFX_H, c);
    }
    for (i = 100; i < GFX_H; i += 100) {
        gfx_hline(0, i, GFX_W, c);
    }
}

static void draw_corners(int blk, uint32_t c)
{
    gfx_fill_rect(0,             0,             blk, blk, c);   /* 左上 */
    gfx_fill_rect(GFX_W - blk,   0,             blk, blk, c);   /* 右上 */
    gfx_fill_rect(0,             GFX_H - blk,   blk, blk, c);   /* 左下 */
    gfx_fill_rect(GFX_W - blk,   GFX_H - blk,   blk, blk, c);   /* 右下 */
}

void lcd_pass_demo(void)
{
    unsigned int tick = 0;
    int rc;
    int cx = GFX_W / 2;
    int cy = GFX_H / 2;

    printf("lcd pass demo: AXI-LCD self test\r\n");

    rc = gfx_init(GFX_FB0);
    printf("gfx_init rc = %d, LCD ID = 0x%08x (expect 0x4384)\r\n",
           rc, gfx_lcd_id());
    printf("RES = 0x%08x, FB_SIZE = %d bytes\r\n",
           axi_lcd_get_res(), (int)axi_lcd_get_fb_bytes());
    if (rc != 0) {
        printf("!! AXI-LCD 没响应, 先查 bit / 排线\r\n");
        for (;;) {
            delay_s(1);
            printf(".");
        }
    }

    /* ---------------- [1] 整屏纯色 ---------------- */
    printf("[1] full screen: blue -> green -> red -> white -> black\r\n");

    gfx_clear(GFX_BLUE);    delay_ms(600);
    gfx_clear(GFX_GREEN);   delay_ms(600);
    gfx_clear(GFX_RED);     delay_ms(600);
    gfx_clear(GFX_WHITE);   delay_ms(600);
    gfx_clear(GFX_BLACK);   delay_ms(300);

    /* ---------------- [2] 几何图案 ---------------- */
    printf("[2] frame + grid + corner blocks + center cross\r\n");

    draw_grid(0x00303030);              /* 深灰网格, 不抢眼 */
    gfx_rect(0, 0, GFX_W, GFX_H, GFX_WHITE);
    gfx_rect(1, 1, GFX_W - 2, GFX_H - 2, GFX_WHITE);
    draw_corners(40, GFX_WHITE);

    gfx_thick_hline(cx - 40, cy, 80, 2, GFX_WHITE);
    gfx_thick_vline(cx, cy - 40, 80, 2, GFX_WHITE);
    gfx_fill_rect(cx - 3, cy - 3, 6, 6, GFX_RED);

    /* ---------------- [3] 文字 ---------------- */
    gfx_str(cx - 7 * GFX_CHAR_W, 60, "LCD PASS 800x480", GFX_WHITE, GFX_BLACK);
    gfx_str(cx - 8 * GFX_CHAR_W, 90, "AXI-LCD  fb 0x40000000", GFX_CYAN, GFX_BLACK);
    gfx_str(20, GFX_H - 40, "corners: LU/RU/LD/RD", GFX_YELLOW, GFX_BLACK);

    printf("[3] text drawn. 白框贴满四边 = 显示通路正常\r\n");
    printf("lcd_test0 finished\r\n");

    for (;;) {
        delay_s(1);
        printf(".");
        (void)tick;
    }
}
