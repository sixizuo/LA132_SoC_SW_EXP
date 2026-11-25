/*
 * @Author: yx
 * @Date: 2024-10-15
 * @LastEditors: niick
 * @LastEditTime: 2025-02-21
 * @Description: 数学函数库
 * @Version: V1.0.1
 */

#include "math.h"

/**
 * @description: 幂函数： m^n
 * @param {uint8_t} m	基数
 * @param {uint8_t} n	指数
 * @return {*}
 */
uint32_t oled_pow(uint8_t m, uint8_t n) {
    uint32_t result = 1;
    while (n--) {
        result *= m;
	}
    return result;
}