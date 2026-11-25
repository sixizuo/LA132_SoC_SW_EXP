/**
 * @file    demo_pwm_motor.c
 * @brief   PWM 驱动直流电机: 正转 5s -> 停 5s -> 反转 5s -> 停 5s
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/pwm_motor_driver.c_backup (寄存器直接定义在 .c 里)
 * 改动: 寄存器宏统一收到 main.h (pwm_div_freq / pwm_cmp / pwm_cr)。
 *
 * 硬件: PWM @ 0x3009_0000, 输入时钟 16 MHz
 *   div_freq = 500  -> 16MHz/500 = 32 kHz PWM
 *   cmp      = 150  -> 占空比 150/500 = 30%
 *   pwm_cr   : bit0 启动, bit1 方向 (1 = 反转)
 *
 * 现象: 电机转 5 秒 -> 停 5 秒 -> 反向转 5 秒 -> 停 5 秒, 循环。
 */
#include "main.h"

void pwm_motor_demo(void)
{
    *pwm_div_freq = 500;      /* 32 kHz */
    *pwm_cmp      = 150;      /* 30% 占空比 */

    printf("PWM motor: div=500 cmp=150 (30%%), cr bit0=start bit1=dir\r\n");

    for (;;) {
        *pwm_cr = 0x1;        /* 正转 */
        printf("[MOTOR] forward\r\n");
        delay_s(5);

        *pwm_cr = 0x0;        /* 停 */
        printf("[MOTOR] stop\r\n");
        delay_s(5);

        *pwm_cr = 0x3;        /* 反转 (bit0 启动 | bit1 方向) */
        printf("[MOTOR] reverse\r\n");
        delay_s(5);

        *pwm_cr = 0x0;        /* 停 */
        printf("[MOTOR] stop\r\n");
        delay_s(5);
    }
}
