/**
 * @file    demo_scope.c
 * @brief   11.5 实验五: LCD 显示 SPI AD 模拟信号波形 (简化示波器)
 * @Author: WorkBuddy
 * @Date:   2026-11-23 (2026-11-25 大改)
 *
 * 对应工程: exp_array_spi / exp_iic_spi (两者都定义了 EXP_SPI_STREAM)
 *
 * 硬件:  J8 的 SPI AD 模块 (ADC128S102), 走 spi_stream_top
 *        (0x300A_0000)。通道 0 = AD 板上的电位器。
 *
 * 设计要求 (教材 11.5 实验五 + 2026-11-25 上板反馈):
 *   1) 采样缓冲 2400 点 > 显示窗口 800 点: 触发后**连续**显示
 *      buf[k..k+799], 绝不用取模回绕拼接 (拼接会波形变形)。
 *   2) 采样率 1k/2k/5k/10k 四档 (DIV = 32000/16000/6400/3200)
 *   3) 800x480 LCD 上画网格 + 触发电平线 + 波形 + 幅值/频率标注
 *   4) 触发边沿可选 (上升/下降), 触发电平可调 (步进 0.2 V)
 *   5) K1 切采样率, K2 切垂直缩放 (1x / 2x)
 *   6) UART 命令:
 *        r = 采样率循环    e = 触发边沿
 *        t / g = 触发电平 +0.2V / -0.2V
 *        x = 垂直缩放      h = 帮助
 *
 * 2026-11-25 修"四色屏"问题:
 *   - 现象: 串口继续打印, 但 LCD 突然变成四色块切换画面, 不再显示波形。
 *     CPU/APB 都活着 (串口还在打), 说明是 AXI-LCD 取流侧停摆。
 *   - 上一版每帧用 axi_dma_memset 清屏 (1.5 MB DMA 大搬运), 与 LCD 取流
 *     同时压 DDR, 诱发预取下溢/取流 FSM 卡死。改为 **CPU 逐字填充** 清屏
 *     (800*480 = 384K 字, 约 60 ms, 远小于采样一窗的时间), 全程不用 DMA。
 *   - 另加 LCD 活性看门狗: 每帧检查 REG_STATUS 的 FRAME 事件位, 连续
 *     3 帧没再置起就自动 SWRST 重初始化 LCD 并重画, 自愈不重启。
 *
 * 实现要点:
 *   - 采样缓冲放 DDR (0x4050_0000), 不占 .bss (ld.script 只有 4 KB)
 *   - 先采满 2400 点再整屏画, 不边采边画
 *   - 频率用"上/下穿阈值次数"估算, 不做 FFT
 *
 * 现象: 拧 AD 板电位器, 屏上波形跟着上下走; 波形始终以触发电平穿越点
 *       为窗口起点, 稳定不拼接; 串口命令实时改参数。
 */
#include "main.h"
#include "AXI_LCD_DMA/lcd_gfx.h"
#include "interrupt.h"

#define SC_NDISP         800                 /* 显示窗口点数 */
#define SC_NBUF          2400                /* 采样缓冲 > 3 倍窗口 */
#define SC_BUF           ((volatile unsigned short *)0x40500000u)
#define SC_IRQ_K1        5u
#define SC_IRQ_K2        6u

#define C_GRID           0x00102010u         /* 暗绿网格 */
#define C_TRACE          0x00FFFF00u         /* 亮黄波形 */
#define C_TRIG           0x000080C0u         /* 青色触发电平线 */
#define C_TEXT           0x00FFFFFFu

static volatile unsigned int * const s_lcd_st =
    (volatile unsigned int *)AXI_LCD_ADDR(AXI_LCD_REG_STATUS);

/* 四档采样率: DIV = 32 MHz / fs */
static const unsigned int s_div_tab[4] = { 32000u, 16000u, 6400u, 3200u };
static const char *const  s_fs_name[4] = { "1k", "2k", "5k", "10k" };

static volatile unsigned char s_rate;      /* 0~3 */
static volatile unsigned char s_vscale = 1;/* 1 或 2 */
static volatile unsigned char s_edge   = 0;/* 0 = 上升沿, 1 = 下降沿 */
static volatile unsigned short s_th    = 2048;  /* 触发电平 (ADC 码) */
static volatile unsigned char s_chg    = 1;

