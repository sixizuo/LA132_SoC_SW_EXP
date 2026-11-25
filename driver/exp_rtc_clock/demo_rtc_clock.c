/**
 * @file    demo_rtc_clock.c
 * @brief   11.5 实验四: 数码管显示实时时钟 (定时器扫描 + 串口校时 + PCF8563 对时)
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应工程: exp_iic_spi  (必须: 要用 J8 的 IIC 才能访问 PCF8563)
 *           该工程没启用 EXP_KBD / EXP_DOT, 所以 gpio 引脚全归 GPIO,
 *           数码管 gpiob[31:16] 可以照常用。
 *
 * 设计要求 (教材 11.5 实验四):
 *   1) 8 位共阳数码管, 格式 HH-MM-SS
 *   2) 扫描放 1 ms 定时器中断, 每 1 ms 扫一位 -> 8 位一轮 8 ms (125 Hz)
 *   3) 时间由中断累计, 秒/分/时正确进位, 24 小时制
 *   4) 串口校时: "T1230453" = 12:30:45 星期 3, 回车结束, 非阻塞
 *   5) 上电读 PCF8563, 之后每 10 秒对时一次
 *
 * 实现要点:
 *   - 中断里只做 seg7_scan() + 计数 + 每 100 ms 刷一次显示缓冲,
 *     不做除法以外的事 (100 ms 才刷一次, 避免秒变化时整屏闪)。
 *   - 时间进位用整数比较, 不用"每次加 1 ms 再比较 1000 次"。
 *   - I2C 访问 (读/写 RTC) 一律在主循环做: 一次 I2C 事务上千个周期,
 *     放中断里会把扫描节奏打乱, 表现为数码管某一位偏亮。
 *
 * 现象: 数码管显示 12-30-45 走时; 串口每秒一行 "[CLK] ...",
 *       每 10 秒一行 "[RTC] sync ..."; 发 T 命令后立刻改时间。
 */
#include "main.h"
#include "GPIO/seg7.h"
#include "interrupt.h"
#include "I2C/i2c.h"
#include "RTC/rtc.h"

#define CLK_TIMER_IRQ   1u
#define CLK_TIMER_CMP   32000u        /* 1 ms */

static volatile unsigned char s_sec, s_min, s_hour;
static volatile unsigned int  s_ms;          /* 0~999 */
static volatile unsigned int  s_100ms;       /* 0~99  */
static volatile unsigned int  s_uptime;      /* 运行秒数 */
static volatile unsigned char s_need_refresh = 1;

/*--------------------------------------------------------------------
 *  时间进位 (24 小时制)
 *------------------------------------------------------------------*/
static void time_tick(void)
{
    if (++s_sec >= 60u) {
        s_sec = 0;
        if (++s_min >= 60u) {
            s_min = 0;
            if (++s_hour >= 24u) {
                s_hour = 0;
            }
        }
    }
    s_uptime++;
}

/* 显示缓冲: '1','2','-','3','0','-','4','5' */
static void refresh_display(void)
{
    char b[8];

    b[0] = (char)('0' + (s_hour / 10u));
    b[1] = (char)('0' + (s_hour % 10u));
    b[2] = '-';
    b[3] = (char)('0' + (s_min / 10u));
    b[4] = (char)('0' + (s_min % 10u));
    b[5] = '-';
    b[6] = (char)('0' + (s_sec / 10u));
    b[7] = (char)('0' + (s_sec % 10u));

    seg7_set_chars(b, 8);
}

/*--------------------------------------------------------------------
 *  1 ms 定时器中断
 *------------------------------------------------------------------*/
static void clk_isr(void)
{
    seg7_scan();

    if (++s_ms >= 1000u) {
        s_ms = 0;
        time_tick();
    }

    if (++s_100ms >= 100u) {
        s_100ms = 0;
        s_need_refresh = 1;
    }

    *timer_cfg    = *timer_cfg;
    *intc_int_clr = (1u << CLK_TIMER_IRQ);
}

/*--------------------------------------------------------------------
 *  BCD <-> 十进制
 *------------------------------------------------------------------*/
static unsigned char bcd2dec(unsigned char b)
{
    return (unsigned char)(((b >> 4) * 10u) + (b & 0x0Fu));
}

static unsigned char dec2bcd(unsigned char d)
{
    return (unsigned char)(((d / 10u) << 4) | (d % 10u));
}

/*--------------------------------------------------------------------
 *  RTC_ReadTime 的字段顺序 (依据 bsp/RTC/rtc.c 的实现, 不是想当然):
 *      buf[0]=秒 buf[1]=分 buf[2]=时 buf[3]=星期 buf[4]=日 buf[5]=月 buf[6]=年
 *  全部是 BCD, 保留位已屏蔽。RTC_SetTime 用的是同一套顺序。
 *------------------------------------------------------------------*/
