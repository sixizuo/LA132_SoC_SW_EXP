/*
 * @Author: yx
 * @Date: 2025-01-15
 * @LastEditors: WorkBuddy
 * @LastEditTime: 2026-10-31
 * @Description:
 *      yunxiao_LA132_SoC_AC850_Irq 工程 —— 外设寄存器定义总表
 * @Version: V1.1.0.261031
 *
 * 本文件只放 **寄存器地址/位定义 + 必要声明**, 不放任何变量定义。
 * 各外设的 demo 一律从这里取寄存器, 不再自己往 .c 里写裸地址,
 * 也不使用 typedef struct 方式访问寄存器 (结构体偏移与实际 RTL
 * 寄存器排布一旦不一致就会静默读写错地址)。
 */

#ifndef _MAIN_H_
#define _MAIN_H_

#include "interrupt.h"

#include "LA_TIMER/latimer.h"
#include "UART/uart.h"
#include "PRINTF/printf.h"

#define SET_BYTE(ptr, new_value, mask) \
    do { \
        unsigned int value = *((unsigned int*)(ptr)); \
        unsigned int bit_mask = (((mask) & 0b1) * 0xff) | ((((mask)>>1) & 0b1) * 0xff00) \
            | ((((mask)>>2) & 0b1) * 0xff0000) | ((((mask)>>3) & 0b1) * 0xff000000); \
        value = (value & ~bit_mask) | ((new_value) & bit_mask); \
        *((unsigned int*)(ptr)) = value; \
    } while (0)

#define SET_CHAR(ptr, new_char, index) SET_BYTE(ptr, ((new_char) << (index)*8), (0x1 << (index)));

/*====================================================================
 * 1. UART   @ 0x3001_0000
 *
 *    ---- data (0x00) -------------------------------------------------
 *    写: 低 8 位送入发送 FIFO (深度 16)
 *    读: 弹出接收 FIFO 队首一个字节
 *    !! 读 data 时如果接收 FIFO 是空的, 硬件 apb_pready 不会拉高,
 *       AXI2APB 桥就会一直停在那里等 -> **整条总线卡死**。
 *       所以任何读 data 之前必须先确认 bit0 = 1。
 *
 *    ---- ctrl (0x04) ------------------------------------------------
 *    **写**进去的是控制字 (3 bit):
 *        bit[1:0] 波特率  00=9600 01=19200 10=38400 11=115200
 *        bit2     校验    0=8 数据位无校验(8N1) 1=带校验位(9 位帧)
 *    **读**回来的是状态字, 跟写进去的控制字完全没有关系!
 *        bit0 = 接收 FIFO 非空 (有数据)
 *        bit1 = 发送 FIFO 满   (满时不可写)
 *        bit[7:2] = 0
 *    (依据 RTL hw/peripheral/apb_uart/uart_top.v:
 *         assign status = {6'b0, tx_full, !rx_empty};
 *         UART_CTRL 读 -> prdata = status;
 *     老代码按 "bit0=RX 非空, bit3=发送忙" 理解, bit0 恰好对,
 *     但 **bit3 永远是 0** -> 判发送满永远通过 -> 见 uart_putc 的说明)
 *
 *    ---- stat (0x08, 只读) 2026-11-02 新增 --------------------------
 *        bit[4:0] = RX FIFO 里当前的字节个数 (0 ~ 16)
 *        (依据 uart_top.v: `UART_STAT -> prdata = {3'b000, rx_count};
 *         rx_count 由 uart_rfifo 的 w_ptr-r_ptr 差值实时给出)
 *        用途: 判断"串口已经收够 N 个字节", 不用拿固定延时去猜。
 *==================================================================*/
#define uart_data ((volatile unsigned int*) 0x30010000)
#define uart_ctrl ((volatile unsigned int*) 0x30010004)
#define uart_stat ((volatile unsigned int*) 0x30010008)

/* stat 读回值 */
#define UART_RX_CNT_MASK    0x1Fu       /* bit[4:0] = RX FIFO 字节个数 */

/* ctrl 写入值 (波特率选择) */
#define UART_BAUD_9600      0x0u
#define UART_BAUD_19200     0x1u
#define UART_BAUD_38400     0x2u
#define UART_BAUD_115200    0x3u
#define UART_PARITY_EN      (1u << 2)   /* 1 = 带校验位 (9 位帧, 终端要 8N1 就别置) */

