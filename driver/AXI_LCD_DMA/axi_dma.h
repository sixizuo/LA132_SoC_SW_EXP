/**
 * @file    axi_dma.h
 * @brief   AXI DMA 控制器驱动 (LA132 / 云晓 100T)
 *          - DMA 作为 AXI 主设备在 DDR3 内搬运数据
 *          - DMA 作为 AXI 从设备提供配置寄存器
 *          - 可配置: 源地址 / 目的地址 / 数据类型 / 传输字节数
 *
 *  基址 : 0x4001_0000  (AXI 从设备 S1, 64KB)
 *         !! 新地址 —— 既不是原 APB DMA 的 0x510E_0000, 也不是早期的
 *            0x3000_0000 (那个地址落在 DDR 512MB 窗口 0x2000_0000 ~
 *            0x3FFF_FFFF 之内, 会被 DDR 译码吞掉) !!
 *         原 APB DMA 控制器 (driver/DMA/dma.h) 仍然保留, 与之互不干扰
 *
 *  配套 RTL : hw/peripheral/axi_dma/axi_dma.v
 *
 *  !! 与旧 APB DMA (driver/DMA/dma.h) 寄存器布局不同 !!
 *     旧: src/dst/number_of_words/control/status
 *     新: src/dst/len(字节)/start/ctrl/stat/done/ver
 */

#ifndef _AXI_DMA_H_
#define _AXI_DMA_H_

#include "test.h"

