/**
 * @file    axi_lcd.c
 * @brief   AXI LCD 控制器驱动实现
 *          配套 RTL : hw/peripheral/axi_lcd/axi_lcd.v
 *
 *  注意: AXI 从设备寄存器只支持单拍访问, CPU 逐字读写即可, 无需 burst。
 */

#include "axi_lcd.h"

#define LCD_REG(off)   (*(__IO uint32_t *)(AXI_LCD_ADDR(off)))
#define LCD_REG_RO(off) (*(__I  uint32_t *)(AXI_LCD_ADDR(off)))

/* 供上层驱动 (如 DMA memset) 复用的显存基址缓存 */
static uint32_t s_fb_base = 0;

uint32_t axi_lcd_read(uint32_t off)
{
    return *(__I uint32_t *)(AXI_LCD_ADDR(off));
}

void axi_lcd_write(uint32_t off, uint32_t val)
{
    LCD_REG(off) = val;
}

void axi_lcd_reset(void)
{
    LCD_REG(AXI_LCD_REG_CTRL) = AXI_LCD_CTRL_SWRST;   /* 自清 */
    s_fb_base = 0;
}

int axi_lcd_probe(void)
{
    if ((axi_lcd_read(AXI_LCD_REG_ID) & 0xFFFFu) != AXI_LCD_ID_EXPECT) {
        return -1;
    }
    if (axi_lcd_read(AXI_LCD_REG_RES) != ((AXI_LCD_WIDTH << 16) | AXI_LCD_HEIGHT)) {
        return -1;
    }
    return 0;
}

void axi_lcd_set_fb(uint32_t fb_base)
{
    /* 与 RTL 一致: 硬件会再强制 64B 对齐, 这里先软件对齐便于比较 */
    s_fb_base = fb_base & ~0x3Fu;
    LCD_REG(AXI_LCD_REG_BUF) = s_fb_base;
}

void axi_lcd_set_fmt(uint32_t fmt)
{
    uint32_t ctrl = LCD_REG_RO(AXI_LCD_REG_CTRL);
    ctrl &= ~AXI_LCD_CTRL_FMT_MSK;
    ctrl |= ((fmt << AXI_LCD_CTRL_FMT_POS) & AXI_LCD_CTRL_FMT_MSK);
    LCD_REG(AXI_LCD_REG_CTRL) = ctrl;
}

void axi_lcd_set_prefill_thresh(uint32_t thresh)
{
    uint32_t ctrl = LCD_REG_RO(AXI_LCD_REG_CTRL);
    ctrl &= ~AXI_LCD_CTRL_PFT_MSK;
    ctrl |= ((thresh << AXI_LCD_CTRL_PFT_POS) & AXI_LCD_CTRL_PFT_MSK);
    LCD_REG(AXI_LCD_REG_CTRL) = ctrl;
}

void axi_lcd_start(void)
{
    uint32_t ctrl = LCD_REG_RO(AXI_LCD_REG_CTRL);
    ctrl |= (AXI_LCD_CTRL_EN | AXI_LCD_CTRL_GO);
    LCD_REG(AXI_LCD_REG_CTRL) = ctrl;
}

void axi_lcd_stop(void)
{
    uint32_t ctrl = LCD_REG_RO(AXI_LCD_REG_CTRL);
    ctrl &= ~AXI_LCD_CTRL_EN;
    LCD_REG(AXI_LCD_REG_CTRL) = ctrl;
}

uint32_t axi_lcd_get_status(void)
{
    return axi_lcd_read(AXI_LCD_REG_STATUS);
}

void axi_lcd_clear_status(void)
{
    /* 写 1 清零 FRAME / UNDERRUN */
    LCD_REG(AXI_LCD_REG_STATUS) = (AXI_LCD_ST_FRAME | AXI_LCD_ST_UNDERRUN);
}

uint32_t axi_lcd_get_fill_level(void)
{
    return (axi_lcd_get_status() & AXI_LCD_ST_FILL_MSK) >> AXI_LCD_ST_FILL_POS;
}

uint32_t axi_lcd_get_fb_bytes(void)
{
    return axi_lcd_read(AXI_LCD_REG_FBSIZE);
}

uint32_t axi_lcd_get_res(void)
{
    return axi_lcd_read(AXI_LCD_REG_RES);
}

int axi_lcd_wait_frame(uint32_t timeout)
{
    if (timeout == 0u) {
        while ((axi_lcd_get_status() & AXI_LCD_ST_FRAME) == 0u) {
            ;
        }
    } else {
        while (timeout-- != 0u) {
            if ((axi_lcd_get_status() & AXI_LCD_ST_FRAME) != 0u) {
                break;
            }
        }
        if ((axi_lcd_get_status() & AXI_LCD_ST_FRAME) == 0u) {
            return -1;
        }
    }
    axi_lcd_clear_status();
    return 0;
}
