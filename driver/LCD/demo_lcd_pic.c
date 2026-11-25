/**
 * @file    demo_lcd_pic.c
 * @brief   AXI-LCD 画位图: 代码生成的 30x30 小企鹅 (放大 4 倍) + 一条对角线
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/lcd_display_char_line_pic.c_backup
 * 变更 (2026-10-31): 由老 APB-LCD (0x5200_0000, 带 4x4 缩放) 改为
 *       AXI-LCD (0x2000_0000 + DDR3 显存)。AXI-LCD 没有硬件缩放, 所以
 *       企鹅在这里用软件放大 4 倍 (原来屏上看到的也是 4 倍大小)。
 *       企鹅的生成算法 (椭圆身体/圆头/眼睛/嘴巴/围巾/翅膀/脚) 原样保留。
 *
 * 位图格式: 每像素 0x00RRGGBB, 数组按行优先 (penguin[y][x])。
 *
 * 现象: 屏上一条红色对角线 (左上->右下), 左上角 (30,30) 处一只 120x120
 *       的小企鹅, 旁边有文字标注。
 */
#include "main.h"
#include "AXI_LCD_DMA/lcd_gfx.h"

#define COLOR_BLACK   0x00000000
#define COLOR_WHITE   0x00FFFFFF
#define COLOR_ORANGE  0x00FFA500
#define COLOR_YELLOW  0x00FFD700
#define COLOR_BLUE    0x004A90E2
#define COLOR_RED     0x00FF4444

#define PIC_W   30
#define PIC_H   30
#define PIC_ZOOM 4          /* 软件放大倍数 (老 APB-LCD 是 4x4 硬件缩放) */

static uint32_t penguin[PIC_H][PIC_W];

static void init_penguin(void)
{
    int x, y;

    /* 背景: 天蓝 */
    for (y = 0; y < PIC_H; y++) {
        for (x = 0; x < PIC_W; x++) {
            penguin[y][x] = COLOR_BLUE;
        }
    }

    /* 身体: 黑色椭圆, 中心 (15,18)、半径 7 / 8 */
    for (y = 10; y <= 26; y++) {
        for (x = 8; x <= 21; x++) {
            int dx = x - 15;
            int dy = y - 18;
            if (dx * dx * 64 + dy * dy * 49 <= 49 * 64) {
                penguin[y][x] = COLOR_BLACK;
            }
        }
    }

    /* 肚皮: 白色椭圆 */
    for (y = 14; y <= 25; y++) {
        for (x = 10; x <= 20; x++) {
            int dx = x - 15;
            int dy = y - 20;
            if (dx * dx * 64 + dy * dy * 36 <= 36 * 64) {
                penguin[y][x] = COLOR_WHITE;
            }
        }
    }

    /* 头: 黑色圆, 半径 6 */
    for (y = 5; y <= 14; y++) {
        for (x = 10; x <= 20; x++) {
            int dx = x - 15;
            int dy = y - 10;
            if (dx * dx + dy * dy <= 36) {
                penguin[y][x] = COLOR_BLACK;
            }
        }
    }

    /* 脸: 白色圆 */
    for (y = 8; y <= 13; y++) {
        for (x = 12; x <= 18; x++) {
            int dx = x - 15;
            int dy = y - 11;
            if (dx * dx + dy * dy <= 16) {
                penguin[y][x] = COLOR_WHITE;
            }
        }
    }

    /* 眼睛 */
    penguin[9][12]  = COLOR_BLACK;
    penguin[9][13]  = COLOR_BLACK;
    penguin[10][12] = COLOR_BLACK;
    penguin[10][13] = COLOR_BLACK;

    penguin[9][17]  = COLOR_BLACK;
    penguin[9][18]  = COLOR_BLACK;
    penguin[10][17] = COLOR_BLACK;
    penguin[10][18] = COLOR_BLACK;

    penguin[8][11] = COLOR_WHITE;     /* 高光 */
    penguin[8][16] = COLOR_WHITE;

    /* 嘴巴: 橙色三角 */
    penguin[11][14] = COLOR_ORANGE;
    penguin[11][15] = COLOR_ORANGE;
    penguin[11][16] = COLOR_ORANGE;
    penguin[12][14] = COLOR_ORANGE;
    penguin[12][15] = COLOR_ORANGE;
    penguin[12][16] = COLOR_ORANGE;
    penguin[13][15] = COLOR_ORANGE;

    /* 腮红 */
    penguin[12][10] = COLOR_RED;
    penguin[12][11] = COLOR_RED;
    penguin[13][10] = COLOR_RED;
    penguin[12][19] = COLOR_RED;
    penguin[12][20] = COLOR_RED;
    penguin[13][20] = COLOR_RED;

    /* 围巾 */
    for (x = 9; x <= 21; x++) {
        penguin[14][x] = COLOR_YELLOW;
        penguin[15][x] = COLOR_YELLOW;
    }
    penguin[16][9]  = COLOR_YELLOW;
    penguin[17][9]  = COLOR_YELLOW;
    penguin[16][21] = COLOR_YELLOW;
    penguin[17][21] = COLOR_YELLOW;

    /* 翅膀 */
    for (y = 16; y <= 20; y++) {
        for (x = 5; x <= 8; x++) {
            if (y - x < 12) {
                penguin[y][x] = COLOR_BLACK;
            }
        }
        for (x = 22; x <= 25; x++) {
            if (y + x > 38) {
                penguin[y][x] = COLOR_BLACK;
            }
        }
    }

    /* 脚掌 */
    for (x = 11; x <= 14; x++) {
        penguin[27][x]     = COLOR_ORANGE;
        penguin[28][x]     = COLOR_ORANGE;
        penguin[27][x + 5] = COLOR_ORANGE;
        penguin[28][x + 5] = COLOR_ORANGE;
    }
}

/** 按 PIC_ZOOM 放大绘制 (AXI-LCD 没有硬件缩放) */
static void draw_penguin(int x0, int y0)
{
    int x, y, i, j;

    for (y = 0; y < PIC_H; y++) {
        for (x = 0; x < PIC_W; x++) {
            uint32_t c = penguin[y][x];

            for (j = 0; j < PIC_ZOOM; j++) {
                for (i = 0; i < PIC_ZOOM; i++) {
                    gfx_pixel(x0 + x * PIC_ZOOM + i,
                              y0 + y * PIC_ZOOM + j, c);
                }
            }
        }
    }
}

void lcd_pic_demo(void)
{
    unsigned int tick = 0;
    int rc;

    printf("lcd pic demo: AXI-LCD bitmap %dx%d (zoom %d) at (30,30)\r\n",
           PIC_W, PIC_H, PIC_ZOOM);

    rc = gfx_init(GFX_FB0);
    printf("gfx_init rc = %d, LCD ID = 0x%08x\r\n", rc, gfx_lcd_id());
    if (rc != 0) {
        for (;;) {
            delay_s(1);
            printf(".");
        }
    }

    gfx_clear(0x00000000);

    /* 对角线: 验证 (0,0) 在左上、(799,479) 在右下 */
    gfx_line(0, 0, GFX_W - 1, GFX_H - 1, COLOR_RED);

    init_penguin();
    draw_penguin(30, 30);

    gfx_str(30, 180, "PENGUIN 30x30 x4", COLOR_WHITE, 0x00000000);
    gfx_str(30, 200, "AXI-LCD / DDR3 fb", COLOR_YELLOW, 0x00000000);

    printf("penguin drawn: body/head/eyes/beak/scarf/wings/feet\r\n");

    for (;;) {
        delay_s(1);
        printf(".");
        (void)tick;
    }
}
