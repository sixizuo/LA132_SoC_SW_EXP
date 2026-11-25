/**
 * @file    demo_adc9280.c
 * @brief   ADC9280 (并行 ADC + 1024 字节 FIFO) 取数的两种方式
 * @Author: WorkBuddy
 * @Date:   2026-11-04
 *
 * ====================================================================
 *  一. 2026-11-04 重写的两件事
 * ====================================================================
 *  1) 取数不再"软件造读脉冲"
 *     旧写法: 清 CSR.bit2 -> 置 bit2 -> 清 bit2 -> 再读 DATA,
 *             每读 1 个字节要写 3 次 CSR, DMA 根本插不进来。
 *     新写法: **读一次 DATA 就是弹出一个字节**, 由硬件插等待
 *             (hw/peripheral/apb_adc/apb_adc_top.v 的 3 态读握手)。
 *             所以本文件里再也不会出现 adc_fifo_rd。
 *  2) 新增 DMA 通路
 *     ADC FIFO --APB-DMA(src 固定 / dst 自增 / 8bit)--> APB RAM
 *
 * ====================================================================
 *  二. 为什么 DMA 只落到 APB RAM, 不再往 DDR 搬
 * ====================================================================
 *  - APB-DMA (dma_top @0x300E_0000) 的主口接在 **APB 总线**上, 只能访问
 *    APB 从设备 (0x3000_0000 段), 到不了 DDR (0x4000_0000)。所以 DMA 的
 *    目的只能是 APB RAM (0x300F_0000)。
 *  - AXI-DMAC (0x2001_0000) 能到 DDR, 但它没有 src_inc 位(源地址永远递增),
 *    而这里恰恰要反复读同一个 ADC 数据口; 且 AXI2APB 只支持 len==0 的单拍,
 *    走 APB 只能 8bit 单拍, 效率极低。所以不用它。
 *  => 数据通路: ADC DATA 0x300B_0008 --APB-DMA--> APB RAM 0x300F_0000
 *     搬完由 CPU 直接读 APB RAM 做统计/校验。
 *
 * ====================================================================
 *  三. 寄存器 (user/main.h)
 * ====================================================================
 *    adc_9280_div  0x300B0000  采样分频, 采样率 = 32MHz / div
 *    adc_9280_csr  0x300B0004  见 main.h 第 10 节的位定义
 *    adc_9280_data 0x300B0008  读一次 = 弹出 1 个字节
 *
 *    dma_src_addr_base 0x300E0000 / dma_dst_addr_base 0x300E0004
 *    dma_number        0x300E0008 / dma_cr_sr 0x300E000C (bit0 BUSY, 写 1 启动)
 *    dma_cfg           0x300E0010  bit4 int_en / bit3 dst_inc / bit2 src_inc
 *                                  bit[1:0] word_len (00 = 8bit)
 *
 * ====================================================================
 *  四. 菜单与现象 (APP_SEL = 14)
 * ====================================================================
 *    1  APB 直读   : 采满 1024 点后用 CPU 逐个读数据口, 打印统计 + 前 32 字节
 *    2  APB-DMA    : 同一批数据由 APB-DMA 搬进 APB RAM, 再统计
 *
 *  说明:
 *    - 每轮都是"采满 1024 点 -> 停采样 -> 再搬", 这样 FIFO 里一定有 1024
 *      个字节, 搬的时候不会因为空读掺入 0x00。
 *    - config_sel.vh 里必须打开 `ADC_9280_PERIPHERALS` (J8 与矩阵键盘互斥,
 *      与 DAC9708 引脚不冲突, 可以同时打开)。
 */
#include "main.h"

/*--------------------------------------------------------------------
 *  参数
 *------------------------------------------------------------------*/