static void k1_isr(void)
{
    s_rate = (unsigned char)((s_rate + 1u) & 3u);
    s_chg  = 1;
    *intc_int_clr = (1u << SC_IRQ_K1);
}

static void k2_isr(void)
{
    s_vscale = (s_vscale == 1u) ? 2u : 1u;
    s_chg    = 1;
    *intc_int_clr = (1u << SC_IRQ_K2);
}

/*--------------------------------------------------------------------
 *  采一窗: 从流式 SPI 的 RX FIFO 取 n 个 12 位样本
 *------------------------------------------------------------------*/
static int scope_capture(volatile unsigned short *buf, int n)
{
    int i;
    unsigned int guard;

    /* 先清掉上一轮残留 (FIFO 64 深) */
    guard = 0;
    while ((spis_status & SPIS_ST_RX_NE) && (guard++ < 128u)) {
        (void)spis_data;
    }

    for (i = 0; i < n; i++) {
        guard = 0;
        while (!(spis_status & SPIS_ST_RX_NE)) {
            if (++guard > 20000000u) {
                return i;                    /* 采样停住: 返回已采到的点数 */
            }
        }
        buf[i] = (unsigned short)(spis_data & 0x0FFFu);
    }
    return n;
}

/*--------------------------------------------------------------------
 *  触发: 在缓冲前段 (留足一个窗口) 找第一个穿越触发电平的位置。
 *  返回窗口起点 k (0 = 没找到, 自由运行显示前 800 点)。
 *  显示 k..k+799 连续数据, **不回绕拼接** —— 这是波形变形的根源。
 *------------------------------------------------------------------*/
static int scope_trigger(volatile unsigned short *buf, unsigned short th,
                         unsigned char falling)
{
    int i;
    const int limit = SC_NBUF - SC_NDISP;    /* 触发点最靠后的合法位置 */

    if (!falling) {
        for (i = 1; i < limit; i++) {
            if ((buf[i - 1] < th) && (buf[i] >= th)) return i;
        }
    } else {
        for (i = 1; i < limit; i++) {
            if ((buf[i - 1] > th) && (buf[i] <= th)) return i;
        }
    }
    return 0;
}

/* 竖直映射: 12 位样本 -> 像素 y (0 在上), scale = 1 或 2 */
static int scope_y(unsigned short v, unsigned char scale)
{
    int d = (int)v - 2048;
    int y = 240 - ((d * 479 * (int)scale) / 4095);

    if (y < 0)   y = 0;
    if (y > 479) y = 479;
    return y;
}

/*--------------------------------------------------------------------
 *  清屏: CPU 逐字填 0。**不用 AXI-DMA** —— 1.5 MB 的 DMA 搬运会和
 *  LCD 取流撞 DDR, 是"四色屏"问题的诱因 (见文件头注释)。
 *------------------------------------------------------------------*/
static void scope_fill_black(void)
{
    volatile unsigned int *p = (volatile unsigned int *)(unsigned int)GFX_FB0;
    unsigned int i;

    for (i = 0u; i < (AXI_LCD_WIDTH * AXI_LCD_HEIGHT); i++) {
        p[i] = 0u;
    }
}

static void scope_draw_grid(void)
{
    int i;

    scope_fill_black();

    for (i = 0; i <= 8; i++) {                 /* 横线: 每 60 像素 */
        gfx_hline(0, i * 60, SC_NDISP, C_GRID);
    }
    for (i = 0; i <= 10; i++) {                /* 竖线: 每 80 像素 */
        gfx_vline(i * 80, 0, 480, C_GRID);
    }

    /* 中线 (1.65 V) 用亮一点的绿色 */
    gfx_hline(0, 240, SC_NDISP, 0x0000C000u);
}

/*--------------------------------------------------------------------
 *  LCD 活性看门狗: FRAME 事件位 W1C。先清掉, 下一轮循环 (>=0.2 s,
 *  至少几十帧) 再读: 又置起了 = LCD 在刷屏; 连续 3 轮没置起 = 取流
 *  停摆, 自动 SWRST 重初始化并重画。UNDERRUN 顺手清并计数。
 *------------------------------------------------------------------*/
static unsigned int s_underruns;
static unsigned char s_lcd_wait  = 1;          /* 1 = 等待 FRAME 再置起 */
static unsigned char s_lcd_dead  = 0;

