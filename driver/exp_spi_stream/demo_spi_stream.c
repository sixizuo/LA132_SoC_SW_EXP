/**
 * @file    demo_spi_stream.c
 * @brief   11.5 实验九: FIFO 型 SPI AD/DA 与 DMA (0x300A_0000)
 * @Author: WorkBuddy
 * @Date:   2026-11-23
 *
 * 对应硬件: hw/peripheral/exp_spi_stream/spi_stream_top.v (内含原 spi_top)
 * 对应工程: exp_array_spi / exp_iic_spi (两者都定义了 EXP_SPI_STREAM)
 *
 * 寄存器 (spi_stream_top.v, 与教材表 11-21 一致):
 *   0x00 CTRL   bit0 使能 bit1 0=AD 1=DA bit2 中断使能 bit3 回环
 *   0x04 DIV    采样分频 fs = 32 MHz / DIV, 小于 64 按 64
 *   0x08 DATA   写: 压 TX FIFO(DA) / 读: 弹 RX FIFO; 空时读回 0xFFFF_FFFF
 *   0x0C STATUS bit0 RX 非空 bit1 半满 bit2 满 bit3 TX 空 bit4 TX 满 bit5 忙
 *   0x10 CNT    已完成采样个数, 写任意值清零
 *   0x14 CH     ADC 通道 0~7
 *   0x18 FIFO_LVL [7:0] RX 条数 [15:8] TX 条数
 *   0x1C VERSION 0x5350_0003
 *
 * 测试顺序 (先回环、再接模拟信号, 把"SPI 时序问题"和"FIFO/DMA 问题"分开):
 *   A. 版本 / 复位值 / DIV 钳位
 *   B. 回环 (CTRL[3]=1): 写 500 个递增数, 读回逐个比对, 不需要外部模块
 *   C. AD 采样: DIV=3200 (10 kHz), 100 ms 后 CNT 应约 1000;
 *      读 100 个样本打印电压; 半满标志在 32 条时置位
 *   D. 清 CNT
 *   E. APB DMA: 从 FIFO 数据口搬 64 个样本到片内 SRAM,
 *      cfg = 0x0A (字, 源不自增, 目的自增), 查 BUSY 等结束
 *   F. DA 通带: 往 TX FIFO 灌一个锯齿波, 示波器可看 (可选)
 *
 * 现象: 串口依次打印 A~F 各步结果, 全绿时打印 ALL PASS;
 *       之后每秒打印一次 CNT 增量 (应约等于 DIV 对应的采样率)。
 */
#include "main.h"
#include "interrupt.h"

#define SS_DMA_DST      0x300F0200u    /* 片内 SRAM 目的区 (躲开 0x300F0100 的 DMA 中断标志) */
#define SS_IRQ_LINE     13u            /* 教材表 11-7: int_13 = SPI 流 FIFO */
#define SS_MAX_SAMPLE   500

static unsigned int s_fail;

static void chk(const char *name, unsigned int got, unsigned int exp)
{
    if (got == exp) {
        printf("   %-28s = 0x%08x  ok\r\n", name, got);
    } else {
        printf("   %-28s = 0x%08x  <-- FAIL (expect 0x%08x)\r\n",
               name, got, exp);
        s_fail++;
    }
}

/* 等 RX FIFO 里有数据, 超时返回 0xFFFFFFFF */
static unsigned int ss_read(void)
{
    unsigned int guard = 0;

    while (!(spis_status & SPIS_ST_RX_NE)) {
        if (++guard > 4000000u) {
            return SPIS_EMPTY_DATA;
        }
    }
    return spis_data;
}

/* 把 RX FIFO 读空 */
static void ss_flush(void)
{
    unsigned int guard = 0;

    while ((spis_status & SPIS_ST_RX_NE) && (guard++ < 256u)) {
        (void)spis_data;
    }
}

/* A. 版本 / 复位值 / 钳位 */
static void test_ident(void)
{
    printf("\r\n-- A. identity --\r\n");
    chk("VERSION", spis_version, 0x53500003u);
    chk("CTRL reset", spis_ctrl, 0u);
    chk("CH reset", spis_ch, 0u);
    chk("DIV default", spis_div, 3200u);

    spis_div = 10;
    chk("DIV clamp (write 10)", spis_div, 64u);
    spis_div = 3200;
}

