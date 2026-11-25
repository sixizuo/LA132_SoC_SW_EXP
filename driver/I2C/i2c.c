/*
 * @Author: yx
 * @Date: 2024-10-21
 * @LastEditors: niick
 * @LastEditTime: 2025-04-07
 * @Description: IIC库函数
 * @Version: V1.0.1
 */

#include "I2C/i2c.h"

/**
 * @description: 初始化
 * @param { I2C_InitTypedef*}  I2C_InitStruct
 * @return {*}
 */
void I2C_Init(int I2C_ClockSpeed) {
    uint32_t tmp = 0;
    uint32_t pclk = 32000000;

    I2C_InitTypedef I2C_InitStruct;
    I2C_InitStruct.I2C_ClockSpeed = I2C_ClockSpeed;
    I2C_InitStruct.I2C_Mode = ms;
    I2C_InitStruct.I2C_BuslockCheckEn = buslock_check_en;
    i2c->CTRL = ms;

    tmp = pclk / I2C_InitStruct.I2C_ClockSpeed;
    tmp = (tmp >> 2) - 1;

    i2c->PRERL = tmp;
    i2c->PRERH = tmp >> 8;

    i2c->CTRL = en | (I2C_InitStruct.I2C_Mode) | (I2C_InitStruct.I2C_BuslockCheckEn);
    //  i2c->CTRL = 0b10100010;

    if (I2C_InitStruct.I2C_BuslockCheckEn) {
        i2c->CSR = recover;
    }
    I2C_Wait();
}

/**
 * @description: 起始信号
 * @return {*}
 */
void I2C_GenerateSTART() {
    i2c->CSR = sta;
	I2C_Wait();
}

/**
 * @description: 停止信号
 * @return {*}
 */
void I2C_GenerateSTOP() {
    i2c->CSR = sto;
	I2C_Wait();
}

/**
 * @description: 响应信号
 * @return {*}
 */
void I2C_GenerateACK() {
    i2c->CSR = ack;
}

/**
 * @description: 发送数据
 * @param {uint8_t} Data
 * @return {*}
 */
void I2C_SendData(uint8_t Data) {
    I2C_Unlock();

    i2c->DR = Data;
    i2c->CSR = wr;

    I2C_Wait();
}

/**
 * @description:    接受数据
 * @param {uint8_t} Stop
 * @return {*}
 */
uint8_t I2C_ReceiveData(uint32_t Stop) {
    I2C_Unlock();

    i2c->CSR = rd | Stop;
    I2C_Wait();

    return (uint8_t)i2c->DR;
}

/**
 * @description: I2C等待
 * @return {*}
 */
void I2C_Wait() {
    uint32_t tmp;
    tmp = i2c->CSR;
    while (tmp & tip) {
        tmp = i2c->CSR;
    }
}

/**
 * @description: I2C解锁
 * @return {*}
 */
void I2C_Unlock() {
    uint32_t tmp;
    tmp = i2c->CSR;
    if (tmp & buslock) {
        i2c->CSR = recover;
    }
}

/**
 * @description: I2C忙
 * @return {*}
 */
void I2C_Busy() {
    uint8_t tmp;
    tmp = i2c->CSR;
    while (tmp & busy) {
        tmp = i2c->CSR;
    }
}

/**
 * @description: I2C延迟
 * @param {volatile int} i
 * @return {*}
 */
void I2C_Delay(volatile int i) {
    while (i--)
        ;
}
