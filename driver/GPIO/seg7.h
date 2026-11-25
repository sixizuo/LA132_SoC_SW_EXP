/**
 * @file    seg7.h
 * @brief   本板共阳极数码管的扫描驱动 (默认 4 位, 可配 8 位)
 *
 *  硬件 (yunxiao AC850 实验箱, 见 hw/constraints/gpio.xdc + 上板实测):
 *
 *    an  = gpio48/49/50 -> gpiob[23:16] (0x30000056), 接 74HC138 3-8
 *          译码器的 A0/A1/A2, 所以**只能送二进制序号 0~7**, 不能送段码。
 *          实测 an=0 点亮的是**最右**那一位 -> 位序号要取反: an = (N-1)-p。
 *    seg = gpio56~63    -> gpiob[31:24] (0x30000057), 逐位 a,b,c,d,e,f,g,dp
 *          即段码 bit0=a ... bit6=g, bit7=dp。
 *
 *  本板数码管是**共阳极**: 段引脚输出低电平才点亮。
 *    - 段码 = 共阴标准表取反
 *    - 全灭 = 0xFF (不是 0x00) ← 这个搞反会整屏常亮
 *    - 扫描顺序必须是 "先消隐 -> 换位 -> 送段码", 否则换位瞬间
 *      上一位的段码会落到新位上, 出现重影
 *
 *  位数: seg7_set_ndigits(4) = 默认, 行为与老版本完全一致;
 *        seg7_set_ndigits(8) = 8 位扫描 (74HC138 有 8 根译码输出)。
 *        如果整板只焊了 4 位数码管, 设 8 位时 an=4~7 对应的位不亮。
 *
 *  原来这套段码表和扫描代码是直接摊在 main.h / 各个 main.c 备份里的,
 *  现在收敛到这里, GPIO 例程和定时器例程共用。
 */
#ifndef _SEG7_H_
#define _SEG7_H_

#ifdef __cplusplus
extern "C" {
#endif

#define SEG7_OFF  0xFF   /* 共阳极全灭 */
#define SEG7_DASH 0x10   /* 内部码: 显示 '-' */

/** 把 gpiob[31:16] 配成输出, 清屏 */
void seg7_init(void);

/** 设置扫描位数 2~8 (默认 4, 老例程不用改) */
void seg7_set_ndigits(unsigned char n);

/** 显示 0~9999 的整数 (内部拆成 4 位) */
void seg7_set_value(unsigned int v);

/** 直接给数字, d[0]=最左 ... d[N-1]=最右, N=当前位数, 内容 0~9 */
void seg7_set_digits(const unsigned char d[4]);

/** 给 ASCII 字符串: '0'~'9' 'A'~'F' 'a'~'f' 显示十六进制,
 *  '-' 显示横杠, 其余字符该位熄灭。s[0]=最左, n<=当前位数。
 *  例: seg7_set_chars("1234ABCD", 8) 配合 8 位扫描。 */
void seg7_set_chars(const char *s, int n);

/** 扫描一位。需要周期调用 (软件循环里 delay, 或定时器中断) */
void seg7_scan(void);

/** 取 0~9 的共阳段码 (已取反) */
unsigned char seg7_code(unsigned char digit);

#ifdef __cplusplus
}
#endif

#endif /* _SEG7_H_ */
