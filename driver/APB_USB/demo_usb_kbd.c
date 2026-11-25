/**
 * @file    demo_usb_kbd.c
 * @brief   APP_SEL 25 —— USB 键盘 + 数码管 联动演示 (与 PC 端 usb_kbd_gui 配套)
 * @Author: WorkBuddy
 * @Date:   2026-11-02
 *
 *  数据流:
 *    PC GUI  --FT232H--> usb rx : '0'~'9' 数字字符, 主循环轮询收取,
 *                                收到一个立即前滚更新 8 位显示缓冲
 *                                (查段码表, 数码管显示最近收到的 8 个字符)
 *    矩阵键盘 --定时器中断--> usb tx : 每按一次键 (20ms 消抖) 把键值字符
 *                                '0'~'F' 的 ASCII 从 USB TX 发给 PC 显示
 *
 *  关于"键盘中断"的说明:
 *    本板矩阵键盘的行/列线 (gpioa[19:16]/[11:8]) **没有接 INTC**,
 *    硬件上不存在独立键盘中断线, 所以采用教科书常用替代方案:
 *    在 1ms 定时器中断里扫描键盘 + 软件消抖 (键盘中断的"准中断"实现)。
 *    数码管动态扫描也在同一个定时器中断里。
 *
 *  键值映射 (kbd_chars, 可按实际键盘丝印修改):
 *        列0  列1  列2  列3
 *    行0  1    2    3    A
 *    行1  4    5    6    B
 *    行2  7    8    9    C
 *    行3  E    0    F    D
 *    覆盖 0~9 + A~F 共 16 个键。
 *
 *  统计: rx=PC 收到的字节数, key=发出的键值数, drop=TX 满被丢的键值数
 *  心跳: [hb ...] 约 2s 一次
 */
#include "main.h"
#include "demo.h"
#include "GPIO/seg7.h"
#include "APB_USB/usb.h"

/*--------------------------------------------------------------------
 *  配置
 *------------------------------------------------------------------*/
#define DISP_N          8       /* 显示位数 (要求硬件 74HC138 有 8 位输出) */
#define TIMER_IRQ_LINE  1u      /* INTC 第 1 根线 */
#define TIMER_PERIOD    32000u  /* 32 MHz 下约 1 ms */
#define KBD_DEBOUNCE_MS 20      /* 按键消抖时间 */

#define HB_PERIOD       3000000u/* 主循环空转 ~2s 一拍 */

/*--------------------------------------------------------------------
 *  显示缓冲: disp[0]=最左(最早收到的) ... disp[7]=最右(最新)
 *  初始 "--------", 收到新字符整体左移一位, 新字符落在最右
 *------------------------------------------------------------------*/
static volatile char s_disp[DISP_N] = { '-','-','-','-','-','-','-','-' };

/*--------------------------------------------------------------------
 *  统计
 *------------------------------------------------------------------*/
static volatile unsigned int s_rx   = 0;   /* 从 PC 收到的字节 */
static volatile unsigned int s_key  = 0;   /* 已发出的键值数   */
static volatile unsigned int s_drop = 0;   /* TX 满丢弃的键值  */

/*--------------------------------------------------------------------
 *  矩阵键盘: 4x4, 行 gpioa[19:16] 输出, 列 gpioa[11:8] 输入
 *  扫描码 = (行字节 << 4) | (列输入 & 0x0F), 按下的线为 0
 *------------------------------------------------------------------*/
static const unsigned char k_row_sel[4] = { 0xF7u, 0xFBu, 0xFDu, 0xFEu };

static const char k_chars[4][4] = {
    { '1', '2', '3', 'A' },
    { '4', '5', '6', 'B' },
    { '7', '8', '9', 'C' },
    { 'E', '0', 'F', 'D' }
};

/* 扫一遍键盘, 返回 0xFF (无键) 或扫描码 */
static unsigned char kbd_scan(void)
{
    int r;

    for (r = 0; r < 4; r++) {
        unsigned char cols;

        GPIOA_OUT(2) = k_row_sel[r];              /* 逐行拉低一行 */
        cols = GPIOA_IN(1) & 0x0Fu;               /* 读列 */
        if (cols != 0x0Fu) {
            return (unsigned char)((k_row_sel[r] << 4) | cols);
        }
    }
    return 0xFFu;
}

/* 扫描码 -> 键值字符, 无效返回 0 */
static char kbd_char(unsigned char sc)
{
    int r, c;

    for (r = 0; r < 4; r++) {
        /* 注意截断: 扫描码构造时 (uchar)(sel<<4), 比对侧必须同样截断,
         * 否则 0x70 != 0xF70 永远失配, 键值永远发不出去 */
        if ((sc & 0xF0u) != (unsigned char)(k_row_sel[r] << 4))
            continue;
        switch (sc & 0x0Fu) {
        case 0x0E: c = 0; break;   /* bit0=0 -> 列0 */
        case 0x0D: c = 1; break;
        case 0x0B: c = 2; break;
        case 0x07: c = 3; break;
        default:   return 0;       /* 多键同按, 忽略 */
        }
        return k_chars[r][c];
    }
    return 0;
}

