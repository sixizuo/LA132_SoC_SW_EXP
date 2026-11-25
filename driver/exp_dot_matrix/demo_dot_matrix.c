/**
 * @file    demo_dot_matrix.c
 * @brief   11.5 实验七: LED 点阵数字显示控制器 (0x3007_0000) 的显示测试
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应硬件: hw/peripheral/exp_dotmatrix/apb_dot.v
 * 对应工程: exp_array_spi (必须: EXP_DOT 宏)
 *           !! gpiob[15:0] 被点阵独占, 所以本 demo 里数码管
 *              (gpiob[31:16]) 仍然可用, 两者不冲突。
 *
 * 寄存器 (以 apb_dot.v 为准, 与教材表 11-16 一致):
 *   0x00 CTRL   bit0 使能 / bit1 闪烁 / bit[4:2] 亮度 / bit[6:5] 模式
 *   0x04 CHAR   字符 0~9
 *   0x08 ROWDIV 行周期 (32 MHz 周期), 默认 4000 = 125 us
 *   0x0C RAM0   第 0~3 行, 每 8 位一行
 *   0x10 RAM1   第 4~7 行
 *   0x14 SHIFT  每多少帧滚动一列
 *   0x18 STATUS bit0 busy / bit[2:0] 行号 / bit[15:8] 帧计数
 *   0x1C VERSION 0x444F_0001
 *
 * 测试流程 (对应教材验收标准):
 *   A. 版本 + 复位值
 *   B. 字符模式: 0~9 每秒换一个
 *   C. 亮度: 1 与 7 交替, 肉眼看明暗; @ROWDIV 检查 -- 用 STATUS 行号变化
 *   D. 图形模式: 画一个"心跳"图 + 一个边框
 *   E. 闪烁: bit1 打开, 1 Hz 亮灭, 字符内容不丢
 *   F. 滚动模式: 逐帧左移, 观察无撕裂
 *   G. 关使能 -> 整屏灭
 *
 * 现象: 点阵先显示 0~9, 然后心形图, 然后闪烁, 最后滚动, 串口每一步打印一行。
 */
#include "main.h"
#include "GPIO/seg7.h"

void dot_matrix_demo(void)
{
    unsigned int v;
    int d, i;
    unsigned int frame0;

    printf("exp7: 8x8 LED dot matrix controller @0x%08x\r\n", dot_base);

    v = dot_version;
    printf("VERSION = 0x%08x (expect 0x444f0001) %s\r\n", v,
           (v == 0x444F0001u) ? "ok" : "<-- FAIL");
    printf("reset: CTRL=0x%08x ROWDIV=%u SHIFT=%u\r\n",
           dot_ctrl, dot_rowdiv, dot_shift);

    /* ---- A. 字符模式: 0~9 ---- */
    dot_rowdiv = 4000;                          /* 125 us/行 -> 1 kHz */
    dot_ctrl   = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_CHAR;
    printf("char mode, bright=5, ROWDIV=4000 (1 kHz frame)\r\n");

    seg7_init();                                /* 数码管同步显示同一个数字 */
    for (d = 0; d <= 9; d++) {
        char s[2];
        dot_char = (unsigned int)d;
        s[0] = (char)('0' + d);
        s[1] = 0;
        seg7_set_chars(s, 1);
        printf("  digit %d\r\n", d);
        /* 800 ms, 期间每 2 ms 扫一位数码管 (seg7_scan 必须周期调用) */
        for (i = 0; i < 400; i++) {
            seg7_scan();
            delay_ms(2);
        }
    }

    /* ---- B. 亮度: 1 <-> 7 交替 ---- */
    printf("brightness 1 <-> 7 (watch the panel)\r\n");
    for (i = 0; i < 6; i++) {
        dot_ctrl = DOT_CTRL_EN | DOT_CTRL_BRIGHT((i & 1) ? 7u : 1u) | DOT_MODE_CHAR;
        delay_ms(500);
    }
    dot_ctrl = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_CHAR;

    /* ---- C. 图形模式: 心跳 + 上下边框 ---- */
    printf("graph mode: heart beat pattern\r\n");
    dot_ctrl = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_GRAPH;
    /* 每字节一行, bit0 = 最左列; 0x18/0x3C/0x7E/0xFF 是常见的"心形"上半 */
    dot_ram0 = 0x3C7EFFFFu;                     /* 行 0..3: 3C 7E FF FF */
    dot_ram1 = 0xFF7E3C18u;                     /* 行 4..7: FF 7E 3C 18 */
    delay_ms(1500);

    /* 边框: 外圈全亮 */
    dot_ram0 = 0x000000FFu;                     /* 行 0..3: FF 00 00 00 */
    dot_ram1 = 0x000000FFu;                     /* 行 4..7: 00 00 00 FF */
    delay_ms(1500);

    /* ---- D. 闪烁: 内容不丢 ---- */
    printf("blink on (1 Hz), content must stay\r\n");
    dot_ctrl = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_CHAR | DOT_CTRL_BLINK;
    dot_char = 8;
    delay_ms(3000);
    dot_ctrl = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_CHAR;
    delay_ms(300);

    /* ---- E. 滚动模式: 每秒移一列 ---- */
    printf("scroll mode (shift per 8 frames ~ 8 ms/col)\r\n");
    dot_shift = 8;                              /* 每 8 帧移一列 */
    dot_ctrl  = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_SCROLL;
    dot_char  = 3;
    delay_ms(3000);

    /* ---- F. 关使能: 整屏灭, 行线全高 ---- */
    dot_ctrl = 0;
    printf("disabled -> panel off\r\n");
    delay_ms(500);

    /* ---- G. 收尾: 回到字符模式并读一次 STATUS ---- */
    dot_ctrl   = DOT_CTRL_EN | DOT_CTRL_BRIGHT(5) | DOT_MODE_CHAR;
    dot_char   = 0;
    delay_ms(200);
    frame0     = DOT_ST_FRAME(dot_status);
    delay_ms(50);
    printf("STATUS=0x%08x row=%u frame=%u->%u (frame 在涨 = 扫描在跑)\r\n",
           dot_status, DOT_ST_ROW(dot_status), frame0, DOT_ST_FRAME(dot_status));

    printf("\r\n==== DOT MATRIX DEMO DONE (visual check on panel) ====\r\n");

    /* 最后停在 0~9 循环, 方便目测; 数码管同步显示当前数字 */
    for (;;) {
        for (d = 0; d <= 9; d++) {
            char s[2];
            int t;
            dot_char = (unsigned int)d;
            s[0] = (char)('0' + d);
            s[1] = 0;
            seg7_set_chars(s, 1);
            for (t = 0; t < 500; t++) {         /* 1 s, 每 2 ms 扫一位 */
                seg7_scan();
                delay_ms(2);
            }
        }
    }
}