/* ctrl 读回的状态位 */
#define UART_ST_RX_RDY      (1u << 0)   /* RX FIFO 非空, 可以读 data */
#define UART_ST_TX_FULL     (1u << 1)   /* TX FIFO 满, 不能写 data */

/*====================================================================
 * 2. GPIO   @ 0x3000_0000
 *    dir : 1 = 输入(三态) , 0 = 输出      <-- 注意不是反的
 *    out : 输出数据
 *    in  : 输入数据
 *    每个 32 位端口按字节可分: [7:0] [15:8] [23:16] [31:24]
 *
 *    本板(yunxiao)接线:
 *      gpioa[7:0]   -> 拨码开关 sw0~7     (输入)
 *      gpioa[11:8]  -> 矩阵键盘 列        (输入)
 *      gpioa[15:12] -> 步进电机 / J4      (输出)
 *      gpioa[19:16] -> 矩阵键盘 行        (输出)
 *      gpioa[31:24] -> LED  D1~D8         (输出)
 *      gpiob[15:0]  -> 点阵行/列、其它    (输出)
 *      gpiob[23:16] -> 数码管 an  (gpio48~50 -> 3-8 译码器 A0~A2)
 *      gpiob[31:24] -> 数码管 seg (gpio56~63 -> a,b,c,d,e,f,g,dp)
 *==================================================================*/
#define gpioa_dir ((volatile unsigned int*) 0x30000040)
#define gpioa_out ((volatile unsigned int*) 0x30000044)
#define gpioa_in  ((volatile unsigned int*) 0x30000048)

#define gpiob_dir ((volatile unsigned int*) 0x30000050)
#define gpiob_out ((volatile unsigned int*) 0x30000054)
#define gpiob_in  ((volatile unsigned int*) 0x30000058)

/* 按字节访问同一个端口 (n = 0..3, 0 是最低字节) */
#define GPIOA_DIR(n)  (*(volatile unsigned char *)(0x30000040u + (n)))
#define GPIOA_OUT(n)  (*(volatile unsigned char *)(0x30000044u + (n)))
#define GPIOA_IN(n)   (*(volatile unsigned char *)(0x30000048u + (n)))
#define GPIOB_DIR(n)  (*(volatile unsigned char *)(0x30000050u + (n)))
#define GPIOB_OUT(n)  (*(volatile unsigned char *)(0x30000054u + (n)))
#define GPIOB_IN(n)   (*(volatile unsigned char *)(0x30000058u + (n)))

#define gpiob_an  ((volatile unsigned char*) 0x30000056) /* [23:16] 数码管位选 */
#define gpiob_seg ((volatile unsigned char*) 0x30000057) /* [31:24] 数码管段选 */
#define gpioa_sw  ((volatile unsigned char*) 0x30000048) /* [7:0]   拨码开关   */
#define gpioa_led ((volatile unsigned char*) 0x30000047) /* [31:24] LED        */

/*====================================================================
 * 3. GPIO 外部中断 (EXTI)  @ 0x3000_0020
 *==================================================================*/
#define exint_en   ((volatile unsigned int*) 0x30000020)
#define exint_pol  ((volatile unsigned int*) 0x30000024)
#define exint_edge ((volatile unsigned int*) 0x30000028)
#define exint_clr  ((volatile unsigned int*) 0x3000002c)
#define exint_two  ((volatile unsigned int*) 0x30000030)

/*====================================================================
 * 4. INTC (8 路中断控制器)  @ 0x3002_0000
 *    8 路相或成一根进CPU 的 HWI4, 向量入口在 0x1C001000
 *    bit n 对应 intc_irq_n
 *==================================================================*/
#define intc_int_en   ((volatile unsigned int*) 0x30020000)
#define intc_int_pol  ((volatile unsigned int*) 0x30020004)
#define intc_int_edge ((volatile unsigned int*) 0x30020008)
#define intc_int_clr  ((volatile unsigned int*) 0x3002000c)
#define intc_int_set  ((volatile unsigned int*) 0x30020010)
#define intc_int_out  ((volatile unsigned int*) 0x30020014)

/*====================================================================
 * 5. 定时器   @ 0x3003_0000   时钟 32 MHz
 *    cfg : bit0 启动, bit1 周期模式, bit2 中断使能 ; 读 cfg 清中断
 *    cnt : 当前计数
 *    cmp : 首次比较值
 *    stp : 周期重装值
 *==================================================================*/
