/*
 * @Author: yx
 * @Date: 2024-10-12
 * @LastEditors: niick
 * @LastEditTime: 2025-04-18
 * @Description: 中断头文件
 * @Version: V1.0.1
 */

#ifndef _INTC_H_
#define _INTC_H_

#ifdef __cplusplus
extern "C" {
#endif

#define SOPC_INTC_BASE 0x30020000

typedef struct
{
    volatile unsigned int En;   // 0x00 中断使能寄存器. 1=中断使能
    volatile unsigned int Pol;  // 0x04 中断极性寄存器. 1=高电平/上升沿触发
    volatile unsigned int Edge; // 0x08 中断边沿寄存器. 1=上升沿触发
    volatile unsigned int Clr;  // 0x0c 中断清除寄存器. 1=清除中断源
    volatile unsigned int Set;  // 0x10 中断设置寄存器. 1=测试中断，不使用！！！！！！！
    volatile unsigned int Out;  // 0x14 中断输出寄存器. 1=中断触发
} SOPC_INTC_TypeDef;

#define INTC_CONTROLLER ((SOPC_INTC_TypeDef *) SOPC_INTC_BASE)

void Set_Interrupt(int num);
void Clr_Interrupt(int num);
void Init_Interrupt(int num,int pol,int edge);


//Pin reuse
#define MUL_SEL_BASE 0x30020040
typedef struct 
{
    volatile unsigned int Mul_sel;
} SOPC_MUL_TypeDef;

#define MUL_CONTROLLER ((SOPC_MUL_TypeDef *) MUL_SEL_BASE)

void Set_Mul(int Mul, int val);

#ifdef __cplusplus
}
#endif

#endif // _INTC_H_
