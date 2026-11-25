/**
 * @file    demo_rtc.c
 * @brief   RTC (PCF8563 兼容, I2C1 地址 0x51) 读时间, 可选校时
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/RTC_IIC_POLLING.c_backup
 *
 * 改动:
 *   老例程一上来就 `if(uart_read_char()=='Y')`, 没有终端就永远卡住。
 *   现在改成非阻塞: 上电后 5 秒内敲 'Y' 才进入校时流程 (校时仍按原来的
 *   一问一答, 输入两位 BCD, 回车结束), 否则直接开始显示时间。
 *
 * 时间寄存器都是 BCD 码 (0x25 表示 25), 所以直接用 %x 打印。
 *
 * 2026-11-04 修订 (实测定位):
 *   1) 芯片是 PCF8563 兼容, 寄存器 0x02=秒 ... 0x08=年, 地址本来就对。
 *      之前"时间有误"是显示没屏蔽保留位: 星期读到 0x23、月读到 0x31,
 *      直接 %x 打出来就成了 weekday 23 / 月 31。现已按位屏蔽。
 *   2) 本 I2C 控制器连续读多字节拿不到数据 (全 0xFF), 改回逐字节读。
 *
 * 现象: 串口每秒打印一行 "20YY-MM-DD weekday H:MM:SS", 秒数在走。
 */
#include "main.h"
#include "I2C/i2c.h"
#include "RTC/rtc.h"

/* 等一个字符, 最多等 timeout_ms 毫秒, 没有就返回 -1 */
static int wait_key(unsigned int timeout_ms)
{
    unsigned int i;
    int c;

    for (i = 0; i < timeout_ms; i++) {
        if ((c = uart_getchar_nb()) >= 0) {
            return c;
        }
        delay_ms(1);
    }
    return -1;
}

static void rtc_prompt_set(void)
{
    unsigned char year, month, day, weekday, hour, minute, second;

    printf("enter the year   to be set (0~99)  : ");
    year    = uart_read_bcd_char();
    printf("%02x\r\n", year);
    printf("enter the month  to be set (1~12)  : ");
    month   = uart_read_bcd_char();
    printf("%02x\r\n", month);
    printf("enter the day    to be set (1~31)  : ");
    day     = uart_read_bcd_char();
    printf("%02x\r\n", day);
    printf("enter the weekday to be set (0~6)  : ");
    weekday = uart_read_bcd_char();
    printf("%02x\r\n", weekday);
    printf("enter the hour   to be set (0~23)  : ");
    hour    = uart_read_bcd_char();
    printf("%02x\r\n", hour);
    printf("enter the minute to be set (0~59)  : ");
    minute  = uart_read_bcd_char();
    printf("%02x\r\n", minute);
    printf("enter the second to be set (0~59)  : ");
    second  = uart_read_bcd_char();
    printf("%02x\r\n", second);

    RTC_Init(year, month, day, weekday, hour, minute, second);
    printf("new time: 20%02x-%02x-%02x weekday %x  %02x:%02x:%02x\r\n",
           year, month, day, weekday, hour, minute, second);
}

void rtc_demo(void)
{
    uint8_t buf[7];   /* buf[0]=秒 .. buf[6]=年 (BCD) */
    uint8_t second, minute, hour, weekday, day, month, year;

    *iic_sel =2;  /* I2C1 = 第 1 路 (位选: bit0->I2C0, bit1->I2C1), RTC 挂这里 */
    I2C_Init(400000);                 /* SCL 400 kHz */

    printf("rtc demo: press 'Y' within 5 s to set the clock ...\r\n");
    if (wait_key(5000) == 'Y') {
        rtc_prompt_set();
    } else {
        printf("(skip setting, show time only)\r\n");
    }

    for (;;) {
        RTC_ReadTime(buf);            /* 逐字节读 + 跨秒校验 */

        second  = buf[0];
        minute  = buf[1];
        hour    = buf[2];             /* 已在 RTC_ReadTime 里屏蔽保留位 */
        weekday = buf[3];
        day     = buf[4];
        month   = buf[5];
        year    = buf[6];

        printf("20%02x-%02x-%02x  weekday %x  %02x:%02x:%02x\r\n",
               year, month, day, weekday, hour, minute, second);

        delay_s(1);
    }
}
