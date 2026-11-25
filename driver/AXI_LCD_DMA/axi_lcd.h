/**
 * @file    axi_lcd.h
 * @brief   AXI LCD 控制器驱动 (LA132 / 云晓 100T)
 *          - LCD 作为 AXI 从设备接收 CPU 配置
 *          - LCD 作为 AXI 主设备读取 DDR3 显存
 *          - 1 像素 = 1 个 32bit 显存字:
 *              bit[31:24] 无效, [23:16] R8, [15:8] G8, [7:0] B8
 *
 *  基址 : 0x4000_0000  (AXI 从设备 S2, 64KB)
 *         !! 新地址 —— 既不是原 APB LCD 的 0x5200_0000, 也不是早期的
 *            0x3001_0000 (那个地址落在 DDR 512MB 窗口 0x2000_0000 ~
 *            0x3FFF_FFFF 之内, 会被 DDR 译码吞掉) !!
 *         本版已移除 APB 版 lcd_top, LCD 全部由 axi_lcd 驱动
 *  显存 : DDR3, 由 axi_lcd_set_fb() 指定 (强制 64B 对齐)
 *
 *  配套 RTL : hw/peripheral/axi_lcd/axi_lcd.v
 */

#ifndef _AXI_LCD_H_
#define _AXI_LCD_H_

#include "test.h"

#ifdef __cplusplus
extern "C" {
#endif

/*--------------------------------------------------------------------
 * 基址与寄存器偏移 (字偏移)
 *------------------------------------------------------------------*/
#define AXI_LCD_BASE            0x20000000u

#define AXI_LCD_REG_CTRL        0x00u   /* R/W  [0]EN [1]GO [3:2]FMT [7:4]PF_THRESH [31]SWRST */
#define AXI_LCD_REG_BUF         0x04u   /* R/W  显存基址, 强制 64B 对齐 */
#define AXI_LCD_REG_STATUS      0x08u   /* R/W1C [31:16]填充字数 [3]FRAME [2]UNDERRUN [0]BUF_READY */
#define AXI_LCD_REG_FBSIZE      0x0Cu   /* R    一帧字节数 = 800*480*4 */
#define AXI_LCD_REG_RES         0x10u   /* R    {H_DISP, V_DISP} = {800, 480} */
#define AXI_LCD_REG_ID          0x14u   /* R    LCD 模块 ID = 0x4384 */

#define AXI_LCD_ADDR(off)       (AXI_LCD_BASE + (off))

/*--------------------------------------------------------------------
 * REG_CTRL 位域
 *------------------------------------------------------------------*/
#define AXI_LCD_CTRL_EN         (1u << 0)   /* 显示使能 */
#define AXI_LCD_CTRL_GO         (1u << 1)   /* 预取启动 */
#define AXI_LCD_CTRL_FMT_POS    2u
#define AXI_LCD_CTRL_FMT_MSK    (3u << 2)
#define AXI_LCD_CTRL_PFT_POS    4u          /* PF_THRESH, 预取阈值 */
#define AXI_LCD_CTRL_PFT_MSK    (0xFu << 4)
#define AXI_LCD_CTRL_SWRST      (1u << 31)  /* 软复位, 自清 */

/* 像素格式 (REG_CTRL[3:2]) */
#define AXI_LCD_FMT_RGB332      0u
#define AXI_LCD_FMT_RGB444      1u
#define AXI_LCD_FMT_RGB565      2u
#define AXI_LCD_FMT_RGB888      3u

/*--------------------------------------------------------------------
 * REG_STATUS 位域
 *------------------------------------------------------------------*/
#define AXI_LCD_ST_BUF_READY    (1u << 0)
#define AXI_LCD_ST_UNDERRUN     (1u << 2)   /* W1C */
#define AXI_LCD_ST_FRAME        (1u << 3)   /* W1C */
#define AXI_LCD_ST_FILL_POS     16u
#define AXI_LCD_ST_FILL_MSK     (0xFFFFu << 16)

/*--------------------------------------------------------------------
 * 屏幕参数 (LCD_SIZE_2 : 4.3" 800x480, id = 0x4384)
 *------------------------------------------------------------------*/
#define AXI_LCD_WIDTH           800u
#define AXI_LCD_HEIGHT          480u
#define AXI_LCD_BYTES_PER_PIX   4u      /* 1 像素 = 1 个 32bit 字 */
#define AXI_LCD_FB_BYTES        (AXI_LCD_WIDTH * AXI_LCD_HEIGHT * AXI_LCD_BYTES_PER_PIX)
#define AXI_LCD_ID_EXPECT       0x4384u

/* RGB888 常用颜色 (显存字低 24 位) */
#define AXI_LCD_RED             0x00FF0000u
#define AXI_LCD_GREEN           0x0000FF00u
#define AXI_LCD_BLUE            0x000000FFu
#define AXI_LCD_WHITE           0x00FFFFFFu
#define AXI_LCD_BLACK           0x00000000u
#define AXI_LCD_YELLOW          0x00FFFF00u
#define AXI_LCD_CYAN            0x0000FFFFu
#define AXI_LCD_MAGENTA         0x00FF00FFu

/* 由 R/G/B 组装显存字 */
#define AXI_LCD_RGB(r, g, b)    ((((uint32_t)(r) & 0xFFu) << 16) | \
                                 (((uint32_t)(g) & 0xFFu) <<  8) | \
                                 (((uint32_t)(b) & 0xFFu) <<  0))

