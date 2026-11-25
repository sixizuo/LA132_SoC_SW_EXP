/**
 * @file    demo_touch_trail.c
 * @brief   LCD 实时触摸轨迹显示 —— 背景黑, 曲线白
 *
 * ====================================================================
 *  硬件通路 (已按 RTL 核对, 见 hw/peripheral/apb_touch/touch_top.v)
 * ====================================================================
 *  触摸控制器  APB  @ 0x3006_0000
 *       +0x00  TOUCH_CTRL      写: [0]工作使能 [1]中断使能
 *                              读: [3:2]={fifo_full, !fifo_empty} [1:0]控制位
 *       +0x04  TOUCH_INTERVAL  采样节流 (单位: APB 时钟拍数, 默认 95000)
 *       +0x08  TOUCH_DATA      读一次 = 从 FIFO 弹出一个点
 *                              数据格式 = {x[31:16], y[15:0]}
 *       FIFO 里只存坐标, 没有"按下/抬起"标志 —— 采样间隔变大就说明抬笔了。
 *
 *  显示控制器  AXI-LCD @ 0x2000_0000, 显存放 DDR @ 0x4000_0000
 *       800 x 480, RGB888, **1 像素 = 1 个 32bit 字** (0x00RRGGBB)
 *       像素地址 = 显存基址 + (y * 800 + x) * 4
 *       LCD 会自己不断地按帧扫描显存, 所以往显存里写就等于"立刻上屏",
 *       不需要每次重启动画。
 *
 * ====================================================================
 *  为什么用轮询而不是中断
 * ====================================================================
 *  FIFO 已经替我们做了缓冲, 主循环直接查 CTRL.bit3 就够了, 不必配 INTC。
 *  (★ 注意: 如果确实想用中断, 触摸 IRQ 接的是 INTC 的 **int_7**。
 *     旧驱动 driver/LCD/lcd_touch.c 里写的 Set_Interrupt(3) 是错的 ——
 *     int_3 是 iic_irq。)
 *
 * ====================================================================
 *  坐标标定 (第一次上板请读这一节)
 * ====================================================================
 *  触摸 IC 输出的原始坐标范围跟屏厂配置有关 (常见 0~4095), 不一定是
 *  800x480。本程序:
 *    1) 用 TOUCH_RAW_MAX_X / _Y 做线性缩放, 默认按 4096 估;
 *    2) 每笔结束时把**这一笔观测到的原始坐标范围**打到串口 ——
 *       在屏上画一条横贯左右、再画一条贯上下的线, 就能量出真实范围,
 *       把量到的值填回 TOUCH_RAW_MAX_X/Y 即可;
 *    3) 若画面是转 90° 或镜像的, 用 TRAIL_SWAP_XY / TRAIL_INV_X / _Y
 *       三个开关一键纠正 (与标定图 [3] 配合判断)。
 *
 * ====================================================================
 *  ★ 已知 RTL 问题: 触摸坐标大部分进不了 FIFO (2026-10-15 定位)
 * ====================================================================
 *  现象: 轨迹是一串稀疏的点, 一笔常被切成很多"单点笔"。
 *
 *  机理 (见 hw/peripheral/apb_touch/touch_top.v + i2c_dri_m.v):
 *    - FIFO 的写时钟是 dri_clk = 32MHz/64 = **500 kHz** (周期 2 us);
 *    - 但写使能 tc_fifo_wren 由 **apb_pclk 域**的 touch_delay_cnt 组合产生,
 *      只高 **2 个 apb 周期 (62.5 ns)**;
 *    - 62.5 ns 的脉冲去撞 2 us 才来一次的写时钟上升沿 →
 *      单次命中率 ≈ 2/64 ≈ **3%**;
 *    - 又因为 delay_cnt 的周期 95000 与 dri_clk 的 64 不同步
 *      (95000 mod 64 = 24), 每次尝试的相位都会漂移,
 *      所以是"大约每 32 次尝试落一个点";
 *    - 加上 touch_dri 每次读触摸 IC 前有 20 ms 延时,
 *      实测某笔尝试间隔 ≈ 2.97 ms → **平均 ~95 ms 才进 FIFO 一个坐标**。
 *
 *  规避 (本文件已做, 不用改 RTL): 把 TRAIL_PEN_UP_MS 放到 250 ms,
 *  一笔就不会被切断。主循环里还会每 2 s 打印 [诊断] 行报实际采样率。
 *
 *  彻底修法 (需改 RTL 并重新出 bit, 未做):
 *    把写使能整体搬到 dri_clk 域 —— 在 dri_clk 域里用计数器产生"单拍脉冲",
 *    再与 touch_valid 相与:
 *        assign tc_fifo_wren = touch_valid & wr_pulse;   // 全在 dri 域
 *    这样每个采样都能被 500 kHz 的写时钟稳定采到。
 */