#define timer_cfg ((volatile unsigned int*) 0x30030000)
#define timer_cnt ((volatile unsigned int*) 0x30030004)
#define timer_cmp ((volatile unsigned int*) 0x30030008)
#define timer_stp ((volatile unsigned int*) 0x3003000c)

/*====================================================================
 * 6. I2C   @ 0x3004_0000   (详见 driver/I2C/i2c.h)
 *    这里再列一遍, 供不用 i2c 库的 demo 直接用
 *==================================================================*/
#define iic_prerl ((volatile unsigned int*) 0x30040000)
#define iic_prerh ((volatile unsigned int*) 0x30040004)
#define iic_ctr   ((volatile unsigned int*) 0x30040008)
#define iic_dr    ((volatile unsigned int*) 0x3004000c)
#define iic_cr_sr ((volatile unsigned int*) 0x30040010)
#define iic_sel   ((volatile unsigned int*) 0x30040020)

/*====================================================================
 * 7. 触摸控制器   @ 0x3006_0000
 *    ctrl     : bit0 使能, bit1 中断使能
 *    interval : 采样间隔 (32MHz 计数)
 *    data     : [31:16] = X, [15:0] = Y
 *==================================================================*/
#define touch_ctrl     ((volatile unsigned int*) 0x30060000)
#define touch_interval     ((volatile unsigned int*) 0x30060004)
#define touch_data         ((volatile unsigned int*) 0x30060008)

/* touch_ctrl 位定义
 *   写: bit0 模块使能, bit1 中断使能
 *   读: bit2 = FIFO **非空** (有坐标), bit3 = FIFO 满
 *       (2026-10-30 踩坑: 依据 RTL touch_top.v
 *        prdata = {28'b0, {full, !empty}, touch_ctrl[1:0]},
 *        旧代码把这两位读反, 一直在等"满", 结果一个点都取不到)
 *   每次读 touch_data 会弹出一个点: {X[31:16], Y[15:0]} */
#define TOUCH_CTRL_EN          (1u << 0)
#define TOUCH_CTRL_IRQEN       (1u << 1)
#define TOUCH_CTRL_NOT_EMPTY   (1u << 2)   /* 读回: 有坐标 */
#define TOUCH_CTRL_FIFO_FULL   (1u << 3)   /* 读回: FIFO 满 */

/*====================================================================
 * 8. PWM   @ 0x3009_0000   时钟 16 MHz
 *    div_freq : 周期 = div_freq / 16MHz
 *    cmp      : 高电平计数, 占空比 = cmp / div_freq
 *    cr       : bit0 启动, bit1 方向(电机 demo 用)
 *==================================================================*/
#define pwm_div_freq ((volatile unsigned int*) 0x30090000)
#define pwm_cmp      ((volatile unsigned int*) 0x30090004)
#define pwm_cr       ((volatile unsigned int*) 0x30090008)

/*====================================================================
 * 9. SPI   @ 0x300A_0000
 *    spcr : bit7 中断使能, bit6 接口使能, bit5 主设备, bit4 sclk 空闲电平
 *           bit3 采样沿, bit[1:0] 分频
 *    spsr : bit2 传输完成
 *    data : 收发缓冲 (写一次发一字节)
 *    sper : bit6 接收中断门槛
 *    softcs : 软件片选, bit0=1 使能 spi0, bit1=1 使能 spi1
 *==================================================================*/
#define spi_spcr   ((volatile unsigned char*) 0x300a0000)
#define spi_spsr   ((volatile unsigned char*) 0x300a0004)
#define spi_data   ((volatile unsigned char*) 0x300a0008)
#define spi_sper   ((volatile unsigned char*) 0x300a000c)
#define spi_softcs ((volatile unsigned char*) 0x300a0014)

