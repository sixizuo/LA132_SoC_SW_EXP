/**
 * @file    demo_touch_multi.c
 * @brief   11.5 实验八: GT911 多点触摸坐标采集 (0x3006_0000)
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应硬件: hw/peripheral/exp_touch_multi/touch_top_multi.v + touch_dri_multi.v
 * 对应工程: exp_array_spi / exp_iic_spi (两者都定义了 EXP_TOUCH_MULTI)
 *           !! 与单点触摸 touch_top **同一地址、不同寄存器**, 老 demo
 *              (APP_SEL=1/23) 在这个 bit 上跑不了, 会读到错的含义。
 *
 * 记录格式 (以 touch_top_multi.v 为准):
 *   多点模式 CTRL[2]=1: {id[3:0], x[13:0], y[13:0]}
 *   单点模式 CTRL[2]=0: {x[15:0], y[15:0]}   (向下兼容老控制器)
 *   FIFO 空时读 DATA 返回 0xFFFF_FFFF
 *
 * 设计要求 (教材 11.5 实验八):
 *   1) 单点模式兼容: CTRL[2]=0 时行为同老控制器
 *   2) 多点模式: 每帧把全部触点写入 FIFO, 最多 5 点
 *   3) NUM 读出本帧点数 0~5
 *   4) 中断仍为"FIFO 非空"电平, 读满一帧后撤销
 *   5) LCD 上同时画出全部触点, 每点不同颜色, 编号标在点旁
 *
 * 实现要点:
 *   - 屏幕上只重画"变化了的点": 每帧先用黑色擦掉上一帧画过的圆,
 *     再画新的。整屏 gfx_clear() 要写 38 万个像素, 会掉到个位数帧率。
 *   - 擦除用的坐标必须单独保存一份 (s_old_x/s_old_y), 不能直接用
 *     本帧的结果, 否则擦的是新位置、旧圆留在屏上。
 *
 * 现象: 一指 -> 1 个白圆; 两指 -> 2 个不同颜色的圆; 最多 5 个;
 *       抬手后圆点消失。串口打印每 10 帧一次的 (id,x,y) 列表。
 */
#include "main.h"
#include "AXI_LCD_DMA/lcd_gfx.h"
#include "interrupt.h"

#define TP_MAX           5
#define TP_IRQ_LINE      7u           /* 教材表 11-7: int_7 = 触摸 */

static const unsigned int s_color[TP_MAX] = {
    0x00FFFFFFu,   /* 白 */
    0x00FF4040u,   /* 红 */
    0x0040FF40u,   /* 绿 */
    0x00FFFF40u,   /* 黄 */
    0x0040FFFFu    /* 青 */
};

static volatile unsigned int s_irq_cnt;
static volatile unsigned char s_irq_off;   /* ISR 里屏蔽了线, 等主循环读完再开 */

/* 上一帧画在屏上的点 (擦除用) */
static int s_old_x[TP_MAX], s_old_y[TP_MAX], s_old_n;

static void tp_isr(void)
{
    s_irq_cnt++;
    /* ★ 触摸中断是"FIFO 非空"电平, 靠读空 FIFO 才会撤销。
     *   如果 ISR 里只清 INTC 的挂起位就返回, 电平还在 -> 立刻重入,
     *   主循环一次都跑不到, 表现是"死机但中断计数在涨"。
     *   所以这里先把 INTC 这一路的使能关掉, 由主循环读完一帧后再打开。 */
    *intc_int_en &= ~(1u << TP_IRQ_LINE);
    s_irq_off = 1;
}

/* 半径 6 的实心圆: 每行用一条横线填充, 比 13×13 次 gfx_pixel 快得多 */
static void draw_dot(int cx, int cy, unsigned int color)
{
    int dy, w, w2;

    for (dy = -6; dy <= 6; dy++) {
        w2 = 36 - dy * dy;
        w  = 0;
        while (((w + 1) * (w + 1)) <= w2) {
            w++;
        }
        gfx_hline(cx - w, cy + dy, 2 * w + 1, color);
    }
}

static void erase_old(void)
{
    int i;

    for (i = 0; i < s_old_n; i++) {
        draw_dot(s_old_x[i], s_old_y[i], GFX_BLACK);
    }
    s_old_n = 0;
}