#include "demo_touch_trail.h"

#include "axi_lcd.h"
#include "axi_dma.h"
#include "PRINTF/printf.h"
#include "LA_TIMER/latimer.h"

/*====================================================================
 *  1. 可调参数
 *==================================================================*/

/* ---- 显示 ---- */
#define TRAIL_FB_BASE           0x40000000u     /* DDR 里的显存 (与 axi_lcd_dma_demo 一致) */
#define TRAIL_W                 800
#define TRAIL_H                 480
#define TRAIL_BLACK             0x00000000u     /* 背景色: 黑 */
#define TRAIL_WHITE             0x00FFFFFFu     /* 轨迹色: 白 */

/* ---- 触摸控制器 ---- */
#define TRAIL_TOUCH_BASE        0x30060000u
#define TRAIL_TOUCH_CTRL        (*(volatile uint32_t *)(TRAIL_TOUCH_BASE + 0x00u))
#define TRAIL_TOUCH_INTV        (*(volatile uint32_t *)(TRAIL_TOUCH_BASE + 0x04u))
#define TRAIL_TOUCH_DATA        (*(volatile uint32_t *)(TRAIL_TOUCH_BASE + 0x08u))

#define TOUCH_CTRL_WORK_EN      (1u << 0)       /* 工作使能 (必须开, 否则不采样) */
#define TOUCH_CTRL_INT_EN       (1u << 1)       /* 中断使能 (轮询方式不用开) */
/* ★ 2026-10-30 修正: 这两位的顺序写反了 —— 触摸点全被丢掉, 屏上画不出轨迹。
 *   依据 RTL (hw/peripheral/apb_touch/touch_top.v):
 *       assign prdata = {28'b0, fifo_state, touch_ctrl[1:0]};
 *       assign fifo_state = {tc_fifo_full, !tc_fifo_empty};   // 2 bit
 *   =>  bit2 = !empty (FIFO 非空 = 有坐标)     <-- 这才是"有数据"
 *       bit3 = full   (FIFO 满)
 *   旧代码按 {full@2, !empty@3} 读, 于是永远在等"FIFO 满",
 *   真正有数据的 bit2 从来没看过 -> 一个点都取不到。
 *   旁证: 使能后立刻读回 0x9 (bit0=1 工作, bit3=1), 那是 Xilinx FIFO
 *   复位期间 full/empty 同时为 1 的瞬间态, 不是"有数据"。 */
#define TOUCH_CTRL_FIFO_RDY     (1u << 2)       /* 读回: FIFO 非空 = 有坐标 */
#define TOUCH_CTRL_FIFO_FULL    (1u << 3)       /* 读回: FIFO 满 */

#define TRAIL_TOUCH_INTERVAL    95000u          /* 采样节流 ≈ 2.97 ms @32MHz */

/* ---- 坐标标定 ----
 * ★ GT911/GT 系列返回的是**面板原生像素坐标**, 4.3" 800x480 屏的满量程
 *   是 0..799 / 0..479, **不是 4096**!
 *   (2026-10-15 踩坑: 按 4096 估满量程 -> 800/4096=0.195, 整幅轨迹被
 *    等比例压进左上角约 156x94 的一小块。)
 * 满量程是运行时变量 g_raw_max_x/y (见下), 这里只给初值;
 * TRAIL_AUTO_RANGE=1 时实测坐标一旦超出当前量程 25% 就自动扩大,
 * 换屏/换触摸 IC 也不用改代码。上限 TOUCH_RAW_MAX_LIMIT 防呆。 */
