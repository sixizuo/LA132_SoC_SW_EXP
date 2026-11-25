/**
 * @file    demo_touch.c
 * @brief   AXI-LCD + 触摸屏: 中断方式读 X/Y, 坐标显示在屏上并打印到串口
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/touch_test.c_back_up + interrupt.c 的 touch_handler()
 * 变更 (2026-10-31): 坐标原先显示在老 APB-LCD 上 (lcd_touch_show, 24x48
 *       大字 + 4x4 缩放), 本版 FPGA 只有 AXI-LCD, 改为用 lcd_gfx 在
 *       AXI-LCD 上重画: 左上角显示 "X = nnn" / "Y = nnn", 屏幕正中到触摸
 *       点之间画十字光标, 直观看出坐标是否跟手。
 *
 * 触发方式: 触摸控制器中断 = INTC 第 7 根线 (电平), 由 start.S 的
 *           intc_irq_7 -> intc_irq_dispatch(7) 进来, 这里用
 *           intc_irq_attach(7, touch_isr) 挂上去。
 *
 * 寄存器 (main.h):
 *   touch_ctrl     0x30060000  bit0 模块使能, bit1 中断使能
 *                              读回: bit2 = FIFO 非空, bit3 = FIFO 满
 *   touch_interval 0x30060004  采样间隔 (32 MHz 计数)
 *   touch_data     0x30060008  [31:16] = X, [15:0] = Y  (读一次弹一个点)
 *
 * 注意: GT911 输出的是**面板原生像素坐标**, 满量程 800 x 480,
 *       不是 4096 (这里是 2026-10-15 踩过的坑)。
 *
 * 现象: 手指按屏, 屏上光标跟着走, 左上角数字变化, 串口打印 "x=.., y=..";
 *       每秒一个点表示主循环在跑。
 */
#include "main.h"
#include "AXI_LCD_DMA/lcd_gfx.h"

#define TOUCH_IRQ_LINE      7u
#define TOUCH_INTERVAL_VAL  95000u      /* 采样节流 ≈ 2.97 ms @32MHz */
#define TOUCH_RAW_MAX_X     800         /* GT911 原始 x 满量程 */
#define TOUCH_RAW_MAX_Y     480         /* GT911 原始 y 满量程 */

#define TXT_X0              20
#define TXT_Y0              20

static volatile unsigned int s_raw_x = 0;
static volatile unsigned int s_raw_y = 0;
static volatile unsigned int s_flag  = 0;

/* 当前屏幕光标位置 (-1 = 还没画过) */
static int s_cx = -1;
static int s_cy = -1;

static void touch_isr(void)
{
    unsigned int d;

    /* FIFO 非空才读: 读一次就弹一个点, 空 FIFO 读出来是无效数据 */
    if ((*touch_ctrl & TOUCH_CTRL_NOT_EMPTY) != 0u) {
        d = *touch_data;

        s_raw_x = (d >> 16) & 0xFFFFu;     /* 高 16 位 = x */
        s_raw_y = d & 0xFFFFu;             /* 低 16 位 = y */
        s_flag  = 1;
    }

    *intc_int_clr = (1u << TOUCH_IRQ_LINE);
}

/** 原始坐标 -> 屏幕坐标, 带裁剪 */
static int touch_scale(unsigned int raw, unsigned int raw_max, int out_max)
{
    unsigned int v;

    if (raw_max == 0u) {
        raw_max = 1u;
    }
    v = (raw * (unsigned int)out_max) / raw_max;
    if (v >= (unsigned int)out_max) {
        v = (unsigned int)out_max - 1u;
    }
    return (int)v;
}

/** 画/擦十字光标: erase = 1 时用背景色覆盖 */
static void draw_cross(int cx, int cy, int erase)
{
    uint32_t c = erase ? GFX_BLACK : GFX_RED;

    gfx_thick_hline(cx - 15, cy, 31, 2, c);
    gfx_thick_vline(cx, cy - 15, 31, 2, c);
}