/*====================================================================
 * 10. ADC9280 (并行/串行 ADC + FIFO)  @ 0x300B_0000
 *
 *   div  0x00  采样分频: 采样率 = 32MHz / div
 *   csr  0x04  写: bit0 采样使能, bit1 FIFO 软复位(电平, 用完要清),
 *                  bit2 保留(旧软件的"读触发", 现已无用),
 *                  bit3 写 1 清粘滞错误位(此时 pwdata[2:0] 要带上原 ctrl 值)
 *              读: bit0 FIFO 满, bit1 ADC 超量程(OTR), bit2 数据就绪,
 *                  bit3 粘滞错误(FIFO 空导致读超时), bit4 FIFO 空
 *   data 0x08  读一次 = 自动从 FIFO 弹出 1 个字节交给总线。
 *              FIFO 空时硬件插等待(最多 4096 个 pclk), 到点返回 0x00 并置
 *              bit3, 不会把总线挂死 —— 所以可以直接读, 也可以让 DMA 连续读。
 *
 *   !! 2026-11-04 RTL 改动: 不再需要 "清/置/清 csr.bit2 再读 data" 那套
 *      软件造脉冲的写法, 直接读 data 即可 (见 apb_adc_top.v 头注释)。
 *==================================================================*/
#define adc_9280_div  ((volatile unsigned int*)  0x300b0000)
#define adc_9280_csr  ((volatile unsigned int*)  0x300b0004)
#define adc_9280_data ((volatile unsigned char*) 0x300b0008)

/* csr 写入位 */
#define adc_en         0x1     /* bit0 采样使能 */
#define adc_fifo_srst  0x2     /* bit1 FIFO 软复位 (电平有效, 置起再清) */
#define adc_fifo_rd    0x4     /* bit2 旧软件的读触发 —— 已无用, 仅为兼容保留 */
#define adc_err_clr    0x8     /* bit3 写 1 清粘滞错误位 */

/* csr 读回位 */
#define adc_fifo_full  0x1     /* bit0 FIFO 满 */
#define adc_out_range  0x2     /* bit1 ADC 超量程 (OTR) */
#define adc_data_ready 0x4     /* bit2 手里已有数据, 可以直接读数据口 */
#define adc_err_sticky 0x8     /* bit3 FIFO 空导致读超时(读成功一次即自动清) */
#define adc_fifo_empty 0x10    /* bit4 FIFO 空 */

/*====================================================================
 * 11. DAC9708 (DDS 波形发生器)  @ 0x300C_0000
 *==================================================================*/
#define dac_9708_div      ((volatile unsigned int*)  0x300c0000)
#define dac_9708_en       ((volatile unsigned int*)  0x300c0004)
#define dac_9708_fword    ((volatile unsigned int*)  0x300c0008)
#define dac_9708_pword    ((volatile unsigned int*)  0x300c000c)
#define dac_9708_aword    ((volatile unsigned int*)  0x300c0010)
#define dac_9708_data_base ((volatile unsigned char*) 0x300c8000)

/* TLV5618A 双通道 SPI DAC 的 16 位命令前缀 (slow mode) */
#define dac_b_slow_first_prefix  0x5000
#define dac_a_slow_second_prefix 0xc000

/*====================================================================
 * 12. APB DMA   @ 0x300E_0000   (4 种通路, 见 driver/DMA/demo_apb_dma.c)
 *==================================================================*/
#define dma_src_addr_base ((volatile unsigned int*)  0x300e0000)
#define dma_dst_addr_base ((volatile unsigned int*)  0x300e0004)
#define dma_number        ((volatile unsigned int*)  0x300e0008)
#define dma_cr_sr         ((volatile unsigned int*)  0x300e000c)
#define dma_cfg           ((volatile unsigned int*)  0x300e0010)
#define dma_int           ((volatile unsigned char*) 0x300f0100)

/*====================================================================
 * 13. 片内 SRAM 窗口 / DDR3
 *   SRAM  : 0x300F_0000  16KB, CPU 可读写
 *   DDR3  : 0x4000_0000  1GB, 同时是 AXI-LCD 的显存
 *==================================================================*/
#define ram_base ((volatile int*) 0x300f0000)
#define ddr_base ((volatile int*) 0x40000000)