#define TOUCH_RAW_MAX_X         800             /* 触摸 IC 原始 x 满量程 (初值) */
#define TOUCH_RAW_MAX_Y         480             /* 触摸 IC 原始 y 满量程 (初值) */
#define TOUCH_RAW_MAX_LIMIT     8192            /* 自动量程上限 (防坏数据撑爆) */
#define TRAIL_AUTO_RANGE        1               /* 1 = 自动扩量程 */
#define TRAIL_SWAP_XY           0               /* 1 = 交换 x/y (画面整体转 90° 时用) */
#define TRAIL_INV_X             0               /* 1 = x 左右镜像 */
#define TRAIL_INV_Y             0               /* 1 = y 上下镜像 */

/* 自动扩量程的迟滞门限 (%): raw 超过 当前量程*(100+25)% 才扩张。
 * 正常划到屏幕边角的 raw≈799/479 不会超过 800/480 的 125%, 不会误触发。 */
#define TRAIL_AUTO_RANGE_HYST   25

/* ---- 手感 ---- */
#define TRAIL_BRUSH_R           3               /* 画笔半径 (像素); 0 = 单像素点 */

/*  ★ 抬笔门限必须大于"相邻两个坐标的最坏间隔", 否则一笔会被切成一堆单点笔。
 *  实测 (2026-10-15): 由于 RTL 侧 FIFO 写使能存在跨时钟问题 (详见文件头
 *  「已知 RTL 问题」一节), 坐标平均 ~95 ms 才进 FIFO 一次, 抖动很大。
 *  所以这里取 250 ms —— 能把一笔连起来, 又远小于 TRAIL_CLEAR_GAP_MS,
 *  逻辑不冲突。**RTL 修好后可以调回 30~50 ms**。 */
#define TRAIL_PEN_UP_MS         250

#define TRAIL_CLEAR_GAP_MS      1500            /* 抬笔超过 1.5 s, 下一笔自动换新画布 */
#define TRAIL_DEBUG_RAW         1               /* 1 = 开头打印若干组原始坐标 */
#define TRAIL_DEBUG_RAW_N       12              /*   打印组数 */
#define TRAIL_STAT_PERIOD_MS    2000            /* 每 2 s 报一次采样率 (诊断用) */

/*====================================================================
 *  2. 显存操作 (直接读写 DDR 里的显存)
 *==================================================================*/

/* ---- 触摸原始坐标满量程 (运行时可扩, 见 trail_auto_range) ---- */
static uint32_t g_raw_max_x = TOUCH_RAW_MAX_X;
static uint32_t g_raw_max_y = TOUCH_RAW_MAX_Y;

static inline void fb_put(int x, int y, uint32_t color)
{
    *(volatile uint32_t *)(TRAIL_FB_BASE
                           + (((uint32_t)y * (uint32_t)TRAIL_W + (uint32_t)x) << 2)) = color;
}

/**
 * 按原始比例缩放并裁剪到 [0, out_max-1]
 * raw <= 65535, out_max <= 800 -> raw*out_max 最大约 5.2e7, 不会溢出 uint32
 */
static int trail_scale(uint32_t raw, uint32_t raw_max, int out_max)
{
    uint32_t v;

    if (raw_max == 0u) {
        raw_max = 1u;
    }
    v = (raw * (uint32_t)out_max) / raw_max;
    if (v >= (uint32_t)out_max) {
        v = (uint32_t)out_max - 1u;
    }
    return (int)v;
}

/**
 * 画笔: 以 (cx,cy) 为圆心画一个实心圆 (比单像素点好按, 也好看)
 * 半径 0 时退化成单像素点。自动裁剪到屏幕内。
 */