static void rtc_sync(const char *why)
{
    unsigned char b[7];

    RTC_ReadTime(b);

    s_sec  = bcd2dec(b[0]);
    s_min  = bcd2dec(b[1]);
    s_hour = bcd2dec(b[2]);

    if (s_sec  > 59u) s_sec  = 0;
    if (s_min  > 59u) s_min  = 0;
    if (s_hour > 23u) s_hour = 0;

    printf("[RTC] %s: 20%02x-%02x-%02x w%x %02x:%02x:%02x\r\n",
           why, b[6], b[5], b[4], (unsigned int)(b[3] & 0x07u),
           b[2], b[1], b[0]);

    s_need_refresh = 1;
}

/*--------------------------------------------------------------------
 *  串口校时: "T" + HH MM SS + W + CR   (共 7 位数字)
 *  例: T1230453 + 回车 = 12:30:45 星期 3
 *------------------------------------------------------------------*/
static unsigned char s_cmd[8];
static unsigned char s_cmd_len;
static unsigned char s_cmd_active;

static void apply_time_cmd(void)
{
    unsigned char hh = (unsigned char)((s_cmd[0] - '0') * 10u + (s_cmd[1] - '0'));
    unsigned char mm = (unsigned char)((s_cmd[2] - '0') * 10u + (s_cmd[3] - '0'));
    unsigned char ss = (unsigned char)((s_cmd[4] - '0') * 10u + (s_cmd[5] - '0'));
    unsigned char wd = (unsigned char)(s_cmd[6] - '0');
    unsigned char cur[7];

    if (hh > 23u || mm > 59u || ss > 59u || wd > 6u) {
        printf("[CMD] out of range: %c%c-%c%c-%c%c w%c\r\n",
               s_cmd[0], s_cmd[1], s_cmd[2], s_cmd[3],
               s_cmd[4], s_cmd[5], s_cmd[6]);
        return;
    }

    /* 软件时间立刻生效 */
    s_hour = hh; s_min = mm; s_sec = ss;
    s_ms = 0;
    s_need_refresh = 1;

    /* 同时写回 RTC: 先读出 日/月/年, 只改 时:分:秒 + 星期
     * 注意 RTC_SetTime 的字段顺序是 buf[3]=星期 / buf[4]=日 */
    RTC_ReadTime(cur);
    cur[0] = dec2bcd(ss);
    cur[1] = dec2bcd(mm);
    cur[2] = dec2bcd(hh);
    cur[3] = wd;
    RTC_SetTime(cur);

    printf("[CMD] set %02u:%02u:%02u weekday %u\r\n",
           hh, mm, ss, wd);
}

static void poll_uart_cmd(void)
{
    int c = uart_getchar_nb();

    if (c < 0) {
        return;
    }

    if (c == 'T' || c == 't') {
        s_cmd_active = 1;
        s_cmd_len    = 0;
        return;
    }

    if (!s_cmd_active) {
        return;
    }

    if (c == '\r' || c == '\n') {
        if (s_cmd_len == 7u) {
            apply_time_cmd();
        } else {
            printf("[CMD] need 7 digits, got %u\r\n", (unsigned int)s_cmd_len);
        }
        s_cmd_active = 0;
        return;
    }

    if (c >= '0' && c <= '9') {
        if (s_cmd_len < 7u) {
            s_cmd[s_cmd_len++] = (unsigned char)c;
        }
    } else {
        s_cmd_active = 0;                   /* 非法字符, 放弃本条命令 */
    }
}

void rtc_clock_demo(void)
{
    unsigned int last_sec  = 0xFFFFFFFFu;
    unsigned int last_sync = 0;
    unsigned char first    = 1;

    printf("exp4: 7-seg real time clock (HH-MM-SS) + PCF8563 sync\r\n");
    printf("  send \"T1230453\\r\" to set 12:30:45 weekday 3\r\n");

    seg7_init();
    seg7_set_ndigits(8);
    refresh_display();

    /* RTC 挂在 I2C1: 位选寄存器 bit1 = 1 选第 1 路, 400 kHz */
    *iic_sel = 2;
    I2C_Init(400000);

    intc_irq_init();
    *intc_int_en   = (1u << CLK_TIMER_IRQ);
    *intc_int_pol  = (1u << CLK_TIMER_IRQ);
    *intc_int_edge = 0x0000;
    intc_irq_attach(CLK_TIMER_IRQ, clk_isr);

    *timer_cfg = 0x00000006;
    *timer_cnt = 0;
    *timer_cmp = CLK_TIMER_CMP;
    *timer_stp = CLK_TIMER_CMP;
    *timer_cfg |= 0x00000001;

    for (;;) {
        poll_uart_cmd();

        if (s_need_refresh) {
            s_need_refresh = 0;
            refresh_display();
        }

        /* 每 10 秒与 RTC 对一次时 (上电第一次立刻读) */
        if (first || (unsigned int)(s_uptime - last_sync) >= 10u) {
            last_sync = s_uptime;
            rtc_sync(first ? "boot" : "10s");
            first = 0;
        }

        if (s_uptime != last_sec) {
            last_sec = s_uptime;
            printf("[CLK] %02u:%02u:%02u\r\n",
                   (unsigned int)s_hour, (unsigned int)s_min, (unsigned int)s_sec);
        }
    }
}
