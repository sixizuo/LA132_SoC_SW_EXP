/*
 * @Author: yx
 * @Date: 2024-12-14
 * @LastEditors: niick
 * @LastEditTime: 2025-02-20
 * @Description: 
 * @Version: V1.0.1
 */
#ifndef _latimer_H_
#define _latimer_H_
#include "test.h"
typedef struct
{
    uint32_t	begin;
    uint32_t	end;
} TIMER_COUNT;

typedef struct
{
    uint32_t	TimeStart;
    uint32_t	TimeInter;

} tsTimeType;


uint32_t get_count(void);
void 	 start_count(TIMER_COUNT *timer_count);
uint32_t stop_count(TIMER_COUNT *timer_count);
void 	 delay_cycle(uint32_t num);
void 	 delay_us(uint32_t x);
void 	 delay_ms(uint32_t x);
void 	 delay_s(uint32_t x);
void    open_count();
void    close_count();

void SetTime(tsTimeType *TimeType, uint32_t TimeInter);
uint8_t  CompareTime(tsTimeType *TimeType);
#endif
