/**
 * @file    lcd_gfx.h
 * @brief   AXI-LCD 图形/文字中间层 (给 demo 用的画图 API)
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 *  用途:
 *    老的 APB-LCD 驱动 (driver/LCD/lcd.c, 基址 0x5200_0000) 有一套画图函数,
 *    但本版 FPGA 已经把 lcd_top 换成了 **AXI-LCD** (基址 0x2000_0000,
 *    显存在 DDR3 0x4000_0000), 老函数一个都用不了。这里把"画点/线/框/
 *    位图/字符"重新按 AXI-LCD 的显存布局实现一遍, 上层 demo 只要 include
 *    本文件即可, 不再关心显存怎么算。
 *
 *  显存布局 (与 hw/peripheral/axi_lcd/axi_lcd.v 一致):
 *      1 像素 = 1 个 32bit 字, 行优先, 每行 800 字
 *      字地址 = fb_base + (y * 800 + x) * 4
 *      bit[23:0] = {R8, G8, B8}, bit[31:24] 无效
 *
 *  坐标系: 左上角 (0,0), x 向右 0..799, y 向下 0..479
 *
 *  依赖: axi_lcd.c (寄存器), axi_dma.c (整屏填充用 DMA 加速)
 */
#ifndef _LCD_GFX_H_
#define _LCD_GFX_H_

#include "axi_lcd.h"

#ifdef __cplusplus
extern "C" {
#endif

/*--------------------------------------------------------------------
 * 显存 / 分辨率
 *------------------------------------------------------------------*/
#define GFX_W               ((int)AXI_LCD_WIDTH)     /* 800 */
#define GFX_H               ((int)AXI_LCD_HEIGHT)    /* 480 */
#define GFX_FB0             0x40000000u              /* 帧缓冲 0 (AXI-LCD 默认) */
#define GFX_FB1             0x40180000u              /* 帧缓冲 1 (双缓冲用)     */

/* 老 lcd.h 里的颜色宏名 (blue/red/...) 是给 APB-LCD 的, 数值恰好也是
 * RGB888, 这里另起一套 gfx_ 前缀, 免得与 lcd.h 冲突 */
#define GFX_BLACK           AXI_LCD_BLACK
#define GFX_WHITE           AXI_LCD_WHITE
#define GFX_RED             AXI_LCD_RED
#define GFX_GREEN           AXI_LCD_GREEN
#define GFX_BLUE            AXI_LCD_BLUE
#define GFX_YELLOW          AXI_LCD_YELLOW
#define GFX_CYAN            AXI_LCD_CYAN
#define GFX_MAGENTA         AXI_LCD_MAGENTA

/* 字符尺寸 (Char_Font_16x16) */
#define GFX_CHAR_W          16
#define GFX_CHAR_H          16

/*--------------------------------------------------------------------
 * 初始化
 *------------------------------------------------------------------*/

/**
 * @brief 初始化 AXI-LCD: 软复位 -> RGB888 -> 设显存 -> 清屏 -> 启动显示
 * @param fb_base 显存基址 (DDR3 内, 自动 64B 对齐), 常用 GFX_FB0
 * @return 0 成功; -1 ID/分辨率不匹配 (LCD 控制器没起来, 后面画什么都没用)
 */
int      gfx_init(uint32_t fb_base);

/** 只设显存基址 (不启动显示), 双缓冲切换时用 */
void     gfx_set_fb(uint32_t fb_base);

/** 当前显存基址 */
uint32_t gfx_fb(void);

/** LCD 控制器 ID (期望 AXI_LCD_ID_EXPECT = 0x4384) */
uint32_t gfx_lcd_id(void);

/*--------------------------------------------------------------------
 * 画图 (全部自带裁剪, 越界自动丢弃, 不会写坏别的显存)
 *------------------------------------------------------------------*/

/** 整屏填色 (走 AXI-DMA, 1.5 MB 约几十 ms; DMA 不可用时自动退化为 CPU 写) */
void gfx_clear(uint32_t color);

void gfx_pixel(int x, int y, uint32_t color);

/** 水平线: 从 (x,y) 向右 len 像素 */
void gfx_hline(int x, int y, int len, uint32_t color);

/** 垂直线: 从 (x,y) 向下 len 像素 */
void gfx_vline(int x, int y, int len, uint32_t color);

/** Bresenham 直线 (任意斜率) */
void gfx_line(int x0, int y0, int x1, int y1, uint32_t color);

/** 线宽 t 的横线/竖线 (t=1 时等于 hline/vline) */
void gfx_thick_hline(int x, int y, int len, int t, uint32_t color);
void gfx_thick_vline(int x, int y, int len, int t, uint32_t color);

/** 矩形边框 / 实心矩形 */
void gfx_rect(int x, int y, int w, int h, uint32_t color);
void gfx_fill_rect(int x, int y, int w, int h, uint32_t color);

/**
 * @brief 画位图
 * @param pic 按行优先的 RGB888 数组, pic[y*width + x]
 */
void gfx_pic(int x, int y, int width, int height, const uint32_t *pic);

/*--------------------------------------------------------------------
 * 文字 (16x16 点阵, 覆盖 ASCII 0x21 ~ 0x7E)
 *------------------------------------------------------------------*/

/**
 * @brief 画一个 16x16 字符 (背景色也填, 相当于"覆盖"而不是"叠加")
 * @param c 可打印 ASCII, 超出范围时显示空白
 */
void gfx_char(int x, int y, char c, uint32_t fg, uint32_t bg);

/** 画字符串, 逐字向右排 (字距 16 像素) */
void gfx_str(int x, int y, const char *s, uint32_t fg, uint32_t bg);

/**
 * @brief 画十进制数, 定宽右对齐, 前导 0 补齐
 * @param len 位数 (例如 324 + len=3 -> "324"; 12 + len=3 -> "012")
 */
void gfx_num(int x, int y, int num, int len, uint32_t fg, uint32_t bg);

#ifdef __cplusplus
}
#endif

#endif /* _LCD_GFX_H_ */
