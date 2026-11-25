/**
 * @file    seg7.c
 * @brief   共阳极数码管扫描驱动 (默认 4 位, 可配 8 位)
 *
 *  2026-11-02 扩展: s_dig 从 4 位扩到 8 位, 新增 seg7_set_ndigits()/
 *  seg7_set_chars()。不调用新接口的老例程 (APP 3/5) 行为完全不变。
 */
#include "GPIO/seg7.h"
#include "main.h"

/* 0~F 的共阳段码 (共阴表取反): bit0=a ... bit6=g, bit7=dp */
static const unsigned char s_code[16] = {
    /* 0    1    2    3    4    5    6    7          */
    0xC0, 0xF9, 0xA4, 0xB0, 0x99, 0x92, 0x82, 0xF8,
    /* 8    9    A    B    C    D    E    F          */
    0x80, 0x90, 0x88, 0x83, 0xC6, 0xA1, 0x86, 0x8E
};
#define SEG_DASH_CODE 0xBF          /* '-' */

static volatile unsigned char s_dig[8] = { 0,0,0,0,0,0,0,0 };
/* s_dig 内容: 0x00~0x0F = 十六进制数字, SEG7_DASH = '-', SEG7_OFF = 熄灭 */
static volatile unsigned char s_pos    = 0;   /* 当前扫到第几位   */
static volatile unsigned char s_ndig   = 4;   /* 扫描位数, 默认 4 */

void seg7_init(void)
{
    /* gpiob_dir: 1 = 输入, 0 = 输出。
     * 数码管在 gpio48~63 (bit16~31), 所以把这 16 位清 0 变输出。 */
    *gpiob_dir &= ~0xffff0000u;
    *gpiob_seg  = SEG7_OFF;   /* 全灭 */
    s_pos = 0;
}

unsigned char seg7_code(unsigned char digit)
{
    return s_code[digit % 10u];
}

void seg7_set_ndigits(unsigned char n)
{
    if (n < 2u)   n = 2u;
    if (n > 8u)   n = 8u;
    s_ndig = n;
}

static unsigned char char_to_segcode(char c)
{
    if (c >= '0' && c <= '9') return (unsigned char)(c - '0');
    if (c >= 'A' && c <= 'F') return (unsigned char)(c - 'A' + 10);
    if (c >= 'a' && c <= 'f') return (unsigned char)(c - 'a' + 10);
    if (c == '-')             return SEG7_DASH;
    return SEG7_OFF;                      /* 其余字符熄灭 */
}

void seg7_set_chars(const char *s, int n)
{
    int i, nd = s_ndig;

    if (n > nd) n = nd;                   /* 只取最左 nd 个字符 */
    for (i = 0; i < nd; i++) {
        s_dig[i] = (i < n) ? char_to_segcode(s[i]) : SEG7_OFF;
    }
}

void seg7_set_digits(const unsigned char d[4])
{
    int i;

    for (i = 0; i < 4; i++) {
        s_dig[i] = (unsigned char)(d[i] % 10u);
    }
    /* 位数 >4 时, 高位补灭 (老例程 ndigits=4 不会走到) */
    for (i = 4; i < (int)s_ndig; i++) {
        s_dig[i] = SEG7_OFF;
    }
}

void seg7_set_value(unsigned int v)
{
    v %= 10000u;
    s_dig[0] = (unsigned char)(v / 1000u);
    s_dig[1] = (unsigned char)((v / 100u) % 10u);
    s_dig[2] = (unsigned char)((v / 10u) % 10u);
    s_dig[3] = (unsigned char)(v % 10u);
    /* 位数 >4 时, 高位补灭 */
    {
        int i;
        for (i = 4; i < (int)s_ndig; i++) s_dig[i] = SEG7_OFF;
    }
}

void seg7_scan(void)
{
    unsigned char nd = s_ndig;
    unsigned char p;
    unsigned char c, code;

    p = (unsigned char)(s_pos % nd);                /* 当前位 */

    c    = s_dig[p];
    code = (c == SEG7_OFF) ? SEG7_OFF
         : (c == SEG7_DASH) ? SEG_DASH_CODE
         : s_code[c & 0x0Fu];

    *gpiob_seg = SEG7_OFF;                          /* 1) 先消隐 */
    *gpiob_an  = (unsigned char)((nd - 1u) - p);    /* 2) 3-8 译码器: 位序取反, an=0 最右 */
    *gpiob_seg = code;                              /* 3) 送段码 */

    s_pos = (unsigned char)((p + 1u) % nd);
}
