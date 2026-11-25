/*
 * @Author: yx
 * @Date: 2024-10-13
 * @LastEditors: niick
 * @LastEditTime: 2025-02-20
 * @Description: PWM库函数
 * @Version: V1.0.1
 */

#include "pwm.h"
#include "LA_TIMER/latimer.h"



/**
 * @description: PWM停止
 * @return {*}
 */
void Pwm_Stop(void) {
    PWM_CONTROLLER->state = 0;
}

/**
 * @description: PWM电机初始化
 * @return {*}
 */
void Pwm_motor_Init(void) {
    PWM_CONTROLLER->state = 0;
    PWM_CONTROLLER->div_freq = 500;
    PWM_CONTROLLER->comp = 250;
    PWM_CONTROLLER->state = 1;
}


/**
 * @description:  设置PWM频率何比较值
 * @param {int} div_freq	实际频率 分为0-8M
 * @param {int} comp		范围0-div_freq
 * @return {*}
 */
void Pwm_Set(int div_freq, int comp) {
    PWM_CONTROLLER->div_freq = div_freq;
    PWM_CONTROLLER->comp = comp;
}

/**
 * @description: 初始化脉宽调制控制器
 * @return {*}
 */
void Pwm_steering_engine_Init(void) {
    PWM_CONTROLLER->state = 0;
    PWM_CONTROLLER->div_freq = 160000;
    PWM_CONTROLLER->comp = 4000;
    PWM_CONTROLLER->state = 1;
}

/**
 * @description: 设置占空比
 * @param {int} angle	角度是9度的倍数
 * @return {*}
 */
void Pwm_steering_engine_Set(int angle) {
    PWM_CONTROLLER->comp = 4000 + 800 * angle / 9;
}
