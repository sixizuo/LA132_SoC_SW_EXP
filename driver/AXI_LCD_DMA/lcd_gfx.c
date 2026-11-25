/**
 * @file    lcd_gfx.c
 * @brief   AXI-LCD 图形/文字中间层实现
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 *  显存访问全部按 **字** 进行:
 *      addr = s_fb + ((y * 800) + x) * 4
 *  800x480x4 = 1 536 000 字节, 刚好落在 FB0 (0x4000_0000) 一帧 0x17_7000
 *  的范围内, 不会踩到 FB1 (0x4018_0000)。
 */

#include "lcd_gfx.h"
#include "axi_dma.h"
#include "LCD/font.h"          /* Char_Font_16x16 : '!'(0x21) ~ '~'(0x7E) */

static uint32_t s_fb = GFX_FB0;

/*--------------------------------------------------------------------
 * 内部: 显存字地址
 *------------------------------------------------------------------*/
static inline volatile uint32_t *gfx_word(int x, int y)
{
    return (volatile uint32_t *)(s_fb + ((((uint32_t)y * AXI_LCD_WIDTH)
                                          + (uint32_t)x) << 2));
}

/*--------------------------------------------------------------------
 * 初始化
 *------------------------------------------------------------------*/
int gfx_init(uint32_t fb_base)
{
    if (axi_lcd_probe() != 0) {
        return -1;
    }

    /* 软复位: 清预取窗口和状态位, 复位后寄存器全 0, 必须重新配置 */
    axi_lcd_reset();

    s_fb = fb_base;

    axi_lcd_set_fmt(AXI_LCD_FMT_RGB888);
    axi_lcd_set_fb(s_fb);
    axi_lcd_clear_status();
    axi_lcd_start();

    return 0;
}

void gfx_set_fb(uint32_t fb_base)
{
    s_fb = fb_base;
    axi_lcd_set_fb(fb_base);
}

uint32_t gfx_fb(void)
{
    return s_fb;
}

uint32_t gfx_lcd_id(void)
{
    return axi_lcd_read(AXI_LCD_REG_ID);
}

/*--------------------------------------------------------------------
 * 画图
 *------------------------------------------------------------------*/
void gfx_clear(uint32_t color)
{
    unsigned int i;
    volatile uint32_t *p;

    color &= 0x00FFFFFFu;

    /* 整屏 1.5 MB: 用 AXI-DMA 从图案缓冲搬, 比 CPU 逐字写快一个数量级 */
    if (axi_dma_memset(s_fb, color, AXI_LCD_FB_BYTES) == AXI_DMA_OK) {
        return;
    }

    /* DMA 不可用 (没例化/参数错) 时退化成 CPU 填充, 保证画面不至于残影 */
    p = (volatile uint32_t *)s_fb;
    for (i = 0u; i < (AXI_LCD_WIDTH * AXI_LCD_HEIGHT); i++) {
        p[i] = color;
    }
}

void gfx_pixel(int x, int y, uint32_t color)
{
    if (x < 0 || x >= GFX_W || y < 0 || y >= GFX_H) {
        return;
    }
    *gfx_word(x, y) = color & 0x00FFFFFFu;
}

void gfx_hline(int x, int y, int len, uint32_t color)
{
    int i;
    volatile uint32_t *p;

    if (y < 0 || y >= GFX_H || len <= 0) {
        return;
    }
    if (x < 0) {
        len += x;
        x = 0;
    }
    if (x + len > GFX_W) {
        len = GFX_W - x;
    }
    if (len <= 0) {
        return;
    }

    p = gfx_word(x, y);
    for (i = 0; i < len; i++) {
        p[i] = color & 0x00FFFFFFu;
    }
}

void gfx_vline(int x, int y, int len, uint32_t color)
{
    int i;

    if (x < 0 || x >= GFX_W || len <= 0) {
        return;
    }
    if (y < 0) {
        len += y;
        y = 0;
    }
    if (y + len > GFX_H) {
        len = GFX_H - y;
    }
    if (len <= 0) {
        return;
    }

    for (i = 0; i < len; i++) {
        *gfx_word(x, y + i) = color & 0x00FFFFFFu;
    }
}

void gfx_thick_hline(int x, int y, int len, int t, uint32_t color)
{
    int i;

    if (t < 1) {
        t = 1;
    }
    for (i = 0; i < t; i++) {
        gfx_hline(x, y + i, len, color);
    }
}