#define ADC_SAMPLE_DIV   8u             /* 采样率 = 32MHz/8 = 4 MSPS      */
#define ADC_FIFO_LEN     1024u          /* FIFO 深度, 一轮采满一屏         */
#define ADC_DATA_ADDR    0x300B0008u    /* 数据口地址 (给 DMA 当源地址)    */
#define ADC_DMA_RAM      0x300F0000u    /* APB RAM, APB-DMA 的落地缓冲     */

/* dma_cfg: bit3 dst_inc=1, bit2 src_inc=0, bit[1:0]=00 (8bit)
 *        => 0x08: 源地址固定(反复读 ADC 数据口), 目的地址递增          */
#define DMA_CFG_ADC      0x08u

#define ADC_FULL_GUARD   1000000u       /* 等 FIFO 满的轮询上限 (安全网)   */
#define APB_DMA_GUARD    1000000u       /* 等 APB-DMA 结束的轮询上限       */

static unsigned char s_buf[ADC_FIFO_LEN];

/*====================================================================
 *  ADC 采样控制
 *==================================================================*/

/* 停采样 (ctrl = 0: 关使能, 同时释放 FIFO 软复位) */
static void adc_stop(void)
{
    *adc_9280_csr = 0;
}

/* 复位 FIFO -> 使能采样。
 * 注意 bit1 是电平有效的软复位, 必须再写一次把它清掉, 否则 FIFO 一直被复位。 */
static void adc_begin(unsigned int div)
{
    *adc_9280_div = div;
    *adc_9280_csr = adc_fifo_srst;      /* 复位 FIFO + 读握手流水线 */
    *adc_9280_csr = 0;                  /* 释放复位 */
    *adc_9280_csr = adc_en;             /* 开始采样 */
}

/* 采满一屏 (1024 个字节) 后停采样; 返回 1 = 成功, 0 = 超时 */
static int adc_capture(void)
{
    unsigned int guard = ADC_FULL_GUARD;

    adc_begin(ADC_SAMPLE_DIV);

    while ((*adc_9280_csr & adc_fifo_full) == 0u) {
        if (--guard == 0u) {
            printf("  [ADC] wait FIFO full timeout, stop anyway\r\n");
            adc_stop();
            return 0;
        }
    }

    adc_stop();
    return 1;
}

/* 打印 CSR 的读回状态 (调试用) */
static void adc_show_status(const char *tag)
{
    unsigned int st = *adc_9280_csr;

    printf("  [%s] csr=0x%02x: full=%u otr=%u ready=%u err=%u empty=%u\r\n",
           tag, st,
           (st & adc_fifo_full)  ? 1u : 0u,
           (st & adc_out_range)  ? 1u : 0u,
           (st & adc_data_ready) ? 1u : 0u,
           (st & adc_err_sticky) ? 1u : 0u,
           (st & adc_fifo_empty) ? 1u : 0u);
}

/* 统计 + 前 32 字节 */
static void adc_report(const char *tag, volatile unsigned char *p, unsigned int n)
{
    unsigned int i, min = 255u, max = 0u, sum = 0u;

    for (i = 0; i < n; i++) {
        unsigned int v = p[i];
        if (v < min) min = v;
        if (v > max) max = v;
        sum += v;
    }

    printf("  [%s] n=%u min=%u max=%u avg=%u\r\n", tag, n, min, max, sum / n);

    printf("  [%s] first 32:", tag);
    for (i = 0; i < 32u && i < n; i++) {
        printf(" %02x", p[i]);
    }
    printf("\r\n");
}

/*====================================================================
 *  APB-DMA : 一次阻塞式搬运 (src/dst 都在 APB 段, 目的地是 APB RAM)
 *    src/dst : 源/目的地址   n : 字节数   cfg : dma_cfg 低 5 位
 *    返回 0 成功, -1 超时
 *==================================================================*/