static void scope_lcd_watchdog(void)
{
    unsigned int st = *s_lcd_st;

    if (st & AXI_LCD_ST_UNDERRUN) {
        *s_lcd_st = AXI_LCD_ST_UNDERRUN;       /* W1C */
        s_underruns++;
    }

    if (st & AXI_LCD_ST_FRAME) {
        *s_lcd_st = AXI_LCD_ST_FRAME;          /* 活着: 清掉, 等下一帧 */
        s_lcd_wait = 1;
        s_lcd_dead = 0;
        return;
    }

    /* 没等到 FRAME 再置起 */
    if (s_lcd_wait) {
        s_lcd_wait = 0;                        /* 第一轮没等到, 先观察 */
        s_lcd_dead = 1;
        return;
    }
    if (++s_lcd_dead >= 3u) {
        printf("[SCOPE] LCD dead (underruns=%u) -> re-init\r\n", s_underruns);
        axi_lcd_reset();
        axi_lcd_set_fmt(AXI_LCD_FMT_RGB888);
        axi_lcd_set_fb(GFX_FB0);
        axi_lcd_clear_status();
        axi_lcd_start();
        s_lcd_wait = 1;
        s_lcd_dead = 0;
        scope_draw_grid();
    }
}

static void scope_print_cfg(void)
{
    printf("[CFG] fs=%sSa/s edge=%s trig=%umV x%u\r\n",
           s_fs_name[s_rate], s_edge ? "FALL" : "RISE",
           (unsigned int)s_th * 3300u / 4095u, (unsigned int)s_vscale);
}