void gfx_thick_vline(int x, int y, int len, int t, uint32_t color)
{
    int i;

    if (t < 1) {
        t = 1;
    }
    for (i = 0; i < t; i++) {
        gfx_vline(x + i, y, len, color);
    }
}

void gfx_line(int x0, int y0, int x1, int y1, uint32_t color)
{
    int dx = (x1 > x0) ? (x1 - x0) : (x0 - x1);
    int dy = (y1 > y0) ? (y1 - y0) : (y0 - y1);
    int sx = (x0 < x1) ? 1 : -1;
    int sy = (y0 < y1) ? 1 : -1;
    int err = dx - dy;

    for (;;) {
        gfx_pixel(x0, y0, color);

        if (x0 == x1 && y0 == y1) {
            break;
        }

        {
            int e2 = err * 2;
            if (e2 > -dy) { err -= dy; x0 += sx; }
            if (e2 <  dx) { err += dx; y0 += sy; }
        }
    }
}

void gfx_rect(int x, int y, int w, int h, uint32_t color)
{
    if (w <= 0 || h <= 0) {
        return;
    }
    gfx_hline(x,     y,         w, color);
    gfx_hline(x,     y + h - 1, w, color);
    gfx_vline(x,     y,         h, color);
    gfx_vline(x + w - 1, y,     h, color);
}

void gfx_fill_rect(int x, int y, int w, int h, uint32_t color)
{
    int i;

    if (w <= 0 || h <= 0) {
        return;
    }
    for (i = 0; i < h; i++) {
        gfx_hline(x, y + i, w, color);
    }
}

void gfx_pic(int x, int y, int width, int height, const uint32_t *pic)
{
    int i, j;

    if (pic == 0) {
        return;
    }

    for (j = 0; j < height; j++) {
        for (i = 0; i < width; i++) {
            gfx_pixel(x + i, y + j, pic[j * width + i]);
        }
    }
}

/*--------------------------------------------------------------------
 * 文字
 *------------------------------------------------------------------*/
void gfx_char(int x, int y, char c, uint32_t fg, uint32_t bg)
{
    int r, b;
    int idx;

    fg &= 0x00FFFFFFu;
    bg &= 0x00FFFFFFu;

    /* 字库只覆盖 0x21 ~ 0x7E, 其它字符 (空格/中文/控制符) 画成纯背景块 */
    idx = (int)c - (int)'!';
    if (idx < 0 || idx > (94 - 1)) {
        gfx_fill_rect(x, y, GFX_CHAR_W, GFX_CHAR_H, bg);
        return;
    }

    /* 字库排布 (见 font.h 注释 + lcd_display_char_16x16 的取法):
     *   一个字符 = 2 个 8 行子块, 每个子块 8 行 x 2 字节
     *   [2*idx + r/8][2*(r%8) + 0] -> 该行左 8 像素
     *   [2*idx + r/8][2*(r%8) + 1] -> 该行右 8 像素
     *   字节内 **bit0 = 最左像素** (逆向取模) */
    for (r = 0; r < GFX_CHAR_H; r++) {
        uint8_t b0 = Char_Font_16x16[2 * idx + (r >> 3)][2 * (r & 7) + 0];
        uint8_t b1 = Char_Font_16x16[2 * idx + (r >> 3)][2 * (r & 7) + 1];

        for (b = 0; b < 8; b++) {
            gfx_pixel(x + b,     y + r, ((b0 >> b) & 1u) ? fg : bg);
            gfx_pixel(x + 8 + b, y + r, ((b1 >> b) & 1u) ? fg : bg);
        }
    }
}

void gfx_str(int x, int y, const char *s, uint32_t fg, uint32_t bg)
{
    if (s == 0) {
        return;
    }
    while (*s != '\0') {
        gfx_char(x, y, *s, fg, bg);
        x += GFX_CHAR_W;
        s++;
    }
}

void gfx_num(int x, int y, int num, int len, uint32_t fg, uint32_t bg)
{
    int i, pow10, digit;

    if (len <= 0) {
        return;
    }
    if (len > 9) {
        len = 9;
    }
    if (num < 0) {
        num = -num;
    }

    for (i = 0; i < len; i++) {
        /* 10^(len-1-i), 用循环乘避免 64 位除法 (链接不带 libgcc) */
        int k;
        pow10 = 1;
        for (k = 0; k < (len - 1 - i); k++) {
            pow10 *= 10;
        }
        digit = (num / pow10) % 10;
        gfx_char(x + i * GFX_CHAR_W, y, (char)('0' + digit), fg, bg);
    }
}