void touch_demo(void)
{
    unsigned int tick = 0;
    int rc;
    int x, y;

    printf("touch demo: AXI-LCD + touch irq line %u\r\n", TOUCH_IRQ_LINE);

    /* ---------- 1. 屏 ---------- */
    rc = gfx_init(GFX_FB0);
    printf("gfx_init rc = %d, LCD ID = 0x%08x\r\n", rc, gfx_lcd_id());
    if (rc != 0) {
        printf("!! AXI-LCD 没响应, 触摸坐标无处显示 (串口仍可用)\r\n");
    }

    gfx_clear(GFX_BLACK);
    gfx_rect(0, 0, GFX_W, GFX_H, 0x00404040);
    gfx_str(TXT_X0, TXT_Y0 - 20, "AXI-LCD TOUCH", GFX_CYAN, GFX_BLACK);
    gfx_str(TXT_X0, TXT_Y0 + 40, "raw:", GFX_WHITE, GFX_BLACK);
    gfx_str(TXT_X0, TXT_Y0 + 100, "scr:", GFX_WHITE, GFX_BLACK);

    /* ---------- 2. 触摸控制器 ---------- */
    *touch_interval = TOUCH_INTERVAL_VAL;
    *touch_ctrl    |= TOUCH_CTRL_EN | TOUCH_CTRL_IRQEN;

    printf("touch_ctrl = 0x%08x, interval = %u\r\n",
           *touch_ctrl, *touch_interval);

    /* ---------- 3. 中断 ---------- */
    intc_irq_init();
    *intc_int_en   = (1u << TOUCH_IRQ_LINE);
    *intc_int_pol  = (1u << TOUCH_IRQ_LINE);
    *intc_int_edge = 0x0000;                    /* 电平方式 */
    intc_irq_attach(TOUCH_IRQ_LINE, touch_isr);

    printf("等触摸中断... (手指按屏)\r\n");

    for (;;) {
        if (s_flag) {
            unsigned int rx = s_raw_x;
            unsigned int ry = s_raw_y;

            s_flag = 0;

            /* 屏上显示原始坐标 */
            gfx_fill_rect(TXT_X0 + 4 * GFX_CHAR_W, TXT_Y0 + 40, 6 * GFX_CHAR_W,
                          GFX_CHAR_H, GFX_BLACK);
            gfx_num(TXT_X0 + 4 * GFX_CHAR_W, TXT_Y0 + 40, (int)rx, 4,
                    GFX_YELLOW, GFX_BLACK);
            gfx_fill_rect(TXT_X0 + 9 * GFX_CHAR_W, TXT_Y0 + 40, 6 * GFX_CHAR_W,
                          GFX_CHAR_H, GFX_BLACK);
            gfx_num(TXT_X0 + 9 * GFX_CHAR_W, TXT_Y0 + 40, (int)ry, 4,
                    GFX_YELLOW, GFX_BLACK);

            /* 屏上显示映射后的屏幕坐标 */
            x = touch_scale(rx, TOUCH_RAW_MAX_X, GFX_W);
            y = touch_scale(ry, TOUCH_RAW_MAX_Y, GFX_H);

            gfx_fill_rect(TXT_X0 + 4 * GFX_CHAR_W, TXT_Y0 + 100, 6 * GFX_CHAR_W,
                          GFX_CHAR_H, GFX_BLACK);
            gfx_num(TXT_X0 + 4 * GFX_CHAR_W, TXT_Y0 + 100, x, 4,
                    GFX_GREEN, GFX_BLACK);
            gfx_fill_rect(TXT_X0 + 9 * GFX_CHAR_W, TXT_Y0 + 100, 6 * GFX_CHAR_W,
                          GFX_CHAR_H, GFX_BLACK);
            gfx_num(TXT_X0 + 9 * GFX_CHAR_W, TXT_Y0 + 100, y, 4,
                    GFX_GREEN, GFX_BLACK);

            /* 十字光标: 先擦旧的, 再画新的 */
            if (s_cx >= 0) {
                draw_cross(s_cx, s_cy, 1);
            }
            draw_cross(x, y, 0);
            s_cx = x;
            s_cy = y;

            printf("[TOUCH] raw = %u, %u  ->  scr = %d, %d\r\n", rx, ry, x, y);
        }

        delay_ms(5);
        if (++tick >= 200) {
            tick = 0;
            printf(".");
        }
    }
}