/*====================================================================
 * 14. AXI-LCD / AXI-DMAC  (本版 FPGA 的显示通路)
 *   AXI-LCD  配置寄存器 @ 0x2000_0000  ID = 0x4384, 800x480
 *   AXI-DMAC 配置寄存器 @ 0x2001_0000
 *   显存     @ 0x4000_0000 (FB0) / 0x4018_0000 (FB1)
 *   1 像素 = 1 个 32bit 字 = {8'b0, R8, G8, B8}
 *
 *   !! 老的 APB-LCD (0x5200_0000) 在本版 bit 里已经没有了, 原来 user/ 下
 *      那 4 个 lcd / touch 例程已经改用这套 AXI 通路。
 *
 *   详细寄存器位定义/画图接口见:
 *      driver/AXI_LCD_DMA/axi_lcd.h   寄存器 + API
 *      driver/AXI_LCD_DMA/axi_dma.h   DMA
 *      driver/AXI_LCD_DMA/lcd_gfx.h   画点/线/框/位图/字符
 *   这里只列基址, **不要**在本文件重复定义 AXI_LCD_xxx 宏, 否则与
 *   axi_lcd.h 撞名。
 *==================================================================*/
#define lcd_axi_base   0x20000000u
#define lcd_axi_dma_base 0x20010000u
#define lcd_fb0        0x40000000u
#define lcd_fb1        0x40180000u

/*====================================================================
 * 15. APB USB (FT232H 245-FIFO 模式)  @ 0x3010_0000
 *   !! 本寄存器组是 2026-11-02 才接到 APB 总线上的 (godson_mcu_top.sv
 *      的 APB_PERIPH_DECLARATION(usb,...,16)), 之前的 bit 里 usb_psel
 *      是悬空隐式线, 访问这里等于访问空洞。
 *
 *   寄存器 (偏移, 见 hw/peripheral/apb_usb/usb_top.v):
 *     +0x00  USB_DATA   写: 低 8 位推入 TX FIFO (到 PC)
 *                       读: 从 RX FIFO 弹出 1 字节 (来自 PC)
 *                       !! 读会弹出, 空读得到垃圾, 必须先判 bit0
 *     +0x04  USB_CTRL   读 = 状态字: {30'b0, tx_full, !rx_empty}
 *                       bit0 = RX FIFO 非空 (有 PC 来的数据)
 *                       bit1 = TX FIFO 满
 *                       写: 无作用 (硬件忽略)
 *   FIFO 深度各 64 字节; usb_irq = RX 非空 (电平), 本版 bit 未接 INTC,
 *   只能轮询。usb_rw 状态机在 60MHz USB 时钟域自动搬运, 软件只碰 FIFO。
 *   详细 API 见 driver/APB_USB/usb.h
 *==================================================================*/
#define usb_base       0x30100000u
#define usb_data ((volatile unsigned int*) 0x30100000)
#define usb_ctrl ((volatile unsigned int*) 0x30100004)
#define USB_ST_RX_RDY   0x1u    /* USB_CTRL bit0: RX FIFO 非空 */
#define USB_ST_TX_FULL  0x2u    /* USB_CTRL bit1: TX FIFO 满  */

