/**
 * @file    demo_step_motor.c
 * @brief   步进电机 28BYJ-48 八拍驱动 (单方向连续转)
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/step_motor.c_backup
 * 改动: gpio 地址改用 main.h 的 GPIOA_DIR(n) / GPIOA_OUT(n);
 *       四相驱动码仍是原来的 8 拍码 (只用 gpioa[15:12] 高半字节)。
 *
 * 接线: gpioa[15:12] -> 步进电机四相 A/B/C/D (经 ULN2003)
 *       字节序号 1, 位 4~7
 *
 * 八拍顺序 (0xE0 表示 A 相):
 *   顺时针 A -> AB -> B -> BC -> C -> CD -> D -> DA
 *   逆时针 A -> AD -> D -> DC -> C -> CB -> B -> BA
 *
 * 现象: 电机持续转动, 转速由慢到快逐渐加速 (整个过程约 27 分钟,
 *       这是原例程的节奏: j 从 100 递减到 1, 每步 20us*j)。
 *       想快点看效果, 把下面的 k < 2000 改成 k < 200 即可 (约 3 分钟),
 *       或者把 20 * j 改成 5 * j。
 */
#include "main.h"

#define STEP_BYTE   1        /* gpioa 字节序号 1 -> gpioa[15:12] */

/* 八拍驱动码: bit7..bit4 = D C B A */
static const unsigned char s_byj_8_ccw[8] = {
    0xE0, 0xC0, 0xD0, 0x90, 0xB0, 0x30, 0x70, 0x60
};
static const unsigned char s_byj_8_cw[8] = {
    0xE0, 0x60, 0x70, 0x30, 0xB0, 0x90, 0xD0, 0xC0
};

void step_motor_demo(void)
{
    const unsigned char *code = s_byj_8_ccw;
    int j, k, i;

    GPIOA_DIR(STEP_BYTE) = 0x00;        /* 步进电机四相 = 输出 */
    GPIOA_OUT(STEP_BYTE) = 0x00;

    printf("step motor: gpioa[15:12] = A/B/C/D, 8-beat drive\r\n");

    for (;;) {
        /* 由慢到快: 每转一圈延时逐渐变短 */
        for (j = 100; j > 0; j--) {
            for (k = 0; k < 2000; k++) {
                for (i = 0; i < 8; i++) {
                    GPIOA_OUT(STEP_BYTE) = code[i];
                    delay_us((unsigned int)(20 * j));
                }
            }
        }

        /* 换方向再转一轮 */
        code = (code == s_byj_8_ccw) ? s_byj_8_cw : s_byj_8_ccw;
        printf("[STEP] direction changed\r\n");
    }
}
