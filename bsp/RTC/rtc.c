/*
 * @Author: yx
 * @Date: 2025-03-19
 * @LastEditors: niick
 * @LastEditTime: 2025-04-07
 * @Description: 
 * @Version: V1.0.1
 */

#include "rtc.h"
#include "I2C/i2c.h"
//extern uint32_t year;

// 转换 BCD 为十进制
uint8_t BCD2Decimal1(uint8_t bcd) {
    return ((bcd >> 4) * 10) + (bcd & 0x0F);
}

uint8_t RTC_WriteRegister(uint8_t reg, uint8_t data) {
    I2C_GenerateSTART();                     // 起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | WRITE_CMD);   // 发送写地址
    I2C_SendData(reg);                       // 发送寄存器地址
    I2C_SendData(data);
    I2C_GenerateSTOP();                      // 停止信号
    I2C_Delay(20);
    return data;
}

uint8_t RTC_ReadRegister(uint8_t reg) {
    uint8_t data=0;

    I2C_GenerateSTART();                     // 起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | WRITE_CMD);   // 发送写地址
    I2C_SendData(reg);                       // 发送寄存器地址
    I2C_GenerateSTART();                     // 重新发送起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | READ_CMD);   // 发送读地址
    data = I2C_ReceiveData(ack);             // 读单字节(回 ACK, 原例程实测可用)
    I2C_GenerateSTOP();                      // 停止信号

    return data;
}

/*==================================================================
 * 读齐 7 个时间字段: buf[0]=秒 buf[1]=分 buf[2]=时 buf[3]=星期
 *                   buf[4]=日 buf[5]=月 buf[6]=年   (全部 BCD)
 *
 * 注意: 本 I2C 控制器上"一次 START 连读多字节"实测拿不到数据(全 0xFF),
 *       所以这里逐个寄存器单独读(每次都是 写地址->寄存器->重复START->读)。
 *       每个字节约 100 us, 7 个字节约 0.7 ms, 远小于 1 s, 不会撕到进位;
 *       最后比对一次秒, 若期间刚跨秒则整组重读。
 *==================================================================*/
void RTC_ReadTime(uint8_t *buf) {
    uint8_t s1, s2;

    do {
        s1 = RTC_ReadRegister(RTC_SECOND_REG) & RTC_MASK_SECOND;
        buf[0] = s1;
        buf[1] = RTC_ReadRegister(RTC_MINUTE_REG)  & RTC_MASK_MINUTE;
        buf[2] = RTC_ReadRegister(RTC_HOUR_REG)    & RTC_MASK_HOUR;
        buf[3] = RTC_ReadRegister(RTC_WEEKDAY_REG) & RTC_MASK_WEEKDAY;
        buf[4] = RTC_ReadRegister(RTC_DAY_REG)     & RTC_MASK_DAY;
        buf[5] = RTC_ReadRegister(RTC_MONTH_REG)   & RTC_MASK_MONTH;
        buf[6] = RTC_ReadRegister(RTC_YEAR_REG);
        s2 = RTC_ReadRegister(RTC_SECOND_REG) & RTC_MASK_SECOND;
    } while (s1 != s2);     /* 读的过程中跨秒了, 重读一遍保证同一时刻 */
}

/*==================================================================
 * 写时间 (PCF8563, 不需要解写保护)
 * buf[0]=秒 .. buf[6]=年, 全部 BCD; 小时 0~23。
 * 顺序: 先写日/星期/月/年/时/分, 最后写秒 -> 写秒的同时清 VL 位启动计时。
 * 各字段按位屏蔽, 保证保留位不会把怪值写进去。
 *==================================================================*/
void RTC_SetTime(uint8_t *buf) {
    RTC_WriteRegister(RTC_CTRL1_REG, 0x00);                     /* 正常模式, 清 TEST */
    RTC_WriteRegister(RTC_DAY_REG,     buf[4] & RTC_MASK_DAY);
    RTC_WriteRegister(RTC_WEEKDAY_REG, buf[3] & RTC_MASK_WEEKDAY);
    RTC_WriteRegister(RTC_MONTH_REG,   buf[5] & RTC_MASK_MONTH);
    RTC_WriteRegister(RTC_YEAR_REG,    buf[6]);
    RTC_WriteRegister(RTC_HOUR_REG,    buf[2] & RTC_MASK_HOUR); /* bit6=0 -> 24 小时制 */
    RTC_WriteRegister(RTC_MINUTE_REG,  buf[1] & RTC_MASK_MINUTE);
    RTC_WriteRegister(RTC_SECOND_REG,  buf[0] & RTC_MASK_SECOND);/* bit7(VL)=0 */
}

/*uint8_t RTC_ReadRegister_month() {
    uint8_t month, month_bcd=0;
    I2C_GenerateSTART();                     // 起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | WRITE_CMD);   // 发送写地址
    I2C_SendData(0x07);                       // 发送寄存器地址
    I2C_GenerateSTART();                     // 重新发送起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | READ_CMD);   // 发送读地址
    month_bcd = I2C_ReceiveData(ack);               // 读取数据并发送停止信号
    I2C_GenerateSTOP();                      // 停止信号
    month = BCD2Decimal1(month_bcd & 0x1F);
    printf("/%d/", month);
    I2C_GenerateSTOP();                      // 停止信号

    if(month==1) lcd_clear_char_16x16(64*11, 0, 0xFFFFFF);
	lcd_display_num(64*10, 0, month, 2, 0xF00);

}

uint8_t RTC_ReadRegister_year() {
    uint8_t year_bcd, year=0;
    I2C_GenerateSTART();                     // 起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | WRITE_CMD);   // 发送写地址
    I2C_SendData(0x08);                       // 发送寄存器地址
    I2C_GenerateSTART();                     // 重新发送起始信号
    I2C_SendData((RTC_I2C_ADDR << 1) | READ_CMD);   // 发送读地址
    year_bcd = I2C_ReceiveData(ack);         // 读取数据并发送停止信号
    I2C_GenerateSTOP();                      // 停止信号
    year = BCD2Decimal1(year_bcd);
    // printf("20%d\n",year);

    // todo :如果需要将RTC读取值放到LCD上进行显示，请将下面注释取消
	// if(!year) lcd_clear_char_16x16(64*8, 0, 0xFFFFFF);
	// lcd_display_num(64*5, 0, 20, 2, 0xF00);
    // lcd_display_num(64*7, 0, year, 2, 0xF00);

}*/

uint32_t RTC_Init(uint8_t year, uint8_t month, uint8_t day, uint8_t weekday,uint8_t hour, uint8_t minute, uint8_t second){
    //初始化时间: 7 字节一次连续写 (内部自动解写保护 + 24h 制位)
    //参数均为 BCD; hour 0~23; weekday 0~6 (0=星期天)
    uint8_t buf[7];

    buf[0] = second;
    buf[1] = minute;
    buf[2] = hour;
    buf[3] = weekday;
    buf[4] = day;
    buf[5] = month;
    buf[6] = year;

    RTC_SetTime(buf);
    return 1;
}