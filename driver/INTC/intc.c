/*
* @Author: yx
* @Date: 2024-10-12
 * @LastEditors: niick
 * @LastEditTime: 2025-04-22
* @Description: 中断库函数
* @Version: V1.0.1
*/

#include "INTC/intc.h"

/**
 * @description: 设置中断
 * @param {int} num	中断号
 * @return {*}
 */
void Set_Interrupt(int num) {
  INTC_CONTROLLER->En |= (1 << num);
}

/**
 * @description: 清除中断标志
 * @param {int} num 中断号
 * @return {*}
 */
void Clr_Interrupt(int num) {
  INTC_CONTROLLER->Clr |= (1 << num);
}

void Init_Interrupt(int num,int pol,int edge)
{
  INTC_CONTROLLER->En |= (1 << num);
  INTC_CONTROLLER->Pol |= (pol << num);
  INTC_CONTROLLER->Edge |= (edge << num);
}

/**
 * @description: 
 * @return {*}
 * mul[0] 00: J7/i2c/spi <-> 01:J7-J8/norflash
 * mul[1] 00: J4/stepmotor <-> 01: J4/adda-oled
 * mul[2] 00: J8/dht11 <-> 01: J7-J8/norflash
 */

void Set_Mul(int Mul, int val) {
  int bit = 2 * Mul;

  MUL_CONTROLLER->Mul_sel &= ~(0x3 << bit);

  MUL_CONTROLLER->Mul_sel |= ((val & 0x3) << bit);
}

