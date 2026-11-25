#ifndef _START_H_
#define _START_H_

/******************  CLK CONFIG  ******************/
#define BSS_BASE            (0x80000000)
#define DATA_BASE           (0x80001000)
#define SP_BASE             (0x80003000-132)
#define REGS_MEM          (0x80003000) //first use in REGS_MEM-4

#define CACHE_OP          (0xfff1ffff)
#define ADDR_MAP          (0x76503210)

#define INT_VECTOR        (0xbbc)
#define INTC_VECTOR       (0x40)


#endif /* _START_H_ */
