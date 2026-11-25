/**
 * @file    axi_dma.c
 * @brief   AXI DMA 控制器驱动实现
 *          配套 RTL : hw/peripheral/axi_dma/axi_dma.v
 *
 *  RTL 的搬运方向是"源地址自增 -> 目的地址自增"的等长拷贝,
 *  没有"目的固定/源固定"模式。填充(memset)通过
 *  「DDR 里的重复图案缓冲 + 分块拷贝」实现。
 */

#include "axi_dma.h"

#define DMA_REG(off)    (*(__IO uint32_t *)(AXI_DMA_ADDR(off)))
#define DMA_REG_RO(off) (*(__I  uint32_t *)(AXI_DMA_ADDR(off)))

/*--------------------------------------------------------------------
 * 填充用的重复图案缓冲 (放在 DDR3 里, 避开显存)
 *   默认值与说明见 axi_dma.h 的 AXI_DMA_MEMSET_BUF / _CHUNK
 *   s_pat_* 是这块缓冲的内容缓存, 见 axi_dma_memset()
 *------------------------------------------------------------------*/
static uint32_t s_pat_value  = 0u;
static int      s_pat_valid  = 0;

uint32_t axi_dma_read(uint32_t off)
{
    return *(__I uint32_t *)(AXI_DMA_ADDR(off));
}

void axi_dma_write(uint32_t off, uint32_t val)
{
    DMA_REG(off) = val;
}

uint32_t axi_dma_get_version(void)
{
    return axi_dma_read(AXI_DMA_REG_VER);
}

uint32_t axi_dma_get_status(void)
{
    return axi_dma_read(AXI_DMA_REG_STAT);
}

int axi_dma_is_busy(void)
{
    return (axi_dma_get_status() & AXI_DMA_ST_BUSY) ? 1 : 0;
}

uint32_t axi_dma_get_done_bytes(void)
{
    return axi_dma_read(AXI_DMA_REG_DONE);
}

void axi_dma_clear_flags(void)
{
    DMA_REG(AXI_DMA_REG_STAT) = (AXI_DMA_ST_DONE | AXI_DMA_ST_ERROR);
}

int axi_dma_config(uint32_t src, uint32_t dst, uint32_t len,
                   uint32_t dtype, uint32_t int_en)
{
    uint32_t width = AXI_DMA_DTYPE_BYTES(dtype);
    uint32_t ctrl;

    /* 与 RTL 一致的前置校验 */
    if (len == 0u || dtype > AXI_DMA_DTYPE_WORD) {
        return AXI_DMA_ERR_PARAM;
    }
    if ((src & (width - 1u)) != 0u || (dst & (width - 1u)) != 0u ||
        (len & (width - 1u)) != 0u) {
        return AXI_DMA_ERR_PARAM;
    }
    if (axi_dma_is_busy()) {
        return AXI_DMA_ERR_PARAM;
    }

    DMA_REG(AXI_DMA_REG_SRC) = src;
    DMA_REG(AXI_DMA_REG_DST) = dst;
    DMA_REG(AXI_DMA_REG_LEN) = len;

    ctrl  = ((dtype  << AXI_DMA_CTRL_DTYPE_POS) & AXI_DMA_CTRL_DTYPE_MSK);
    if (int_en) {
        ctrl |= AXI_DMA_CTRL_INT_EN;
    }
    DMA_REG(AXI_DMA_REG_CTRL) = ctrl;

    return AXI_DMA_OK;
}

void axi_dma_start(void)
{
    axi_dma_clear_flags();
    DMA_REG(AXI_DMA_REG_START) = AXI_DMA_START;      /* 自清 */
}

void axi_dma_abort(void)
{
    DMA_REG(AXI_DMA_REG_START) = AXI_DMA_ABORT;      /* 自清 */
}

int axi_dma_wait(uint32_t timeout)
{
    uint32_t st;

    if (timeout == 0u) {
        do {
            st = axi_dma_get_status();
        } while ((st & AXI_DMA_ST_BUSY) != 0u);
    } else {
        do {
            st = axi_dma_get_status();
            if ((st & AXI_DMA_ST_BUSY) == 0u) {
                break;
            }
        } while (timeout-- != 0u);

        if ((st & AXI_DMA_ST_BUSY) != 0u) {
            return AXI_DMA_ERR_TIMEOUT;
        }
    }

    if ((st & AXI_DMA_ST_ERROR) != 0u) {
        axi_dma_clear_flags();
        return AXI_DMA_ERR_PARAM;       /* 硬件参数校验失败 */
    }
    if ((st & AXI_DMA_ST_ABORT) != 0u) {
        return AXI_DMA_ERR_ABORTED;
    }

    return AXI_DMA_OK;
}

int axi_dma_memcpy(uint32_t src, uint32_t dst, uint32_t len, uint32_t dtype)
{
    int rc = axi_dma_config(src, dst, len, dtype, 0);
    if (rc != AXI_DMA_OK) {
        return rc;
    }
    axi_dma_start();
    return axi_dma_wait(0);
}

int axi_dma_memset(uint32_t dst, uint32_t value, uint32_t count)
{
    volatile uint32_t *pat = (volatile uint32_t *)AXI_DMA_MEMSET_BUF;
    const uint32_t chunk_words = AXI_DMA_MEMSET_CHUNK / 4u;
    uint32_t i;
    int rc;

    /* 1) 目的地址与长度必须 32bit 对齐 */
    if ((dst & 3u) != 0u || (count & 3u) != 0u || count == 0u) {
        return AXI_DMA_ERR_PARAM;
    }

    /* 2) 在图案缓冲里铺一份重复值 (只用 CPU 写一次 32KB)
     *    带一级缓存: 连续用同一个 value 填充时 (例如动画里一种底色要连刷
     *    40 步) 就不必每次都重铺 32KB —— 省掉 8192 次 store。
     *    注意: AXI_DMA_MEMSET_BUF 只允许本函数使用; 若别处往那块地址写过
     *    东西, 必须把 s_pat_valid 置 0, 否则会搬到陈旧数据。 */
    if (!s_pat_valid || s_pat_value != value) {
        for (i = 0u; i < chunk_words; i++) {
            pat[i] = value;
        }
        s_pat_value = value;
        s_pat_valid = 1;
    }

    /* 3) 拷到目的地址: 整块用 CHUNK, 剩尾再拷一次 */
    while (count > AXI_DMA_MEMSET_CHUNK) {
        rc = axi_dma_memcpy(AXI_DMA_MEMSET_BUF, dst, AXI_DMA_MEMSET_CHUNK,
                            AXI_DMA_DTYPE_WORD);
        if (rc != AXI_DMA_OK) {
            return rc;
        }
        dst   += AXI_DMA_MEMSET_CHUNK;
        count -= AXI_DMA_MEMSET_CHUNK;
    }

    if (count != 0u) {
        rc = axi_dma_memcpy(AXI_DMA_MEMSET_BUF, dst, count, AXI_DMA_DTYPE_WORD);
        if (rc != AXI_DMA_OK) {
            return rc;
        }
    }

    return AXI_DMA_OK;
}
