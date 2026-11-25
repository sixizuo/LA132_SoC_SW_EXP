/*
 * @Author: yx
 * @Date: 2024-10-21
 * @LastEditors: niick
 * @LastEditTime: 2025-02-21
 * @Description: AT24C64(eeprom)头文件
 * @Version: V1.0.1
 */
#ifndef _AT24C64_H_
#define _AT24C64_H_

// #include "stdint.h"
#include "test.h"

#define READ_CMD 1
#define WRITE_CMD 0

//#define DEV_ADDR 0xA0 //AC850
#define DEV_ADDR 0xAE //YUNXIAO
#define AT24_PAGE_NUM 256
#define AT24_PAGE_SIZE 32
#define CAPACITY_SIZE (AT24_PAGE_NUM * AT24_PAGE_SIZE)
#define ADDR_BYTE_NUM 2

void AT24C64_WriteByte(uint16_t Addr, uint8_t Data);
uint8_t AT24C64_ReadByte(uint16_t Addr);

#endif // _AT24C64_H_