void lcd_scope_demo(void)
{
    int i, n, k, frames = 0;
    unsigned short vmin, vmax;
    unsigned int crossings, fs;
    int rc;

    printf("exp5: LCD scope, SPI AD via spi_stream @0x%08x\r\n", spis_base);
    printf("[HELP] r=fs e=edge t/g=trig+-0.2V x=vscale h=help\r\n");

    rc = gfx_init(GFX_FB0);
    printf("gfx_init rc=%d, LCD ID=0x%08x\r\n", rc, gfx_lcd_id());
    if (rc != 0) {
        for (;;) { delay_s(1); printf("!! no AXI-LCD\r\n"); }
    }

    /* K1/K2 = INTC 第 5/6 根线, 上升沿 */
    intc_irq_init();
    *intc_int_pol  |= (1u << SC_IRQ_K1) | (1u << SC_IRQ_K2);
    *intc_int_edge |= (1u << SC_IRQ_K1) | (1u << SC_IRQ_K2);
    *intc_int_en   |= (1u << SC_IRQ_K1) | (1u << SC_IRQ_K2);
    intc_irq_attach(SC_IRQ_K1, k1_isr);
    intc_irq_attach(SC_IRQ_K2, k2_isr);

    scope_draw_grid();
    scope_print_cfg();

    for (;;) {
        int c = uart_getchar_nb();

        /* ---- UART 交互参数 ---- */
        if (c == 'r') {
            s_rate = (unsigned char)((s_rate + 1u) & 3u);
            s_chg  = 1;
        } else if (c == 'e') {
            s_edge = (unsigned char)(s_edge ? 0u : 1u);
        } else if (c == 't') {                 /* 触发电平 +0.2V */
            unsigned int t = (unsigned int)s_th + 256u;
            s_th = (unsigned short)((t > 3840u) ? 3840u : t);
        } else if (c == 'g') {                 /* 触发电平 -0.2V */
            unsigned int t = (unsigned int)s_th - 256u;
            s_th = (unsigned short)((t > 65535u) ? 256u : t);
        } else if (c == 'x') {
            s_vscale = (unsigned char)((s_vscale == 1u) ? 2u : 1u);
        } else if (c == 'h') {
            printf("[HELP] r=fs cycle e=edge t/g=trig level x=vscale\r\n");
        }
        if ((c == 'r') || (c == 'e') || (c == 't') ||
            (c == 'g') || (c == 'x')) {
            scope_print_cfg();
        }

        if (s_chg) {
            s_chg = 0;
            spis_ctrl = 0;                       /* 先停, 改 DIV 才生效 */
            spis_div  = s_div_tab[s_rate];
            spis_ch   = 0;                       /* 通道 0 = 电位器 */
            spis_cnt  = 0;                       /* 写任意值清采样计数 */
            spis_ctrl = SPIS_CTRL_EN;            /* AD 模式, 不开中断 */
            delay_ms(2);
        }

        fs = 32000000u / s_div_tab[s_rate];

        n = scope_capture(SC_BUF, SC_NBUF);
        if (n < SC_NBUF) {
            printf("[SCOPE] capture stalled at %d, check SPI AD module\r\n", n);
            scope_lcd_watchdog();
            delay_ms(200);
            continue;
        }

        /* 显示窗口起点: 触发后连续 800 点 */
        k = scope_trigger(SC_BUF, s_th, s_edge);

        vmin = 0x0FFFu; vmax = 0; crossings = 0;
        for (i = 0; i < SC_NDISP; i++) {
            unsigned short v = SC_BUF[k + i];
            unsigned short p = (i > 0) ? SC_BUF[k + i - 1] : v;
            if (v < vmin) vmin = v;
            if (v > vmax) vmax = v;
            if (!s_edge) {
                if ((p < s_th) && (v >= s_th)) crossings++;
            } else {
                if ((p > s_th) && (v <= s_th)) crossings++;
            }
        }

        /* 每帧 CPU 清屏 + 重画网格 (不用 DMA, 见文件头) */
        scope_draw_grid();

        /* 触发电平参考线 (青色) */
        gfx_hline(0, scope_y(s_th, s_vscale), SC_NDISP, C_TRIG);

        /* 画波形: 窗口 = buf[k .. k+799], 连续不拼接 */
        for (i = 0; i < SC_NDISP - 1; i++) {
            unsigned short a = SC_BUF[k + i];
            unsigned short b = SC_BUF[k + i + 1];
            int y1 = scope_y(a, s_vscale);
            int y2 = scope_y(b, s_vscale);

            if (y1 <= y2) gfx_vline(i, y1, y2 - y1 + 1, C_TRACE);
            else          gfx_vline(i, y2, y1 - y2 + 1, C_TRACE);
        }

        /* 参数文字 */
        {
            char line[40];
            unsigned int vpp_mv = (unsigned int)(vmax - vmin) * 3300u / 4095u;
            unsigned int f_hz   = (crossings * fs) / (unsigned int)SC_NDISP;

            gfx_str(8, 8, "LA132 SCOPE  CH0", C_TEXT, GFX_BLACK);
            gfx_str(8, 24, s_fs_name[s_rate], C_TEXT, GFX_BLACK);
            gfx_str(40, 24, "Sa/s", C_TEXT, GFX_BLACK);
            gfx_str(88, 24, s_edge ? "FALL" : "RISE", C_TEXT, GFX_BLACK);

            line[0] = 'V'; line[1] = 'p'; line[2] = 'p'; line[3] = '=';
            line[4] = (char)('0' + (vpp_mv / 1000u) % 10u);
            line[5] = '.';
            line[6] = (char)('0' + (vpp_mv / 100u) % 10u);
            line[7] = (char)('0' + (vpp_mv / 10u) % 10u);
            line[8] = 'V'; line[9] = 0;
            gfx_str(8, 40, line, C_TEXT, GFX_BLACK);

            line[0] = 'f'; line[1] = '=';
            line[2] = (char)('0' + (f_hz / 10000u) % 10u);
            line[3] = (char)('0' + (f_hz / 1000u) % 10u);
            line[4] = (char)('0' + (f_hz / 100u) % 10u);
            line[5] = (char)('0' + (f_hz / 10u) % 10u);
            line[6] = (char)('0' + f_hz % 10u);
            line[7] = 'H'; line[8] = 'z'; line[9] = 0;
            gfx_str(8, 56, line, C_TEXT, GFX_BLACK);

            line[0] = 'x'; line[1] = (char)('0' + s_vscale); line[2] = 0;
            gfx_str(8, 72, line, C_TEXT, GFX_BLACK);
        }

        scope_lcd_watchdog();

        if ((frames++ % 10) == 0) {
            printf("[SCOPE] fs=%s edge=%s th=%u Vpp=%umV f=%uHz trig=%d x%u cnt=%u underrun=%u\r\n",
                   s_fs_name[s_rate], s_edge ? "FALL" : "RISE",
                   (unsigned int)s_th,
                   (unsigned int)(vmax - vmin) * 3300u / 4095u,
                   (crossings * fs) / (unsigned int)SC_NDISP,
                   k, (unsigned int)s_vscale, spis_cnt, s_underruns);
        }
    }
}