/*--------------------------------------------------------------------
 * API
 *------------------------------------------------------------------*/

/** 读寄存器 */
uint32_t axi_lcd_read(uint32_t off);

/** 写寄存器 */
void     axi_lcd_write(uint32_t off, uint32_t val);

/**
 * @brief 软复位 LCD 控制器 (清空预取窗口与状态位), 复位后需重新配置
 */
void     axi_lcd_reset(void);

/**
 * @brief 只做寄存器自检, 不启动显示
 * @return 0 成功; -1 ID 不匹配
 */
int      axi_lcd_probe(void);

/**
 * @brief 设置显存基址 (自动 64 字节对齐)
 * @param fb_base DDR3 中的帧缓冲起始地址 (字节地址)
 */
void     axi_lcd_set_fb(uint32_t fb_base);

/**
 * @brief 设置像素格式
 * @param fmt AXI_LCD_FMT_RGB332 / _RGB444 / _RGB565 / _RGB888
 */
void     axi_lcd_set_fmt(uint32_t fmt);

/**
 * @brief 设置预取阈值 (已写入未消费字数达到该值后才开始受理像素读取)
 * @param thresh 0..15 (硬件字段宽度 4bit)
 * @note  !! 当前 RTL (axi_lcd.v) 里这个字段是**保留位**: REG_CTRL[7:4] 会被
 *        存下来并能回读, 但显示启动阈值实际取自模块参数
 *        `PREFILL` (工程里例化为 256 字), 本函数不会改变行为。
 *        保留它是为了跟原 apb_lcd 的控制字布局对齐。若要把阈值改成可编程,
 *        需要改 RTL 并重新综合 (还要注意阈值给小了会频繁欠载)。
 */
void     axi_lcd_set_prefill_thresh(uint32_t thresh);

/**
 * @brief 启动显示 (置 EN | GO)
 * @note  调用前必须先 axi_lcd_set_fb(); 显存内容需已准备好,
 *        否则会先出现一段欠载画面 (UNDERRUN 置位)。
 */
void     axi_lcd_start(void);

/** 停止显示 (清 EN), 保留预取窗口 */
void     axi_lcd_stop(void);

/** 读 REG_STATUS */
uint32_t axi_lcd_get_status(void);

/** 清 FRAME / UNDERRUN 标志 (W1C) */
void     axi_lcd_clear_status(void);

/** 预取缓冲当前已填充字数 (REG_STATUS[31:16]) */
uint32_t axi_lcd_get_fill_level(void);

/**
 * @brief 等待一次帧结束 (轮询 FRAME 并清除)
 * @param timeout 最大轮询次数, 0 表示不限
 * @return 0 等到一帧; -1 超时
 */
int      axi_lcd_wait_frame(uint32_t timeout);

/**
 * @brief 一帧字节数寄存器值 (上电后可用, 用于校验 RTL 版本)
 */
uint32_t axi_lcd_get_fb_bytes(void);

/** 分辨率寄存器值: {H_DISP, V_DISP} */
uint32_t axi_lcd_get_res(void);

#ifdef __cplusplus
}
#endif

#endif /* _AXI_LCD_H_ */