/*====================================================================
 * 16. 11.5 节实验外设 (exp_* 工程专用)
 *
 *  这些寄存器只在 exp_array_spi / exp_iic_spi 两个 bit 里存在:
 *  RTL 里用 EXP_KBD / EXP_DOT / EXP_TOUCH_MULTI / EXP_SPI_STREAM 宏
 *  决定是否例化。烧了老 bit 却跑这几个例程, 读回来全是 0x0000_0000。
 *
 *  ---- A. APB 矩阵键盘控制器 @ 0x3005_0000  (apb_kbd.v) -------------
 *     0x00 CTRL     RW bit0 使能 bit1 中断使能 bit2 清 KEY 标志
 *                     bit[3:2] 行扫描周期 0=8000 1=16000 2=40000 3=80000
 *     0x04 STATUS   R  bit0 key_valid bit1 pressed
 *                     bit[7:4] 当前键值 bit[15:8] 去抖计数 bit16 计数溢出
 *     0x08 KEY      R  键码 {行[1:0],列[1:0]}, 读清 key_valid
 *     0x0C~0x18 KEYMAP0~3  RW 键码重映射表
 *     0x1C DEBOUNCE RW 去抖次数, 0 按 1 处理
 *     0x20 RAW      R  {当前行号[7:4], 列采样[3:0]}
 *     0x24 VERSION  R  固定 0x4B42_0001 ("KB")
 *     引脚: gpio19~16 行驱动(低有效), gpio11~8 列采样(板上上拉)
 *
 *  ---- B. LED 点阵控制器 @ 0x3007_0000  (apb_dot.v) -----------------
 *     0x00 CTRL     RW bit0 使能 bit1 闪烁 bit[4:2] 亮度 0~7
 *                      bit[6:5] 模式 00=字符 01=图形 10=滚动
 *     0x04 CHAR     W  写入要显示的数字 0~9
 *     0x08 ROWDIV   RW 每行扫描时间 (32MHz 周期), 默认 4000 = 125us, 最小 8
 *     0x0C RAM0     RW 第 0~3 行图形 (每 8 位一行, bit0=最左列)
 *     0x10 RAM1     RW 第 4~7 行图形
 *     0x14 SHIFT    RW 滚动速度: 每多少帧移一列 (0 按 1 处理)
 *     0x18 STATUS   R  bit0 busy bit[2:1] 当前行 bit[15:8] 帧计数
 *     0x1C VERSION  R  固定 0x444F_0001 ("DO")
 *
 *  ---- C. 多点触摸控制器 @ 0x3006_0000 (touch_top_multi.v) ----------
 *     !! 与单点触摸 touch_top 的寄存器映射**不同**, 不能混用!
 *     0x00 CTRL     RW bit0 使能 bit1 中断使能 bit2 多点模式 bit3 清 FIFO
 *     0x04 INTERVAL RW 采样间隔 (32MHz 周期), 默认 95000 约 3ms
 *     0x08 DATA     R  读一条记录并弹出, 空时返回 0xFFFF_FFFF
 *                      多点 {id[3:0], x[13:0], y[13:0]}
 *                      单点 {x[15:0], y[15:0]}
 *     0x0C NUM      R  本帧点数 0~5
 *     0x10 STATUS   R  bit0 空 bit1 满 bit8 帧有效
 *     0x14 MAXPOINT RW 1~5
 *     0x18 VERSION  R  固定 0x5450_0002 ("TP")
 *
 *  ---- D. 流式 SPI 控制器 @ 0x300A_0000 (spi_stream_top.v) ----------
 *     !! 替代原 spi_top, 同一地址, 寄存器完全换掉
 *     0x00 CTRL     RW bit0 使能 bit1 0=AD 1=DA bit2 中断使能 bit3 回环
 *     0x04 DIV      RW fs = 32MHz / DIV, 小于 64 按 64
 *     0x08 DATA     RW 写压 TX FIFO / 读弹 RX FIFO (空返回 0xFFFF_FFFF)
 *     0x0C STATUS   R  bit0 RX 非空 bit1 RX 半满 bit2 RX 满
 *                      bit3 TX 空 bit4 TX 满 bit5 忙
 *     0x10 CNT      R  已完成采样数, 写任意值清零
 *     0x14 CH       RW ADC 通道 0~7
 *     0x18 FIFO_LVL R  [7:0] RX 条数 [15:8] TX 条数
 *     0x1C VERSION  R  固定 0x5350_0003 ("SP")
 *==================================================================*/
#define kbd_base     0x30050000u
#define kbd_ctrl     (*(volatile unsigned int *)(kbd_base + 0x00))
#define kbd_status   (*(volatile unsigned int *)(kbd_base + 0x04))
#define kbd_key      (*(volatile unsigned int *)(kbd_base + 0x08))
#define kbd_keymap0  (*(volatile unsigned int *)(kbd_base + 0x0c))
#define kbd_keymap1  (*(volatile unsigned int *)(kbd_base + 0x10))
#define kbd_keymap2  (*(volatile unsigned int *)(kbd_base + 0x14))
#define kbd_keymap3  (*(volatile unsigned int *)(kbd_base + 0x18))
#define kbd_debounce (*(volatile unsigned int *)(kbd_base + 0x1c))
#define kbd_raw      (*(volatile unsigned int *)(kbd_base + 0x20))
#define kbd_version  (*(volatile unsigned int *)(kbd_base + 0x24))

#define KBD_CTRL_EN        (1u << 0)
#define KBD_CTRL_IRQEN     (1u << 1)
#define KBD_CTRL_CLRKEY    (1u << 2)
#define KBD_ST_KEYVALID    (1u << 0)
#define KBD_ST_PRESSED     (1u << 1)
#define KBD_ST_KEYVAL(k)   (((k) >> 4)  & 0xFu)
#define KBD_ST_DEBCNT(k)   (((k) >> 8)  & 0xFFu)
#define KBD_ST_OVF         (1u << 16)