#ifdef __cplusplus
extern "C" {
#endif

/*--------------------------------------------------------------------
 * 基址与寄存器偏移 (字偏移)
 *------------------------------------------------------------------*/
#define AXI_DMA_BASE            0x20010000u

#define AXI_DMA_REG_SRC         0x00u   /* R/W 源地址 (字节) */
#define AXI_DMA_REG_DST         0x04u   /* R/W 目的地址 (字节) */
#define AXI_DMA_REG_LEN         0x08u   /* R/W 传输字节数 */
#define AXI_DMA_REG_START       0x0Cu   /* W   [0]START(自清) [1]ABORT(自清) */
#define AXI_DMA_REG_CTRL        0x10u   /* R/W [1:0]DTYPE [8]INT_EN */
#define AXI_DMA_REG_STAT        0x14u   /* R/W1C [0]BUSY [1]DONE [2]ERROR [3]ABORT */
#define AXI_DMA_REG_DONE        0x18u   /* R   已传输字节数 */
#define AXI_DMA_REG_VER         0x1Cu   /* R   版本 = 0x4158444D ("AXDM") */

#define AXI_DMA_ADDR(off)       (AXI_DMA_BASE + (off))

/*--------------------------------------------------------------------
 * REG_START 位域
 *------------------------------------------------------------------*/
#define AXI_DMA_START           (1u << 0)
#define AXI_DMA_ABORT           (1u << 1)

/*--------------------------------------------------------------------
 * REG_CTRL 位域
 *------------------------------------------------------------------*/
#define AXI_DMA_CTRL_DTYPE_POS  0u
#define AXI_DMA_CTRL_DTYPE_MSK  (3u << 0)
#define AXI_DMA_CTRL_INT_EN     (1u << 8)

/* 数据类型 (REG_CTRL[1:0]) */
#define AXI_DMA_DTYPE_BYTE      0u      /* 8  bit */
#define AXI_DMA_DTYPE_HALF      1u      /* 16 bit */
#define AXI_DMA_DTYPE_WORD      2u      /* 32 bit */
#define AXI_DMA_DTYPE_BYTES(dt) (1u << (dt))    /* 1 / 2 / 4 */

/*--------------------------------------------------------------------
 * REG_STAT 位域
 *------------------------------------------------------------------*/
#define AXI_DMA_ST_BUSY         (1u << 0)
#define AXI_DMA_ST_DONE         (1u << 1)   /* W1C */
#define AXI_DMA_ST_ERROR        (1u << 2)   /* W1C */
#define AXI_DMA_ST_ABORT        (1u << 3)

#define AXI_DMA_VER_EXPECT      0x4158444Du     /* "AXDM" */

/*--------------------------------------------------------------------
 * 填充(memset)用的重复图案缓冲 —— 必须放在 DDR 里且避开显存
 *   显存一帧 = 800*480*4 = 1 536 000 字节 = 0x17_7000
 *   若显存在 0x2000_0000, 则显存占用 0x2000_0000 ~ 0x2017_6FFF
 *   默认图案缓冲放在 0x2040_0000 (DDR + 4MB), 安全。
 *   可在包含本头文件前重新定义以覆盖。
 *------------------------------------------------------------------*/
#ifndef AXI_DMA_MEMSET_BUF
#define AXI_DMA_MEMSET_BUF      0x40400000u
#endif

#ifndef AXI_DMA_MEMSET_CHUNK
#define AXI_DMA_MEMSET_CHUNK    32768u      /* 32 KB, 必须是 4 的倍数 */
#endif

/*--------------------------------------------------------------------
 * 返回值
 *------------------------------------------------------------------*/
#define AXI_DMA_OK              0
#define AXI_DMA_ERR_PARAM      (-1)     /* 地址/长度未按数据类型对齐, 或长度为 0 */
#define AXI_DMA_ERR_VER        (-2)     /* REG_VER 不匹配 (RTL 未接入?) */
#define AXI_DMA_ERR_TIMEOUT    (-3)
#define AXI_DMA_ERR_ABORTED    (-4)

/*--------------------------------------------------------------------
 * API
 *------------------------------------------------------------------*/

/** 读寄存器 */
uint32_t axi_dma_read(uint32_t off);

/** 写寄存器 */
void     axi_dma_write(uint32_t off, uint32_t val);

/**
 * @brief 读取版本寄存器, 用于确认 AXI DMAC 已正确接入
 * @return AXI_DMA_VER_EXPECT 为正常
 */
uint32_t axi_dma_get_version(void);

/** 读状态寄存器 */
uint32_t axi_dma_get_status(void);

/** 当前是否在搬运中 */
int      axi_dma_is_busy(void);

/** 已传输字节数 */
uint32_t axi_dma_get_done_bytes(void);

/**
 * @brief 配置一次传输 (不启动)
 * @param src   源地址 (字节)
 * @param dst   目的地址 (字节)
 * @param len   传输字节数 (必须能被 数据类型宽度整除)
 * @param dtype AXI_DMA_DTYPE_BYTE / _HALF / _WORD
 * @param int_en 完成中断使能 (0/1)
 * @return AXI_DMA_OK; 参数不合法时返回 AXI_DMA_ERR_PARAM 且不写寄存器
 */
int      axi_dma_config(uint32_t src, uint32_t dst, uint32_t len,
                        uint32_t dtype, uint32_t int_en);

/** 启动已配置的传输 (写 REG_START.START) */
void     axi_dma_start(void);

/** 中止当前传输 (写 REG_START.ABORT), 硬件在批次边界安全停止 */
void     axi_dma_abort(void);

/** 清除 DONE / ERROR 标志 (W1C) */
void     axi_dma_clear_flags(void);

/**
 * @brief 等待传输结束 (BUSY 落 0)
 * @param timeout 最大轮询次数, 0 表示不限
 * @return AXI_DMA_OK; 出错返回 AXI_DMA_ERR_TIMEOUT / _ABORTED;
 *         硬件校验失败 (ERROR) 返回 AXI_DMA_ERR_PARAM
 */
int      axi_dma_wait(uint32_t timeout);

/**
 * @brief 阻塞式内存拷贝 (配置 + 启动 + 等待)
 * @return 见 axi_dma_wait()
 */
int      axi_dma_memcpy(uint32_t src, uint32_t dst, uint32_t len, uint32_t dtype);

/**
 * @brief 阻塞式填充: 把 count 字节写成同一个 32bit 值
 * @param dst   目的地址 (必须 4 字节对齐)
 * @param value 32bit 填充值
 * @param count 字节数 (必须 4 字节对齐)
 * @note  硬件没有"固定源地址"模式, 这里先用 CPU 把 value 写进一小块
 *        临时缓冲, 再用 DMA 从该缓冲搬到目的地址 (利用 64bit 对齐器
 *        的字节移位, 只有 4/8 字节两种模式; 见实现)。
 * @return 见 axi_dma_wait()
 */
int      axi_dma_memset(uint32_t dst, uint32_t value, uint32_t count);

#ifdef __cplusplus
}
#endif

#endif /* _AXI_DMA_H_ */
