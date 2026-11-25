/*
 * @Author: yx
 * @Date: 2025-03-19
 * @LastEditors: niick
 * @LastEditTime: 2025-03-19
 * @Description: 
 * @Version: V1.0.1
 */

#ifndef _RTC_H_
#define _RTC_H_

// #include "stdint.h"
#include "test.h"
#include "PRINTF/printf.h"

/*==================================================================
 * RTC 芯片 = PCF8563 兼容 (I2C 0x51, 挂 I2C1)
 * 2026-11-04 实测确认: 读 0x02=秒 0x03=分 0x04=时 0x05=日
 *                        0x06=星期 0x07=月 0x08=年
 * 老代码地址本来是对的, 显示错是因为没屏蔽保留位:
 *   - 秒   bit7 = VL (电压低标志), 不清会显示 8x
 *   - 时   bit6 = 12/24 选择, 不清会显示 4x/8x
 *   - 星期 bit[7:3] 保留, 实测读到 0x23, 不屏蔽就显示 "23"
 *   - 月   bit[7:5] 保留(bit7=世纪), 实测读到 0x31, 不屏蔽就显示 "31"
 *==================================================================*/
#define RTC_CTRL1_REG    0x00    /* Control_status_1 */
#define RTC_CTRL2_REG    0x01    /* Control_status_2 */
#define RTC_SECOND_REG   0x02    /* [6:0] BCD 00~59, [7]=VL */
#define RTC_MINUTE_REG   0x03    /* [6:0] BCD 00~59 */
#define RTC_HOUR_REG     0x04    /* [5:0] BCD 00~23, [6]=12/24 (0=24h) */
#define RTC_DAY_REG      0x05    /* [5:0] BCD 01~31 */
#define RTC_WEEKDAY_REG  0x06    /* [2:0] 0~6 (0=星期天) */
#define RTC_MONTH_REG    0x07    /* [4:0] BCD 01~12, [7]=世纪 */
#define RTC_YEAR_REG     0x08    /* BCD 00~99 */

#define RTC_MASK_SECOND  0x7F
#define RTC_MASK_MINUTE  0x7F
#define RTC_MASK_HOUR    0x3F
#define RTC_MASK_DAY     0x3F
#define RTC_MASK_WEEKDAY 0x07
#define RTC_MASK_MONTH   0x1F

#define READ_CMD 1
#define WRITE_CMD 0

#define RTC_I2C_ADDR 0x51

uint8_t BCD2Decimal1(uint8_t bcd);
uint8_t RTC_ReadRegister(uint8_t reg);
uint8_t RTC_WriteRegister(uint8_t reg, uint8_t data);
uint8_t RTC_ReadRegister_month();
uint8_t RTC_ReadRegister_year();

/* 一次读齐 7 个时间字段 (逐字节读 + 跨秒校验), buf[0]=秒 .. buf[6]=年。
 * 各字段已屏蔽保留位, 可直接当 BCD 用 %x 打印。 */
void    RTC_ReadTime(uint8_t *buf);
void    RTC_SetTime(uint8_t *buf);   /* buf[0]=秒 .. buf[6]=年 (BCD, 小时 0~23) */

uint32_t RTC_Init(uint8_t year, uint8_t month, uint8_t day, uint8_t weekday,uint8_t hour, uint8_t minute, uint8_t second);


#endif // _RTC_H_