static void trail_brush(int cx, int cy)
{
    int dx, dy;

    if (TRAIL_BRUSH_R <= 0) {
        if (cx >= 0 && cx < TRAIL_W && cy >= 0 && cy < TRAIL_H) {
            fb_put(cx, cy, TRAIL_WHITE);
        }
        return;
    }

    for (dy = -TRAIL_BRUSH_R; dy <= TRAIL_BRUSH_R; dy++) {
        for (dx = -TRAIL_BRUSH_R; dx <= TRAIL_BRUSH_R; dx++) {
            int x = cx + dx;
            int y = cy + dy;

            /* 圆内 (含边界) 才画 */
            if ((dx * dx + dy * dy) > (TRAIL_BRUSH_R * TRAIL_BRUSH_R)) {
                continue;
            }
            if (x < 0 || x >= TRAIL_W || y < 0 || y >= TRAIL_H) {
                continue;
            }
            fb_put(x, y, TRAIL_WHITE);
        }
    }
}

/**
 * Bresenham 直线, 每个落点都盖一个画笔 —— 快速滑动时轨迹才不会断成
 * 一串孤立的点。
 */
static void trail_line(int x0, int y0, int x1, int y1)
{
    int dx = (x1 > x0) ? (x1 - x0) : (x0 - x1);
    int dy = (y1 > y0) ? (y1 - y0) : (y0 - y1);
    int sx = (x0 < x1) ? 1 : -1;
    int sy = (y0 < y1) ? 1 : -1;
    int err = dx - dy;

    for (;;) {
        trail_brush(x0, y0);

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

/** 用 DMA 整屏填色 (比 CPU 逐字写快得多) */
static void trail_clear(uint32_t color)
{
    (void)axi_dma_memset(TRAIL_FB_BASE, color, AXI_LCD_FB_BYTES);
}

/**
 * 自动扩量程: 实测 raw 超出当前量程 TRAIL_AUTO_RANGE_HYST% 才扩张。
 * 正常划到边角的 raw≈799/479 不会超过 800/480 的 125% (带迟滞),
 * 只有换了大分辨率屏/触摸 IC 满量程更大时才会触发, 换板不用改代码。
 */
static void trail_auto_range(uint32_t raw_x, uint32_t raw_y)
{
#if TRAIL_AUTO_RANGE
    /* 用乘法避免除法/浮点: raw > max*(100+HYST)/100  <=>  raw*100 > max*(100+HYST) */
    if ((uint32_t)raw_x * 100u > (uint32_t)g_raw_max_x * (100u + TRAIL_AUTO_RANGE_HYST)
        && raw_x <= TOUCH_RAW_MAX_LIMIT) {
        g_raw_max_x = raw_x;
        printf("    [自动量程] x 满量程 -> %d\r\n", (int)g_raw_max_x);
    }
    if ((uint32_t)raw_y * 100u > (uint32_t)g_raw_max_y * (100u + TRAIL_AUTO_RANGE_HYST)
        && raw_y <= TOUCH_RAW_MAX_LIMIT) {
        g_raw_max_y = raw_y;
        printf("    [自动量程] y 满量程 -> %d\r\n", (int)g_raw_max_y);
    }
#else
    (void)raw_x;
    (void)raw_y;
#endif
}

/**
 * 开机显示区域自检: 满屏白框 + 四角 40x40 方块 + 中心十字, 停 3 s 后擦除。
 * 用来一眼分清故障归属:
 *   白框贴满四边、四角方块分居四角 -> 显示通路正常
 *   (那么"轨迹缩在左上角"就是触摸缩放问题);
 *   白框自己也只占左上角一小块   -> 显示/面板通路问题, 与触摸无关。
 */
static void trail_selfcheck(void)
{
    int i, j;
    const int blk = 40;                     /* 四角方块边长 */
    const int arm = 40;                     /* 中心十字臂长 */
    const int cx = TRAIL_W / 2, cy = TRAIL_H / 2;

    /* 满屏外框 */
    for (i = 0; i < TRAIL_W; i++) {
        fb_put(i, 0, TRAIL_WHITE);
        fb_put(i, TRAIL_H - 1, TRAIL_WHITE);
    }
    for (i = 0; i < TRAIL_H; i++) {
        fb_put(0, i, TRAIL_WHITE);
        fb_put(TRAIL_W - 1, i, TRAIL_WHITE);
    }

    /* 四角 40x40 实心方块 */
    for (j = 0; j < blk; j++) {
        for (i = 0; i < blk; i++) {
            fb_put(i, j, TRAIL_WHITE);                              /* 左上 */
            fb_put(TRAIL_W - 1 - i, j, TRAIL_WHITE);                /* 右上 */
            fb_put(i, TRAIL_H - 1 - j, TRAIL_WHITE);                /* 左下 */
            fb_put(TRAIL_W - 1 - i, TRAIL_H - 1 - j, TRAIL_WHITE);  /* 右下 */
        }
    }

    /* 中心十字 */
    for (i = cx - arm; i <= cx + arm; i++) { fb_put(i, cy, TRAIL_WHITE); }
    for (i = cy - arm; i <= cy + arm; i++) { fb_put(cx, i, TRAIL_WHITE); }

    printf("显示自检图案已画 (外框+四角方块+中心十字), 停 3 s ...\r\n");
    printf(">>> 白框贴满四边 = 显示通路正常; 白框也缩在左上角 = 显示问题\r\n");
    delay_ms(3000);
    trail_clear(TRAIL_BLACK);
    printf("自检结束, 已清屏。\r\n");
}

/*====================================================================
 *  3. 触摸坐标读取 + 映射
 *==================================================================*/

/**
 * @brief 从 FIFO 取一个触摸点 (非阻塞)
 * @return 1 = 取到了, 0 = 当前没有新坐标
 */
static int touch_read_raw(uint32_t *px, uint32_t *py)
{
    uint32_t data;

    if ((TRAIL_TOUCH_CTRL & TOUCH_CTRL_FIFO_RDY) == 0u) {
        return 0;                   /* FIFO 空 */
    }

    data = TRAIL_TOUCH_DATA;        /* 读一次就弹出队首那个点 */

    *px = (data >> 16) & 0xFFFFu;   /* 高 16 位 = x */
    *py =  data        & 0xFFFFu;   /* 低 16 位 = y */
    return 1;
}

/** 原始坐标 -> 屏幕坐标 (含 90° 旋转 / 镜像开关); 满量程用运行时变量 */
static void touch_map(uint32_t raw_x, uint32_t raw_y, int *sx, int *sy)
{
    int x, y;

#if TRAIL_SWAP_XY
    /* 交换 x/y: 注意交换后 x 要用 y 方向的满量程来缩放 */
    x = trail_scale(raw_y, g_raw_max_y, TRAIL_W);
    y = trail_scale(raw_x, g_raw_max_x, TRAIL_H);
#else
    x = trail_scale(raw_x, g_raw_max_x, TRAIL_W);
    y = trail_scale(raw_y, g_raw_max_y, TRAIL_H);
#endif

#if TRAIL_INV_X
    x = (TRAIL_W - 1) - x;
#endif
#if TRAIL_INV_Y
    y = (TRAIL_H - 1) - y;
#endif

    *sx = x;
    *sy = y;
}

/*====================================================================
 *  4. 演示主流程
 *==================================================================*/
void touch_trail_demo(void)
{
    uint32_t st;
    uint32_t raw_x, raw_y;
    uint32_t idle_ms   = 0;         /* 距离上一次收到坐标已过去的毫秒数 */
    uint32_t stroke_no = 0;
    uint32_t n_pts     = 0;         /* 本笔已收到的采样点数 */
    uint32_t rate_ms   = 0;         /* 采样率统计窗口 (ms) */
    uint32_t rate_cnt  = 0;         /* 窗口内收到的点数 */
    uint32_t gap_ms;
#if TRAIL_DEBUG_RAW
    uint32_t dbg_cnt   = 0;
#endif
    /* 每笔的原始坐标观测范围, 用来标定 TOUCH_RAW_MAX_X/Y。
     * ⚠ 必须在本笔**第一个点之前**清零, 否则第一个点会被自己的清零动作抹掉,
     *   单点笔就会打印出 65535..0 这种哨兵值 (2026-10-15 修)。 */
    uint32_t min_x = 0xFFFFu, max_x = 0u;
    uint32_t min_y = 0xFFFFu, max_y = 0u;
    int      sx, sy;
    int      last_x = 0, last_y = 0;
    int      pen_down = 0;

    printf("\r\n==== AXI LCD 触摸轨迹 (背景黑 / 轨迹白) ====\r\n");
    printf("触摸 CTRL @ 0x%08x, 显存 @ 0x%08x (%dx%d)\r\n",
           (unsigned int)TRAIL_TOUCH_BASE,
           (unsigned int)TRAIL_FB_BASE, TRAIL_W, TRAIL_H);

    /* ---------------- (1) 显示自检 + 初始化 ---------------- */
    if (axi_lcd_probe() != 0) {
        printf("!! AXI-LCD 自检失败 (ID/RES 不匹配), 退出\r\n");
        return;
    }
    printf("AXI-LCD  ID = 0x%08x (expect 0x%08x), RES = 0x%08x\r\n",
           axi_lcd_read(AXI_LCD_REG_ID), AXI_LCD_ID_EXPECT,
           axi_lcd_get_res());
    printf("一帧字节数 = %d\r\n", (int)axi_lcd_get_fb_bytes());

    if (axi_dma_get_version() != AXI_DMA_VER_EXPECT) {
        printf("!! AXI-DMAC 未找到, 退出\r\n");
        return;
    }

    /* 先把显存刷成纯黑, 再开显示 —— 否则开机瞬间会看到 DDR 里的随机内容 */
    printf("DMA 清屏 -> 黑 ...\r\n");
    trail_clear(TRAIL_BLACK);

    axi_lcd_set_fmt(AXI_LCD_FMT_RGB888);
    axi_lcd_set_fb(TRAIL_FB_BASE);
    axi_lcd_clear_status();
    axi_lcd_start();

    delay_ms(100);
    st = axi_lcd_get_status();
    printf("LCD STATUS = 0x%08x  fill=%d  frame=%d  underrun=%d\r\n",
           st,
           (int)((st & AXI_LCD_ST_FILL_MSK) >> AXI_LCD_ST_FILL_POS),
           (st & AXI_LCD_ST_FRAME)    ? 1 : 0,
           (st & AXI_LCD_ST_UNDERRUN) ? 1 : 0);
    printf(" >>> 屏上现在应是一片纯黑\r\n");

    /* ---------------- (1.5) 显示区域自检 (3 s) ---------------- */
    trail_selfcheck();

    /* ---------------- (2) 触摸初始化 (轮询, 不用中断) ---------------- */
    TRAIL_TOUCH_INTV = TRAIL_TOUCH_INTERVAL;
    TRAIL_TOUCH_CTRL = TOUCH_CTRL_WORK_EN;      /* 只开工作使能 */
    printf("TOUCH CTRL = 0x%08x (bit0=工作, bit3=有数据)\r\n",
           (unsigned int)TRAIL_TOUCH_CTRL);

    printf("\r\n请用手指在屏上画线 —— 抬笔一下再画就是新的一笔。\r\n");
    printf("判读: 背景应为纯黑, 手指划过的轨迹为白线。\r\n");
    printf("标定: GT 系列输出面板原生坐标, 满量程默认 %d/%d;\r\n",
           TOUCH_RAW_MAX_X, TOUCH_RAW_MAX_Y);
    printf("      自动量程已开(超出 25%% 自动扩, 上限 %d), 每笔结束仍会打印\r\n",
           TOUCH_RAW_MAX_LIMIT);
    printf("      本笔原始坐标范围供核对。\r\n");
    printf("      若轨迹方向与手指不一致, 调 TRAIL_SWAP_XY / TRAIL_INV_X / TRAIL_INV_Y。\r\n");

    /* ---------------- (3) 主循环: 取点 -> 连线 ------------------- */
    for (;;) {
        /* ---- 没有新坐标: 按 1 ms 步进累计空闲时间, 判抬笔 + 统计采样率 ---- */
        if (!touch_read_raw(&raw_x, &raw_y)) {
            delay_ms(1);
            idle_ms++;
            rate_ms++;

            if (pen_down && (idle_ms >= TRAIL_PEN_UP_MS)) {
                pen_down = 0;
                printf("    [第 %d 笔结束] 采样点数 = %d",
                       (int)stroke_no, (int)n_pts);
                if (n_pts > 0u) {
                    printf(", 原始坐标范围 x = %d..%d, y = %d..%d",
                           (int)min_x, (int)max_x, (int)min_y, (int)max_y);
                }
                printf("\r\n");
                printf("    >>> 若这一笔手指横贯了整个屏, 上面的范围就是");
                printf(" TOUCH_RAW_MAX_X/Y 的参考值\r\n");
                printf("    >>> 若采样点数只有 1~2 个, 说明坐标大多没进 FIFO,");
                printf(" 请看下面的 [诊断] 行\r\n");
            }

            if (rate_ms >= TRAIL_STAT_PERIOD_MS) {
                printf("    [诊断] 近 %d ms 收到 %d 个点 (≈ %d 点/秒)\r\n",
                       (int)rate_ms, (int)rate_cnt,
                       (int)(rate_cnt * 1000u / rate_ms));
                rate_ms  = 0;
                rate_cnt = 0;
            }
            continue;
        }

        /* ---- 取到了新坐标 ---- */
        gap_ms  = idle_ms;      /* 距上一个点的间隔 = 是否抬过笔的依据 */
        idle_ms = 0;
        rate_cnt++;

        /* ★ 落笔判断必须在"记录坐标范围"之前 ——
         *   新笔要先把统计清零, 否则第一个点会被自己的清零动作抹掉 */
        if (!pen_down) {
            /* ---- 落笔: 间隔太久就先换一张干净画布 ---- */
            if (gap_ms >= TRAIL_CLEAR_GAP_MS) {
                trail_clear(TRAIL_BLACK);
                printf("    (抬笔较久, 已清屏开新画布)\r\n");
            }

            pen_down  = 1;
            stroke_no++;
            n_pts     = 0;
            min_x = 0xFFFFu; max_x = 0u;    /* 本笔统计清零 (在记录之前!) */
            min_y = 0xFFFFu; max_y = 0u;
            printf("  >> 第 %d 笔开始\r\n", (int)stroke_no);
        }

        /* ---- 记录本笔观测范围 (第一个点也算进来) ---- */
        if (raw_x < min_x) { min_x = raw_x; }
        if (raw_x > max_x) { max_x = raw_x; }
        if (raw_y < min_y) { min_y = raw_y; }
        if (raw_y > max_y) { max_y = raw_y; }
        n_pts++;

        /* ---- 自动扩量程 (在映射之前做, 本点即用新量程) ---- */
        trail_auto_range(raw_x, raw_y);

#if TRAIL_DEBUG_RAW
        if (dbg_cnt < TRAIL_DEBUG_RAW_N) {
            printf("    raw(%2d): x = %5d (0x%04x)  y = %5d (0x%04x)\r\n",
                   (int)dbg_cnt, (int)raw_x, (unsigned int)raw_x,
                   (int)raw_y, (unsigned int)raw_y);
            dbg_cnt++;
        }
#endif

        touch_map(raw_x, raw_y, &sx, &sy);

        if (n_pts == 1u) {
            printf("    第 %d 笔首点 -> 屏幕坐标 (%d, %d)\r\n",
                   (int)stroke_no, sx, sy);
            trail_brush(sx, sy);            /* 第一点只画个点, 不连线 */
        } else {
            /* ---- 笔还在走: 与上一点连成线段 ---- */
            trail_line(last_x, last_y, sx, sy);
        }

        last_x = sx;
        last_y = sy;
    }
}
