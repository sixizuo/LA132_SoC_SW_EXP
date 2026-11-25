/**
 * @file    demo_gpio_mode.c
 * @brief   GPIO 综合轮询例程: 拨码 / 8x8 点阵 / 4 位数码管 / 4x4 矩阵键盘
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/gpio_program_control_mode.c_back_up
 *
 * 与老例程的差别 (都是为了对得上本板 AC850/yunxiao 的接线):
 *   1) 原来用 `*(volatile unsigned char*)(gpio_a_dir + offset)` 自己算地址,
 *      现在统一用 main.h 里的 GPIOA_DIR(n) / GPIOA_OUT(n) / GPIOA_IN(n) 等
 *      按字节访问的宏。
 *   2) 原来那 8 位数码管段码表 {0xF9,0xA4,...} 是别的板子(共阴、8 位、
 *      an 直接送位选)的写法, 在本板(共阳、4 位、an 接 3-8 译码器)上
 *      显示是乱的。这里改用 driver/GPIO/seg7.c, 与 APP_SEL=3 一致。
 *
 * 硬件 (字节序号):
 *   gpioa[0] 拨码 SW1~SW8     入      gpioa[3] LED D1~D8        出
 *   gpioa[1] 矩阵键盘 列      入      gpioa[2] 矩阵键盘 行      出
 *   gpiob[0] 点阵 列          出      gpiob[1] 点阵 行          出
 *   gpiob[2] 数码管 an        出      gpiob[3] 数码管 seg       出
 *
 * 现象:
 *   - LED 跟随拨码开关
 *   - 点阵上滚动显示一个向下的箭头
 *   - 数码管显示 1 2 3 4 (流水扫描)
 *   - 按下矩阵键盘任一键, 串口打印键值扫描码 (行高 4 位 + 列低 4 位)
 */
#include "main.h"
#include "GPIO/seg7.h"

/* 字节偏移 (0 = 最低字节) */
#define SW_BYTE        0
#define LED_BYTE       3
#define KEY_COL_BYTE   1
#define KEY_ROW_BYTE   2
#define DOT_COL_BYTE   0
#define DOT_ROW_BYTE   1

static const unsigned char s_down_arrow[8] = {
    0x18, 0x3C, 0x5A, 0x99, 0x18, 0x18, 0x18, 0x18
};

void gpio_mode_demo(void)
{
    unsigned char key_row_scan = 0xF7;
    unsigned char last_key = 0xFF;
    unsigned char cur_key  = 0xFF;
    unsigned char seg_d[4] = { 1, 2, 3, 4 };
    int i, j;

    /* ---- 方向: 1 = 输入, 0 = 输出 ---- */
    GPIOA_DIR(SW_BYTE)      = 0xFF;   /* 拨码        输入 */
    GPIOA_DIR(LED_BYTE)     = 0x00;   /* LED         输出 */
    GPIOA_DIR(KEY_ROW_BYTE) = 0x00;   /* 键盘行      输出 */
    GPIOA_DIR(KEY_COL_BYTE) = 0xFF;   /* 键盘列      输入 */

    GPIOB_DIR(DOT_COL_BYTE) = 0x00;   /* 点阵列      输出 */
    GPIOB_DIR(DOT_ROW_BYTE) = 0x00;   /* 点阵行      输出 */

    seg7_init();                       /* an / seg 输出 + 清屏 */
    seg7_set_digits(seg_d);

    printf("gpio mode demo: sw / dot-matrix / seg / keypad\r\n");
    printf("press any key on the 4x4 keypad, scan code will be printed\r\n");

    for (;;) {
        /* 1) 拨码 -> LED */
        GPIOA_OUT(LED_BYTE) = GPIOA_IN(SW_BYTE);

        /* 2) 8x8 点阵: 逐行扫描, 显示向下箭头 */
        for (i = 0; i < 8; i++) {
            GPIOB_OUT(DOT_ROW_BYTE) = (unsigned char)~(0x80u >> i);
            GPIOB_OUT(DOT_COL_BYTE) = s_down_arrow[i];
            delay_ms(1);
        }

        /* 3) 数码管: 一次扫一位 */
        for (j = 0; j < 4; j++) {
            seg7_scan();
            delay_ms(1);
        }

        /* 4) 4x4 矩阵键盘: 先判有没有键按下, 再逐行扫描定位 */
        GPIOA_OUT(KEY_ROW_BYTE) = 0x00;
        if ((GPIOA_IN(KEY_COL_BYTE) & 0x0F) != 0x0F) {
            for (i = 0; i < 4; i++) {
                GPIOA_OUT(KEY_ROW_BYTE) = (unsigned char)(key_row_scan >> i);
                if ((GPIOA_IN(KEY_COL_BYTE) & 0x0F) != 0x0F) {
                    cur_key = (unsigned char)(((key_row_scan >> i) << 4)
                                              | (GPIOA_IN(KEY_COL_BYTE) & 0x0F));
                    if (cur_key != last_key) {
                        printf("key scan code = 0x%02x\r\n", cur_key);
                        last_key = cur_key;
                    }
                }
            }
        } else {
            last_key = 0xFF;          /* 松手 */
        }
    }
}
