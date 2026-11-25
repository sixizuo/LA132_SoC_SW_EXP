/*
* @Author: yx
* @Date: 2024-10-21
 * @LastEditors: niick
 * @LastEditTime: 2025-04-03
* @Description: IIC头文件
* @Version: V1.0.1
*/

#ifndef _I2C_H_
#define _I2C_H_

// #include "stdint.h"
#include "test.h"

#define en (uint32_t)0x80
#define ien (uint8_t)0x40
#define ms (uint32_t)0x20
#define buslock_check_en (uint32_t)0x02

#define sta (uint32_t)0x80
#define sto (uint32_t)0x40
#define rd (uint32_t)0x20
#define wr (uint32_t)0x10
#define ack (uint32_t)0x08
#define recover (uint32_t)0x04
#define iack (uint8_t)0x01

#define rxack (uint8_t)0x80
#define busy (uint8_t)0x40
#define al (uint8_t)0x20
#define buslock (uint32_t)0x04
#define tip (uint32_t)0x02
#define iflag (uint8_t)0x01
  
#define I2C_SOC_BASE 0x30040000

typedef struct
{
    volatile uint32_t PRERL;
    volatile uint32_t PRERH;
    volatile uint32_t CTRL;
    volatile uint32_t DR;
    volatile uint32_t CSR;
	volatile uint32_t RESERVED1;
	volatile uint32_t RESERVED2;
	volatile uint32_t RESERVED3;
	volatile uint32_t SELECT;
} I2C_Typedef;

#define i2c ((I2C_Typedef *)I2C_SOC_BASE)

typedef struct
{
    uint32_t I2C_ClockSpeed;
    uint32_t I2C_Mode;
    uint32_t I2C_BuslockCheckEn;
} I2C_InitTypedef;

void I2C_Init(int I2C_ClockSpeed); 
void I2C_GenerateSTART();
void I2C_GenerateSTOP();
void I2C_GenerateACK();
void I2C_SendData(uint8_t Data);
uint8_t I2C_ReceiveData(uint32_t Stop);
void I2C_Wait();
void I2C_Unlock();
void I2C_Busy();
void I2C_Delay(volatile int i);

#endif // _ I2C_H_