/*--------------------------------------------------------------------
 *  定时器中断 (1ms): 数码管扫描 1 位 + 键盘消抖扫描
 *------------------------------------------------------------------*/
static void timer_isr(void)
{
    static unsigned char k_raw_last = 0xFFu;
    static unsigned char k_stable   = 0xFFu;
    static unsigned int  k_cnt      = 0;
    unsigned char raw;

    seg7_scan();                       /* 数码管: 每 1ms 扫 1 位, 8 位一帧 8ms */

    /* 键盘消抖状态机: 连续 20ms 扫到同一个键才算有效 */
    raw = kbd_scan();
    if (raw == k_raw_last) {
        if (k_cnt < 0xFFFFu) k_cnt++;
    } else {
        k_raw_last = raw;
        k_cnt = 0;
    }
    if (k_cnt >= KBD_DEBOUNCE_MS && raw != k_stable) {
        k_stable = raw;
        if (raw != 0xFFu) {            /* 只有 "按下" 事件发字符, 松手不发 */
            char ch = kbd_char(raw);
            if (ch != 0) {
                if (usb_write_byte((unsigned char)ch) == 0)
                    s_key++;
                else
                    s_drop++;          /* PC 没在收, TX 满超时丢弃 */
            }
        }
    }

    *timer_cfg    = *timer_cfg;        /* 读 cfg 清定时器中断 */
    *intc_int_clr = (1u << TIMER_IRQ_LINE);
}

/*--------------------------------------------------------------------
 *  USB 收包: 数字字符 -> 显示缓冲前滚
 *------------------------------------------------------------------*/
static char rx_to_disp(int c)
{
    if (c >= '0' && c <= '9') return (char)c;
    if (c >= 'A' && c <= 'F') return (char)c;
    if (c >= 'a' && c <= 'f') return (char)(c - 'a' + 'A');
    return 0;                          /* 非十六进制字符不显示 */
}

static void usb_poll(void)
{
    int guard;

    /* 一次最多清 32 字节, 防止饿死心跳 */
    for (guard = 0; guard < 32; guard++) {
        int c;
        char ch;

        if (!usb_rx_ready())
            break;
        c = usb_read_byte();
        if (c < 0)
            break;
        s_rx++;

        ch = rx_to_disp(c);
        if (ch != 0) {
            int i;
            for (i = 0; i < DISP_N - 1; i++)       /* 前滚: 左移一位 */
                s_disp[i] = s_disp[i + 1];
            s_disp[DISP_N - 1] = ch;               /* 新字符落最右 */
            seg7_set_chars((const char *)s_disp, DISP_N);
        } else {
            printf("[%02X]", (unsigned)c);         /* 误码可见 */
        }
    }
}

/*--------------------------------------------------------------------
 *  入口 (不返回)
 *------------------------------------------------------------------*/
void usb_kbd_demo(void)
{
    unsigned int hb = 0;

    usb_init();
    seg7_init();                               /* gpiob[31:16] 输出 */
    seg7_set_ndigits(DISP_N);                  /* 8 位扫描 */
    seg7_set_chars((const char *)s_disp, DISP_N);

    /* 矩阵键盘 GPIO 方向: 行(gpioa[19:16], 字节2)输出, 列(字节1)输入 */
    GPIOA_DIR(2) = 0x00u;
    GPIOA_DIR(1) = 0xFFu;

    /* 定时器中断: 1ms, 扫描数码管 + 键盘 */
    intc_irq_init();
    *intc_int_en   = (1u << TIMER_IRQ_LINE);
    *intc_int_pol  = (1u << TIMER_IRQ_LINE);
    *intc_int_edge = 0x0000;
    intc_irq_attach(TIMER_IRQ_LINE, timer_isr);
    *timer_cfg = 0x00000006;
    *timer_cnt = 0x00000000;
    *timer_cmp = TIMER_PERIOD;
    *timer_stp = TIMER_PERIOD;
    *timer_cfg |= 0x00000001;

    printf("\r\n---- APB USB kbd+vseg demo ----\r\n");
    printf("PC->board: '0'~'9' -> vseg (last %d chars, rolling)\r\n", DISP_N);
    printf("board->PC: matrix key (timer-irq scanned, %dms debounce) -> '0'~'F'\r\n",
           KBD_DEBOUNCE_MS);
    printf("USB status = 0x%08x\r\n", usb_status());

    for (;;) {
        usb_poll();

        if (++hb >= HB_PERIOD) {
            hb = 0;
            printf("[hb rx=%u key=%u drop=%u st=0x%x]\r\n",
                   s_rx, s_key, s_drop, usb_status());
        }
    }
}