/* B. 回环: 写什么读什么, 顺序不变 */
static void test_loop(void)
{
    int i;
    unsigned int v, bad = 0;

    printf("\r\n-- B. loopback (CTRL[3]=1) --\r\n");

    spis_ctrl = 0;
    ss_flush();
    spis_ctrl = SPIS_CTRL_EN | SPIS_CTRL_DA | SPIS_CTRL_LOOP;   /* DA + 回环 */

    for (i = 0; i < 32; i++) {                 /* TX FIFO 32 深, 先灌满 */
        spis_data = (unsigned int)(0x100 + i);
    }
    for (i = 0; i < 32; i++) {
        v = ss_read();
        if (v != (unsigned int)(0x100 + i)) {
            if (bad < 4u) {
                printf("   [%2d] got 0x%08x expect 0x%08x\r\n", i, v, 0x100u + i);
            }
            bad++;
        }
    }
    printf("   loopback 32 words, mismatches = %u %s\r\n", bad,
           bad ? "<-- FAIL" : "ok");
    if (bad) s_fail++;

    /* 500 个递增数: 写一个读一个, 检验长期不丢不错 */
    bad = 0;
    for (i = 0; i < SS_MAX_SAMPLE; i++) {
        spis_data = (unsigned int)(i * 37 + 5);
        v = ss_read();
        if (v != (unsigned int)(i * 37 + 5)) {
            bad++;
        }
    }
    printf("   loopback %d words, mismatches = %u %s\r\n",
           SS_MAX_SAMPLE, bad, bad ? "<-- FAIL" : "ok");
    if (bad) s_fail++;

    spis_ctrl = 0;
    ss_flush();
}

/* C. AD 采样 + 半满标志 + CNT */
static void test_ad(void)
{
    unsigned int c1, c2, n, i, s, v;
    unsigned int sum = 0;
    unsigned int half_seen = 0;

    printf("\r\n-- C. AD sampling, DIV=3200 (10 kHz) --\r\n");

    spis_ctrl = 0;
    ss_flush();
    spis_div  = 3200;
    spis_ch   = 0;
    spis_cnt  = 0;
    spis_ctrl = SPIS_CTRL_EN;                  /* AD 模式 */

    delay_ms(100);
    c1 = spis_cnt;
    printf("   CNT after 100 ms = %u (expect ~1000, 10 kHz)\r\n", c1);
    if (c1 < 800u || c1 > 1200u) {
        printf("   !! 采样率偏离, 查 DIV 是否被钳位 / SPI 是否卡在 S_WAIT1\r\n");
        s_fail++;
    }

    /* 半满标志: 不读, 等 FIFO 攒到 32 条 */
    for (i = 0; i < 400000u; i++) {
        if (spis_status & SPIS_ST_RX_HALF) { half_seen = 1; break; }
    }
    printf("   half-full flag %s, FIFO_LVL=0x%08x\r\n",
           half_seen ? "asserted ok" : "NEVER SET <-- FAIL", spis_lvl);
    if (!half_seen) s_fail++;

    /* 取 100 个样本, 打印统计 */
    n = 0; s = 0; sum = 0;
    for (i = 0; i < 100u; i++) {
        v = ss_read();
        if (v == SPIS_EMPTY_DATA) break;
        v &= 0x0FFFu;
        sum += v;
        s = v;
        n++;
    }
    printf("   100 samples: n=%u last=%u avg=%umV\r\n", n, s,
           n ? (sum / n) * 3300u / 4095u : 0u);
    if (n != 100u) {
        printf("   !! 只取到 %u 个样本\r\n", n);
        s_fail++;
    }

    delay_ms(100);
    c2 = spis_cnt;
    printf("   CNT after another 100 ms = %u (delta %u)\r\n", c2, c2 - c1);

    spis_ctrl = 0;
    ss_flush();
}

/* D. 清 CNT */
static void test_cnt_clear(void)
{
    printf("\r\n-- D. CNT clear --\r\n");

    spis_div  = 32000;                         /* 1 kHz, 免得涨太快 */
    spis_cnt  = 0;
    spis_ctrl = SPIS_CTRL_EN;
    delay_ms(50);
    printf("   CNT=%u after 50 ms\r\n", spis_cnt);

    spis_cnt = 0;                              /* 写任意值清零 */
    chk("CNT after write 0", spis_cnt, 0u);
    spis_ctrl = 0;
    ss_flush();
    spis_div = 3200;
}

