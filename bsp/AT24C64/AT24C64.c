/*
 * @Author: yx
 * @Date: 2024-10-21
 * @LastEditors: tangzx
 * @LastEditTime: 2025-02-21
 * @Description: AT24C64(eeprom)驱动库函数
 * @Version: V1.0.1
 */
#include "AT24C64.h"
#include "I2C/i2c.h"


/**
 * @description:            写数据
 * @param {uint16_t} Addr   地址
 * @param {uint8_t} Data    数据
 * @return {*}
 */
void AT24C64_WriteByte(uint16_t Addr, uint8_t Data) {
    I2C_GenerateSTART();
    I2C_SendData(DEV_ADDR | WRITE_CMD);
    I2C_SendData((uint8_t)((Addr>>8) & 0xFF));
    I2C_SendData((uint8_t)(Addr & 0xFF));
    I2C_SendData(Data);
    I2C_GenerateSTOP();
    I2C_Delay(20);
}

/**
 * @description:            读数据
 * @param {uint16_t} Addr   地址
 * @return {*}
 */
uint8_t AT24C64_ReadByte(uint16_t Addr) {
    uint8_t Data = 0;
    I2C_GenerateSTART();
    I2C_SendData(DEV_ADDR | WRITE_CMD);
    I2C_SendData((uint8_t)((Addr>>8) & 0xFF));
    I2C_SendData((uint8_t)(Addr & 0xFF));
    I2C_GenerateSTART();
    I2C_SendData(DEV_ADDR | READ_CMD);
    Data = I2C_ReceiveData(ack);
    I2C_GenerateSTOP();
    return Data;
}