static int apb_dma_copy(unsigned int src, unsigned int dst, unsigned int n,
                        unsigned int cfg, const char *tag)
{
    unsigned int guard = APB_DMA_GUARD;

    /* 等上一条搬完 (BUSY = cr_sr bit0) */
    while ((*dma_cr_sr & 0x1u) != 0u) {
        if (--guard == 0u) {
            printf("  [APB-DMA] %s: previous transfer still busy\r\n", tag);
            return -1;
        }
    }

    *dma_src_addr_base = src;
    *dma_dst_addr_base = dst;
    *dma_cfg           = cfg;
    *dma_number        = n;
    *dma_cr_sr         = 0x1u;          /* 启动 (自清) */

    guard = APB_DMA_GUARD;
    while ((*dma_cr_sr & 0x1u) != 0u) {
        if (--guard == 0u) {
            printf("  [APB-DMA] %s: timeout, abort\r\n", tag);
            return -1;
        }
    }

    printf("  [APB-DMA] %s ok: 0x%08x -> 0x%08x, %u bytes\r\n", tag, src, dst, n);
    return 0;
}

/*====================================================================
 *  方式 1 : APB 直接读数据口
 *==================================================================*/
static void adc_mode_direct(void)
{
    unsigned int i;

    if (!adc_capture()) {
        return;
    }
    adc_show_status("direct");

    /* 读一次 = 弹一个字节; FIFO 空时硬件会自动插等待, 不用软件判空 */
    for (i = 0; i < ADC_FIFO_LEN; i++) {
        s_buf[i] = *adc_9280_data;
    }

    adc_show_status("direct-end");
    adc_report("direct", s_buf, ADC_FIFO_LEN);
}

/*====================================================================
 *  方式 2 : APB-DMA  ADC FIFO -> APB RAM
 *==================================================================*/
static void adc_mode_apb_dma(void)
{
    volatile unsigned char *r = (volatile unsigned char *)ADC_DMA_RAM;
    unsigned int i;

    if (!adc_capture()) {
        return;
    }

    /* 先把目标 RAM 铺成 0xA5, 搬完就能看出 DMA 到底写了哪些字节 */
    for (i = 0; i < ADC_FIFO_LEN; i++) {
        r[i] = 0xA5;
    }

    /* 源地址固定 + 8bit: 每读一次数据口弹一个字节, 目的地址自增 */
    if (apb_dma_copy(ADC_DATA_ADDR, ADC_DMA_RAM, ADC_FIFO_LEN,
                     DMA_CFG_ADC, "ADC->RAM") != 0) {
        return;
    }

    adc_show_status("dma-end");
    adc_report("ram", r, ADC_FIFO_LEN);
}

/*====================================================================
 *  入口
 *==================================================================*/
void adc9280_demo(void)
{
    int c;
    unsigned char mode;

    printf("adc9280 demo: FIFO %u bytes, div=%u (32MHz/%u = %u MHz)\r\n",
           ADC_FIFO_LEN, ADC_SAMPLE_DIV, ADC_SAMPLE_DIV, 32u / ADC_SAMPLE_DIV);
    printf("read style: a single read of DATA pops one byte (no CSR poking).\r\n");

    for (;;) {
        printf("\r\n------------- ADC9280 -------------\r\n");
        printf("  1 : APB direct read (CPU reads DATA %u times)\r\n", ADC_FIFO_LEN);
        printf("  2 : APB-DMA   ADC FIFO -> APB RAM (0x%08x)\r\n", (unsigned int)ADC_DMA_RAM);
        printf("please input 1~2 : ");

        for (;;) {
            c = uart_getchar_nb();
            if (c < 0) {
                continue;                   /* 无输入: 继续等 */
            }
            if (c >= '1' && c <= '2') {
                mode = (unsigned char)c;
                break;
            }
            if (c == '\r' || c == '\n' || c == ' ' || c == '\t') {
                continue;
            }
            printf("\r\n[?] '%c' invalid, please input 1~2\r\n", c);
            printf("please input 1~2 : ");
        }
        printf("%c\r\n", mode);

        if (mode == '1') {
            adc_mode_direct();
        } else {
            adc_mode_apb_dma();
        }

        printf("[ADC] round finished, back to menu.\r\n");
    }
}