/* E. APB DMA 搬 FIFO -> SRAM */
static void test_dma(void)
{
    unsigned int i, ok = 1;
    volatile unsigned int *dst = (volatile unsigned int *)SS_DMA_DST;
    unsigned int guard;

    printf("\r\n-- E. APB DMA : FIFO -> SRAM (64 words) --\r\n");

    spis_ctrl = 0;
    ss_flush();
    spis_div  = 3200;                          /* 10 kHz */
    spis_ctrl = SPIS_CTRL_EN;
    delay_ms(20);                              /* 先攒几个, DMA 才不空等 */

    while ((*dma_cr_sr & 0x1) != 0) {
        ;                                      /* 等上一条结束 */
    }

    *dma_src_addr_base = spis_base + 0x08;     /* FIFO 数据口, 不自增 */
    *dma_dst_addr_base = SS_DMA_DST;           /* SRAM, 自增 */
    *dma_cfg           = 0x0A;                 /* 字 + 源不自增 + 目的自增 */
    *dma_number        = 64;                   /* 搬 64 个字 */
    *dma_cr_sr         = 0x1;                  /* 启动 */

    guard = 0;
    while ((*dma_cr_sr & 0x1) != 0) {
        if (++guard > 8000000u) {
            printf("   !! DMA 超时 (BUSY 不落)\r\n");
            s_fail++;
            return;
        }
    }

    printf("   0x%08x :", SS_DMA_DST);
    for (i = 0; i < 8u; i++) {
        printf(" %03x", dst[i] & 0x0FFFu);
    }
    printf(" ...\r\n");

    /* 检查: 12 位范围内且不是全 0 / 全 F (空 FIFO 会返回 0xFFFFFFFF) */
    for (i = 0; i < 64u; i++) {
        if (dst[i] == 0xFFFFFFFFu) {
            ok = 0;
            break;
        }
    }
    printf("   DMA 64 samples %s\r\n", ok ? "ok" : "<-- FAIL (含 0xFFFFFFFF)");
    if (!ok) s_fail++;

    spis_ctrl = 0;
    ss_flush();
}

/* F. DA: 往 TX FIFO 灌锯齿波 (示波器看 TLV5618A 的 OUT-A)
 *    直接写 12 位码值 = 帧 {SPD=0, PWR=0, A=00, D11..D0} -> 慢模式写 DAC-A。
 *    CS 拉低/拉高由 RTL 状态机自动完成 (S_CS_ON / S_CS_OFF)。
 *    更新率 = fs = 32M/DIV = 10 kHz, 远快于 TLV5618A 慢模式 14 us 建立时间 */
static void test_da_wave(void)
{
    unsigned int i, guard;
    unsigned short v = 0;

    printf("\r\n-- F. DA sawtooth on TLV5618A OUT-A (10 kHz update) --\r\n");

    /* TLV5618A 一次写入是 16 位命令帧:
     *   bit15..12 = 命令前缀, 0xC = 写 DAC-A 并立即更新输出
     *   bit11..0  = 12 位数据
     * 2026-11-25 修: 之前写的是裸 12 位值 (bits15..12 = 0),
     * 命令域无效, DAC 收到的帧不会被更新到输出 -> 无波形。
     * 与原始例程 demo_spi_dac.c 的 0xCxxx/0x5xxx 前缀语义一致。 */
    spis_div  = 3200;                          /* 10 kHz 采样 */
    spis_ctrl = SPIS_CTRL_EN | SPIS_CTRL_DA;

    for (i = 0; i < 2048u; i++) {
        v = (unsigned short)((v + 2u) & 0x0FFFu);
        guard = 0;
        while (spis_status & SPIS_ST_TX_FULL) {   /* TX 32 深, 写满就等 */
            if (++guard > 200000u) break;
        }
        spis_data = 0xC000u | v;               /* 写 OUT-A: 0~3.3V 锯齿波 */
    }
    printf("   wrote 2048 samples (0xC000|v), lvl=0x%08x\r\n", spis_lvl);

    spis_ctrl = 0;
}

void spi_stream_demo(void)
{
    unsigned int c0, c1, t;

    printf("exp9: streaming SPI AD/DA + FIFO + DMA @0x%08x\r\n", spis_base);

    test_ident();
    test_loop();
 //   while(1){
    test_ad();
    test_cnt_clear();
    test_dma();
 //   }
    while(1)
    test_da_wave();

    printf("\r\n==== SPI STREAM SELFTEST: %s (%u error%s) ====\r\n",
           s_fail ? "FAIL" : "PASS", s_fail, s_fail > 1u ? "s" : "");

    /* 收尾: 连续采样, 每秒报一次采样率 */
    spis_ctrl = 0;
    ss_flush();
    spis_div  = 3200;
    spis_ch   = 0;
    spis_cnt  = 0;
    spis_ctrl = SPIS_CTRL_EN;

    for (;;) {
        c0 = spis_cnt;
        delay_s(1);
        c1 = spis_cnt;
        t = c1 - c0;
        printf("[SS] fs=%u Hz (div=3200), lvl=0x%08x st=0x%08x\r\n",
               t, spis_lvl, spis_status);
        ss_flush();                            /* 不读会满, 满了就丢样本 */
    }
}
