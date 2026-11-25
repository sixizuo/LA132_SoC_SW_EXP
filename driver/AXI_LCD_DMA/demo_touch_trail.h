/**
 * @file    demo_touch_trail.h
 * @brief   LCD 实时触摸轨迹显示 (黑底白线) —— 示例程序接口
 *
 *  配套实现: driver/AXI_LCD_DMA/demo_touch_trail.c
 */

#ifndef _DEMO_TOUCH_TRAIL_H_
#define _DEMO_TOUCH_TRAIL_H_

#ifdef __cplusplus
extern "C" {
#endif

/**
 * @brief 触摸轨迹演示主循环 (不返回)
 *
 *  流程: 自检 AXI-LCD -> 显存清黑 -> 启动显示 -> 使能触摸 ->
 *        轮询坐标 FIFO -> 相邻两点间连直线 -> 画到显存
 *
 *  背景黑 (0x00000000), 轨迹白 (0x00FFFFFF)。
 */
void touch_trail_demo(void);

#ifdef __cplusplus
}
#endif

#endif /* _DEMO_TOUCH_TRAIL_H_ */
