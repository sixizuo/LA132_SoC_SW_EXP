#include "regdef.h"
#include "csrdef.h"
#include "tools-asm.h"
#include "start.h"

/* start address for the initialization values of the .data section. defined in ld.script */
.word  _sidata
/* start address for the .data section. defined in ld.script */
.word  _sdata
/* end address for the .data section. defined in ld.script */
.word  _edata
/* start address for the .bss section. defined in ld.script */
.word  _sbss
/* end address for the .bss section. defined in ld.script */
.word  _ebss

.globl _RAM_BSS
_RAM_BSS = BSS_BASE
.globl _RAM_DATA
_RAM_DATA = DATA_BASE

.section .text._start # begin code segment
.weak _start
.type _start, %function
.globl _start

_start:
        move     t1 , zero
        b    LoopCopyDataInit
CopyDataInit:
        la.abs   t3, _sidata
        add.w    t4, t3, t1
        ld.w     t3, t4, 0x0
        add.w    t4, t0, t1
        st.w     t3, t4, 0x0
        addi.w   t1, t1, 0x4
LoopCopyDataInit:
        la.abs   t0, _sdata
        la.abs   t3, _edata
        add.w    t2, t0, t1
        bne      t2, t3, CopyDataInit

        la.abs   t0, _sbss
        la.abs   t1, _ebss
        beq      t1, t0, cpu_init_start
LoopFillZerobss:
        st.w     zero, t0, 0
        addi.w   t0, t0, 4
        bne t1,  t0, LoopFillZerobss

# set up basic system function

cpu_init_start:
### reset normal exception base and Ex config
        li.w      t0, 0x1c001000
        csrwr     t0, CSR_EBase
        li.w      t0, (0<<S_CSR_ExConfig_VS)|(0x0000<<S_CSR_ExConfig_IM) # 4 instruction gap
        csrwr     t0, CSR_ExConfig
        #set int masks
        li.w      t0, 0x1fff
        csrxchg   t0, t0, CSR_ExConfig
    ##set VSEG4(0x80000000~0x9fffffff) to cached, other VSEG to uncached
        li.w      t0, CACHE_OP
        csrwr     t0, CSR_SEGCA
    ##set VSEG4(0x80000000~0x9fffffff) to PSEG0(0x00000000~0x1fffffff), other VSEG unchanged
        li.w      t0, ADDR_MAP
        csrwr     t0, CSR_SEGPA
    ##set DA=0(change DA-mode to AD-mode)
        li.w      t0, 0x8
        csrxchg   zero, t0, CSR_CRMD
        li.w      sp, SP_BASE
        bl        main
        jirl      zero, ra, 0

    .org        0x1000
irq_entry:
    SAVE_REGS_FAST(REGS_MEM)

gpio_irq:
    li.w        a0, 0x30000000
    ld.w        t0, a0, 0x2c

    li.w        a1, 0x10000
    and         t1, t0, a1
    bnez        t1, gpio32_irq

    li.w        a1, 0x20000
    and         t1, t0, a1
    bnez        t1, gpio33_irq

    li.w        a1, 0x40000
    and         t1, t0, a1
    bnez        t1, gpio34_irq

    li.w        a1, 0x80000
    and         t1, t0, a1
    bnez        t1, gpio35_irq

intc_irq:
    li.w        a0, 0x30020000
    ld.w        t0, a0, 0x14            /* INT_OUT, 2026-11-23 起是 16 位 */
    li.w        a1, 0x0000ffff
    and         t0, t0, a1
    beq         t0, zero, irq_exit

    /* 从低位起找第一个挂起的线: a0 = 0..15
     * 用循环而不是 16 段 andi/bnez, 一是代码短, 二是后面若把
     * INT_NUM 再改成 32 只需要把上面的 0xffff 改掉。 */
    move        a0, zero
intc_irq_find:
    andi        t1, t0, 1
    bnez        t1, intc_irq_hit
    srli.w      t0, t0, 1
    addi.w      a0, a0, 1
    b           intc_irq_find

intc_irq_hit:
    beq         a0, zero, intc_irq_0
    b           intc_irq_call

intc_irq_call:
    bl          intc_irq_dispatch
    b           irq_exit

gpio32_irq:
    //bl          gpio32_handler
    b           irq_exit

gpio33_irq:
    //bl          gpio33_handler
    b           irq_exit

gpio34_irq:
    //bl          gpio34_handler
    b           irq_exit

gpio35_irq:
    //bl          gpio35_handler
    b           irq_exit

/*--------------------------------------------------------------------
 *  INTC 16 根线的分派 (2026-11-23 改)
 *    intc_irq_0 (UART) 仍然直接调 uart_handler —— 它是电平中断,
 *    必须无条件把接收 FIFO 读空, 不能指望某个 demo 去挂。
 *    intc_irq_1~15 统一走 intc_irq_dispatch(n):
 *    具体处理函数由 demo 用 intc_irq_attach(n, fn) 运行期挂上,
 *    这样多个 demo 里用到同一条线也不会符号重名,
 *    换 demo 也不必再改这个文件。
 *  a0 = 中断号, SAVE_REGS_FAST 已经保存/恢复 a0, 不会破坏现场。
 *
 *  16 路中断源分配见教材表 11-7:
 *    int_8 AXI-DMAC  int_9 USB  int_10 AXI-LCD 帧结束
 *    int_11 矩阵键盘 int_12 点阵帧同步 int_13 SPI 流 FIFO
 *    int_14/15 软件强制 (只靠 INT_SET)
 *------------------------------------------------------------------*/
intc_irq_0:
    bl          uart_handler
    b           irq_exit

irq_exit:
    RESTORE_REGS_FAST(REGS_MEM)
    ertn
