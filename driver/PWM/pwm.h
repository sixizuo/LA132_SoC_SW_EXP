/*
 * @Author: yx
 * @Date: 2024-10-13
 * @LastEditors: niick
 * @LastEditTime: 2025-02-21
 * @Description: pwm头文件
 * @Version: V1.0.1
 */

#ifndef _PWM_H_
#define _PWM_H_

#ifdef __cplusplus
extern "C" {
#endif

#define SOPC_PWM_BASE 0x30090000

typedef struct
{
    volatile unsigned int div_freq;
    volatile unsigned int comp;
    volatile unsigned int state;
} SOPC_PWM_TypeDef;

#define PWM_CONTROLLER ((SOPC_PWM_TypeDef *) SOPC_PWM_BASE)

void Pwm_Stop(void);
void Pwm_motor_Init(void);
void Pwm_Set(int div_freq, int comp);
void Pwm_steering_engine_Init(void);
void Pwm_steering_engine_Set(int angle);

#ifdef __cplusplus
}
#endif

#endif // _PWM_H_