#define dot_base     0x30070000u
#define dot_ctrl     (*(volatile unsigned int *)(dot_base + 0x00))
#define dot_char     (*(volatile unsigned int *)(dot_base + 0x04))
#define dot_rowdiv   (*(volatile unsigned int *)(dot_base + 0x08))
#define dot_ram0     (*(volatile unsigned int *)(dot_base + 0x0c))
#define dot_ram1     (*(volatile unsigned int *)(dot_base + 0x10))
#define dot_shift    (*(volatile unsigned int *)(dot_base + 0x14))
#define dot_status   (*(volatile unsigned int *)(dot_base + 0x18))
#define dot_version  (*(volatile unsigned int *)(dot_base + 0x1c))

#define DOT_CTRL_EN        (1u << 0)
#define DOT_CTRL_BLINK     (1u << 1)
#define DOT_CTRL_BRIGHT(n) (((unsigned)(n) & 0x7u) << 2)
#define DOT_MODE_CHAR      (0u << 5)
#define DOT_MODE_GRAPH     (1u << 5)
#define DOT_MODE_SCROLL    (2u << 5)
#define DOT_ST_BUSY        (1u << 0)
#define DOT_ST_ROW(s)      (((s) >> 1) & 0x3u)      /* RTL: {15'd0,frame[7:0],5'd0,row,busy} */
#define DOT_ST_FRAME(s)    (((s) >> 8) & 0xFFu)

#define touchm_base     0x30060000u
#define touchm_ctrl     (*(volatile unsigned int *)(touchm_base + 0x00))
#define touchm_interval (*(volatile unsigned int *)(touchm_base + 0x04))
#define touchm_data     (*(volatile unsigned int *)(touchm_base + 0x08))
#define touchm_num      (*(volatile unsigned int *)(touchm_base + 0x0c))
#define touchm_status   (*(volatile unsigned int *)(touchm_base + 0x10))
#define touchm_maxpoint (*(volatile unsigned int *)(touchm_base + 0x14))
#define touchm_version  (*(volatile unsigned int *)(touchm_base + 0x18))

#define TOUCHM_CTRL_EN      (1u << 0)
#define TOUCHM_CTRL_IRQEN   (1u << 1)
#define TOUCHM_CTRL_MULTI   (1u << 2)
#define TOUCHM_CTRL_CLRFIFO (1u << 3)
#define TOUCHM_ST_EMPTY     (1u << 0)
#define TOUCHM_ST_FULL      (1u << 1)
#define TOUCHM_ST_FRAME     (1u << 8)
#define TOUCHM_EMPTY_DATA   0xFFFFFFFFu
#define TOUCHM_REC_ID(r)    (((r) >> 28) & 0xFu)
#define TOUCHM_REC_X(r)     (((r) >> 14) & 0x3FFFu)
#define TOUCHM_REC_Y(r)     ((r) & 0x3FFFu)

#define spis_base     0x300a0000u
#define spis_ctrl     (*(volatile unsigned int *)(spis_base + 0x00))
#define spis_div      (*(volatile unsigned int *)(spis_base + 0x04))
#define spis_data     (*(volatile unsigned int *)(spis_base + 0x08))
#define spis_status   (*(volatile unsigned int *)(spis_base + 0x0c))
#define spis_cnt      (*(volatile unsigned int *)(spis_base + 0x10))
#define spis_ch       (*(volatile unsigned int *)(spis_base + 0x14))
#define spis_lvl      (*(volatile unsigned int *)(spis_base + 0x18))
#define spis_version  (*(volatile unsigned int *)(spis_base + 0x1c))

#define SPIS_CTRL_EN        (1u << 0)
#define SPIS_CTRL_DA        (1u << 1)
#define SPIS_CTRL_IRQEN     (1u << 2)
#define SPIS_CTRL_LOOP      (1u << 3)
#define SPIS_ST_RX_NE       (1u << 0)
#define SPIS_ST_RX_HALF     (1u << 1)
#define SPIS_ST_RX_FULL     (1u << 2)
#define SPIS_ST_TX_EMPTY    (1u << 3)
#define SPIS_ST_TX_FULL     (1u << 4)
#define SPIS_ST_BUSY        (1u << 5)
#define SPIS_ST_RXLVL(s)    ((s) & 0xFFu)
#define SPIS_ST_TXLVL(s)    (((s) >> 8) & 0xFFu)
#define SPIS_EMPTY_DATA     0xFFFFFFFFu

#endif /* _MAIN_H_ */