void touch_multi_demo(void)
{
    int i, n, rc;
    unsigned int num, r, st;
    unsigned int frames = 0;
    unsigned int mode_multi = 1;
    int px[TP_MAX], py[TP_MAX], pid[TP_MAX];

    printf("exp8: multi-touch (GT911) @0x%08x\r\n", touchm_base);
    printf("VERSION = 0x%08x (expect 0x54500002)\r\n", touchm_version);

    rc = gfx_init(GFX_FB0);
    printf("gfx_init rc=%d LCD ID=0x%08x\r\n", rc, gfx_lcd_id());
    if (rc != 0) {
        for (;;) { delay_s(1); printf("!! no AXI-LCD\r\n"); }
    }
    gfx_clear(GFX_BLACK);
    gfx_str(8, 8,  "MULTI-TOUCH  GT911", 0x00FFFFFFu, GFX_BLACK);
    gfx_str(8, 24, "up to 5 points, color follows id", 0x00808080u, GFX_BLACK);

    intc_irq_init();
    *intc_int_pol  |= (1u << TP_IRQ_LINE);
    *intc_int_edge &= ~(1u << TP_IRQ_LINE);    /* 电平方式 */
    *intc_int_en   |= (1u << TP_IRQ_LINE);
    intc_irq_attach(TP_IRQ_LINE, tp_isr);

    touchm_maxpoint = TP_MAX;
    touchm_interval = 95000;                   /* 约 3 ms 采一帧 */
    touchm_ctrl     = TOUCHM_CTRL_EN | TOUCHM_CTRL_MULTI | TOUCHM_CTRL_IRQEN;
    printf("CTRL=0x%08x MAXPOINT=%u\r\n", touchm_ctrl, touchm_maxpoint);

    for (;;) {
        int c = uart_getchar_nb();

        if (c == 's') {                        /* 切单点/多点模式 */
            mode_multi = !mode_multi;
            touchm_ctrl = TOUCHM_CTRL_EN
                        | (mode_multi ? TOUCHM_CTRL_MULTI : 0u)
                        | TOUCHM_CTRL_IRQEN
                        | TOUCHM_CTRL_CLRFIFO;
            touchm_ctrl &= ~TOUCHM_CTRL_CLRFIFO;
            erase_old();
            printf("[MODE] %s\r\n", mode_multi ? "multi" : "single (compat)");
        }

        st  = touchm_status;
        num = touchm_num & 0x0Fu;

        if (st & TOUCHM_ST_EMPTY) {
            erase_old();                       /* 抬手: 把屏上的点擦掉 */
            if (s_irq_off) {                   /* FIFO 已空, 重新打开中断 */
                s_irq_off = 0;
                *intc_int_en |= (1u << TP_IRQ_LINE);
            }
            delay_ms(10);
            continue;
        }

        if (num == 0u) {
            num = 1u;                          /* 兼容单点: NUM 可能为 0 但有数据 */
        }
        if (num > TP_MAX) {
            num = TP_MAX;
        }

        n = 0;
        for (i = 0; i < (int)num; i++) {
            r = touchm_data;
            if (r == TOUCHM_EMPTY_DATA) {
                break;
            }
            if (mode_multi) {
                pid[n] = (int)TOUCHM_REC_ID(r);
                px [n] = (int)TOUCHM_REC_X(r);
                py [n] = (int)TOUCHM_REC_Y(r);
            } else {
                pid[n] = n;
                px [n] = (int)((r >> 16) & 0xFFFFu);
                py [n] = (int)(r & 0xFFFFu);
            }
            n++;
        }

        if (s_irq_off) {                       /* 这一帧读完了, 打开中断 */
            s_irq_off = 0;
            *intc_int_en |= (1u << TP_IRQ_LINE);
        }

        erase_old();
        for (i = 0; i < n; i++) {
            int q = pid[i] % TP_MAX;
            draw_dot(px[i], py[i], s_color[q]);
            gfx_fill_rect(px[i] - 3, py[i] - 13, 7, 7, s_color[q]);   /* 编号标记 */
            s_old_x[i] = px[i];
            s_old_y[i] = py[i];
        }
        s_old_n = n;

        if ((frames++ % 10u) == 0u) {
            printf("[TP] num=%u irq=%u :", num, s_irq_cnt);
            for (i = 0; i < n; i++) {
                printf(" (%d,%d,%d)", pid[i], px[i], py[i]);
            }
            printf("\r\n");
        }

        delay_ms(10);
    }
}
