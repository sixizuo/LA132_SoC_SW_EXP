
D:/LA132_SoC_SW_EXP/build/la132_demo.elf:     file format elf32-loongarch
D:/LA132_SoC_SW_EXP/build/la132_demo.elf


Disassembly of section .text:

1c000000 <_start>:
_start():
D:/LA132_SoC_SW_EXP/user/start.S:28
1c000000:	0015000d 	move	$r13,$r0
D:/LA132_SoC_SW_EXP/user/start.S:29
1c000004:	50002000 	b	32(0x20) # 1c000024 <LoopCopyDataInit>

1c000008 <CopyDataInit>:
CopyDataInit():
D:/LA132_SoC_SW_EXP/user/start.S:31
1c000008:	1438004f 	lu12i.w	$r15,114690(0x1c002)
1c00000c:	03b0b1ef 	ori	$r15,$r15,0xc2c
D:/LA132_SoC_SW_EXP/user/start.S:32
1c000010:	001035f0 	add.w	$r16,$r15,$r13
D:/LA132_SoC_SW_EXP/user/start.S:33
1c000014:	2880020f 	ld.w	$r15,$r16,0
D:/LA132_SoC_SW_EXP/user/start.S:34
1c000018:	00103590 	add.w	$r16,$r12,$r13
D:/LA132_SoC_SW_EXP/user/start.S:35
1c00001c:	2980020f 	st.w	$r15,$r16,0
D:/LA132_SoC_SW_EXP/user/start.S:36
1c000020:	028011ad 	addi.w	$r13,$r13,4(0x4)

1c000024 <LoopCopyDataInit>:
LoopCopyDataInit():
D:/LA132_SoC_SW_EXP/user/start.S:38
1c000024:	1500002c 	lu12i.w	$r12,-524287(0x80001)
1c000028:	0380018c 	ori	$r12,$r12,0x0
D:/LA132_SoC_SW_EXP/user/start.S:39
1c00002c:	1500002f 	lu12i.w	$r15,-524287(0x80001)
1c000030:	038011ef 	ori	$r15,$r15,0x4
D:/LA132_SoC_SW_EXP/user/start.S:40
1c000034:	0010358e 	add.w	$r14,$r12,$r13
D:/LA132_SoC_SW_EXP/user/start.S:41
1c000038:	5fffd1cf 	bne	$r14,$r15,-48(0x3ffd0) # 1c000008 <CopyDataInit>
D:/LA132_SoC_SW_EXP/user/start.S:43
1c00003c:	1500000c 	lu12i.w	$r12,-524288(0x80000)
1c000040:	0380018c 	ori	$r12,$r12,0x0
D:/LA132_SoC_SW_EXP/user/start.S:44
1c000044:	1500000d 	lu12i.w	$r13,-524288(0x80000)
1c000048:	038321ad 	ori	$r13,$r13,0xc8
D:/LA132_SoC_SW_EXP/user/start.S:45
1c00004c:	580011ac 	beq	$r13,$r12,16(0x10) # 1c00005c <cpu_init_start>

1c000050 <LoopFillZerobss>:
LoopFillZerobss():
D:/LA132_SoC_SW_EXP/user/start.S:47
1c000050:	29800180 	st.w	$r0,$r12,0
D:/LA132_SoC_SW_EXP/user/start.S:48
1c000054:	0280118c 	addi.w	$r12,$r12,4(0x4)
D:/LA132_SoC_SW_EXP/user/start.S:49
1c000058:	5ffff9ac 	bne	$r13,$r12,-8(0x3fff8) # 1c000050 <LoopFillZerobss>

1c00005c <cpu_init_start>:
cpu_init_start():
D:/LA132_SoC_SW_EXP/user/start.S:55
1c00005c:	1438002c 	lu12i.w	$r12,114689(0x1c001)
D:/LA132_SoC_SW_EXP/user/start.S:56
1c000060:	0400302c 	csrwr	$r12,0xc
D:/LA132_SoC_SW_EXP/user/start.S:57
1c000064:	0015000c 	move	$r12,$r0
D:/LA132_SoC_SW_EXP/user/start.S:58
1c000068:	0400102c 	csrwr	$r12,0x4
D:/LA132_SoC_SW_EXP/user/start.S:60
1c00006c:	1400002c 	lu12i.w	$r12,1(0x1)
1c000070:	03bffd8c 	ori	$r12,$r12,0xfff
D:/LA132_SoC_SW_EXP/user/start.S:61
1c000074:	0400118c 	csrxchg	$r12,$r12,0x4
D:/LA132_SoC_SW_EXP/user/start.S:63
1c000078:	15ffe3ec 	lu12i.w	$r12,-225(0xfff1f)
1c00007c:	03bffd8c 	ori	$r12,$r12,0xfff
D:/LA132_SoC_SW_EXP/user/start.S:64
1c000080:	0406442c 	csrwr	$r12,0x191
D:/LA132_SoC_SW_EXP/user/start.S:66
1c000084:	14eca06c 	lu12i.w	$r12,484611(0x76503)
1c000088:	0388418c 	ori	$r12,$r12,0x210
D:/LA132_SoC_SW_EXP/user/start.S:67
1c00008c:	0406402c 	csrwr	$r12,0x190
D:/LA132_SoC_SW_EXP/user/start.S:69
1c000090:	0380200c 	ori	$r12,$r0,0x8
D:/LA132_SoC_SW_EXP/user/start.S:70
1c000094:	04000180 	csrxchg	$r0,$r12,0x0
D:/LA132_SoC_SW_EXP/user/start.S:71
1c000098:	15000043 	lu12i.w	$r3,-524286(0x80002)
1c00009c:	03bdf063 	ori	$r3,$r3,0xf7c
D:/LA132_SoC_SW_EXP/user/start.S:72
1c0000a0:	5426d000 	bl	9936(0x26d0) # 1c002770 <main>
D:/LA132_SoC_SW_EXP/user/start.S:73
1c0000a4:	4c000020 	jirl	$r0,$r1,0
	...

1c001000 <irq_entry>:
irq_entry():
D:/LA132_SoC_SW_EXP/user/start.S:77
1c001000:	0400c435 	csrwr	$r21,0x31
1c001004:	15000075 	lu12i.w	$r21,-524285(0x80003)
1c001008:	29bff2ac 	st.w	$r12,$r21,-4(0xffc)
1c00100c:	29bfe2ad 	st.w	$r13,$r21,-8(0xff8)
1c001010:	29bfd2ae 	st.w	$r14,$r21,-12(0xff4)
1c001014:	29bfc2af 	st.w	$r15,$r21,-16(0xff0)
1c001018:	29bfb2b0 	st.w	$r16,$r21,-20(0xfec)
1c00101c:	29bfa2b1 	st.w	$r17,$r21,-24(0xfe8)
1c001020:	29bf92b2 	st.w	$r18,$r21,-28(0xfe4)
1c001024:	29bf82b3 	st.w	$r19,$r21,-32(0xfe0)
1c001028:	29bf72b4 	st.w	$r20,$r21,-36(0xfdc)
1c00102c:	29bed2a4 	st.w	$r4,$r21,-76(0xfb4)
1c001030:	29bec2a5 	st.w	$r5,$r21,-80(0xfb0)
1c001034:	29beb2a6 	st.w	$r6,$r21,-84(0xfac)
1c001038:	29bea2a7 	st.w	$r7,$r21,-88(0xfa8)
1c00103c:	29be92a8 	st.w	$r8,$r21,-92(0xfa4)
1c001040:	29be82a9 	st.w	$r9,$r21,-96(0xfa0)
1c001044:	29be72aa 	st.w	$r10,$r21,-100(0xf9c)
1c001048:	29be62ab 	st.w	$r11,$r21,-104(0xf98)
1c00104c:	29be52a1 	st.w	$r1,$r21,-108(0xf94)
1c001050:	29be42a3 	st.w	$r3,$r21,-112(0xf90)

1c001054 <gpio_irq>:
gpio_irq():
D:/LA132_SoC_SW_EXP/user/start.S:80
1c001054:	14600004 	lu12i.w	$r4,196608(0x30000)
D:/LA132_SoC_SW_EXP/user/start.S:81
1c001058:	2880b08c 	ld.w	$r12,$r4,44(0x2c)
D:/LA132_SoC_SW_EXP/user/start.S:83
1c00105c:	14000205 	lu12i.w	$r5,16(0x10)
D:/LA132_SoC_SW_EXP/user/start.S:84
1c001060:	0014958d 	and	$r13,$r12,$r5
D:/LA132_SoC_SW_EXP/user/start.S:85
1c001064:	440069a0 	bnez	$r13,104(0x68) # 1c0010cc <gpio32_irq>
D:/LA132_SoC_SW_EXP/user/start.S:87
1c001068:	14000405 	lu12i.w	$r5,32(0x20)
D:/LA132_SoC_SW_EXP/user/start.S:88
1c00106c:	0014958d 	and	$r13,$r12,$r5
D:/LA132_SoC_SW_EXP/user/start.S:89
1c001070:	440061a0 	bnez	$r13,96(0x60) # 1c0010d0 <gpio33_irq>
D:/LA132_SoC_SW_EXP/user/start.S:91
1c001074:	14000805 	lu12i.w	$r5,64(0x40)
D:/LA132_SoC_SW_EXP/user/start.S:92
1c001078:	0014958d 	and	$r13,$r12,$r5
D:/LA132_SoC_SW_EXP/user/start.S:93
1c00107c:	440059a0 	bnez	$r13,88(0x58) # 1c0010d4 <gpio34_irq>
D:/LA132_SoC_SW_EXP/user/start.S:95
1c001080:	14001005 	lu12i.w	$r5,128(0x80)
D:/LA132_SoC_SW_EXP/user/start.S:96
1c001084:	0014958d 	and	$r13,$r12,$r5
D:/LA132_SoC_SW_EXP/user/start.S:97
1c001088:	440051a0 	bnez	$r13,80(0x50) # 1c0010d8 <gpio35_irq>

1c00108c <intc_irq>:
intc_irq():
D:/LA132_SoC_SW_EXP/user/start.S:100
1c00108c:	14600404 	lu12i.w	$r4,196640(0x30020)
D:/LA132_SoC_SW_EXP/user/start.S:101
1c001090:	2880508c 	ld.w	$r12,$r4,20(0x14)
D:/LA132_SoC_SW_EXP/user/start.S:102
1c001094:	140001e5 	lu12i.w	$r5,15(0xf)
1c001098:	03bffca5 	ori	$r5,$r5,0xfff
D:/LA132_SoC_SW_EXP/user/start.S:103
1c00109c:	0014958c 	and	$r12,$r12,$r5
D:/LA132_SoC_SW_EXP/user/start.S:104
1c0010a0:	58004580 	beq	$r12,$r0,68(0x44) # 1c0010e4 <irq_exit>
D:/LA132_SoC_SW_EXP/user/start.S:109
1c0010a4:	00150004 	move	$r4,$r0

1c0010a8 <intc_irq_find>:
intc_irq_find():
D:/LA132_SoC_SW_EXP/user/start.S:111
1c0010a8:	0340058d 	andi	$r13,$r12,0x1
D:/LA132_SoC_SW_EXP/user/start.S:112
1c0010ac:	440011a0 	bnez	$r13,16(0x10) # 1c0010bc <intc_irq_hit>
D:/LA132_SoC_SW_EXP/user/start.S:113
1c0010b0:	0044858c 	srli.w	$r12,$r12,0x1
D:/LA132_SoC_SW_EXP/user/start.S:114
1c0010b4:	02800484 	addi.w	$r4,$r4,1(0x1)
D:/LA132_SoC_SW_EXP/user/start.S:115
1c0010b8:	53fff3ff 	b	-16(0xffffff0) # 1c0010a8 <intc_irq_find>

1c0010bc <intc_irq_hit>:
intc_irq_hit():
D:/LA132_SoC_SW_EXP/user/start.S:118
1c0010bc:	58002080 	beq	$r4,$r0,32(0x20) # 1c0010dc <intc_irq_0>
D:/LA132_SoC_SW_EXP/user/start.S:119
1c0010c0:	50000400 	b	4(0x4) # 1c0010c4 <intc_irq_call>

1c0010c4 <intc_irq_call>:
intc_irq_call():
D:/LA132_SoC_SW_EXP/user/start.S:122
1c0010c4:	54178400 	bl	6020(0x1784) # 1c002848 <intc_irq_dispatch>
D:/LA132_SoC_SW_EXP/user/start.S:123
1c0010c8:	50001c00 	b	28(0x1c) # 1c0010e4 <irq_exit>

1c0010cc <gpio32_irq>:
gpio32_irq():
D:/LA132_SoC_SW_EXP/user/start.S:127
1c0010cc:	50001800 	b	24(0x18) # 1c0010e4 <irq_exit>

1c0010d0 <gpio33_irq>:
gpio33_irq():
D:/LA132_SoC_SW_EXP/user/start.S:131
1c0010d0:	50001400 	b	20(0x14) # 1c0010e4 <irq_exit>

1c0010d4 <gpio34_irq>:
gpio34_irq():
D:/LA132_SoC_SW_EXP/user/start.S:135
1c0010d4:	50001000 	b	16(0x10) # 1c0010e4 <irq_exit>

1c0010d8 <gpio35_irq>:
gpio35_irq():
D:/LA132_SoC_SW_EXP/user/start.S:139
1c0010d8:	50000c00 	b	12(0xc) # 1c0010e4 <irq_exit>

1c0010dc <intc_irq_0>:
intc_irq_0():
D:/LA132_SoC_SW_EXP/user/start.S:157
1c0010dc:	5417a400 	bl	6052(0x17a4) # 1c002880 <uart_handler>
D:/LA132_SoC_SW_EXP/user/start.S:158
1c0010e0:	50000400 	b	4(0x4) # 1c0010e4 <irq_exit>

1c0010e4 <irq_exit>:
irq_exit():
D:/LA132_SoC_SW_EXP/user/start.S:161
1c0010e4:	15000075 	lu12i.w	$r21,-524285(0x80003)
1c0010e8:	28bff2ac 	ld.w	$r12,$r21,-4(0xffc)
1c0010ec:	28bfe2ad 	ld.w	$r13,$r21,-8(0xff8)
1c0010f0:	28bfd2ae 	ld.w	$r14,$r21,-12(0xff4)
1c0010f4:	28bfc2af 	ld.w	$r15,$r21,-16(0xff0)
1c0010f8:	28bfb2b0 	ld.w	$r16,$r21,-20(0xfec)
1c0010fc:	28bfa2b1 	ld.w	$r17,$r21,-24(0xfe8)
1c001100:	28bf92b2 	ld.w	$r18,$r21,-28(0xfe4)
1c001104:	28bf82b3 	ld.w	$r19,$r21,-32(0xfe0)
1c001108:	28bf72b4 	ld.w	$r20,$r21,-36(0xfdc)
1c00110c:	28bed2a4 	ld.w	$r4,$r21,-76(0xfb4)
1c001110:	28bec2a5 	ld.w	$r5,$r21,-80(0xfb0)
1c001114:	28beb2a6 	ld.w	$r6,$r21,-84(0xfac)
1c001118:	28bea2a7 	ld.w	$r7,$r21,-88(0xfa8)
1c00111c:	28be92a8 	ld.w	$r8,$r21,-92(0xfa4)
1c001120:	28be82a9 	ld.w	$r9,$r21,-96(0xfa0)
1c001124:	28be72aa 	ld.w	$r10,$r21,-100(0xf9c)
1c001128:	28be62ab 	ld.w	$r11,$r21,-104(0xf98)
1c00112c:	28be52a1 	ld.w	$r1,$r21,-108(0xf94)
1c001130:	28be42a3 	ld.w	$r3,$r21,-112(0xf90)
1c001134:	0400c415 	csrrd	$r21,0x31
D:/LA132_SoC_SW_EXP/user/start.S:162
1c001138:	06483800 	ertn

1c00113c <q_push>:
q_push():
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:55
1c00113c:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001140:	02bb518c 	addi.w	$r12,$r12,-300(0xed4)
1c001144:	2a00018c 	ld.bu	$r12,$r12,0
1c001148:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c00114c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001150:	03403d8c 	andi	$r12,$r12,0xf
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:57
1c001154:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c001158:	02baedad 	addi.w	$r13,$r13,-325(0xebb)
1c00115c:	2a0001ad 	ld.bu	$r13,$r13,0
1c001160:	006781ad 	bstrpick.w	$r13,$r13,0x7,0x0
1c001164:	580029ac 	beq	$r13,$r12,40(0x28) # 1c00118c <q_push+0x50>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:60
1c001168:	1cc7ffef 	pcaddu12i	$r15,409599(0x63fff)
1c00116c:	02baa1ef 	addi.w	$r15,$r15,-344(0xea8)
1c001170:	2a0001ed 	ld.bu	$r13,$r15,0
1c001174:	006781ae 	bstrpick.w	$r14,$r13,0x7,0x0
1c001178:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c00117c:	02ba71ad 	addi.w	$r13,$r13,-356(0xe9c)
1c001180:	001039ad 	add.w	$r13,$r13,$r14
1c001184:	290001a4 	st.b	$r4,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:61
1c001188:	290001ec 	st.b	$r12,$r15,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:62
1c00118c:	4c000020 	jirl	$r0,$r1,0

1c001190 <q_pop>:
q_pop():
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:68
1c001190:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001194:	02ba018c 	addi.w	$r12,$r12,-384(0xe80)
1c001198:	2a00018d 	ld.bu	$r13,$r12,0
1c00119c:	006781ad 	bstrpick.w	$r13,$r13,0x7,0x0
1c0011a0:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c0011a4:	02b9bd8c 	addi.w	$r12,$r12,-401(0xe6f)
1c0011a8:	2a00018c 	ld.bu	$r12,$r12,0
1c0011ac:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0011b0:	580041ac 	beq	$r13,$r12,64(0x40) # 1c0011f0 <q_pop+0x60>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:71
1c0011b4:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c0011b8:	02b96dad 	addi.w	$r13,$r13,-421(0xe5b)
1c0011bc:	2a0001ac 	ld.bu	$r12,$r13,0
1c0011c0:	0067818e 	bstrpick.w	$r14,$r12,0x7,0x0
1c0011c4:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c0011c8:	02b9418c 	addi.w	$r12,$r12,-432(0xe50)
1c0011cc:	0010398c 	add.w	$r12,$r12,$r14
1c0011d0:	2a000184 	ld.bu	$r4,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:72
1c0011d4:	2a0001ac 	ld.bu	$r12,$r13,0
1c0011d8:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0011dc:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0011e0:	03403d8c 	andi	$r12,$r12,0xf
1c0011e4:	290001ac 	st.b	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:73
1c0011e8:	00678084 	bstrpick.w	$r4,$r4,0x7,0x0
1c0011ec:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:69
1c0011f0:	02bffc04 	addi.w	$r4,$r0,-1(0xfff)
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:74
1c0011f4:	4c000020 	jirl	$r0,$r1,0

1c0011f8 <bits_first>:
bits_first():
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:90
1c0011f8:	0015000c 	move	$r12,$r0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:90 (discriminator 1)
1c0011fc:	02803c0d 	addi.w	$r13,$r0,15(0xf)
1c001200:	600019ac 	blt	$r13,$r12,24(0x18) # 1c001218 <bits_first+0x20>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:91
1c001204:	0017b08d 	srl.w	$r13,$r4,$r12
1c001208:	034005ad 	andi	$r13,$r13,0x1
1c00120c:	440011a0 	bnez	$r13,16(0x10) # 1c00121c <bits_first+0x24>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:90 (discriminator 2)
1c001210:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001214:	53ffebff 	b	-24(0xfffffe8) # 1c0011fc <bits_first+0x4>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:95
1c001218:	02bffc0c 	addi.w	$r12,$r0,-1(0xfff)
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:96
1c00121c:	00150184 	move	$r4,$r12
1c001220:	4c000020 	jirl	$r0,$r1,0

1c001224 <kbd_scan_isr>:
kbd_scan_isr():
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:102
1c001224:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001228:	29803061 	st.w	$r1,$r3,12(0xc)
1c00122c:	29802077 	st.w	$r23,$r3,8(0x8)
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:106
1c001230:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c001234:	02b751ad 	addi.w	$r13,$r13,-556(0xdd4)
1c001238:	288001ac 	ld.w	$r12,$r13,0
1c00123c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001240:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:107
1c001244:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c001248:	02b6f1ad 	addi.w	$r13,$r13,-580(0xdbc)
1c00124c:	288001ac 	ld.w	$r12,$r13,0
1c001250:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001254:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:110
1c001258:	14600017 	lu12i.w	$r23,196608(0x30000)
1c00125c:	03811aee 	ori	$r14,$r23,0x46
1c001260:	2a0001cc 	ld.bu	$r12,$r14,0
1c001264:	0343c18d 	andi	$r13,$r12,0xf0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:111
1c001268:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c00126c:	02b6998c 	addi.w	$r12,$r12,-602(0xda6)
1c001270:	2a00018f 	ld.bu	$r15,$r12,0
1c001274:	0280040c 	addi.w	$r12,$r0,1(0x1)
1c001278:	00173d8c 	sll.w	$r12,$r12,$r15
1c00127c:	0014300c 	nor	$r12,$r0,$r12
1c001280:	03403d8c 	andi	$r12,$r12,0xf
1c001284:	001531ac 	or	$r12,$r13,$r12
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:112
1c001288:	290001cc 	st.b	$r12,$r14,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:115
1c00128c:	02801404 	addi.w	$r4,$r0,5(0x5)
1c001290:	54053400 	bl	1332(0x534) # 1c0017c4 <delay_us>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:118
1c001294:	038126f7 	ori	$r23,$r23,0x49
1c001298:	2a0002ef 	ld.bu	$r15,$r23,0
1c00129c:	03403def 	andi	$r15,$r15,0xf
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:119
1c0012a0:	0015000c 	move	$r12,$r0
1c0012a4:	50000c00 	b	12(0xc) # 1c0012b0 <kbd_scan_isr+0x8c>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:119 (discriminator 2)
1c0012a8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0012ac:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:119 (discriminator 1)
1c0012b0:	02800c0d 	addi.w	$r13,$r0,3(0x3)
1c0012b4:	68004dac 	bltu	$r13,$r12,76(0x4c) # 1c001300 <kbd_scan_isr+0xdc>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:120
1c0012b8:	0017b1ed 	srl.w	$r13,$r15,$r12
1c0012bc:	034005ad 	andi	$r13,$r13,0x1
1c0012c0:	47ffe9bf 	bnez	$r13,-24(0x7fffe8) # 1c0012a8 <kbd_scan_isr+0x84>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:121
1c0012c4:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c0012c8:	02b529ad 	addi.w	$r13,$r13,-694(0xd4a)
1c0012cc:	2a0001ae 	ld.bu	$r14,$r13,0
1c0012d0:	006781ce 	bstrpick.w	$r14,$r14,0x7,0x0
1c0012d4:	0004b1ce 	alsl.w	$r14,$r14,$r12,0x2
1c0012d8:	0280040d 	addi.w	$r13,$r0,1(0x1)
1c0012dc:	001739ad 	sll.w	$r13,$r13,$r14
1c0012e0:	006f81ae 	bstrpick.w	$r14,$r13,0xf,0x0
1c0012e4:	1cc7fff0 	pcaddu12i	$r16,409599(0x63fff)
1c0012e8:	02b4a210 	addi.w	$r16,$r16,-728(0xd28)
1c0012ec:	2a40020d 	ld.hu	$r13,$r16,0
1c0012f0:	006f81ad 	bstrpick.w	$r13,$r13,0xf,0x0
1c0012f4:	001539ad 	or	$r13,$r13,$r14
1c0012f8:	2940020d 	st.h	$r13,$r16,0
1c0012fc:	53ffafff 	b	-84(0xfffffac) # 1c0012a8 <kbd_scan_isr+0x84>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:125
1c001300:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c001304:	02b439ad 	addi.w	$r13,$r13,-754(0xd0e)
1c001308:	2a0001ac 	ld.bu	$r12,$r13,0
1c00130c:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001310:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001314:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001318:	290001ac 	st.b	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:126
1c00131c:	2a0001ac 	ld.bu	$r12,$r13,0
1c001320:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001324:	02800c0d 	addi.w	$r13,$r0,3(0x3)
1c001328:	6c0099ac 	bgeu	$r13,$r12,152(0x98) # 1c0013c0 <kbd_scan_isr+0x19c>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:131
1c00132c:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001330:	02b3898c 	addi.w	$r12,$r12,-798(0xce2)
1c001334:	29000180 	st.b	$r0,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:132
1c001338:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c00133c:	02b3518c 	addi.w	$r12,$r12,-812(0xcd4)
1c001340:	2a40018d 	ld.hu	$r13,$r12,0
1c001344:	006f81ae 	bstrpick.w	$r14,$r13,0xf,0x0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:133
1c001348:	29400180 	st.h	$r0,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:135
1c00134c:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001350:	02b2f98c 	addi.w	$r12,$r12,-834(0xcbe)
1c001354:	2a40018c 	ld.hu	$r12,$r12,0
1c001358:	006f818c 	bstrpick.w	$r12,$r12,0xf,0x0
1c00135c:	5800918e 	beq	$r12,$r14,144(0x90) # 1c0013ec <kbd_scan_isr+0x1c8>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:138
1c001360:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001364:	02b2a98c 	addi.w	$r12,$r12,-854(0xcaa)
1c001368:	2940018d 	st.h	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:139
1c00136c:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001370:	02b2758c 	addi.w	$r12,$r12,-867(0xc9d)
1c001374:	29000180 	st.b	$r0,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:143
1c001378:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c00137c:	02b2458c 	addi.w	$r12,$r12,-879(0xc91)
1c001380:	2a00018c 	ld.bu	$r12,$r12,0
1c001384:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001388:	0280180d 	addi.w	$r13,$r0,6(0x6)
1c00138c:	6c0035ac 	bgeu	$r13,$r12,52(0x34) # 1c0013c0 <kbd_scan_isr+0x19c>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:144
1c001390:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001394:	02b1e98c 	addi.w	$r12,$r12,-902(0xc7a)
1c001398:	2a400184 	ld.hu	$r4,$r12,0
1c00139c:	006f8084 	bstrpick.w	$r4,$r4,0xf,0x0
1c0013a0:	57fe5bff 	bl	-424(0xffffe58) # 1c0011f8 <bits_first>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:146
1c0013a4:	60001880 	blt	$r4,$r0,24(0x18) # 1c0013bc <kbd_scan_isr+0x198>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:146 (discriminator 1)
1c0013a8:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c0013ac:	02b1818c 	addi.w	$r12,$r12,-928(0xc60)
1c0013b0:	2a00018c 	ld.bu	$r12,$r12,0
1c0013b4:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0013b8:	40006d80 	beqz	$r12,108(0x6c) # 1c001424 <kbd_scan_isr+0x200>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:149
1c0013bc:	60008480 	blt	$r4,$r0,132(0x84) # 1c001440 <kbd_scan_isr+0x21c>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:155
1c0013c0:	1460060c 	lu12i.w	$r12,196656(0x30030)
1c0013c4:	2880018d 	ld.w	$r13,$r12,0
1c0013c8:	2980018d 	st.w	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:156
1c0013cc:	1460040c 	lu12i.w	$r12,196640(0x30020)
1c0013d0:	0380318c 	ori	$r12,$r12,0xc
1c0013d4:	0280080d 	addi.w	$r13,$r0,2(0x2)
1c0013d8:	2980018d 	st.w	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:157
1c0013dc:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0013e0:	28802077 	ld.w	$r23,$r3,8(0x8)
1c0013e4:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0013e8:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:136
1c0013ec:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c0013f0:	02b0758c 	addi.w	$r12,$r12,-995(0xc1d)
1c0013f4:	2a00018c 	ld.bu	$r12,$r12,0
1c0013f8:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0013fc:	0283fc0d 	addi.w	$r13,$r0,255(0xff)
1c001400:	5bff798d 	beq	$r12,$r13,-136(0x3ff78) # 1c001378 <kbd_scan_isr+0x154>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:136 (discriminator 1)
1c001404:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c001408:	02b015ad 	addi.w	$r13,$r13,-1019(0xc05)
1c00140c:	2a0001ac 	ld.bu	$r12,$r13,0
1c001410:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001414:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001418:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c00141c:	290001ac 	st.b	$r12,$r13,0
1c001420:	53ff5bff 	b	-168(0xfffff58) # 1c001378 <kbd_scan_isr+0x154>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:147
1c001424:	00678084 	bstrpick.w	$r4,$r4,0x7,0x0
1c001428:	57fd17ff 	bl	-748(0xffffd14) # 1c00113c <q_push>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:148
1c00142c:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001430:	02af718c 	addi.w	$r12,$r12,-1060(0xbdc)
1c001434:	0280040d 	addi.w	$r13,$r0,1(0x1)
1c001438:	2900018d 	st.b	$r13,$r12,0
1c00143c:	53ff87ff 	b	-124(0xfffff84) # 1c0013c0 <kbd_scan_isr+0x19c>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:149 (discriminator 1)
1c001440:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001444:	02af218c 	addi.w	$r12,$r12,-1080(0xbc8)
1c001448:	2a00018c 	ld.bu	$r12,$r12,0
1c00144c:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001450:	43ff719f 	beqz	$r12,-144(0x7fff70) # 1c0013c0 <kbd_scan_isr+0x19c>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:150
1c001454:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001458:	02aed18c 	addi.w	$r12,$r12,-1100(0xbb4)
1c00145c:	29000180 	st.b	$r0,$r12,0
1c001460:	53ff63ff 	b	-160(0xfffff60) # 1c0013c0 <kbd_scan_isr+0x19c>

1c001464 <kbd_scan_demo>:
kbd_scan_demo():
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:160
1c001464:	02bf4063 	addi.w	$r3,$r3,-48(0xfd0)
1c001468:	2980b061 	st.w	$r1,$r3,44(0x2c)
1c00146c:	2980a077 	st.w	$r23,$r3,40(0x28)
1c001470:	29809078 	st.w	$r24,$r3,36(0x24)
1c001474:	29808079 	st.w	$r25,$r3,32(0x20)
1c001478:	2980707a 	st.w	$r26,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:164
1c00147c:	02802005 	addi.w	$r5,$r0,8(0x8)
1c001480:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001484:	02928084 	addi.w	$r4,$r4,1184(0x4a0)
1c001488:	54129800 	bl	4760(0x1298) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:166
1c00148c:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001490:	02936084 	addi.w	$r4,$r4,1240(0x4d8)
1c001494:	54128c00 	bl	4748(0x128c) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:169
1c001498:	1460000c 	lu12i.w	$r12,196608(0x30000)
1c00149c:	0381058d 	ori	$r13,$r12,0x41
1c0014a0:	02bffc0e 	addi.w	$r14,$r0,-1(0xfff)
1c0014a4:	290001ae 	st.b	$r14,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:170
1c0014a8:	0381098d 	ori	$r13,$r12,0x42
1c0014ac:	290001a0 	st.b	$r0,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:171
1c0014b0:	0381198c 	ori	$r12,$r12,0x46
1c0014b4:	02803c0d 	addi.w	$r13,$r0,15(0xf)
1c0014b8:	2900018d 	st.b	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:173
1c0014bc:	54017000 	bl	368(0x170) # 1c00162c <seg7_init>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:175
1c0014c0:	54134000 	bl	4928(0x1340) # 1c002800 <intc_irq_init>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:176
1c0014c4:	1460040c 	lu12i.w	$r12,196640(0x30020)
1c0014c8:	0280080d 	addi.w	$r13,$r0,2(0x2)
1c0014cc:	2980018d 	st.w	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:177
1c0014d0:	0380118e 	ori	$r14,$r12,0x4
1c0014d4:	298001cd 	st.w	$r13,$r14,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:178
1c0014d8:	0380218c 	ori	$r12,$r12,0x8
1c0014dc:	29800180 	st.w	$r0,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:179
1c0014e0:	1c000005 	pcaddu12i	$r5,0
1c0014e4:	02b510a5 	addi.w	$r5,$r5,-700(0xd44)
1c0014e8:	02800404 	addi.w	$r4,$r0,1(0x1)
1c0014ec:	54134000 	bl	4928(0x1340) # 1c00282c <intc_irq_attach>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:181
1c0014f0:	1460060c 	lu12i.w	$r12,196656(0x30030)
1c0014f4:	0280180d 	addi.w	$r13,$r0,6(0x6)
1c0014f8:	2980018d 	st.w	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:182
1c0014fc:	0380118d 	ori	$r13,$r12,0x4
1c001500:	298001a0 	st.w	$r0,$r13,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:183
1c001504:	0380218e 	ori	$r14,$r12,0x8
1c001508:	140000ed 	lu12i.w	$r13,7(0x7)
1c00150c:	03b401ad 	ori	$r13,$r13,0xd00
1c001510:	298001cd 	st.w	$r13,$r14,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:184
1c001514:	0380318e 	ori	$r14,$r12,0xc
1c001518:	298001cd 	st.w	$r13,$r14,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:185
1c00151c:	2880018d 	ld.w	$r13,$r12,0
1c001520:	038005ad 	ori	$r13,$r13,0x1
1c001524:	2980018d 	st.w	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:162
1c001528:	0015001a 	move	$r26,$r0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:161
1c00152c:	00150018 	move	$r24,$r0
1c001530:	50001c00 	b	28(0x1c) # 1c00154c <kbd_scan_demo+0xe8>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:200
1c001534:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001538:	02ab318c 	addi.w	$r12,$r12,-1332(0xacc)
1c00153c:	2880018c 	ld.w	$r12,$r12,0
1c001540:	0011618c 	sub.w	$r12,$r12,$r24
1c001544:	028f9c0d 	addi.w	$r13,$r0,999(0x3e7)
1c001548:	680051ac 	bltu	$r13,$r12,80(0x50) # 1c001598 <kbd_scan_demo+0x134>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:188
1c00154c:	57fc47ff 	bl	-956(0xffffc44) # 1c001190 <q_pop>
1c001550:	00150097 	move	$r23,$r4
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:190
1c001554:	63ffe080 	blt	$r4,$r0,-32(0x3ffe0) # 1c001534 <kbd_scan_demo+0xd0>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:192
1c001558:	1c00002c 	pcaddu12i	$r12,1(0x1)
1c00155c:	0291d18c 	addi.w	$r12,$r12,1140(0x474)
1c001560:	0010118c 	add.w	$r12,$r12,$r4
1c001564:	28000199 	ld.b	$r25,$r12,0
1c001568:	29003079 	st.b	$r25,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:193
1c00156c:	29003460 	st.b	$r0,$r3,13(0xd)
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:194
1c001570:	02800405 	addi.w	$r5,$r0,1(0x1)
1c001574:	02803064 	addi.w	$r4,$r3,12(0xc)
1c001578:	5400e400 	bl	228(0xe4) # 1c00165c <seg7_set_chars>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:195
1c00157c:	00150326 	move	$r6,$r25
1c001580:	001502e5 	move	$r5,$r23
1c001584:	1c000024 	pcaddu12i	$r4,1(0x1)
1c001588:	02907084 	addi.w	$r4,$r4,1052(0x41c)
1c00158c:	54119400 	bl	4500(0x1194) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:196
1c001590:	0280075a 	addi.w	$r26,$r26,1(0x1)
1c001594:	53ffa3ff 	b	-96(0xfffffa0) # 1c001534 <kbd_scan_demo+0xd0>
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:201
1c001598:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c00159c:	02a9a18c 	addi.w	$r12,$r12,-1432(0xa68)
1c0015a0:	28800198 	ld.w	$r24,$r12,0
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:202
1c0015a4:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c0015a8:	02a9818c 	addi.w	$r12,$r12,-1440(0xa60)
1c0015ac:	28800186 	ld.w	$r6,$r12,0
1c0015b0:	00150345 	move	$r5,$r26
1c0015b4:	1c000024 	pcaddu12i	$r4,1(0x1)
1c0015b8:	028ff084 	addi.w	$r4,$r4,1020(0x3fc)
1c0015bc:	54116400 	bl	4452(0x1164) # 1c002720 <printf>
1c0015c0:	53ff8fff 	b	-116(0xfffff8c) # 1c00154c <kbd_scan_demo+0xe8>

1c0015c4 <char_to_segcode>:
char_to_segcode():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:48
1c0015c4:	0067808d 	bstrpick.w	$r13,$r4,0x7,0x0
1c0015c8:	02bf41ac 	addi.w	$r12,$r13,-48(0xfd0)
1c0015cc:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0015d0:	0280240e 	addi.w	$r14,$r0,9(0x9)
1c0015d4:	6c0031cc 	bgeu	$r14,$r12,48(0x30) # 1c001604 <char_to_segcode+0x40>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:49
1c0015d8:	02befdac 	addi.w	$r12,$r13,-65(0xfbf)
1c0015dc:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0015e0:	0280140e 	addi.w	$r14,$r0,5(0x5)
1c0015e4:	6c0029cc 	bgeu	$r14,$r12,40(0x28) # 1c00160c <char_to_segcode+0x48>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:50
1c0015e8:	02be7dac 	addi.w	$r12,$r13,-97(0xf9f)
1c0015ec:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c0015f0:	0280140e 	addi.w	$r14,$r0,5(0x5)
1c0015f4:	6c0025cc 	bgeu	$r14,$r12,36(0x24) # 1c001618 <char_to_segcode+0x54>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:51
1c0015f8:	0280b40c 	addi.w	$r12,$r0,45(0x2d)
1c0015fc:	5800288c 	beq	$r4,$r12,40(0x28) # 1c001624 <char_to_segcode+0x60>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:52
1c001600:	0283fc0c 	addi.w	$r12,$r0,255(0xff)
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:53
1c001604:	00150184 	move	$r4,$r12
1c001608:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:49 (discriminator 1)
1c00160c:	02bf25ac 	addi.w	$r12,$r13,-55(0xfc9)
1c001610:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001614:	53fff3ff 	b	-16(0xffffff0) # 1c001604 <char_to_segcode+0x40>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:50 (discriminator 1)
1c001618:	02bea5ac 	addi.w	$r12,$r13,-87(0xfa9)
1c00161c:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001620:	53ffe7ff 	b	-28(0xfffffe4) # 1c001604 <char_to_segcode+0x40>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:51
1c001624:	0280400c 	addi.w	$r12,$r0,16(0x10)
1c001628:	53ffdfff 	b	-36(0xfffffdc) # 1c001604 <char_to_segcode+0x40>

1c00162c <seg7_init>:
seg7_init():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:29
1c00162c:	1460000c 	lu12i.w	$r12,196608(0x30000)
1c001630:	0381418e 	ori	$r14,$r12,0x50
1c001634:	288001cd 	ld.w	$r13,$r14,0
1c001638:	006f81ad 	bstrpick.w	$r13,$r13,0xf,0x0
1c00163c:	298001cd 	st.w	$r13,$r14,0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:30
1c001640:	03815d8c 	ori	$r12,$r12,0x57
1c001644:	02bffc0d 	addi.w	$r13,$r0,-1(0xfff)
1c001648:	2900018d 	st.b	$r13,$r12,0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:31
1c00164c:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c001650:	02a7618c 	addi.w	$r12,$r12,-1576(0x9d8)
1c001654:	29000180 	st.b	$r0,$r12,0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:32
1c001658:	4c000020 	jirl	$r0,$r1,0

1c00165c <seg7_set_chars>:
seg7_set_chars():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:56
1c00165c:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c001660:	29807061 	st.w	$r1,$r3,28(0x1c)
1c001664:	29806077 	st.w	$r23,$r3,24(0x18)
1c001668:	29805078 	st.w	$r24,$r3,20(0x14)
1c00166c:	29804079 	st.w	$r25,$r3,16(0x10)
1c001670:	2980307a 	st.w	$r26,$r3,12(0xc)
1c001674:	0015009a 	move	$r26,$r4
1c001678:	001500b9 	move	$r25,$r5
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:57
1c00167c:	1cc8000c 	pcaddu12i	$r12,409600(0x64000)
1c001680:	02a6118c 	addi.w	$r12,$r12,-1660(0x984)
1c001684:	2a000198 	ld.bu	$r24,$r12,0
1c001688:	00678318 	bstrpick.w	$r24,$r24,0x7,0x0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:59
1c00168c:	64000b05 	bge	$r24,$r5,8(0x8) # 1c001694 <seg7_set_chars+0x38>
1c001690:	00150319 	move	$r25,$r24
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:60
1c001694:	00150017 	move	$r23,$r0
1c001698:	50001c00 	b	28(0x1c) # 1c0016b4 <seg7_set_chars+0x58>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:61
1c00169c:	0283fc04 	addi.w	$r4,$r0,255(0xff)
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:61 (discriminator 4)
1c0016a0:	1cc7ffec 	pcaddu12i	$r12,409599(0x63fff)
1c0016a4:	02a6218c 	addi.w	$r12,$r12,-1656(0x988)
1c0016a8:	00105d8c 	add.w	$r12,$r12,$r23
1c0016ac:	29000184 	st.b	$r4,$r12,0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:60 (discriminator 4)
1c0016b0:	028006f7 	addi.w	$r23,$r23,1(0x1)
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:60 (discriminator 2)
1c0016b4:	64001af8 	bge	$r23,$r24,24(0x18) # 1c0016cc <seg7_set_chars+0x70>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:61
1c0016b8:	67ffe6f9 	bge	$r23,$r25,-28(0x3ffe4) # 1c00169c <seg7_set_chars+0x40>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:61 (discriminator 1)
1c0016bc:	00105f4c 	add.w	$r12,$r26,$r23
1c0016c0:	28000184 	ld.b	$r4,$r12,0
1c0016c4:	57ff03ff 	bl	-256(0xfffff00) # 1c0015c4 <char_to_segcode>
1c0016c8:	53ffdbff 	b	-40(0xfffffd8) # 1c0016a0 <seg7_set_chars+0x44>
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:63
1c0016cc:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c0016d0:	28806077 	ld.w	$r23,$r3,24(0x18)
1c0016d4:	28805078 	ld.w	$r24,$r3,20(0x14)
1c0016d8:	28804079 	ld.w	$r25,$r3,16(0x10)
1c0016dc:	2880307a 	ld.w	$r26,$r3,12(0xc)
1c0016e0:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0016e4:	4c000020 	jirl	$r0,$r1,0

1c0016e8 <get_count>:
get_count():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:17
1c0016e8:	00006004 	rdtimel.w	$r4,$r0
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:19
1c0016ec:	4c000020 	jirl	$r0,$r1,0

1c0016f0 <open_count>:
open_count():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:23
1c0016f0:	0380400c 	ori	$r12,$r0,0x10
1c0016f4:	0402bd80 	csrxchg	$r0,$r12,0xaf
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:24
1c0016f8:	4c000020 	jirl	$r0,$r1,0

1c0016fc <close_count>:
close_count():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:27
1c0016fc:	0380400c 	ori	$r12,$r0,0x10
1c001700:	0402bd8c 	csrxchg	$r12,$r12,0xaf
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:28
1c001704:	4c000020 	jirl	$r0,$r1,0

1c001708 <start_count>:
start_count():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:31
1c001708:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00170c:	29803061 	st.w	$r1,$r3,12(0xc)
1c001710:	29802077 	st.w	$r23,$r3,8(0x8)
1c001714:	00150097 	move	$r23,$r4
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:32
1c001718:	29800080 	st.w	$r0,$r4,0
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:33
1c00171c:	29801080 	st.w	$r0,$r4,4(0x4)
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:35
1c001720:	57ffcbff 	bl	-56(0xfffffc8) # 1c0016e8 <get_count>
1c001724:	298002e4 	st.w	$r4,$r23,0
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:36
1c001728:	28803061 	ld.w	$r1,$r3,12(0xc)
1c00172c:	28802077 	ld.w	$r23,$r3,8(0x8)
1c001730:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001734:	4c000020 	jirl	$r0,$r1,0

1c001738 <stop_count>:
stop_count():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:39
1c001738:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00173c:	29803061 	st.w	$r1,$r3,12(0xc)
1c001740:	29802077 	st.w	$r23,$r3,8(0x8)
1c001744:	00150097 	move	$r23,$r4
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:41
1c001748:	57ffa3ff 	bl	-96(0xfffffa0) # 1c0016e8 <get_count>
1c00174c:	298012e4 	st.w	$r4,$r23,4(0x4)
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:42
1c001750:	288002ec 	ld.w	$r12,$r23,0
1c001754:	6800188c 	bltu	$r4,$r12,24(0x18) # 1c00176c <stop_count+0x34>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:44
1c001758:	00113084 	sub.w	$r4,$r4,$r12
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:51
1c00175c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001760:	28802077 	ld.w	$r23,$r3,8(0x8)
1c001764:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001768:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:49
1c00176c:	0014300c 	nor	$r12,$r0,$r12
1c001770:	00103084 	add.w	$r4,$r4,$r12
1c001774:	53ffebff 	b	-24(0xfffffe8) # 1c00175c <stop_count+0x24>

1c001778 <delay_cycle>:
delay_cycle():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:54
1c001778:	02bf8063 	addi.w	$r3,$r3,-32(0xfe0)
1c00177c:	29807061 	st.w	$r1,$r3,28(0x1c)
1c001780:	29806077 	st.w	$r23,$r3,24(0x18)
1c001784:	00150097 	move	$r23,$r4
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:56
1c001788:	29802060 	st.w	$r0,$r3,8(0x8)
1c00178c:	29803060 	st.w	$r0,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:58
1c001790:	57ff63ff 	bl	-160(0xfffff60) # 1c0016f0 <open_count>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:59
1c001794:	02802064 	addi.w	$r4,$r3,8(0x8)
1c001798:	57ff73ff 	bl	-144(0xfffff70) # 1c001708 <start_count>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:55
1c00179c:	00150004 	move	$r4,$r0
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:61
1c0017a0:	6c001097 	bgeu	$r4,$r23,16(0x10) # 1c0017b0 <delay_cycle+0x38>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:63
1c0017a4:	02802064 	addi.w	$r4,$r3,8(0x8)
1c0017a8:	57ff93ff 	bl	-112(0xfffff90) # 1c001738 <stop_count>
1c0017ac:	53fff7ff 	b	-12(0xffffff4) # 1c0017a0 <delay_cycle+0x28>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:65
1c0017b0:	57ff4fff 	bl	-180(0xfffff4c) # 1c0016fc <close_count>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:66
1c0017b4:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c0017b8:	28806077 	ld.w	$r23,$r3,24(0x18)
1c0017bc:	02808063 	addi.w	$r3,$r3,32(0x20)
1c0017c0:	4c000020 	jirl	$r0,$r1,0

1c0017c4 <delay_us>:
delay_us():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:69
1c0017c4:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0017c8:	29803061 	st.w	$r1,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:70
1c0017cc:	00409484 	slli.w	$r4,$r4,0x5
1c0017d0:	57ffabff 	bl	-88(0xfffffa8) # 1c001778 <delay_cycle>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:71
1c0017d4:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0017d8:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0017dc:	4c000020 	jirl	$r0,$r1,0

1c0017e0 <uart_irq_count_inc>:
uart_irq_count_inc():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:28
1c0017e0:	1cc7ffed 	pcaddu12i	$r13,409599(0x63fff)
1c0017e4:	02a291ad 	addi.w	$r13,$r13,-1884(0x8a4)
1c0017e8:	288001ac 	ld.w	$r12,$r13,0
1c0017ec:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0017f0:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:29
1c0017f4:	4c000020 	jirl	$r0,$r1,0

1c0017f8 <uart_init>:
uart_init():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:56
1c0017f8:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:59
1c0017fc:	1400012c 	lu12i.w	$r12,9(0x9)
1c001800:	0398018c 	ori	$r12,$r12,0x600
1c001804:	5800448c 	beq	$r4,$r12,68(0x44) # 1c001848 <uart_init+0x50>
1c001808:	1400038c 	lu12i.w	$r12,28(0x1c)
1c00180c:	0388018c 	ori	$r12,$r12,0x200
1c001810:	5800408c 	beq	$r4,$r12,64(0x40) # 1c001850 <uart_init+0x58>
1c001814:	1400008c 	lu12i.w	$r12,4(0x4)
1c001818:	03ac018c 	ori	$r12,$r12,0xb00
1c00181c:	58003c8c 	beq	$r4,$r12,60(0x3c) # 1c001858 <uart_init+0x60>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:64
1c001820:	0015000c 	move	$r12,$r0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:66
1c001824:	03400d8c 	andi	$r12,$r12,0x3
1c001828:	400038a0 	beqz	$r5,56(0x38) # 1c001860 <uart_init+0x68>
1c00182c:	0280100d 	addi.w	$r13,$r0,4(0x4)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:66 (discriminator 4)
1c001830:	0015358c 	or	$r12,$r12,$r13
1c001834:	1460020d 	lu12i.w	$r13,196624(0x30010)
1c001838:	038011ad 	ori	$r13,$r13,0x4
1c00183c:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:80 (discriminator 4)
1c001840:	29803060 	st.w	$r0,$r3,12(0xc)
1c001844:	50003000 	b	48(0x30) # 1c001874 <uart_init+0x7c>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:61
1c001848:	0280080c 	addi.w	$r12,$r0,2(0x2)
1c00184c:	53ffdbff 	b	-40(0xfffffd8) # 1c001824 <uart_init+0x2c>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:62
1c001850:	02800c0c 	addi.w	$r12,$r0,3(0x3)
1c001854:	53ffd3ff 	b	-48(0xfffffd0) # 1c001824 <uart_init+0x2c>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:60
1c001858:	0280040c 	addi.w	$r12,$r0,1(0x1)
1c00185c:	53ffcbff 	b	-56(0xfffffc8) # 1c001824 <uart_init+0x2c>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:66
1c001860:	0015000d 	move	$r13,$r0
1c001864:	53ffcfff 	b	-52(0xfffffcc) # 1c001830 <uart_init+0x38>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:80 (discriminator 3)
1c001868:	2880306c 	ld.w	$r12,$r3,12(0xc)
1c00186c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001870:	2980306c 	st.w	$r12,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:80 (discriminator 1)
1c001874:	2880306d 	ld.w	$r13,$r3,12(0xc)
1c001878:	140000ec 	lu12i.w	$r12,7(0x7)
1c00187c:	03b3fd8c 	ori	$r12,$r12,0xcff
1c001880:	6fffe98d 	bgeu	$r12,$r13,-24(0x3ffe8) # 1c001868 <uart_init+0x70>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:101
1c001884:	0015000e 	move	$r14,$r0
1c001888:	50001000 	b	16(0x10) # 1c001898 <uart_init+0xa0>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:106 (discriminator 2)
1c00188c:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c001890:	29800180 	st.w	$r0,$r12,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:101 (discriminator 2)
1c001894:	028005ce 	addi.w	$r14,$r14,1(0x1)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:101 (discriminator 1)
1c001898:	02800c0c 	addi.w	$r12,$r0,3(0x3)
1c00189c:	6000318e 	blt	$r12,$r14,48(0x30) # 1c0018cc <uart_init+0xd4>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:102
1c0018a0:	0015000d 	move	$r13,$r0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:103 (discriminator 2)
1c0018a4:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c0018a8:	0380118c 	ori	$r12,$r12,0x4
1c0018ac:	2880018c 	ld.w	$r12,$r12,0
1c0018b0:	0340098c 	andi	$r12,$r12,0x2
1c0018b4:	43ffd99f 	beqz	$r12,-40(0x7fffd8) # 1c00188c <uart_init+0x94>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:103 (discriminator 1)
1c0018b8:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c0018bc:	1400060c 	lu12i.w	$r12,48(0x30)
1c0018c0:	03b4fd8c 	ori	$r12,$r12,0xd3f
1c0018c4:	6fffe18d 	bgeu	$r12,$r13,-32(0x3ffe0) # 1c0018a4 <uart_init+0xac>
1c0018c8:	53ffc7ff 	b	-60(0xfffffc4) # 1c00188c <uart_init+0x94>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:108
1c0018cc:	0015000d 	move	$r13,$r0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:109 (discriminator 2)
1c0018d0:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c0018d4:	0380118c 	ori	$r12,$r12,0x4
1c0018d8:	2880018c 	ld.w	$r12,$r12,0
1c0018dc:	0340098c 	andi	$r12,$r12,0x2
1c0018e0:	40001580 	beqz	$r12,20(0x14) # 1c0018f4 <uart_init+0xfc>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:109 (discriminator 1)
1c0018e4:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c0018e8:	1400060c 	lu12i.w	$r12,48(0x30)
1c0018ec:	03b4fd8c 	ori	$r12,$r12,0xd3f
1c0018f0:	6fffe18d 	bgeu	$r12,$r13,-32(0x3ffe0) # 1c0018d0 <uart_init+0xd8>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:113
1c0018f4:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0018f8:	4c000020 	jirl	$r0,$r1,0

1c0018fc <uart_putc>:
uart_putc():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:129
1c0018fc:	0015000d 	move	$r13,$r0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:142
1c001900:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c001904:	0380118c 	ori	$r12,$r12,0x4
1c001908:	2880018c 	ld.w	$r12,$r12,0
1c00190c:	0340098c 	andi	$r12,$r12,0x2
1c001910:	40002d80 	beqz	$r12,44(0x2c) # 1c00193c <uart_putc+0x40>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:143
1c001914:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c001918:	1400060c 	lu12i.w	$r12,48(0x30)
1c00191c:	03b5018c 	ori	$r12,$r12,0xd40
1c001920:	6fffe18d 	bgeu	$r12,$r13,-32(0x3ffe0) # 1c001900 <uart_putc+0x4>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:144
1c001924:	1cc7ffcd 	pcaddu12i	$r13,409598(0x63ffe)
1c001928:	029d61ad 	addi.w	$r13,$r13,1880(0x758)
1c00192c:	288001ac 	ld.w	$r12,$r13,0
1c001930:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001934:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:145
1c001938:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:148
1c00193c:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c001940:	29800184 	st.w	$r4,$r12,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:149
1c001944:	4c000020 	jirl	$r0,$r1,0

1c001948 <uart_irq_rx_mode>:
uart_irq_rx_mode():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:178
1c001948:	00129004 	sltu	$r4,$r0,$r4
1c00194c:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c001950:	029b918c 	addi.w	$r12,$r12,1764(0x6e4)
1c001954:	29800184 	st.w	$r4,$r12,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:179
1c001958:	4c000020 	jirl	$r0,$r1,0

1c00195c <uart_rx_push>:
uart_rx_push():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:183
1c00195c:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c001960:	029b718c 	addi.w	$r12,$r12,1756(0x6dc)
1c001964:	2880018c 	ld.w	$r12,$r12,0
1c001968:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c00196c:	0281000e 	addi.w	$r14,$r0,64(0x40)
1c001970:	0020b98d 	mod.w	$r13,$r12,$r14
1c001974:	5c0009c0 	bne	$r14,$r0,8(0x8) # 1c00197c <uart_rx_push+0x20>
1c001978:	002a0007 	break	0x7
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:185
1c00197c:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c001980:	029ae18c 	addi.w	$r12,$r12,1720(0x6b8)
1c001984:	2880018c 	ld.w	$r12,$r12,0
1c001988:	5800298d 	beq	$r12,$r13,40(0x28) # 1c0019b0 <uart_rx_push+0x54>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:186
1c00198c:	1cc7ffce 	pcaddu12i	$r14,409598(0x63ffe)
1c001990:	029ab1ce 	addi.w	$r14,$r14,1708(0x6ac)
1c001994:	288001cf 	ld.w	$r15,$r14,0
1c001998:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c00199c:	029a918c 	addi.w	$r12,$r12,1700(0x6a4)
1c0019a0:	00103d8c 	add.w	$r12,$r12,$r15
1c0019a4:	29000184 	st.b	$r4,$r12,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:187
1c0019a8:	298001cd 	st.w	$r13,$r14,0
1c0019ac:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:189
1c0019b0:	1cc7ffcd 	pcaddu12i	$r13,409598(0x63ffe)
1c0019b4:	029b41ad 	addi.w	$r13,$r13,1744(0x6d0)
1c0019b8:	288001ac 	ld.w	$r12,$r13,0
1c0019bc:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0019c0:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:191
1c0019c4:	4c000020 	jirl	$r0,$r1,0

1c0019c8 <_putchar>:
_putchar():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/putchar.c:29
1c0019c8:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c0019cc:	29803061 	st.w	$r1,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/putchar.c:30
1c0019d0:	00678084 	bstrpick.w	$r4,$r4,0x7,0x0
1c0019d4:	57ff2bff 	bl	-216(0xfffff28) # 1c0018fc <uart_putc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/putchar.c:32
1c0019d8:	00150004 	move	$r4,$r0
1c0019dc:	28803061 	ld.w	$r1,$r3,12(0xc)
1c0019e0:	02804063 	addi.w	$r3,$r3,16(0x10)
1c0019e4:	4c000020 	jirl	$r0,$r1,0

1c0019e8 <_out_null>:
_out_null():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:43
1c0019e8:	4c000020 	jirl	$r0,$r1,0

1c0019ec <_atoi>:
_atoi():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:74
1c0019ec:	0015000d 	move	$r13,$r0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:75
1c0019f0:	2880008e 	ld.w	$r14,$r4,0
1c0019f4:	280001cc 	ld.b	$r12,$r14,0
_is_digit():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:68
1c0019f8:	02bf418c 	addi.w	$r12,$r12,-48(0xfd0)
1c0019fc:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
_atoi():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:75
1c001a00:	0280240f 	addi.w	$r15,$r0,9(0x9)
1c001a04:	680025ec 	bltu	$r15,$r12,36(0x24) # 1c001a28 <_atoi+0x3c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:77
1c001a08:	0280280c 	addi.w	$r12,$r0,10(0xa)
1c001a0c:	001c31ad 	mul.w	$r13,$r13,$r12
1c001a10:	028005cc 	addi.w	$r12,$r14,1(0x1)
1c001a14:	2980008c 	st.w	$r12,$r4,0
1c001a18:	280001cc 	ld.b	$r12,$r14,0
1c001a1c:	0010358d 	add.w	$r13,$r12,$r13
1c001a20:	02bf41ad 	addi.w	$r13,$r13,-48(0xfd0)
1c001a24:	53ffcfff 	b	-52(0xfffffcc) # 1c0019f0 <_atoi+0x4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:80
1c001a28:	001501a4 	move	$r4,$r13
1c001a2c:	4c000020 	jirl	$r0,$r1,0

1c001a30 <_out_rev>:
_out_rev():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:85
1c001a30:	02bf4063 	addi.w	$r3,$r3,-48(0xfd0)
1c001a34:	2980b061 	st.w	$r1,$r3,44(0x2c)
1c001a38:	2980a076 	st.w	$r22,$r3,40(0x28)
1c001a3c:	29809077 	st.w	$r23,$r3,36(0x24)
1c001a40:	29808078 	st.w	$r24,$r3,32(0x20)
1c001a44:	29807079 	st.w	$r25,$r3,28(0x1c)
1c001a48:	2980607a 	st.w	$r26,$r3,24(0x18)
1c001a4c:	2980507b 	st.w	$r27,$r3,20(0x14)
1c001a50:	2980407c 	st.w	$r28,$r3,16(0x10)
1c001a54:	2980307d 	st.w	$r29,$r3,12(0xc)
1c001a58:	2980207e 	st.w	$r30,$r3,8(0x8)
1c001a5c:	2980107f 	st.w	$r31,$r3,4(0x4)
1c001a60:	00150098 	move	$r24,$r4
1c001a64:	001500b9 	move	$r25,$r5
1c001a68:	001500df 	move	$r31,$r6
1c001a6c:	001500fa 	move	$r26,$r7
1c001a70:	0015011d 	move	$r29,$r8
1c001a74:	00150137 	move	$r23,$r9
1c001a78:	0015015c 	move	$r28,$r10
1c001a7c:	00150176 	move	$r22,$r11
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:90
1c001a80:	03400d6c 	andi	$r12,$r11,0x3
1c001a84:	40002d80 	beqz	$r12,44(0x2c) # 1c001ab0 <_out_rev+0x80>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:99
1c001a88:	400052e0 	beqz	$r23,80(0x50) # 1c001ad8 <_out_rev+0xa8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:101
1c001a8c:	02bffef7 	addi.w	$r23,$r23,-1(0xfff)
1c001a90:	00105fac 	add.w	$r12,$r29,$r23
1c001a94:	028004db 	addi.w	$r27,$r6,1(0x1)
1c001a98:	00150347 	move	$r7,$r26
1c001a9c:	00150325 	move	$r5,$r25
1c001aa0:	28000184 	ld.b	$r4,$r12,0
1c001aa4:	4c000301 	jirl	$r1,$r24,0
1c001aa8:	00150366 	move	$r6,$r27
1c001aac:	53ffdfff 	b	-36(0xfffffdc) # 1c001a88 <_out_rev+0x58>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:92
1c001ab0:	0015013b 	move	$r27,$r9
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:92 (discriminator 1)
1c001ab4:	6fffd77c 	bgeu	$r27,$r28,-44(0x3ffd4) # 1c001a88 <_out_rev+0x58>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:94 (discriminator 3)
1c001ab8:	028004de 	addi.w	$r30,$r6,1(0x1)
1c001abc:	00150347 	move	$r7,$r26
1c001ac0:	00150325 	move	$r5,$r25
1c001ac4:	02808004 	addi.w	$r4,$r0,32(0x20)
1c001ac8:	4c000301 	jirl	$r1,$r24,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:92 (discriminator 3)
1c001acc:	0280077b 	addi.w	$r27,$r27,1(0x1)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:94 (discriminator 3)
1c001ad0:	001503c6 	move	$r6,$r30
1c001ad4:	53ffe3ff 	b	-32(0xfffffe0) # 1c001ab4 <_out_rev+0x84>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:105
1c001ad8:	03400ad6 	andi	$r22,$r22,0x2
1c001adc:	44003ec0 	bnez	$r22,60(0x3c) # 1c001b18 <_out_rev+0xe8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:114
1c001ae0:	001500c4 	move	$r4,$r6
1c001ae4:	2880b061 	ld.w	$r1,$r3,44(0x2c)
1c001ae8:	2880a076 	ld.w	$r22,$r3,40(0x28)
1c001aec:	28809077 	ld.w	$r23,$r3,36(0x24)
1c001af0:	28808078 	ld.w	$r24,$r3,32(0x20)
1c001af4:	28807079 	ld.w	$r25,$r3,28(0x1c)
1c001af8:	2880607a 	ld.w	$r26,$r3,24(0x18)
1c001afc:	2880507b 	ld.w	$r27,$r3,20(0x14)
1c001b00:	2880407c 	ld.w	$r28,$r3,16(0x10)
1c001b04:	2880307d 	ld.w	$r29,$r3,12(0xc)
1c001b08:	2880207e 	ld.w	$r30,$r3,8(0x8)
1c001b0c:	2880107f 	ld.w	$r31,$r3,4(0x4)
1c001b10:	0280c063 	addi.w	$r3,$r3,48(0x30)
1c001b14:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:107
1c001b18:	00117ccc 	sub.w	$r12,$r6,$r31
1c001b1c:	6fffc59c 	bgeu	$r12,$r28,-60(0x3ffc4) # 1c001ae0 <_out_rev+0xb0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:109
1c001b20:	028004d7 	addi.w	$r23,$r6,1(0x1)
1c001b24:	00150347 	move	$r7,$r26
1c001b28:	00150325 	move	$r5,$r25
1c001b2c:	02808004 	addi.w	$r4,$r0,32(0x20)
1c001b30:	4c000301 	jirl	$r1,$r24,0
1c001b34:	001502e6 	move	$r6,$r23
1c001b38:	53ffe3ff 	b	-32(0xfffffe0) # 1c001b18 <_out_rev+0xe8>

1c001b3c <_ntoa_format>:
_ntoa_format():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:120
1c001b3c:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c001b40:	29803061 	st.w	$r1,$r3,12(0xc)
1c001b44:	28804070 	ld.w	$r16,$r3,16(0x10)
1c001b48:	2880506f 	ld.w	$r15,$r3,20(0x14)
1c001b4c:	2880606c 	ld.w	$r12,$r3,24(0x18)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:122
1c001b50:	0340098d 	andi	$r13,$r12,0x2
1c001b54:	440065a0 	bnez	$r13,100(0x64) # 1c001bb8 <_ntoa_format+0x7c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:124
1c001b58:	40001de0 	beqz	$r15,28(0x1c) # 1c001b74 <_ntoa_format+0x38>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:124 (discriminator 1)
1c001b5c:	0340058d 	andi	$r13,$r12,0x1
1c001b60:	400015a0 	beqz	$r13,20(0x14) # 1c001b74 <_ntoa_format+0x38>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:124 (discriminator 2)
1c001b64:	44000d40 	bnez	$r10,12(0xc) # 1c001b70 <_ntoa_format+0x34>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:124 (discriminator 3)
1c001b68:	0340318d 	andi	$r13,$r12,0xc
1c001b6c:	400009a0 	beqz	$r13,8(0x8) # 1c001b74 <_ntoa_format+0x38>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:126
1c001b70:	02bffdef 	addi.w	$r15,$r15,-1(0xfff)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:129
1c001b74:	6c003130 	bgeu	$r9,$r16,48(0x30) # 1c001ba4 <_ntoa_format+0x68>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:129 (discriminator 1)
1c001b78:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001b7c:	680029a9 	bltu	$r13,$r9,40(0x28) # 1c001ba4 <_ntoa_format+0x68>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:131
1c001b80:	0010250d 	add.w	$r13,$r8,$r9
1c001b84:	0280c00e 	addi.w	$r14,$r0,48(0x30)
1c001b88:	290001ae 	st.b	$r14,$r13,0
1c001b8c:	02800529 	addi.w	$r9,$r9,1(0x1)
1c001b90:	53ffe7ff 	b	-28(0xfffffe4) # 1c001b74 <_ntoa_format+0x38>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:136
1c001b94:	0010250d 	add.w	$r13,$r8,$r9
1c001b98:	0280c00e 	addi.w	$r14,$r0,48(0x30)
1c001b9c:	290001ae 	st.b	$r14,$r13,0
1c001ba0:	02800529 	addi.w	$r9,$r9,1(0x1)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:134
1c001ba4:	0340058d 	andi	$r13,$r12,0x1
1c001ba8:	400011a0 	beqz	$r13,16(0x10) # 1c001bb8 <_ntoa_format+0x7c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:134 (discriminator 1)
1c001bac:	6c000d2f 	bgeu	$r9,$r15,12(0xc) # 1c001bb8 <_ntoa_format+0x7c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:134 (discriminator 2)
1c001bb0:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001bb4:	6fffe1a9 	bgeu	$r13,$r9,-32(0x3ffe0) # 1c001b94 <_ntoa_format+0x58>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:141
1c001bb8:	0340418d 	andi	$r13,$r12,0x10
1c001bbc:	400049a0 	beqz	$r13,72(0x48) # 1c001c04 <_ntoa_format+0xc8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:143
1c001bc0:	0350018d 	andi	$r13,$r12,0x400
1c001bc4:	440011a0 	bnez	$r13,16(0x10) # 1c001bd4 <_ntoa_format+0x98>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:143 (discriminator 1)
1c001bc8:	40000d20 	beqz	$r9,12(0xc) # 1c001bd4 <_ntoa_format+0x98>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:143 (discriminator 2)
1c001bcc:	58006d30 	beq	$r9,$r16,108(0x6c) # 1c001c38 <_ntoa_format+0xfc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:143 (discriminator 3)
1c001bd0:	5800692f 	beq	$r9,$r15,104(0x68) # 1c001c38 <_ntoa_format+0xfc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:152
1c001bd4:	0280400d 	addi.w	$r13,$r0,16(0x10)
1c001bd8:	5800896d 	beq	$r11,$r13,136(0x88) # 1c001c60 <_ntoa_format+0x124>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:156
1c001bdc:	0280400d 	addi.w	$r13,$r0,16(0x10)
1c001be0:	5800a56d 	beq	$r11,$r13,164(0xa4) # 1c001c84 <_ntoa_format+0x148>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:160
1c001be4:	0280080d 	addi.w	$r13,$r0,2(0x2)
1c001be8:	5800c16d 	beq	$r11,$r13,192(0xc0) # 1c001ca8 <_ntoa_format+0x16c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:164
1c001bec:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001bf0:	680015a9 	bltu	$r13,$r9,20(0x14) # 1c001c04 <_ntoa_format+0xc8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:166
1c001bf4:	0010250d 	add.w	$r13,$r8,$r9
1c001bf8:	0280c00e 	addi.w	$r14,$r0,48(0x30)
1c001bfc:	290001ae 	st.b	$r14,$r13,0
1c001c00:	02800529 	addi.w	$r9,$r9,1(0x1)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:170
1c001c04:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001c08:	680019a9 	bltu	$r13,$r9,24(0x18) # 1c001c20 <_ntoa_format+0xe4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:172
1c001c0c:	4000b940 	beqz	$r10,184(0xb8) # 1c001cc4 <_ntoa_format+0x188>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:174
1c001c10:	0010250d 	add.w	$r13,$r8,$r9
1c001c14:	0280b40e 	addi.w	$r14,$r0,45(0x2d)
1c001c18:	290001ae 	st.b	$r14,$r13,0
1c001c1c:	02800529 	addi.w	$r9,$r9,1(0x1)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:186
1c001c20:	0015018b 	move	$r11,$r12
1c001c24:	001501ea 	move	$r10,$r15
1c001c28:	57fe0bff 	bl	-504(0xffffe08) # 1c001a30 <_out_rev>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:187
1c001c2c:	28803061 	ld.w	$r1,$r3,12(0xc)
1c001c30:	02804063 	addi.w	$r3,$r3,16(0x10)
1c001c34:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:145
1c001c38:	02bffd2d 	addi.w	$r13,$r9,-1(0xfff)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:146
1c001c3c:	40001da0 	beqz	$r13,28(0x1c) # 1c001c58 <_ntoa_format+0x11c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:146 (discriminator 1)
1c001c40:	0280400e 	addi.w	$r14,$r0,16(0x10)
1c001c44:	58000d6e 	beq	$r11,$r14,12(0xc) # 1c001c50 <_ntoa_format+0x114>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:145
1c001c48:	001501a9 	move	$r9,$r13
1c001c4c:	53ff8bff 	b	-120(0xfffff88) # 1c001bd4 <_ntoa_format+0x98>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:148
1c001c50:	02bff929 	addi.w	$r9,$r9,-2(0xffe)
1c001c54:	53ff83ff 	b	-128(0xfffff80) # 1c001bd4 <_ntoa_format+0x98>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:145
1c001c58:	001501a9 	move	$r9,$r13
1c001c5c:	53ff7bff 	b	-136(0xfffff78) # 1c001bd4 <_ntoa_format+0x98>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:152 (discriminator 1)
1c001c60:	0340818d 	andi	$r13,$r12,0x20
1c001c64:	47ff79bf 	bnez	$r13,-136(0x7fff78) # 1c001bdc <_ntoa_format+0xa0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:152 (discriminator 2)
1c001c68:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001c6c:	6bff71a9 	bltu	$r13,$r9,-144(0x3ff70) # 1c001bdc <_ntoa_format+0xa0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:154
1c001c70:	0010250d 	add.w	$r13,$r8,$r9
1c001c74:	0281e00e 	addi.w	$r14,$r0,120(0x78)
1c001c78:	290001ae 	st.b	$r14,$r13,0
1c001c7c:	02800529 	addi.w	$r9,$r9,1(0x1)
1c001c80:	53ff6fff 	b	-148(0xfffff6c) # 1c001bec <_ntoa_format+0xb0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:156 (discriminator 1)
1c001c84:	0340818d 	andi	$r13,$r12,0x20
1c001c88:	43ff5dbf 	beqz	$r13,-164(0x7fff5c) # 1c001be4 <_ntoa_format+0xa8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:156 (discriminator 2)
1c001c8c:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001c90:	6bff55a9 	bltu	$r13,$r9,-172(0x3ff54) # 1c001be4 <_ntoa_format+0xa8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:158
1c001c94:	0010250d 	add.w	$r13,$r8,$r9
1c001c98:	0281600e 	addi.w	$r14,$r0,88(0x58)
1c001c9c:	290001ae 	st.b	$r14,$r13,0
1c001ca0:	02800529 	addi.w	$r9,$r9,1(0x1)
1c001ca4:	53ff4bff 	b	-184(0xfffff48) # 1c001bec <_ntoa_format+0xb0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:160 (discriminator 1)
1c001ca8:	02807c0d 	addi.w	$r13,$r0,31(0x1f)
1c001cac:	6bff41a9 	bltu	$r13,$r9,-192(0x3ff40) # 1c001bec <_ntoa_format+0xb0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:162
1c001cb0:	0010250d 	add.w	$r13,$r8,$r9
1c001cb4:	0281880e 	addi.w	$r14,$r0,98(0x62)
1c001cb8:	290001ae 	st.b	$r14,$r13,0
1c001cbc:	02800529 	addi.w	$r9,$r9,1(0x1)
1c001cc0:	53ff2fff 	b	-212(0xfffff2c) # 1c001bec <_ntoa_format+0xb0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:176
1c001cc4:	0340118d 	andi	$r13,$r12,0x4
1c001cc8:	400019a0 	beqz	$r13,24(0x18) # 1c001ce0 <_ntoa_format+0x1a4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:178
1c001ccc:	0010250d 	add.w	$r13,$r8,$r9
1c001cd0:	0280ac0e 	addi.w	$r14,$r0,43(0x2b)
1c001cd4:	290001ae 	st.b	$r14,$r13,0
1c001cd8:	02800529 	addi.w	$r9,$r9,1(0x1)
1c001cdc:	53ff47ff 	b	-188(0xfffff44) # 1c001c20 <_ntoa_format+0xe4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:180
1c001ce0:	0340218d 	andi	$r13,$r12,0x8
1c001ce4:	43ff3dbf 	beqz	$r13,-196(0x7fff3c) # 1c001c20 <_ntoa_format+0xe4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:182
1c001ce8:	0010250d 	add.w	$r13,$r8,$r9
1c001cec:	0280800e 	addi.w	$r14,$r0,32(0x20)
1c001cf0:	290001ae 	st.b	$r14,$r13,0
1c001cf4:	02800529 	addi.w	$r9,$r9,1(0x1)
1c001cf8:	53ff2bff 	b	-216(0xfffff28) # 1c001c20 <_ntoa_format+0xe4>

1c001cfc <_ntoa_long>:
_ntoa_long():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:193
1c001cfc:	02bd8063 	addi.w	$r3,$r3,-160(0xf60)
1c001d00:	29827061 	st.w	$r1,$r3,156(0x9c)
1c001d04:	28829071 	ld.w	$r17,$r3,164(0xa4)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:198
1c001d08:	44000d00 	bnez	$r8,12(0xc) # 1c001d14 <_ntoa_long+0x18>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:200
1c001d0c:	02bfbc0c 	addi.w	$r12,$r0,-17(0xfef)
1c001d10:	0014b231 	and	$r17,$r17,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:204
1c001d14:	0350022e 	andi	$r14,$r17,0x400
1c001d18:	4000f5c0 	beqz	$r14,244(0xf4) # 1c001e0c <_ntoa_long+0x110>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:204 (discriminator 1)
1c001d1c:	4001c900 	beqz	$r8,456(0x1c8) # 1c001ee4 <_ntoa_long+0x1e8>
1c001d20:	0015000e 	move	$r14,$r0
1c001d24:	5000e800 	b	232(0xe8) # 1c001e0c <_ntoa_long+0x110>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:212 (discriminator 2)
1c001d28:	0340822c 	andi	$r12,$r17,0x20
1c001d2c:	40001d80 	beqz	$r12,28(0x1c) # 1c001d48 <_ntoa_long+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:212
1c001d30:	0281040c 	addi.w	$r12,$r0,65(0x41)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:212 (discriminator 7)
1c001d34:	00103d8c 	add.w	$r12,$r12,$r15
1c001d38:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
1c001d3c:	02bfd98c 	addi.w	$r12,$r12,-10(0xff6)
1c001d40:	00005d8f 	ext.w.b	$r15,$r12
1c001d44:	5000e800 	b	232(0xe8) # 1c001e2c <_ntoa_long+0x130>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:212
1c001d48:	0281840c 	addi.w	$r12,$r0,97(0x61)
1c001d4c:	53ffebff 	b	-24(0xfffffe8) # 1c001d34 <_ntoa_long+0x38>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:216 (discriminator 2)
1c001d50:	0340822c 	andi	$r12,$r17,0x20
1c001d54:	40001d80 	beqz	$r12,28(0x1c) # 1c001d70 <_ntoa_long+0x74>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:216
1c001d58:	02810412 	addi.w	$r18,$r0,65(0x41)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:216 (discriminator 7)
1c001d5c:	0010364d 	add.w	$r13,$r18,$r13
1c001d60:	006781ad 	bstrpick.w	$r13,$r13,0x7,0x0
1c001d64:	02bfd9ad 	addi.w	$r13,$r13,-10(0xff6)
1c001d68:	00005db2 	ext.w.b	$r18,$r13
1c001d6c:	5000f000 	b	240(0xf0) # 1c001e5c <_ntoa_long+0x160>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:216
1c001d70:	02818412 	addi.w	$r18,$r0,97(0x61)
1c001d74:	53ffebff 	b	-24(0xfffffe8) # 1c001d5c <_ntoa_long+0x60>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:220 (discriminator 2)
1c001d78:	0340822c 	andi	$r12,$r17,0x20
1c001d7c:	40001d80 	beqz	$r12,28(0x1c) # 1c001d98 <_ntoa_long+0x9c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:220
1c001d80:	0281040d 	addi.w	$r13,$r0,65(0x41)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:220 (discriminator 7)
1c001d84:	001041ad 	add.w	$r13,$r13,$r16
1c001d88:	006781ad 	bstrpick.w	$r13,$r13,0x7,0x0
1c001d8c:	02bfd9ad 	addi.w	$r13,$r13,-10(0xff6)
1c001d90:	00005db0 	ext.w.b	$r16,$r13
1c001d94:	5000f800 	b	248(0xf8) # 1c001e8c <_ntoa_long+0x190>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:220
1c001d98:	0281840d 	addi.w	$r13,$r0,97(0x61)
1c001d9c:	53ffebff 	b	-24(0xfffffe8) # 1c001d84 <_ntoa_long+0x88>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:224 (discriminator 2)
1c001da0:	0340822d 	andi	$r13,$r17,0x20
1c001da4:	40001da0 	beqz	$r13,28(0x1c) # 1c001dc0 <_ntoa_long+0xc4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:224
1c001da8:	0281040d 	addi.w	$r13,$r0,65(0x41)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:224 (discriminator 7)
1c001dac:	001031ad 	add.w	$r13,$r13,$r12
1c001db0:	006781ad 	bstrpick.w	$r13,$r13,0x7,0x0
1c001db4:	02bfd9ad 	addi.w	$r13,$r13,-10(0xff6)
1c001db8:	00005dac 	ext.w.b	$r12,$r13
1c001dbc:	50010000 	b	256(0x100) # 1c001ebc <_ntoa_long+0x1c0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:224
1c001dc0:	0281840d 	addi.w	$r13,$r0,97(0x61)
1c001dc4:	53ffebff 	b	-24(0xfffffe8) # 1c001dac <_ntoa_long+0xb0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:213
1c001dc8:	00150208 	move	$r8,$r16
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:208
1c001dcc:	0015000c 	move	$r12,$r0
1c001dd0:	00150010 	move	$r16,$r0
1c001dd4:	00150012 	move	$r18,$r0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:228
1c001dd8:	0040e18c 	slli.w	$r12,$r12,0x18
1c001ddc:	0040c20d 	slli.w	$r13,$r16,0x10
1c001de0:	0015358c 	or	$r12,$r12,$r13
1c001de4:	0040a24d 	slli.w	$r13,$r18,0x8
1c001de8:	0015358c 	or	$r12,$r12,$r13
1c001dec:	00153d8c 	or	$r12,$r12,$r15
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:229
1c001df0:	0282406d 	addi.w	$r13,$r3,144(0x90)
1c001df4:	0004b5cd 	alsl.w	$r13,$r14,$r13,0x2
1c001df8:	29be01ac 	st.w	$r12,$r13,-128(0xf80)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:230
1c001dfc:	028005ce 	addi.w	$r14,$r14,1(0x1)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:231
1c001e00:	4000e900 	beqz	$r8,232(0xe8) # 1c001ee8 <_ntoa_long+0x1ec>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:231 (discriminator 1)
1c001e04:	02807c0c 	addi.w	$r12,$r0,31(0x1f)
1c001e08:	6800e18e 	bltu	$r12,$r14,224(0xe0) # 1c001ee8 <_ntoa_long+0x1ec>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:211
1c001e0c:	0021a90f 	mod.wu	$r15,$r8,$r10
1c001e10:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001e18 <_ntoa_long+0x11c>
1c001e14:	002a0007 	break	0x7
1c001e18:	00005ded 	ext.w.b	$r13,$r15
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:212
1c001e1c:	0280240c 	addi.w	$r12,$r0,9(0x9)
1c001e20:	63ff098d 	blt	$r12,$r13,-248(0x3ff08) # 1c001d28 <_ntoa_long+0x2c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:212 (discriminator 1)
1c001e24:	0280c1ec 	addi.w	$r12,$r15,48(0x30)
1c001e28:	00005d8f 	ext.w.b	$r15,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:213 (discriminator 8)
1c001e2c:	00212910 	div.wu	$r16,$r8,$r10
1c001e30:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001e38 <_ntoa_long+0x13c>
1c001e34:	002a0007 	break	0x7
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:214 (discriminator 8)
1c001e38:	6bff910a 	bltu	$r8,$r10,-112(0x3ff90) # 1c001dc8 <_ntoa_long+0xcc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:215
1c001e3c:	0021aa0d 	mod.wu	$r13,$r16,$r10
1c001e40:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001e48 <_ntoa_long+0x14c>
1c001e44:	002a0007 	break	0x7
1c001e48:	00005db2 	ext.w.b	$r18,$r13
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:216
1c001e4c:	0280240c 	addi.w	$r12,$r0,9(0x9)
1c001e50:	63ff0192 	blt	$r12,$r18,-256(0x3ff00) # 1c001d50 <_ntoa_long+0x54>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:216 (discriminator 1)
1c001e54:	0280c1ad 	addi.w	$r13,$r13,48(0x30)
1c001e58:	00005db2 	ext.w.b	$r18,$r13
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:217 (discriminator 8)
1c001e5c:	00212a08 	div.wu	$r8,$r16,$r10
1c001e60:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001e68 <_ntoa_long+0x16c>
1c001e64:	002a0007 	break	0x7
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:218 (discriminator 8)
1c001e68:	6800660a 	bltu	$r16,$r10,100(0x64) # 1c001ecc <_ntoa_long+0x1d0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:219
1c001e6c:	0021a910 	mod.wu	$r16,$r8,$r10
1c001e70:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001e78 <_ntoa_long+0x17c>
1c001e74:	002a0007 	break	0x7
1c001e78:	00005e0d 	ext.w.b	$r13,$r16
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:220
1c001e7c:	0280240c 	addi.w	$r12,$r0,9(0x9)
1c001e80:	63fef98d 	blt	$r12,$r13,-264(0x3fef8) # 1c001d78 <_ntoa_long+0x7c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:220 (discriminator 1)
1c001e84:	0280c20d 	addi.w	$r13,$r16,48(0x30)
1c001e88:	00005db0 	ext.w.b	$r16,$r13
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:221 (discriminator 8)
1c001e8c:	00212913 	div.wu	$r19,$r8,$r10
1c001e90:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001e98 <_ntoa_long+0x19c>
1c001e94:	002a0007 	break	0x7
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:222 (discriminator 8)
1c001e98:	6800410a 	bltu	$r8,$r10,64(0x40) # 1c001ed8 <_ntoa_long+0x1dc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:223
1c001e9c:	0021aa6c 	mod.wu	$r12,$r19,$r10
1c001ea0:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001ea8 <_ntoa_long+0x1ac>
1c001ea4:	002a0007 	break	0x7
1c001ea8:	00005d94 	ext.w.b	$r20,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:224
1c001eac:	0280240d 	addi.w	$r13,$r0,9(0x9)
1c001eb0:	63fef1b4 	blt	$r13,$r20,-272(0x3fef0) # 1c001da0 <_ntoa_long+0xa4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:224 (discriminator 1)
1c001eb4:	0280c18c 	addi.w	$r12,$r12,48(0x30)
1c001eb8:	00005d8c 	ext.w.b	$r12,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:225 (discriminator 8)
1c001ebc:	00212a68 	div.wu	$r8,$r19,$r10
1c001ec0:	5c000940 	bne	$r10,$r0,8(0x8) # 1c001ec8 <_ntoa_long+0x1cc>
1c001ec4:	002a0007 	break	0x7
1c001ec8:	53ff13ff 	b	-240(0xfffff10) # 1c001dd8 <_ntoa_long+0xdc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:208
1c001ecc:	0015000c 	move	$r12,$r0
1c001ed0:	00150010 	move	$r16,$r0
1c001ed4:	53ff07ff 	b	-252(0xfffff04) # 1c001dd8 <_ntoa_long+0xdc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:221
1c001ed8:	00150268 	move	$r8,$r19
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:208
1c001edc:	0015000c 	move	$r12,$r0
1c001ee0:	53fefbff 	b	-264(0xffffef8) # 1c001dd8 <_ntoa_long+0xdc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:195
1c001ee4:	0015010e 	move	$r14,$r8
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:245
1c001ee8:	004089ce 	slli.w	$r14,$r14,0x2
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:246
1c001eec:	50000800 	b	8(0x8) # 1c001ef4 <_ntoa_long+0x1f8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:248
1c001ef0:	0015018e 	move	$r14,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:246
1c001ef4:	400019c0 	beqz	$r14,24(0x18) # 1c001f0c <_ntoa_long+0x210>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:246 (discriminator 1)
1c001ef8:	02bffdcc 	addi.w	$r12,$r14,-1(0xfff)
1c001efc:	0282406d 	addi.w	$r13,$r3,144(0x90)
1c001f00:	001031ad 	add.w	$r13,$r13,$r12
1c001f04:	283e01ad 	ld.b	$r13,$r13,-128(0xf80)
1c001f08:	43ffe9bf 	beqz	$r13,-24(0x7fffe8) # 1c001ef0 <_ntoa_long+0x1f4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:253
1c001f0c:	29802071 	st.w	$r17,$r3,8(0x8)
1c001f10:	2882806c 	ld.w	$r12,$r3,160(0xa0)
1c001f14:	2980106c 	st.w	$r12,$r3,4(0x4)
1c001f18:	2980006b 	st.w	$r11,$r3,0
1c001f1c:	0015014b 	move	$r11,$r10
1c001f20:	0015012a 	move	$r10,$r9
1c001f24:	001501c9 	move	$r9,$r14
1c001f28:	02804068 	addi.w	$r8,$r3,16(0x10)
1c001f2c:	57fc13ff 	bl	-1008(0xffffc10) # 1c001b3c <_ntoa_format>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:254
1c001f30:	28827061 	ld.w	$r1,$r3,156(0x9c)
1c001f34:	02828063 	addi.w	$r3,$r3,160(0xa0)
1c001f38:	4c000020 	jirl	$r0,$r1,0

1c001f3c <_vsnprintf>:
_vsnprintf():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:258
1c001f3c:	02bec063 	addi.w	$r3,$r3,-80(0xfb0)
1c001f40:	29813061 	st.w	$r1,$r3,76(0x4c)
1c001f44:	29812076 	st.w	$r22,$r3,72(0x48)
1c001f48:	29811077 	st.w	$r23,$r3,68(0x44)
1c001f4c:	29810078 	st.w	$r24,$r3,64(0x40)
1c001f50:	2980f079 	st.w	$r25,$r3,60(0x3c)
1c001f54:	2980e07a 	st.w	$r26,$r3,56(0x38)
1c001f58:	2980d07b 	st.w	$r27,$r3,52(0x34)
1c001f5c:	2980c07c 	st.w	$r28,$r3,48(0x30)
1c001f60:	2980b07d 	st.w	$r29,$r3,44(0x2c)
1c001f64:	2980a07e 	st.w	$r30,$r3,40(0x28)
1c001f68:	2980907f 	st.w	$r31,$r3,36(0x24)
1c001f6c:	0015009a 	move	$r26,$r4
1c001f70:	001500b9 	move	$r25,$r5
1c001f74:	001500d8 	move	$r24,$r6
1c001f78:	29807067 	st.w	$r7,$r3,28(0x1c)
1c001f7c:	29806068 	st.w	$r8,$r3,24(0x18)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:262
1c001f80:	40071ca0 	beqz	$r5,1820(0x71c) # 1c00269c <_vsnprintf+0x760>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:543
1c001f84:	00150017 	move	$r23,$r0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:268
1c001f88:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c001f8c:	28000184 	ld.b	$r4,$r12,0
1c001f90:	40071880 	beqz	$r4,1816(0x718) # 1c0026a8 <_vsnprintf+0x76c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:271
1c001f94:	0280940d 	addi.w	$r13,$r0,37(0x25)
1c001f98:	58002c8d 	beq	$r4,$r13,44(0x2c) # 1c001fc4 <_vsnprintf+0x88>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:274
1c001f9c:	028006fb 	addi.w	$r27,$r23,1(0x1)
1c001fa0:	00150307 	move	$r7,$r24
1c001fa4:	001502e6 	move	$r6,$r23
1c001fa8:	00150325 	move	$r5,$r25
1c001fac:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:275
1c001fb0:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c001fb4:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001fb8:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:274
1c001fbc:	00150377 	move	$r23,$r27
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:276
1c001fc0:	53ffcbff 	b	-56(0xfffffc8) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:281
1c001fc4:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c001fc8:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:285
1c001fcc:	0015001e 	move	$r30,$r0
1c001fd0:	50007400 	b	116(0x74) # 1c002044 <_vsnprintf+0x108>
_is_digit():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:68
1c001fd4:	02bf41cc 	addi.w	$r12,$r14,-48(0xfd0)
1c001fd8:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
_vsnprintf():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:301
1c001fdc:	0280240d 	addi.w	$r13,$r0,9(0x9)
1c001fe0:	6c00d1ac 	bgeu	$r13,$r12,208(0xd0) # 1c0020b0 <_vsnprintf+0x174>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:305
1c001fe4:	0280a80c 	addi.w	$r12,$r0,42(0x2a)
1c001fe8:	5800d9cc 	beq	$r14,$r12,216(0xd8) # 1c0020c0 <_vsnprintf+0x184>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:300
1c001fec:	0015001f 	move	$r31,$r0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:323
1c001ff0:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c001ff4:	2800018e 	ld.b	$r14,$r12,0
1c001ff8:	0280b80d 	addi.w	$r13,$r0,46(0x2e)
1c001ffc:	5800f5cd 	beq	$r14,$r13,244(0xf4) # 1c0020f0 <_vsnprintf+0x1b4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:322
1c002000:	0015001d 	move	$r29,$r0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:340
1c002004:	2880706d 	ld.w	$r13,$r3,28(0x1c)
1c002008:	280001ac 	ld.b	$r12,$r13,0
1c00200c:	0281a80e 	addi.w	$r14,$r0,106(0x6a)
1c002010:	5801b58e 	beq	$r12,$r14,436(0x1b4) # 1c0021c4 <_vsnprintf+0x288>
1c002014:	640149cc 	bge	$r14,$r12,328(0x148) # 1c00215c <_vsnprintf+0x220>
1c002018:	0281b00e 	addi.w	$r14,$r0,108(0x6c)
1c00201c:	5801698e 	beq	$r12,$r14,360(0x168) # 1c002184 <_vsnprintf+0x248>
1c002020:	0281e80e 	addi.w	$r14,$r0,122(0x7a)
1c002024:	5c01ad8e 	bne	$r12,$r14,428(0x1ac) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:369
1c002028:	038403de 	ori	$r30,$r30,0x100
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:370
1c00202c:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c002030:	2980706d 	st.w	$r13,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:371
1c002034:	50019c00 	b	412(0x19c) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:290
1c002038:	038007de 	ori	$r30,$r30,0x1
1c00203c:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c002040:	2980706d 	st.w	$r13,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:288
1c002044:	2880706d 	ld.w	$r13,$r3,28(0x1c)
1c002048:	280001ae 	ld.b	$r14,$r13,0
1c00204c:	02bf81cc 	addi.w	$r12,$r14,-32(0xfe0)
1c002050:	00678190 	bstrpick.w	$r16,$r12,0x7,0x0
1c002054:	0280400f 	addi.w	$r15,$r0,16(0x10)
1c002058:	6bff7df0 	bltu	$r15,$r16,-132(0x3ff7c) # 1c001fd4 <_vsnprintf+0x98>
1c00205c:	1c00002f 	pcaddu12i	$r15,1(0x1)
1c002060:	02a601ef 	addi.w	$r15,$r15,-1664(0x980)
1c002064:	0004be0c 	alsl.w	$r12,$r16,$r15,0x2
1c002068:	2880018c 	ld.w	$r12,$r12,0
1c00206c:	4c000180 	jirl	$r0,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:291
1c002070:	03800bde 	ori	$r30,$r30,0x2
1c002074:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c002078:	2980706d 	st.w	$r13,$r3,28(0x1c)
1c00207c:	53ffcbff 	b	-56(0xfffffc8) # 1c002044 <_vsnprintf+0x108>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:292
1c002080:	038013de 	ori	$r30,$r30,0x4
1c002084:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c002088:	2980706d 	st.w	$r13,$r3,28(0x1c)
1c00208c:	53ffbbff 	b	-72(0xfffffb8) # 1c002044 <_vsnprintf+0x108>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:293
1c002090:	038023de 	ori	$r30,$r30,0x8
1c002094:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c002098:	2980706d 	st.w	$r13,$r3,28(0x1c)
1c00209c:	53ffabff 	b	-88(0xfffffa8) # 1c002044 <_vsnprintf+0x108>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:294
1c0020a0:	038043de 	ori	$r30,$r30,0x10
1c0020a4:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c0020a8:	2980706d 	st.w	$r13,$r3,28(0x1c)
1c0020ac:	53ff9bff 	b	-104(0xfffff98) # 1c002044 <_vsnprintf+0x108>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:303
1c0020b0:	02807064 	addi.w	$r4,$r3,28(0x1c)
1c0020b4:	57f93bff 	bl	-1736(0xffff938) # 1c0019ec <_atoi>
1c0020b8:	0015009f 	move	$r31,$r4
1c0020bc:	53ff37ff 	b	-204(0xfffff34) # 1c001ff0 <_vsnprintf+0xb4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:307
1c0020c0:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c0020c4:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c0020c8:	2980606d 	st.w	$r13,$r3,24(0x18)
1c0020cc:	2880019f 	ld.w	$r31,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:308
1c0020d0:	600017e0 	blt	$r31,$r0,20(0x14) # 1c0020e4 <_vsnprintf+0x1a8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:318
1c0020d4:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c0020d8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0020dc:	2980706c 	st.w	$r12,$r3,28(0x1c)
1c0020e0:	53ff13ff 	b	-240(0xfffff10) # 1c001ff0 <_vsnprintf+0xb4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:310
1c0020e4:	03800bde 	ori	$r30,$r30,0x2
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:311
1c0020e8:	00117c1f 	sub.w	$r31,$r0,$r31
1c0020ec:	53ffebff 	b	-24(0xfffffe8) # 1c0020d4 <_vsnprintf+0x198>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:325
1c0020f0:	039003de 	ori	$r30,$r30,0x400
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:326
1c0020f4:	0280058d 	addi.w	$r13,$r12,1(0x1)
1c0020f8:	2980706d 	st.w	$r13,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:327
1c0020fc:	2800058d 	ld.b	$r13,$r12,1(0x1)
_is_digit():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:68
1c002100:	02bf41ac 	addi.w	$r12,$r13,-48(0xfd0)
1c002104:	0067818c 	bstrpick.w	$r12,$r12,0x7,0x0
_vsnprintf():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:327
1c002108:	0280240e 	addi.w	$r14,$r0,9(0x9)
1c00210c:	6c0015cc 	bgeu	$r14,$r12,20(0x14) # 1c002120 <_vsnprintf+0x1e4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:331
1c002110:	0280a80c 	addi.w	$r12,$r0,42(0x2a)
1c002114:	58001dac 	beq	$r13,$r12,28(0x1c) # 1c002130 <_vsnprintf+0x1f4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:322
1c002118:	0015001d 	move	$r29,$r0
1c00211c:	53feebff 	b	-280(0xffffee8) # 1c002004 <_vsnprintf+0xc8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:329
1c002120:	02807064 	addi.w	$r4,$r3,28(0x1c)
1c002124:	57f8cbff 	bl	-1848(0xffff8c8) # 1c0019ec <_atoi>
1c002128:	0015009d 	move	$r29,$r4
1c00212c:	53fedbff 	b	-296(0xffffed8) # 1c002004 <_vsnprintf+0xc8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:333
1c002130:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c002134:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002138:	2980606d 	st.w	$r13,$r3,24(0x18)
1c00213c:	2880019d 	ld.w	$r29,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:334
1c002140:	600017a0 	blt	$r29,$r0,20(0x14) # 1c002154 <_vsnprintf+0x218>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:335
1c002144:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c002148:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c00214c:	2980706c 	st.w	$r12,$r3,28(0x1c)
1c002150:	53feb7ff 	b	-332(0xffffeb4) # 1c002004 <_vsnprintf+0xc8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:334
1c002154:	0015001d 	move	$r29,$r0
1c002158:	53ffefff 	b	-20(0xfffffec) # 1c002144 <_vsnprintf+0x208>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:340
1c00215c:	0281a00e 	addi.w	$r14,$r0,104(0x68)
1c002160:	5c00718e 	bne	$r12,$r14,112(0x70) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:353
1c002164:	038203cf 	ori	$r15,$r30,0x80
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:354
1c002168:	028005ac 	addi.w	$r12,$r13,1(0x1)
1c00216c:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:355
1c002170:	280005ae 	ld.b	$r14,$r13,1(0x1)
1c002174:	0281a00d 	addi.w	$r13,$r0,104(0x68)
1c002178:	58003dcd 	beq	$r14,$r13,60(0x3c) # 1c0021b4 <_vsnprintf+0x278>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:353
1c00217c:	001501fe 	move	$r30,$r15
1c002180:	50005000 	b	80(0x50) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:343
1c002184:	038403cf 	ori	$r15,$r30,0x100
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:344
1c002188:	028005ac 	addi.w	$r12,$r13,1(0x1)
1c00218c:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:345
1c002190:	280005ae 	ld.b	$r14,$r13,1(0x1)
1c002194:	0281b00d 	addi.w	$r13,$r0,108(0x6c)
1c002198:	58000dcd 	beq	$r14,$r13,12(0xc) # 1c0021a4 <_vsnprintf+0x268>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:343
1c00219c:	001501fe 	move	$r30,$r15
1c0021a0:	50003000 	b	48(0x30) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:347
1c0021a4:	038c03de 	ori	$r30,$r30,0x300
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:348
1c0021a8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0021ac:	2980706c 	st.w	$r12,$r3,28(0x1c)
1c0021b0:	50002000 	b	32(0x20) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:357
1c0021b4:	038303de 	ori	$r30,$r30,0xc0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:358
1c0021b8:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0021bc:	2980706c 	st.w	$r12,$r3,28(0x1c)
1c0021c0:	50001000 	b	16(0x10) # 1c0021d0 <_vsnprintf+0x294>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:364
1c0021c4:	038803de 	ori	$r30,$r30,0x200
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:365
1c0021c8:	028005ad 	addi.w	$r13,$r13,1(0x1)
1c0021cc:	2980706d 	st.w	$r13,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:378
1c0021d0:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c0021d4:	28000184 	ld.b	$r4,$r12,0
1c0021d8:	02bf6c8c 	addi.w	$r12,$r4,-37(0xfdb)
1c0021dc:	0067818e 	bstrpick.w	$r14,$r12,0x7,0x0
1c0021e0:	02814c0d 	addi.w	$r13,$r0,83(0x53)
1c0021e4:	680491ae 	bltu	$r13,$r14,1168(0x490) # 1c002674 <_vsnprintf+0x738>
1c0021e8:	1c00002d 	pcaddu12i	$r13,1(0x1)
1c0021ec:	02a0e1ad 	addi.w	$r13,$r13,-1992(0x838)
1c0021f0:	0004b5cc 	alsl.w	$r12,$r14,$r13,0x2
1c0021f4:	2880018c 	ld.w	$r12,$r12,0
1c0021f8:	4c000180 	jirl	$r0,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:390
1c0021fc:	0281e00c 	addi.w	$r12,$r0,120(0x78)
1c002200:	58002c8c 	beq	$r4,$r12,44(0x2c) # 1c00222c <_vsnprintf+0x2f0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:390 (discriminator 1)
1c002204:	0281600c 	addi.w	$r12,$r0,88(0x58)
1c002208:	5800bc8c 	beq	$r4,$r12,188(0xbc) # 1c0022c4 <_vsnprintf+0x388>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:394
1c00220c:	0281bc0c 	addi.w	$r12,$r0,111(0x6f)
1c002210:	5800bc8c 	beq	$r4,$r12,188(0xbc) # 1c0022cc <_vsnprintf+0x390>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:398
1c002214:	0281880c 	addi.w	$r12,$r0,98(0x62)
1c002218:	5800bc8c 	beq	$r4,$r12,188(0xbc) # 1c0022d4 <_vsnprintf+0x398>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:405
1c00221c:	02bfbc0c 	addi.w	$r12,$r0,-17(0xfef)
1c002220:	0014b3de 	and	$r30,$r30,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:404
1c002224:	0280280a 	addi.w	$r10,$r0,10(0xa)
1c002228:	50000800 	b	8(0x8) # 1c002230 <_vsnprintf+0x2f4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:392
1c00222c:	0280400a 	addi.w	$r10,$r0,16(0x10)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:409
1c002230:	0281600c 	addi.w	$r12,$r0,88(0x58)
1c002234:	5800a88c 	beq	$r4,$r12,168(0xa8) # 1c0022dc <_vsnprintf+0x3a0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:415
1c002238:	0281a40c 	addi.w	$r12,$r0,105(0x69)
1c00223c:	5800148c 	beq	$r4,$r12,20(0x14) # 1c002250 <_vsnprintf+0x314>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:415 (discriminator 1)
1c002240:	0281900c 	addi.w	$r12,$r0,100(0x64)
1c002244:	58000c8c 	beq	$r4,$r12,12(0xc) # 1c002250 <_vsnprintf+0x314>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:417
1c002248:	02bfcc0c 	addi.w	$r12,$r0,-13(0xff3)
1c00224c:	0014b3de 	and	$r30,$r30,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:421
1c002250:	035003cc 	andi	$r12,$r30,0x400
1c002254:	40000d80 	beqz	$r12,12(0xc) # 1c002260 <_vsnprintf+0x324>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:423
1c002258:	02bff80c 	addi.w	$r12,$r0,-2(0xffe)
1c00225c:	0014b3de 	and	$r30,$r30,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:427
1c002260:	0281a40c 	addi.w	$r12,$r0,105(0x69)
1c002264:	5800808c 	beq	$r4,$r12,128(0x80) # 1c0022e4 <_vsnprintf+0x3a8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:427 (discriminator 1)
1c002268:	0281900c 	addi.w	$r12,$r0,100(0x64)
1c00226c:	5800788c 	beq	$r4,$r12,120(0x78) # 1c0022e4 <_vsnprintf+0x3a8>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:448
1c002270:	034803cc 	andi	$r12,$r30,0x200
1c002274:	4400cd80 	bnez	$r12,204(0xcc) # 1c002340 <_vsnprintf+0x404>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:452
1c002278:	034403cc 	andi	$r12,$r30,0x100
1c00227c:	44014d80 	bnez	$r12,332(0x14c) # 1c0023c8 <_vsnprintf+0x48c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:458
1c002280:	034103cc 	andi	$r12,$r30,0x40
1c002284:	40018180 	beqz	$r12,384(0x180) # 1c002404 <_vsnprintf+0x4c8>
1c002288:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c00228c:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002290:	2980606d 	st.w	$r13,$r3,24(0x18)
1c002294:	2a000188 	ld.bu	$r8,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:461 (discriminator 2)
1c002298:	2980107e 	st.w	$r30,$r3,4(0x4)
1c00229c:	2980007f 	st.w	$r31,$r3,0
1c0022a0:	001503ab 	move	$r11,$r29
1c0022a4:	00150009 	move	$r9,$r0
1c0022a8:	00150307 	move	$r7,$r24
1c0022ac:	001502e6 	move	$r6,$r23
1c0022b0:	00150325 	move	$r5,$r25
1c0022b4:	00150344 	move	$r4,$r26
1c0022b8:	57fa47ff 	bl	-1468(0xffffa44) # 1c001cfc <_ntoa_long>
1c0022bc:	00150097 	move	$r23,$r4
1c0022c0:	50008000 	b	128(0x80) # 1c002340 <_vsnprintf+0x404>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:392
1c0022c4:	0280400a 	addi.w	$r10,$r0,16(0x10)
1c0022c8:	53ff6bff 	b	-152(0xfffff68) # 1c002230 <_vsnprintf+0x2f4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:396
1c0022cc:	0280200a 	addi.w	$r10,$r0,8(0x8)
1c0022d0:	53ff63ff 	b	-160(0xfffff60) # 1c002230 <_vsnprintf+0x2f4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:400
1c0022d4:	0280080a 	addi.w	$r10,$r0,2(0x2)
1c0022d8:	53ff5bff 	b	-168(0xfffff58) # 1c002230 <_vsnprintf+0x2f4>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:411
1c0022dc:	038083de 	ori	$r30,$r30,0x20
1c0022e0:	53ff5bff 	b	-168(0xfffff58) # 1c002238 <_vsnprintf+0x2fc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:430
1c0022e4:	034803cc 	andi	$r12,$r30,0x200
1c0022e8:	44005980 	bnez	$r12,88(0x58) # 1c002340 <_vsnprintf+0x404>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:433
1c0022ec:	034403cc 	andi	$r12,$r30,0x100
1c0022f0:	44006180 	bnez	$r12,96(0x60) # 1c002350 <_vsnprintf+0x414>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:440
1c0022f4:	034103cc 	andi	$r12,$r30,0x40
1c0022f8:	4000a180 	beqz	$r12,160(0xa0) # 1c002398 <_vsnprintf+0x45c>
1c0022fc:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c002300:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002304:	2980606d 	st.w	$r13,$r3,24(0x18)
1c002308:	28000189 	ld.b	$r9,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:442 (discriminator 2)
1c00230c:	0048fd2c 	srai.w	$r12,$r9,0x1f
1c002310:	0015a588 	xor	$r8,$r12,$r9
1c002314:	2980107e 	st.w	$r30,$r3,4(0x4)
1c002318:	2980007f 	st.w	$r31,$r3,0
1c00231c:	001503ab 	move	$r11,$r29
1c002320:	0044fd29 	srli.w	$r9,$r9,0x1f
1c002324:	00113108 	sub.w	$r8,$r8,$r12
1c002328:	00150307 	move	$r7,$r24
1c00232c:	001502e6 	move	$r6,$r23
1c002330:	00150325 	move	$r5,$r25
1c002334:	00150344 	move	$r4,$r26
1c002338:	57f9c7ff 	bl	-1596(0xffff9c4) # 1c001cfc <_ntoa_long>
1c00233c:	00150097 	move	$r23,$r4
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:465
1c002340:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c002344:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c002348:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:466
1c00234c:	53fc3fff 	b	-964(0xffffc3c) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:435
1c002350:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c002354:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002358:	2980606d 	st.w	$r13,$r3,24(0x18)
1c00235c:	28800189 	ld.w	$r9,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:436
1c002360:	0048fd2c 	srai.w	$r12,$r9,0x1f
1c002364:	0015a588 	xor	$r8,$r12,$r9
1c002368:	2980107e 	st.w	$r30,$r3,4(0x4)
1c00236c:	2980007f 	st.w	$r31,$r3,0
1c002370:	001503ab 	move	$r11,$r29
1c002374:	0044fd29 	srli.w	$r9,$r9,0x1f
1c002378:	00113108 	sub.w	$r8,$r8,$r12
1c00237c:	00150307 	move	$r7,$r24
1c002380:	001502e6 	move	$r6,$r23
1c002384:	00150325 	move	$r5,$r25
1c002388:	00150344 	move	$r4,$r26
1c00238c:	57f973ff 	bl	-1680(0xffff970) # 1c001cfc <_ntoa_long>
1c002390:	00150097 	move	$r23,$r4
1c002394:	53ffafff 	b	-84(0xfffffac) # 1c002340 <_vsnprintf+0x404>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:441
1c002398:	034203cc 	andi	$r12,$r30,0x80
1c00239c:	40001980 	beqz	$r12,24(0x18) # 1c0023b4 <_vsnprintf+0x478>
1c0023a0:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c0023a4:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c0023a8:	2980606d 	st.w	$r13,$r3,24(0x18)
1c0023ac:	28400189 	ld.h	$r9,$r12,0
1c0023b0:	53ff5fff 	b	-164(0xfffff5c) # 1c00230c <_vsnprintf+0x3d0>
1c0023b4:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c0023b8:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c0023bc:	2980606d 	st.w	$r13,$r3,24(0x18)
1c0023c0:	28800189 	ld.w	$r9,$r12,0
1c0023c4:	53ff4bff 	b	-184(0xfffff48) # 1c00230c <_vsnprintf+0x3d0>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:454
1c0023c8:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c0023cc:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c0023d0:	2980606d 	st.w	$r13,$r3,24(0x18)
1c0023d4:	28800188 	ld.w	$r8,$r12,0
1c0023d8:	2980107e 	st.w	$r30,$r3,4(0x4)
1c0023dc:	2980007f 	st.w	$r31,$r3,0
1c0023e0:	001503ab 	move	$r11,$r29
1c0023e4:	00150009 	move	$r9,$r0
1c0023e8:	00150307 	move	$r7,$r24
1c0023ec:	001502e6 	move	$r6,$r23
1c0023f0:	00150325 	move	$r5,$r25
1c0023f4:	00150344 	move	$r4,$r26
1c0023f8:	57f907ff 	bl	-1788(0xffff904) # 1c001cfc <_ntoa_long>
1c0023fc:	00150097 	move	$r23,$r4
1c002400:	53ff43ff 	b	-192(0xfffff40) # 1c002340 <_vsnprintf+0x404>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:459
1c002404:	034203cc 	andi	$r12,$r30,0x80
1c002408:	40001980 	beqz	$r12,24(0x18) # 1c002420 <_vsnprintf+0x4e4>
1c00240c:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c002410:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002414:	2980606d 	st.w	$r13,$r3,24(0x18)
1c002418:	2a400188 	ld.hu	$r8,$r12,0
1c00241c:	53fe7fff 	b	-388(0xffffe7c) # 1c002298 <_vsnprintf+0x35c>
1c002420:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c002424:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002428:	2980606d 	st.w	$r13,$r3,24(0x18)
1c00242c:	28800188 	ld.w	$r8,$r12,0
1c002430:	53fe6bff 	b	-408(0xffffe68) # 1c002298 <_vsnprintf+0x35c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:473
1c002434:	03400bde 	andi	$r30,$r30,0x2
1c002438:	400073c0 	beqz	$r30,112(0x70) # 1c0024a8 <_vsnprintf+0x56c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:471
1c00243c:	0280041b 	addi.w	$r27,$r0,1(0x1)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:482
1c002440:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c002444:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002448:	2980606d 	st.w	$r13,$r3,24(0x18)
1c00244c:	028006fc 	addi.w	$r28,$r23,1(0x1)
1c002450:	00150307 	move	$r7,$r24
1c002454:	001502e6 	move	$r6,$r23
1c002458:	00150325 	move	$r5,$r25
1c00245c:	28000184 	ld.b	$r4,$r12,0
1c002460:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:484
1c002464:	44006fc0 	bnez	$r30,108(0x6c) # 1c0024d0 <_vsnprintf+0x594>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:492
1c002468:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c00246c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c002470:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:493
1c002474:	00150397 	move	$r23,$r28
1c002478:	53fb13ff 	b	-1264(0xffffb10) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:477
1c00247c:	028006fc 	addi.w	$r28,$r23,1(0x1)
1c002480:	00150307 	move	$r7,$r24
1c002484:	001502e6 	move	$r6,$r23
1c002488:	00150325 	move	$r5,$r25
1c00248c:	02808004 	addi.w	$r4,$r0,32(0x20)
1c002490:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:475
1c002494:	0015036c 	move	$r12,$r27
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:477
1c002498:	00150397 	move	$r23,$r28
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:475
1c00249c:	0280059b 	addi.w	$r27,$r12,1(0x1)
1c0024a0:	6bffdd9f 	bltu	$r12,$r31,-36(0x3ffdc) # 1c00247c <_vsnprintf+0x540>
1c0024a4:	53ff9fff 	b	-100(0xfffff9c) # 1c002440 <_vsnprintf+0x504>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:471
1c0024a8:	0280040c 	addi.w	$r12,$r0,1(0x1)
1c0024ac:	53fff3ff 	b	-16(0xffffff0) # 1c00249c <_vsnprintf+0x560>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:488
1c0024b0:	0280079d 	addi.w	$r29,$r28,1(0x1)
1c0024b4:	00150307 	move	$r7,$r24
1c0024b8:	00150386 	move	$r6,$r28
1c0024bc:	00150325 	move	$r5,$r25
1c0024c0:	02808004 	addi.w	$r4,$r0,32(0x20)
1c0024c4:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:486
1c0024c8:	001502fb 	move	$r27,$r23
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:488
1c0024cc:	001503bc 	move	$r28,$r29
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:486
1c0024d0:	02800777 	addi.w	$r23,$r27,1(0x1)
1c0024d4:	6bffdf7f 	bltu	$r27,$r31,-36(0x3ffdc) # 1c0024b0 <_vsnprintf+0x574>
1c0024d8:	53ff93ff 	b	-112(0xfffff90) # 1c002468 <_vsnprintf+0x52c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:498
1c0024dc:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c0024e0:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c0024e4:	2980606d 	st.w	$r13,$r3,24(0x18)
1c0024e8:	2880019c 	ld.w	$r28,$r12,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:499
1c0024ec:	44002ba0 	bnez	$r29,40(0x28) # 1c002514 <_vsnprintf+0x5d8>
1c0024f0:	02bffc0c 	addi.w	$r12,$r0,-1(0xfff)
1c0024f4:	0015039b 	move	$r27,$r28
_strnlen_s():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:60
1c0024f8:	2800036d 	ld.b	$r13,$r27,0
1c0024fc:	400021a0 	beqz	$r13,32(0x20) # 1c00251c <_vsnprintf+0x5e0>
1c002500:	02bffd8d 	addi.w	$r13,$r12,-1(0xfff)
1c002504:	40001980 	beqz	$r12,24(0x18) # 1c00251c <_vsnprintf+0x5e0>
1c002508:	0280077b 	addi.w	$r27,$r27,1(0x1)
1c00250c:	001501ac 	move	$r12,$r13
1c002510:	53ffebff 	b	-24(0xfffffe8) # 1c0024f8 <_vsnprintf+0x5bc>
_vsnprintf():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:499
1c002514:	001503ac 	move	$r12,$r29
1c002518:	53ffdfff 	b	-36(0xfffffdc) # 1c0024f4 <_vsnprintf+0x5b8>
_strnlen_s():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:61
1c00251c:	0011737b 	sub.w	$r27,$r27,$r28
_vsnprintf():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:501
1c002520:	035003d6 	andi	$r22,$r30,0x400
1c002524:	400016c0 	beqz	$r22,20(0x14) # 1c002538 <_vsnprintf+0x5fc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:503
1c002528:	0012efac 	sltu	$r12,$r29,$r27
1c00252c:	0013b37b 	masknez	$r27,$r27,$r12
1c002530:	001333ac 	maskeqz	$r12,$r29,$r12
1c002534:	0015337b 	or	$r27,$r27,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:506
1c002538:	03400bcc 	andi	$r12,$r30,0x2
1c00253c:	2980506c 	st.w	$r12,$r3,20(0x14)
1c002540:	44005d80 	bnez	$r12,92(0x5c) # 1c00259c <_vsnprintf+0x660>
1c002544:	50002800 	b	40(0x28) # 1c00256c <_vsnprintf+0x630>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:510
1c002548:	028006ec 	addi.w	$r12,$r23,1(0x1)
1c00254c:	2980406c 	st.w	$r12,$r3,16(0x10)
1c002550:	00150307 	move	$r7,$r24
1c002554:	001502e6 	move	$r6,$r23
1c002558:	00150325 	move	$r5,$r25
1c00255c:	02808004 	addi.w	$r4,$r0,32(0x20)
1c002560:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:508
1c002564:	001503db 	move	$r27,$r30
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:510
1c002568:	28804077 	ld.w	$r23,$r3,16(0x10)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:508
1c00256c:	0280077e 	addi.w	$r30,$r27,1(0x1)
1c002570:	6bffdb7f 	bltu	$r27,$r31,-40(0x3ffd8) # 1c002548 <_vsnprintf+0x60c>
1c002574:	001503db 	move	$r27,$r30
1c002578:	50002400 	b	36(0x24) # 1c00259c <_vsnprintf+0x660>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:515
1c00257c:	0015019d 	move	$r29,$r12
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:517
1c002580:	0280079c 	addi.w	$r28,$r28,1(0x1)
1c002584:	028006fe 	addi.w	$r30,$r23,1(0x1)
1c002588:	00150307 	move	$r7,$r24
1c00258c:	001502e6 	move	$r6,$r23
1c002590:	00150325 	move	$r5,$r25
1c002594:	4c000341 	jirl	$r1,$r26,0
1c002598:	001503d7 	move	$r23,$r30
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:515
1c00259c:	28000384 	ld.b	$r4,$r28,0
1c0025a0:	40001080 	beqz	$r4,16(0x10) # 1c0025b0 <_vsnprintf+0x674>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:515 (discriminator 1)
1c0025a4:	43ffdedf 	beqz	$r22,-36(0x7fffdc) # 1c002580 <_vsnprintf+0x644>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:515 (discriminator 2)
1c0025a8:	02bfffac 	addi.w	$r12,$r29,-1(0xfff)
1c0025ac:	47ffd3bf 	bnez	$r29,-48(0x7fffd0) # 1c00257c <_vsnprintf+0x640>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:521
1c0025b0:	2880506c 	ld.w	$r12,$r3,20(0x14)
1c0025b4:	44003580 	bnez	$r12,52(0x34) # 1c0025e8 <_vsnprintf+0x6ac>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:529
1c0025b8:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c0025bc:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c0025c0:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:530
1c0025c4:	53f9c7ff 	b	-1596(0xffff9c4) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:525
1c0025c8:	028006fd 	addi.w	$r29,$r23,1(0x1)
1c0025cc:	00150307 	move	$r7,$r24
1c0025d0:	001502e6 	move	$r6,$r23
1c0025d4:	00150325 	move	$r5,$r25
1c0025d8:	02808004 	addi.w	$r4,$r0,32(0x20)
1c0025dc:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:523
1c0025e0:	0015039b 	move	$r27,$r28
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:525
1c0025e4:	001503b7 	move	$r23,$r29
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:523
1c0025e8:	0280077c 	addi.w	$r28,$r27,1(0x1)
1c0025ec:	6bffdf7f 	bltu	$r27,$r31,-36(0x3ffdc) # 1c0025c8 <_vsnprintf+0x68c>
1c0025f0:	53ffcbff 	b	-56(0xfffffc8) # 1c0025b8 <_vsnprintf+0x67c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:536
1c0025f4:	038087de 	ori	$r30,$r30,0x21
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:537
1c0025f8:	2880606c 	ld.w	$r12,$r3,24(0x18)
1c0025fc:	0280118d 	addi.w	$r13,$r12,4(0x4)
1c002600:	2980606d 	st.w	$r13,$r3,24(0x18)
1c002604:	28800188 	ld.w	$r8,$r12,0
1c002608:	2980107e 	st.w	$r30,$r3,4(0x4)
1c00260c:	0280200c 	addi.w	$r12,$r0,8(0x8)
1c002610:	2980006c 	st.w	$r12,$r3,0
1c002614:	001503ab 	move	$r11,$r29
1c002618:	0280400a 	addi.w	$r10,$r0,16(0x10)
1c00261c:	00150009 	move	$r9,$r0
1c002620:	00150307 	move	$r7,$r24
1c002624:	001502e6 	move	$r6,$r23
1c002628:	00150325 	move	$r5,$r25
1c00262c:	00150344 	move	$r4,$r26
1c002630:	57f6cfff 	bl	-2356(0xffff6cc) # 1c001cfc <_ntoa_long>
1c002634:	00150097 	move	$r23,$r4
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:538
1c002638:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c00263c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c002640:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:539
1c002644:	53f947ff 	b	-1724(0xffff944) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:543
1c002648:	028006fb 	addi.w	$r27,$r23,1(0x1)
1c00264c:	00150307 	move	$r7,$r24
1c002650:	001502e6 	move	$r6,$r23
1c002654:	00150325 	move	$r5,$r25
1c002658:	02809404 	addi.w	$r4,$r0,37(0x25)
1c00265c:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:544
1c002660:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c002664:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c002668:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:543
1c00266c:	00150377 	move	$r23,$r27
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:545
1c002670:	53f91bff 	b	-1768(0xffff918) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:548
1c002674:	028006fb 	addi.w	$r27,$r23,1(0x1)
1c002678:	00150307 	move	$r7,$r24
1c00267c:	001502e6 	move	$r6,$r23
1c002680:	00150325 	move	$r5,$r25
1c002684:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:549
1c002688:	2880706c 	ld.w	$r12,$r3,28(0x1c)
1c00268c:	0280058c 	addi.w	$r12,$r12,1(0x1)
1c002690:	2980706c 	st.w	$r12,$r3,28(0x1c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:548
1c002694:	00150377 	move	$r23,$r27
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:550
1c002698:	53f8f3ff 	b	-1808(0xffff8f0) # 1c001f88 <_vsnprintf+0x4c>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:265
1c00269c:	1dfffffa 	pcaddu12i	$r26,-1(0xfffff)
1c0026a0:	028d335a 	addi.w	$r26,$r26,844(0x34c)
1c0026a4:	53f8e3ff 	b	-1824(0xffff8e0) # 1c001f84 <_vsnprintf+0x48>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:555
1c0026a8:	680052f8 	bltu	$r23,$r24,80(0x50) # 1c0026f8 <_vsnprintf+0x7bc>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:555 (discriminator 1)
1c0026ac:	02bfff06 	addi.w	$r6,$r24,-1(0xfff)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:555 (discriminator 4)
1c0026b0:	00150307 	move	$r7,$r24
1c0026b4:	00150325 	move	$r5,$r25
1c0026b8:	00150004 	move	$r4,$r0
1c0026bc:	4c000341 	jirl	$r1,$r26,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:559 (discriminator 4)
1c0026c0:	001502e4 	move	$r4,$r23
1c0026c4:	28813061 	ld.w	$r1,$r3,76(0x4c)
1c0026c8:	28812076 	ld.w	$r22,$r3,72(0x48)
1c0026cc:	28811077 	ld.w	$r23,$r3,68(0x44)
1c0026d0:	28810078 	ld.w	$r24,$r3,64(0x40)
1c0026d4:	2880f079 	ld.w	$r25,$r3,60(0x3c)
1c0026d8:	2880e07a 	ld.w	$r26,$r3,56(0x38)
1c0026dc:	2880d07b 	ld.w	$r27,$r3,52(0x34)
1c0026e0:	2880c07c 	ld.w	$r28,$r3,48(0x30)
1c0026e4:	2880b07d 	ld.w	$r29,$r3,44(0x2c)
1c0026e8:	2880a07e 	ld.w	$r30,$r3,40(0x28)
1c0026ec:	2880907f 	ld.w	$r31,$r3,36(0x24)
1c0026f0:	02814063 	addi.w	$r3,$r3,80(0x50)
1c0026f4:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:555
1c0026f8:	001502e6 	move	$r6,$r23
1c0026fc:	53ffb7ff 	b	-76(0xfffffb4) # 1c0026b0 <_vsnprintf+0x774>

1c002700 <_out_char>:
_out_char():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:49
1c002700:	44000880 	bnez	$r4,8(0x8) # 1c002708 <_out_char+0x8>
1c002704:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:47
1c002708:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c00270c:	29803061 	st.w	$r1,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:51
1c002710:	57f2bbff 	bl	-3400(0xffff2b8) # 1c0019c8 <_putchar>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:53
1c002714:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002718:	02804063 	addi.w	$r3,$r3,16(0x10)
1c00271c:	4c000020 	jirl	$r0,$r1,0

1c002720 <printf>:
printf():
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:562
1c002720:	02bf0063 	addi.w	$r3,$r3,-64(0xfc0)
1c002724:	29807061 	st.w	$r1,$r3,28(0x1c)
1c002728:	29809065 	st.w	$r5,$r3,36(0x24)
1c00272c:	2980a066 	st.w	$r6,$r3,40(0x28)
1c002730:	2980b067 	st.w	$r7,$r3,44(0x2c)
1c002734:	2980c068 	st.w	$r8,$r3,48(0x30)
1c002738:	2980d069 	st.w	$r9,$r3,52(0x34)
1c00273c:	2980e06a 	st.w	$r10,$r3,56(0x38)
1c002740:	2980f06b 	st.w	$r11,$r3,60(0x3c)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:564
1c002744:	02809068 	addi.w	$r8,$r3,36(0x24)
1c002748:	29803068 	st.w	$r8,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:566
1c00274c:	00150087 	move	$r7,$r4
1c002750:	02bffc06 	addi.w	$r6,$r0,-1(0xfff)
1c002754:	02802065 	addi.w	$r5,$r3,8(0x8)
1c002758:	1c000004 	pcaddu12i	$r4,0
1c00275c:	02bea084 	addi.w	$r4,$r4,-88(0xfa8)
1c002760:	57f7dfff 	bl	-2084(0xffff7dc) # 1c001f3c <_vsnprintf>
D:/LA132_SoC_SW_EXP/bsp/PRINTF/printf.c:569
1c002764:	28807061 	ld.w	$r1,$r3,28(0x1c)
1c002768:	02810063 	addi.w	$r3,$r3,64(0x40)
1c00276c:	4c000020 	jirl	$r0,$r1,0

1c002770 <main>:
main():
D:/LA132_SoC_SW_EXP/user/main.c:45
1c002770:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002774:	29803061 	st.w	$r1,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/user/main.c:51
1c002778:	00150005 	move	$r5,$r0
1c00277c:	14000384 	lu12i.w	$r4,28(0x1c)
1c002780:	03880084 	ori	$r4,$r4,0x200
1c002784:	57f077ff 	bl	-3980(0xffff074) # 1c0017f8 <uart_init>
D:/LA132_SoC_SW_EXP/user/main.c:53
1c002788:	1c000004 	pcaddu12i	$r4,0
1c00278c:	028fa084 	addi.w	$r4,$r4,1000(0x3e8)
1c002790:	57ff93ff 	bl	-112(0xfffff90) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/user/main.c:54
1c002794:	02806c05 	addi.w	$r5,$r0,27(0x1b)
1c002798:	1c000004 	pcaddu12i	$r4,0
1c00279c:	02903084 	addi.w	$r4,$r4,1036(0x40c)
1c0027a0:	57ff83ff 	bl	-128(0xfffff80) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/user/main.c:55
1c0027a4:	1c000004 	pcaddu12i	$r4,0
1c0027a8:	02908084 	addi.w	$r4,$r4,1056(0x420)
1c0027ac:	57ff77ff 	bl	-140(0xfffff74) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/user/main.c:169
1c0027b0:	1c000004 	pcaddu12i	$r4,0
1c0027b4:	02912084 	addi.w	$r4,$r4,1096(0x448)
1c0027b8:	57ff6bff 	bl	-152(0xfffff68) # 1c002720 <printf>
D:/LA132_SoC_SW_EXP/user/main.c:170
1c0027bc:	57ecabff 	bl	-4952(0xfffeca8) # 1c001464 <kbd_scan_demo>
D:/LA132_SoC_SW_EXP/user/main.c:203 (discriminator 1)
1c0027c0:	50000000 	b	0 # 1c0027c0 <main+0x50>

1c0027c4 <Write_INT_EENTRY>:
Write_INT_EENTRY():
D:/LA132_SoC_SW_EXP/user/interrupt.c:35
1c0027c4:	1438002c 	lu12i.w	$r12,114689(0x1c001)
1c0027c8:	0400302c 	csrwr	$r12,0xc
D:/LA132_SoC_SW_EXP/user/interrupt.c:38
1c0027cc:	4c000020 	jirl	$r0,$r1,0

1c0027d0 <Enable_LA_Globl_Int>:
Enable_LA_Globl_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:41
1c0027d0:	0380100c 	ori	$r12,$r0,0x4
1c0027d4:	0400018c 	csrxchg	$r12,$r12,0x0
D:/LA132_SoC_SW_EXP/user/interrupt.c:44
1c0027d8:	4c000020 	jirl	$r0,$r1,0

1c0027dc <Enable_LA_Local_Int>:
Enable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:57
1c0027dc:	0280040c 	addi.w	$r12,$r0,1(0x1)
1c0027e0:	0280088d 	addi.w	$r13,$r4,2(0x2)
1c0027e4:	0017358c 	sll.w	$r12,$r12,$r13
1c0027e8:	0400118c 	csrxchg	$r12,$r12,0x4
D:/LA132_SoC_SW_EXP/user/interrupt.c:62
1c0027ec:	4c000020 	jirl	$r0,$r1,0

1c0027f0 <Set_LA_VS>:
Set_LA_VS():
D:/LA132_SoC_SW_EXP/user/interrupt.c:73
1c0027f0:	0280008c 	addi.w	$r12,$r4,0
1c0027f4:	0040c18c 	slli.w	$r12,$r12,0x10
1c0027f8:	0400118c 	csrxchg	$r12,$r12,0x4
D:/LA132_SoC_SW_EXP/user/interrupt.c:77
1c0027fc:	4c000020 	jirl	$r0,$r1,0

1c002800 <intc_irq_init>:
intc_irq_init():
D:/LA132_SoC_SW_EXP/user/interrupt.c:83
1c002800:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002804:	29803061 	st.w	$r1,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/user/interrupt.c:84
1c002808:	57ffbfff 	bl	-68(0xfffffbc) # 1c0027c4 <Write_INT_EENTRY>
D:/LA132_SoC_SW_EXP/user/interrupt.c:85
1c00280c:	00150004 	move	$r4,$r0
1c002810:	57ffe3ff 	bl	-32(0xfffffe0) # 1c0027f0 <Set_LA_VS>
D:/LA132_SoC_SW_EXP/user/interrupt.c:86
1c002814:	02801004 	addi.w	$r4,$r0,4(0x4)
1c002818:	57ffc7ff 	bl	-60(0xfffffc4) # 1c0027dc <Enable_LA_Local_Int>
D:/LA132_SoC_SW_EXP/user/interrupt.c:87
1c00281c:	57ffb7ff 	bl	-76(0xfffffb4) # 1c0027d0 <Enable_LA_Globl_Int>
D:/LA132_SoC_SW_EXP/user/interrupt.c:88
1c002820:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002824:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002828:	4c000020 	jirl	$r0,$r1,0

1c00282c <intc_irq_attach>:
intc_irq_attach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:99
1c00282c:	02803c0c 	addi.w	$r12,$r0,15(0xf)
1c002830:	68001584 	bltu	$r12,$r4,20(0x14) # 1c002844 <intc_irq_attach+0x18>
D:/LA132_SoC_SW_EXP/user/interrupt.c:100
1c002834:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c002838:	02a1518c 	addi.w	$r12,$r12,-1964(0x854)
1c00283c:	0004b084 	alsl.w	$r4,$r4,$r12,0x2
1c002840:	29800085 	st.w	$r5,$r4,0
D:/LA132_SoC_SW_EXP/user/interrupt.c:102
1c002844:	4c000020 	jirl	$r0,$r1,0

1c002848 <intc_irq_dispatch>:
intc_irq_dispatch():
D:/LA132_SoC_SW_EXP/user/interrupt.c:113
1c002848:	02803c0c 	addi.w	$r12,$r0,15(0xf)
1c00284c:	68003184 	bltu	$r12,$r4,48(0x30) # 1c00287c <intc_irq_dispatch+0x34>
D:/LA132_SoC_SW_EXP/user/interrupt.c:113 (discriminator 1)
1c002850:	1cc7ffcc 	pcaddu12i	$r12,409598(0x63ffe)
1c002854:	02a0e18c 	addi.w	$r12,$r12,-1992(0x838)
1c002858:	0004b084 	alsl.w	$r4,$r4,$r12,0x2
1c00285c:	2880008c 	ld.w	$r12,$r4,0
1c002860:	40001d80 	beqz	$r12,28(0x1c) # 1c00287c <intc_irq_dispatch+0x34>
D:/LA132_SoC_SW_EXP/user/interrupt.c:112
1c002864:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002868:	29803061 	st.w	$r1,$r3,12(0xc)
D:/LA132_SoC_SW_EXP/user/interrupt.c:114
1c00286c:	4c000181 	jirl	$r1,$r12,0
D:/LA132_SoC_SW_EXP/user/interrupt.c:116
1c002870:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002874:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002878:	4c000020 	jirl	$r0,$r1,0
1c00287c:	4c000020 	jirl	$r0,$r1,0

1c002880 <uart_handler>:
uart_handler():
D:/LA132_SoC_SW_EXP/user/interrupt.c:135
1c002880:	02bfc063 	addi.w	$r3,$r3,-16(0xff0)
1c002884:	29803061 	st.w	$r1,$r3,12(0xc)
1c002888:	29802077 	st.w	$r23,$r3,8(0x8)
1c00288c:	29801078 	st.w	$r24,$r3,4(0x4)
D:/LA132_SoC_SW_EXP/user/interrupt.c:139
1c002890:	57ef53ff 	bl	-4272(0xfffef50) # 1c0017e0 <uart_irq_count_inc>
D:/LA132_SoC_SW_EXP/user/interrupt.c:141
1c002894:	1460040d 	lu12i.w	$r13,196640(0x30020)
1c002898:	288001b8 	ld.w	$r24,$r13,0
D:/LA132_SoC_SW_EXP/user/interrupt.c:142
1c00289c:	02bff80c 	addi.w	$r12,$r0,-2(0xffe)
1c0028a0:	0014b30c 	and	$r12,$r24,$r12
1c0028a4:	298001ac 	st.w	$r12,$r13,0
D:/LA132_SoC_SW_EXP/user/interrupt.c:136
1c0028a8:	0015000d 	move	$r13,$r0
D:/LA132_SoC_SW_EXP/user/interrupt.c:148
1c0028ac:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c0028b0:	0380118c 	ori	$r12,$r12,0x4
1c0028b4:	2880018c 	ld.w	$r12,$r12,0
1c0028b8:	0340058c 	andi	$r12,$r12,0x1
1c0028bc:	40002980 	beqz	$r12,40(0x28) # 1c0028e4 <uart_handler+0x64>
D:/LA132_SoC_SW_EXP/user/interrupt.c:148 (discriminator 1)
1c0028c0:	028005b7 	addi.w	$r23,$r13,1(0x1)
1c0028c4:	0280fc0c 	addi.w	$r12,$r0,63(0x3f)
1c0028c8:	60001d8d 	blt	$r12,$r13,28(0x1c) # 1c0028e4 <uart_handler+0x64>
D:/LA132_SoC_SW_EXP/user/interrupt.c:149
1c0028cc:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c0028d0:	28800184 	ld.w	$r4,$r12,0
1c0028d4:	00678084 	bstrpick.w	$r4,$r4,0x7,0x0
1c0028d8:	57f087ff 	bl	-3964(0xffff084) # 1c00195c <uart_rx_push>
D:/LA132_SoC_SW_EXP/user/interrupt.c:148
1c0028dc:	001502ed 	move	$r13,$r23
1c0028e0:	53ffcfff 	b	-52(0xfffffcc) # 1c0028ac <uart_handler+0x2c>
D:/LA132_SoC_SW_EXP/user/interrupt.c:152
1c0028e4:	1460020c 	lu12i.w	$r12,196624(0x30010)
1c0028e8:	0380118c 	ori	$r12,$r12,0x4
1c0028ec:	2880018c 	ld.w	$r12,$r12,0
1c0028f0:	0340058c 	andi	$r12,$r12,0x1
1c0028f4:	44002180 	bnez	$r12,32(0x20) # 1c002914 <uart_handler+0x94>
D:/LA132_SoC_SW_EXP/user/interrupt.c:160
1c0028f8:	1460040c 	lu12i.w	$r12,196640(0x30020)
1c0028fc:	29800198 	st.w	$r24,$r12,0
D:/LA132_SoC_SW_EXP/user/interrupt.c:161
1c002900:	28803061 	ld.w	$r1,$r3,12(0xc)
1c002904:	28802077 	ld.w	$r23,$r3,8(0x8)
1c002908:	28801078 	ld.w	$r24,$r3,4(0x4)
1c00290c:	02804063 	addi.w	$r3,$r3,16(0x10)
1c002910:	4c000020 	jirl	$r0,$r1,0
D:/LA132_SoC_SW_EXP/user/interrupt.c:156
1c002914:	00150004 	move	$r4,$r0
1c002918:	57f033ff 	bl	-4048(0xffff030) # 1c001948 <uart_irq_rx_mode>
D:/LA132_SoC_SW_EXP/user/interrupt.c:157
1c00291c:	53ffe7ff 	b	-28(0xfffffe4) # 1c002900 <uart_handler+0x80>

Disassembly of section .rodata:

1c002920 <s_key_char-0xac>:
1c002920:	32707865 	0x32707865
1c002924:	7834203a 	0x7834203a
1c002928:	656b2034 	bge	$r1,$r20,92960(0x16b20) # 1c019448 <_sidata+0x1681c>
1c00292c:	64617079 	bge	$r3,$r25,24944(0x6170) # 1c008a9c <_sidata+0x5e70>
1c002930:	6373202c 	blt	$r1,$r12,-36064(0x37320) # 1bff9c50 <_start-0x63b0>
1c002934:	656e6e61 	bge	$r19,$r1,93804(0x16e6c) # 1c0197a0 <_sidata+0x16b74>
1c002938:	6e692064 	bgeu	$r3,$r4,-104160(0x26920) # 1bfe9258 <_start-0x16da8>
1c00293c:	736d3120 	vssrarni.wu.d	$vr0,$vr9,0xc
1c002940:	6d697420 	bgeu	$r1,$r0,92532(0x16974) # 1c0192b4 <_sidata+0x16688>
1c002944:	49207265 	0x49207265
1c002948:	28205253 	ld.b	$r19,$r18,-2028(0x814)
1c00294c:	6f626564 	bgeu	$r11,$r4,-40348(0x36264) # 1bff8bb0 <_start-0x7450>
1c002950:	65636e75 	bge	$r19,$r21,90988(0x1636c) # 1c018cbc <_sidata+0x16090>
1c002954:	20752520 	ll.w	$r0,$r9,29988(0x7524)
1c002958:	6e756f72 	bgeu	$r27,$r18,-101012(0x2756c) # 1bfe9ec4 <_start-0x1613c>
1c00295c:	0d297364 	xvbitsel.v	$xr4,$xr27,$xr28,$xr18
1c002960:	0000000a 	0x0000000a
1c002964:	73776f72 	0x73776f72
1c002968:	67203d20 	bge	$r9,$r0,-57284(0x3203c) # 1bff49a4 <_start-0xb65c>
1c00296c:	616f6970 	blt	$r11,$r16,94056(0x16f68) # 1c0198d4 <_sidata+0x16ca8>
1c002970:	3a39315b 	0x3a39315b
1c002974:	205d3631 	ll.w	$r17,$r17,23860(0x5d34)
1c002978:	2c74756f 	vst	$vr15,$r11,-739(0xd1d)
1c00297c:	6c6f6320 	bgeu	$r25,$r0,28512(0x6f60) # 1c0098dc <_sidata+0x6cb0>
1c002980:	203d2073 	ll.w	$r19,$r3,15648(0x3d20)
1c002984:	6f697067 	bgeu	$r3,$r7,-38544(0x36970) # 1bff92f4 <_start-0x6d0c>
1c002988:	31315b61 	0x31315b61
1c00298c:	205d383a 	ll.w	$r26,$r1,23864(0x5d38)
1c002990:	28206e69 	ld.b	$r9,$r19,-2021(0x81b)
1c002994:	6c6c7570 	bgeu	$r11,$r16,27764(0x6c74) # 1c009608 <_sidata+0x69dc>
1c002998:	2970752d 	st.h	$r13,$r9,-995(0xc1d)
1c00299c:	00000a0d 	0x00000a0d
1c0029a0:	3d59454b 	0x3d59454b
1c0029a4:	28206425 	ld.b	$r5,$r1,-2023(0x819)
1c0029a8:	0d296325 	xvbitsel.v	$xr5,$xr25,$xr24,$xr18
1c0029ac:	0000000a 	0x0000000a
1c0029b0:	5d42485b 	bne	$r2,$r27,82504(0x14248) # 1c016bf8 <_sidata+0x13fcc>
1c0029b4:	79656b20 	0x79656b20
1c0029b8:	75253d73 	0x75253d73
1c0029bc:	71726920 	0x71726920
1c0029c0:	2075253d 	ll.w	$r29,$r9,29988(0x7524)
1c0029c4:	73312820 	vsrli.d	$vr0,$vr1,0xa
1c0029c8:	000a0d29 	0x000a0d29

1c0029cc <s_key_char>:
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:45
1c0029cc:	33323130 	xvstelm.w	$xr16,$r9,-464(0x230),0x4
1c0029d0:	37363534 	0x37363534
1c0029d4:	42413938 	beqz	$r9,-1949384(0x624138) # 1be26b0c <_start-0x1d94f4>
1c0029d8:	46454443 	bnez	$r2,935236(0xe4544) # 1c0e6f1c <_sidata+0xe42f0>
1c0029dc:	1c002090 	pcaddu12i	$r16,260(0x104)
1c0029e0:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c0029e4:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c0029e8:	1c0020a0 	pcaddu12i	$r0,261(0x105)
1c0029ec:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c0029f0:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c0029f4:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c0029f8:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c0029fc:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c002a00:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c002a04:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c002a08:	1c002080 	pcaddu12i	$r0,260(0x104)
1c002a0c:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c002a10:	1c002070 	pcaddu12i	$r16,259(0x103)
1c002a14:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c002a18:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
1c002a1c:	1c002038 	pcaddu12i	$r24,257(0x101)
1c002a20:	1c002648 	pcaddu12i	$r8,306(0x132)
1c002a24:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a28:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a2c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a30:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a34:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a38:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a3c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a40:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a44:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a48:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a4c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a50:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a54:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a58:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a5c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a60:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a64:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a68:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a6c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a70:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a74:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a78:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a7c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a80:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a84:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a88:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a8c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a90:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a94:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a98:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002a9c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002aa0:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002aa4:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002aa8:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002aac:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ab0:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ab4:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ab8:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002abc:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ac0:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ac4:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ac8:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002acc:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ad0:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ad4:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ad8:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002adc:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ae0:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ae4:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002ae8:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002aec:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002af0:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002af4:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002af8:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002afc:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b00:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b04:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b08:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b0c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b10:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b14:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002b18:	1c002434 	pcaddu12i	$r20,289(0x121)
1c002b1c:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002b20:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b24:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b28:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b2c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b30:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002b34:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b38:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b3c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b40:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b44:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b48:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002b4c:	1c0025f4 	pcaddu12i	$r20,303(0x12f)
1c002b50:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b54:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b58:	1c0024dc 	pcaddu12i	$r28,294(0x126)
1c002b5c:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b60:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002b64:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b68:	1c002674 	pcaddu12i	$r20,307(0x133)
1c002b6c:	1c0021fc 	pcaddu12i	$r28,271(0x10f)
1c002b70:	3d3d0a0d 	0x3d3d0a0d
1c002b74:	3d3d3d3d 	0x3d3d3d3d
1c002b78:	3d3d3d3d 	0x3d3d3d3d
1c002b7c:	3d3d3d3d 	0x3d3d3d3d
1c002b80:	3d3d3d3d 	0x3d3d3d3d
1c002b84:	3d3d3d3d 	0x3d3d3d3d
1c002b88:	3d3d3d3d 	0x3d3d3d3d
1c002b8c:	3d3d3d3d 	0x3d3d3d3d
1c002b90:	3d3d3d3d 	0x3d3d3d3d
1c002b94:	3d3d3d3d 	0x3d3d3d3d
1c002b98:	3d3d3d3d 	0x3d3d3d3d
1c002b9c:	3d3d3d3d 	0x3d3d3d3d
1c002ba0:	00000a0d 	0x00000a0d
1c002ba4:	414c2020 	beqz	$r1,85024(0x14c20) # 1c0177c4 <_sidata+0x14b98>
1c002ba8:	20323331 	ll.w	$r17,$r25,12848(0x3230)
1c002bac:	6d656420 	bgeu	$r1,$r0,91492(0x16564) # 1c019110 <_sidata+0x164e4>
1c002bb0:	4120206f 	beqz	$r3,4005920(0x3d2020) # 1c3d4bd0 <_sidata+0x3d1fa4>
1c002bb4:	535f5050 	b	21192528(0x1435f50) # 1d438b04 <_sidata+0x1435ed8>
1c002bb8:	3d204c45 	0x3d204c45
1c002bbc:	0d642520 	xvshuf.b	$xr0,$xr9,$xr9,$xr8
1c002bc0:	0000000a 	0x0000000a
1c002bc4:	3d3d3d3d 	0x3d3d3d3d
1c002bc8:	3d3d3d3d 	0x3d3d3d3d
1c002bcc:	3d3d3d3d 	0x3d3d3d3d
1c002bd0:	3d3d3d3d 	0x3d3d3d3d
1c002bd4:	3d3d3d3d 	0x3d3d3d3d
1c002bd8:	3d3d3d3d 	0x3d3d3d3d
1c002bdc:	3d3d3d3d 	0x3d3d3d3d
1c002be0:	3d3d3d3d 	0x3d3d3d3d
1c002be4:	3d3d3d3d 	0x3d3d3d3d
1c002be8:	3d3d3d3d 	0x3d3d3d3d
1c002bec:	3d3d3d3d 	0x3d3d3d3d
1c002bf0:	0a0d3d3d 	0x0a0d3d3d
1c002bf4:	00000000 	0x00000000
1c002bf8:	5050415b 	b	90984512(0x56c5040) # 216c7c38 <_sidata+0x56c500c>
1c002bfc:	3732205d 	0x3732205d
1c002c00:	70786520 	0x70786520
1c002c04:	34202032 	0x34202032
1c002c08:	6b203478 	bltu	$r3,$r24,-57292(0x32034) # 1bff4c3c <_start-0xb3c4>
1c002c0c:	61707965 	blt	$r11,$r5,94328(0x17078) # 1c019c84 <_sidata+0x17058>
1c002c10:	63732064 	blt	$r3,$r4,-36064(0x37320) # 1bff9f30 <_start-0x60d0>
1c002c14:	656e6e61 	bge	$r19,$r1,93804(0x16e6c) # 1c019a80 <_sidata+0x16e54>
1c002c18:	6e692064 	bgeu	$r3,$r4,-104160(0x26920) # 1bfe9538 <_start-0x16ac8>
1c002c1c:	6d697420 	bgeu	$r1,$r0,92532(0x16974) # 1c019590 <_sidata+0x16964>
1c002c20:	49207265 	0x49207265
1c002c24:	0a0d5253 	0x0a0d5253
1c002c28:	00000000 	0x00000000

Disassembly of section .data:

80001000 <_sdata>:
_sdata():
80001000:	00000004 	0x00000004

Disassembly of section .bss:

80000000 <_sbss>:
_sbss():
80000000:	00000000 	0x00000000

80000004 <s_irq_cnt>:
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:82
80000004:	00000000 	0x00000000

80000008 <s_hold>:
	...

80000009 <s_deb>:
	...

8000000a <s_stable>:
	...

8000000c <s_bits>:
	...

8000000e <s_row>:
	...

8000000f <s_q_tail>:
	...

80000010 <s_q_head>:
D:/LA132_SoC_SW_EXP/driver/exp_kbd_scan/demo_kbd_scan.c:51
80000010:	00000000 	0x00000000

80000014 <s_q>:
	...

80000024 <s_pos>:
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:22
80000024:	00000000 	0x00000000

80000028 <s_dig>:
	...

80000030 <s_irq_rx_mode>:
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:174
80000030:	00000000 	0x00000000

80000034 <s_rx_tail>:
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:171
80000034:	00000000 	0x00000000

80000038 <s_rx_head>:
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:170
80000038:	00000000 	0x00000000

8000003c <s_rx_buf>:
	...

8000007c <s_putc_drop>:
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:20
8000007c:	00000000 	0x00000000

80000080 <s_rx_drop>:
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:19
80000080:	00000000 	0x00000000

80000084 <s_irq_cnt>:
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:18
80000084:	00000000 	0x00000000

80000088 <s_irq_hook>:
	...

Disassembly of section .debug_line:

00000000 <.debug_line>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
       0:	0000009b 	0x0000009b
       4:	00370002 	0x00370002
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
       8:	01010000 	fadd.d	$f0,$f0,$f0
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
       c:	000d0efb 	bytepick.d	$r27,$r23,$r3,0x2
      10:	01010101 	fadd.d	$f1,$f8,$f0
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
      14:	01000000 	0x01000000
D:/LA132_SoC_SW_EXP/user/interrupt.c:109
      18:	44010000 	bnez	$r0,256(0x100) # 118 <_start-0x1bfffee8>
delay_s():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:86
      1c:	414c2f3a 	beqz	$r25,-1487828(0x694c2c) # ffe94c48 <_edata+0x7fe93c44>
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
      20:	5f323331 	bne	$r25,$r17,-52688(0x33230) # ffff3250 <_edata+0x7fff224c>
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
      24:	5f436f53 	bne	$r26,$r19,-48276(0x3436c) # ffff4390 <_edata+0x7fff338c>
      28:	455f5753 	bnez	$r26,-3317932(0x4d5f54) # ffcd5f7c <_edata+0x7fcd4f78>
      2c:	752f5058 	xvsigncov.w	$xr24,$xr2,$xr20
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
      30:	00726573 	bstrins.w	$r19,$r11,0x12,0x19
      34:	61747300 	blt	$r24,$r0,95344(0x17470) # 174a4 <_start-0x1bfe8b5c>
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
      38:	532e7472 	b	30092916(0x1cb2e74) # 1cb2eac <_start-0x1a34d154>
      3c:	00000100 	0x00000100
      40:	02050000 	slti	$r0,$r0,320(0x140)
uart_read_bcd_char():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
      44:	1c000000 	pcaddu12i	$r0,0
      48:	4b011b03 	0x4b011b03
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
      4c:	4b4b834c 	0x4b4b834c
      50:	834c4b4b 	0x834c4b4b
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
      54:	834c4b83 	0x834c4b83
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
      58:	4b4b4c83 	bceqz	$fcc4,1002316(0xf4b4c) # f4ba4 <_start-0x1bf0b45c>
      5c:	4b4b4b50 	0x4b4b4b50
      60:	834c834c 	0x834c834c
      64:	4b4c834c 	0x4b4c834c
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
      68:	024b834b 	sltui	$r11,$r26,736(0x2e0)
      6c:	02161edc 	slti	$r28,$r22,1415(0x587)
      70:	4c4b1554 	jirl	$r20,$r10,19220(0x4b14)
      74:	4b4c4b4b 	0x4b4c4b4b
      78:	4b4b4c4b 	bceqz	$fcc2,3099468(0x2f4b4c) # 2f4bc4 <_start-0x1bd0b43c>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
      7c:	4d4b4b4c 	jirl	$r12,$r26,84808(0x14b48)
      80:	4b834b4b 	0x4b834b4b
      84:	4b4b4c4f 	bceqz	$fcc2,4148044(0x3f4b4c) # 3f4bd0 <_start-0x1bc0b430>
      88:	4b4d4b4b 	0x4b4d4b4b
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:254
      8c:	4e4e4b4d 	jirl	$r13,$r26,-111032(0x24e48)
      90:	12034e4e 	addu16i.d	$r14,$r18,-32557(0x80d3)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:259
      94:	024d4b4a 	sltui	$r10,$r26,850(0x352)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:260
      98:	04021354 	csrxchg	$r20,$r26,0x84
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 3)
      9c:	13010100 	addu16i.d	$r0,$r8,-16320(0xc040)
      a0:	02000004 	slti	$r4,$r0,0
      a4:	00012200 	asrtle.d	$r16,$r8
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
      a8:	fb010100 	0xfb010100
      ac:	01000d0e 	0x01000d0e
      b0:	00010101 	0x00010101
      b4:	00010000 	asrtle.d	$r0,$r0
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
      b8:	3a440100 	0x3a440100
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
      bc:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
      c0:	535f3233 	b	-120627408(0x8cf5f30) # f8cf5ff0 <_edata+0x78cf4fec>
      c4:	535f436f 	b	-37789888(0xdbf5f40) # fdbf6004 <_edata+0x7dbf5000>
      c8:	58455f57 	beq	$r26,$r23,17756(0x455c) # 4624 <_start-0x1bffb9dc>
      cc:	72642f50 	0x72642f50
      d0:	72657669 	0x72657669
      d4:	7078652f 	0x7078652f
      d8:	64626b5f 	bge	$r26,$r31,25192(0x6268) # 6340 <_start-0x1bff9cc0>
      dc:	6163735f 	blt	$r26,$r31,90992(0x16370) # 1644c <_start-0x1bfe9bb4>
      e0:	3a44006e 	0x3a44006e
      e4:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
      e8:	535f3233 	b	-120627408(0x8cf5f30) # f8cf6018 <_edata+0x78cf5014>
      ec:	535f436f 	b	-37789888(0xdbf5f40) # fdbf602c <_edata+0x7dbf5028>
      f0:	58455f57 	beq	$r26,$r23,17756(0x455c) # 464c <_start-0x1bffb9b4>
      f4:	6e692f50 	bgeu	$r26,$r16,-104148(0x2692c) # fffe6a20 <_edata+0x7ffe5a1c>
      f8:	64756c63 	bge	$r3,$r3,30060(0x756c) # 7664 <_start-0x1bff899c>
      fc:	3a440065 	0x3a440065
     100:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
     104:	535f3233 	b	-120627408(0x8cf5f30) # f8cf6034 <_edata+0x78cf5030>
     108:	535f436f 	b	-37789888(0xdbf5f40) # fdbf6048 <_edata+0x7dbf5044>
     10c:	58455f57 	beq	$r26,$r23,17756(0x455c) # 4668 <_start-0x1bffb998>
     110:	72642f50 	0x72642f50
     114:	72657669 	0x72657669
     118:	4950472f 	0x4950472f
     11c:	3a44004f 	0x3a44004f
     120:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
     124:	535f3233 	b	-120627408(0x8cf5f30) # f8cf6054 <_edata+0x78cf5050>
     128:	535f436f 	b	-37789888(0xdbf5f40) # fdbf6068 <_edata+0x7dbf5064>
     12c:	58455f57 	beq	$r26,$r23,17756(0x455c) # 4688 <_start-0x1bffb978>
     130:	73622f50 	vssrani.d.q	$vr16,$vr26,0xb
     134:	52502f70 	b	-37597140(0xdc2502c) # fdc25160 <_edata+0x7dc2415c>
     138:	46544e49 	bnez	$r18,2511948(0x26544c) # 265584 <_start-0x1bd9aa7c>
     13c:	2f3a4400 	0x2f3a4400
     140:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
     144:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff54a0 <_edata+0x7fff449c>
     148:	57535f43 	bl	-49327268(0xd0f535c) # fd0f54a4 <_edata+0x7d0f44a0>
     14c:	5058455f 	b	92035140(0x57c5844) # 57c5990 <_start-0x1683a670>
     150:	6573752f 	bge	$r9,$r15,95092(0x17374) # 174c4 <_start-0x1bfe8b3c>
     154:	3a440072 	0x3a440072
     158:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
     15c:	535f3233 	b	-120627408(0x8cf5f30) # f8cf608c <_edata+0x78cf5088>
     160:	535f436f 	b	-37789888(0xdbf5f40) # fdbf60a0 <_edata+0x7dbf509c>
     164:	58455f57 	beq	$r26,$r23,17756(0x455c) # 46c0 <_start-0x1bffb940>
     168:	72642f50 	0x72642f50
     16c:	72657669 	0x72657669
     170:	5f414c2f 	bne	$r1,$r15,-48820(0x3414c) # ffff42bc <_edata+0x7fff32b8>
     174:	454d4954 	bnez	$r10,-3060408(0x514d48) # ffd14ebc <_edata+0x7fd13eb8>
     178:	64000052 	bge	$r2,$r18,0 # 178 <_start-0x1bfffe88>
     17c:	5f6f6d65 	bne	$r11,$r5,-37012(0x36f6c) # ffff70e8 <_edata+0x7fff60e4>
     180:	5f64626b 	bne	$r19,$r11,-39840(0x36460) # ffff65e0 <_edata+0x7fff55dc>
     184:	6e616373 	bgeu	$r27,$r19,-106144(0x26160) # fffe62e4 <_edata+0x7ffe52e0>
     188:	0100632e 	0x0100632e
     18c:	65740000 	bge	$r0,$r0,95232(0x17400) # 1758c <_start-0x1bfe8a74>
     190:	682e7473 	bltu	$r3,$r19,11892(0x2e74) # 3004 <_start-0x1bffcffc>
     194:	00000200 	0x00000200
     198:	37676573 	0x37676573
     19c:	0300682e 	lu52i.d	$r14,$r1,26(0x1a)
     1a0:	72700000 	0x72700000
     1a4:	66746e69 	bge	$r19,$r9,-101268(0x2746c) # fffe7610 <_edata+0x7ffe660c>
     1a8:	0400682e 	csrwr	$r14,0x1a
     1ac:	6e690000 	bgeu	$r0,$r0,-104192(0x26900) # fffe6aac <_edata+0x7ffe5aa8>
     1b0:	72726574 	0x72726574
     1b4:	2e747075 	0x2e747075
     1b8:	00050068 	alsl.w	$r8,$r3,$r0,0x3
     1bc:	74616c00 	xvabsd.w	$xr0,$xr0,$xr27
     1c0:	72656d69 	0x72656d69
     1c4:	0600682e 	cacop	0xe,$r1,26(0x1a)
     1c8:	05000000 	0x05000000
     1cc:	02050001 	slti	$r1,$r0,320(0x140)
     1d0:	1c00113c 	pcaddu12i	$r28,137(0x89)
     1d4:	05013503 	0x05013503
     1d8:	33051305 	0x33051305
     1dc:	13050106 	addu16i.d	$r6,$r8,-16064(0xc140)
     1e0:	05053c08 	0x05053c08
     1e4:	0d054c06 	0x0d054c06
     1e8:	08050106 	0x08050106
     1ec:	060505f2 	cacop	0x12,$r15,321(0x141)
     1f0:	0608054d 	cacop	0xd,$r10,513(0x201)
     1f4:	f2130501 	0xf2130501
     1f8:	f3060505 	0xf3060505
     1fc:	01060e05 	0x01060e05
     200:	024b0105 	sltui	$r5,$r8,704(0x2c0)
     204:	01010004 	fadd.d	$f4,$f0,$f0
     208:	05000105 	0x05000105
     20c:	00119002 	sub.d	$r2,$r0,$r4
     210:	00c0031c 	bstrpick.d	$r28,$r24,0x0,0x0
     214:	13050501 	addu16i.d	$r1,$r8,-16063(0xc141)
     218:	06120514 	cacop	0x14,$r8,1153(0x481)
     21c:	08080501 	0x08080501
     220:	060505e4 	cacop	0x4,$r15,321(0x141)
     224:	060c054d 	cacop	0xd,$r10,769(0x301)
     228:	f2070501 	0xf2070501
     22c:	f3060505 	0xf3060505
     230:	01062a05 	0x01062a05
     234:	05ba1005 	0x05ba1005
     238:	05054a0e 	0x05054a0e
     23c:	0c054b06 	0x0c054b06
     240:	054a0106 	0x054a0106
     244:	01054610 	fmul.d	$f16,$f16,$f17
     248:	0004024f 	alsl.w	$r15,$r18,$r0,0x1
     24c:	01050101 	fmul.d	$f1,$f8,$f0
     250:	f8020500 	0xf8020500
     254:	031c0011 	lu52i.d	$r17,$r0,1792(0x700)
     258:	050100d6 	0x050100d6
     25c:	05141305 	0x05141305
     260:	0501060c 	0x0501060c
     264:	04020005 	csrrd	$r5,0x80
     268:	09054a01 	0x09054a01
     26c:	0d058306 	0x0d058306
     270:	0c050106 	0x0c050106
     274:	001a0582 	0x001a0582
     278:	49020402 	bceqz	$fcc0,590340(0x90204) # 9047c <_start-0x1bf6fb84>
     27c:	02040200 	slti	$r0,$r16,256(0x100)
     280:	4f0c054a 	jirl	$r10,$r10,-62460(0x30c04)
     284:	4a4b0105 	bcnez	$fcc0,1460992(0x164b00) # 164d84 <_start-0x1be9b27c>
     288:	01000402 	0x01000402
     28c:	00010501 	0x00010501
     290:	12240205 	addu16i.d	$r5,$r16,-30464(0x8900)
     294:	e5031c00 	0xe5031c00
     298:	05050100 	0x05050100
     29c:	051413bb 	0x051413bb
     2a0:	0501060e 	0x0501060e
     2a4:	3d080605 	0x3d080605
     2a8:	01060905 	0x01060905
     2ac:	08060505 	0x08060505
     2b0:	061b053f 	cacop	0x1f,$r9,1729(0x6c1)
     2b4:	ba090501 	0xba090501
     2b8:	4b060505 	bcnez	$fcc0,1508868(0x170604) # 1708bc <_start-0x1be8f744>
     2bc:	01062105 	0x01062105
     2c0:	3c080c05 	0x3c080c05
     2c4:	05820905 	0x05820905
     2c8:	054b0605 	0x054b0605
     2cc:	0501061d 	0x0501061d
     2d0:	854d0605 	0x854d0605
     2d4:	01061b05 	0x01061b05
     2d8:	05820905 	0x05820905
     2dc:	054b0605 	0x054b0605
     2e0:	0501060e 	0x0501060e
     2e4:	20054a05 	ll.w	$r5,$r16,1352(0x548)
     2e8:	02040200 	slti	$r0,$r16,256(0x100)
     2ec:	0402004a 	csrxchg	$r10,$r2,0x80
     2f0:	05054a02 	0x05054a02
     2f4:	01040200 	0x01040200
     2f8:	0609054a 	cacop	0xa,$r10,577(0x241)
     2fc:	06210583 	cacop	0x3,$r12,-1983(0x841)
     300:	820c0501 	0x820c0501
     304:	4b060d05 	bcnez	$fcc0,1508876(0x17060c) # 170910 <_start-0x1be8f6f0>
     308:	01063505 	0x01063505
     30c:	05f23a05 	0x05f23a05
     310:	17054a2b 	lu32i.d	$r11,-513455(0x82a51)
     314:	4a140582 	bcnez	$fcc4,660484(0xa1404) # a1718 <_start-0x1bf5e8e8>
     318:	08060505 	0x08060505
     31c:	060a05b0 	cacop	0x10,$r13,641(0x281)
     320:	0505ba01 	0x0505ba01
     324:	0f05f306 	0x0f05f306
     328:	08050106 	0x08050106
     32c:	06050582 	cacop	0x2,$r12,321(0x141)
     330:	060c0587 	cacop	0x7,$r12,769(0x301)
     334:	06050501 	cacop	0x1,$r8,321(0x141)
     338:	060c05bb 	cacop	0x1b,$r13,769(0x301)
     33c:	06050501 	cacop	0x1,$r8,321(0x141)
     340:	060c05f3 	cacop	0x13,$r15,769(0x301)
     344:	06050501 	cacop	0x1,$r8,321(0x141)
     348:	060f054c 	cacop	0xc,$r10,961(0x3c1)
     34c:	f2080501 	0xf2080501
     350:	4d060905 	jirl	$r5,$r8,67080(0x10608)
     354:	01061205 	0x01061205
     358:	bb060905 	0xbb060905
     35c:	01061205 	0x01061205
     360:	be060505 	0xbe060505
     364:	01060f05 	0x01060f05
     368:	05f20805 	0x05f20805
     36c:	05830609 	0x05830609
     370:	05010611 	0x05010611
     374:	3e080609 	0x3e080609
     378:	01060c05 	0x01060c05
     37c:	02001705 	slti	$r5,$r24,5(0x5)
     380:	054a0104 	0x054a0104
     384:	04020014 	csrrd	$r20,0x80
     388:	1005f201 	addu16i.d	$r1,$r16,380(0x17c)
     38c:	13054d06 	addu16i.d	$r6,$r8,-16045(0xc153)
     390:	054a0106 	0x054a0106
     394:	05180605 	0x05180605
     398:	05010615 	0x05010615
     39c:	05058213 	0x05058213
     3a0:	13054b06 	addu16i.d	$r6,$r24,-16046(0xc152)
     3a4:	01050106 	fmul.d	$f6,$f8,$f0
     3a8:	060905f3 	cacop	0x13,$r15,577(0x241)
     3ac:	05f26b03 	0x05f26b03
     3b0:	05010613 	0x05010613
     3b4:	054af20c 	0x054af20c
     3b8:	0402001c 	csrrd	$r28,0x80
     3bc:	054a0601 	0x054a0601
     3c0:	04020021 	csrwr	$r1,0x80
     3c4:	05010601 	0x05010601
     3c8:	0b03060d 	0x0b03060d
     3cc:	4a06e408 	bceqz	$fcc0,2229988(0x2206e4) # 220ab0 <_start-0x1bddf550>
     3d0:	14054b06 	lu12i.w	$r6,10840(0x2a58)
     3d4:	1a050106 	pcalau12i	$r6,10248(0x2808)
     3d8:	01040200 	0x01040200
     3dc:	0d053d08 	0x0d053d08
     3e0:	053d0806 	0x053d0806
     3e4:	02010614 	slti	$r20,$r16,65(0x41)
     3e8:	01010010 	fadd.d	$f16,$f0,$f0
     3ec:	05000105 	0x05000105
     3f0:	00146402 	nor	$r2,$r0,$r25
     3f4:	019f031c 	0x019f031c
     3f8:	08050501 	0x08050501
     3fc:	f4141375 	0xf4141375
     400:	061d05bd 	cacop	0x1d,$r13,1857(0x741)
     404:	06050501 	cacop	0x1,$r8,321(0x141)
     408:	061d05f3 	cacop	0x13,$r15,1857(0x741)
     40c:	06050501 	cacop	0x1,$r8,321(0x141)
     410:	061d0583 	cacop	0x3,$r12,1857(0x741)
     414:	06050501 	cacop	0x1,$r8,321(0x141)
     418:	054b4cbc 	0x054b4cbc
     41c:	05010614 	0x05010614
     420:	05bb0605 	0x05bb0605
     424:	05010614 	0x05010614
     428:	05830605 	0x05830605
     42c:	05010614 	0x05010614
     430:	f4830605 	0xf4830605
     434:	01061005 	0x01061005
     438:	bb060505 	0xbb060505
     43c:	01061005 	0x01061005
     440:	83060505 	0x83060505
     444:	01061005 	0x01061005
     448:	f3060505 	0xf3060505
     44c:	01061005 	0x01061005
     450:	83060505 	0x83060505
     454:	01061005 	0x01061005
     458:	69031205 	bltu	$r16,$r5,66320(0x10310) # 10768 <_start-0x1bfef898>
     45c:	090549ba 	0x090549ba
     460:	82270306 	0x82270306
     464:	01061205 	0x01061205
     468:	82f20c05 	0x82f20c05
     46c:	03060505 	lu52i.d	$r5,$r8,385(0x181)
     470:	09050173 	0x09050173
     474:	06110513 	cacop	0x13,$r8,1089(0x441)
     478:	06090501 	cacop	0x1,$r8,577(0x241)
     47c:	060c0584 	cacop	0x4,$r12,769(0x301)
     480:	060d0501 	cacop	0x1,$r8,833(0x341)
     484:	1e05134b 	pcaddu18i	$r11,10394(0x289a)
     488:	12050106 	addu16i.d	$r6,$r8,-32448(0x8140)
     48c:	060d05f2 	cacop	0x12,$r15,833(0x341)
     490:	0612054b 	cacop	0xb,$r10,1153(0x481)
     494:	060d0501 	cacop	0x1,$r8,833(0x341)
     498:	0682064b 	0x0682064b
     49c:	053d084b 	0x053d084b
     4a0:	4a01060e 	0x4a01060e
     4a4:	060d054a 	cacop	0xa,$r10,833(0x341)
     4a8:	06150517 	cacop	0x17,$r8,1345(0x541)
     4ac:	060d0501 	cacop	0x1,$r8,833(0x341)
     4b0:	002002bb 	div.w	$r27,$r21,$r0
     4b4:	03590101 	andi	$r1,$r8,0x640
     4b8:	00020000 	0x00020000
     4bc:	00000063 	0x00000063
     4c0:	0efb0101 	0x0efb0101
     4c4:	0101000d 	fadd.d	$f13,$f0,$f0
     4c8:	00000101 	0x00000101
     4cc:	00000100 	0x00000100
     4d0:	2f3a4401 	0x2f3a4401
     4d4:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
     4d8:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff5834 <_edata+0x7fff4830>
     4dc:	57535f43 	bl	-49327268(0xd0f535c) # fd0f5838 <_edata+0x7d0f4834>
     4e0:	5058455f 	b	92035140(0x57c5844) # 57c5d24 <_start-0x1683a2dc>
     4e4:	6972642f 	bltu	$r1,$r15,94820(0x17264) # 17748 <_start-0x1bfe88b8>
     4e8:	2f726576 	0x2f726576
     4ec:	4f495047 	jirl	$r7,$r2,-46768(0x34950)
     4f0:	2f3a4400 	0x2f3a4400
     4f4:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
     4f8:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff5854 <_edata+0x7fff4850>
     4fc:	57535f43 	bl	-49327268(0xd0f535c) # fd0f5858 <_edata+0x7d0f4854>
     500:	5058455f 	b	92035140(0x57c5844) # 57c5d44 <_start-0x1683a2bc>
     504:	636e692f 	blt	$r9,$r15,-37272(0x36e68) # ffff736c <_edata+0x7fff6368>
     508:	6564756c 	bge	$r11,$r12,91252(0x16474) # 1697c <_start-0x1bfe9684>
     50c:	65730000 	bge	$r0,$r0,94976(0x17300) # 1780c <_start-0x1bfe87f4>
     510:	632e3767 	blt	$r27,$r7,-53708(0x32e34) # ffff3344 <_edata+0x7fff2340>
     514:	00000100 	0x00000100
     518:	74736574 	xvmin.w	$xr20,$xr11,$xr25
     51c:	0200682e 	slti	$r14,$r1,26(0x1a)
     520:	05000000 	0x05000000
     524:	02050001 	slti	$r1,$r0,320(0x140)
     528:	1c0015c4 	pcaddu12i	$r4,174(0xae)
     52c:	05012e03 	0x05012e03
     530:	12051305 	addu16i.d	$r5,$r24,-32444(0x8144)
     534:	08050106 	0x08050106
     538:	060505ba 	cacop	0x1a,$r13,321(0x141)
     53c:	06120583 	cacop	0x3,$r12,1153(0x481)
     540:	82080501 	0x82080501
     544:	83060505 	0x83060505
     548:	01061205 	0x01061205
     54c:	05820805 	0x05820805
     550:	05830605 	0x05830605
     554:	05010608 	0x05010608
     558:	0105830c 	0x0105830c
     55c:	1f054a4b 	pcaddu18i	$r11,-513454(0x82a52)
     560:	01040200 	0x01040200
     564:	26054606 	ldptr.d	$r6,$r16,1348(0x544)
     568:	01040200 	0x01040200
     56c:	1f050106 	pcaddu18i	$r6,-514040(0x82808)
     570:	01040200 	0x01040200
     574:	2605bb06 	ldptr.d	$r6,$r24,1464(0x5b8)
     578:	01040200 	0x01040200
     57c:	02bb0106 	addi.w	$r6,$r8,-320(0xec0)
     580:	01010008 	fadd.d	$f8,$f0,$f0
     584:	05000105 	0x05000105
     588:	00162c02 	orn	$r2,$r0,$r11
     58c:	0119031c 	0x0119031c
     590:	05150505 	0x05150505
     594:	05010610 	0x05010610
     598:	3d080605 	0x3d080605
     59c:	01061105 	0x01061105
     5a0:	bb060505 	0xbb060505
     5a4:	01060b05 	0x01060b05
     5a8:	02bb0105 	addi.w	$r5,$r8,-320(0xec0)
     5ac:	01010004 	fadd.d	$f4,$f0,$f0
     5b0:	05000105 	0x05000105
     5b4:	00000002 	0x00000002
     5b8:	01220300 	0x01220300
     5bc:	05130505 	0x05130505
     5c0:	05010619 	0x05010619
     5c4:	0105f212 	0x0105f212
     5c8:	04024abb 	csrxchg	$r27,$r21,0x92
     5cc:	05010100 	0x05010100
     5d0:	02050001 	slti	$r1,$r0,320(0x140)
     5d4:	00000000 	0x00000000
     5d8:	05012703 	0x05012703
     5dc:	08051305 	0x08051305
     5e0:	05050106 	0x05050106
     5e4:	08058306 	0x08058306
     5e8:	15050106 	lu12i.w	$r6,-514040(0x82808)
     5ec:	05494a82 	0x05494a82
     5f0:	054c0605 	0x054c0605
     5f4:	0501060c 	0x0501060c
     5f8:	0402bb01 	csrxchg	$r1,$r24,0xae
     5fc:	05010100 	0x05010100
     600:	02050001 	slti	$r1,$r0,320(0x140)
     604:	1c00165c 	pcaddu12i	$r28,178(0xb2)
     608:	06013703 	cacop	0x3,$r24,77(0x4d)
     60c:	06050501 	cacop	0x1,$r8,321(0x141)
     610:	0c05e508 	0x0c05e508
     614:	05050106 	0x05050106
     618:	0805f406 	0x0805f406
     61c:	13050106 	addu16i.d	$r6,$r8,-16064(0xc140)
     620:	0605054a 	cacop	0xa,$r10,321(0x141)
     624:	060c054b 	cacop	0xb,$r10,769(0x301)
     628:	4a050501 	bcnez	$fcc0,394500(0x60504) # 60b2c <_start-0x1bf9f4d4>
     62c:	004b1205 	0x004b1205
     630:	4a040402 	bceqz	$fcc0,656388(0xa0404) # a0a34 <_start-0x1bf5f5cc>
     634:	02001a05 	slti	$r5,$r16,6(0x6)
     638:	05f10404 	0x05f10404
     63c:	04020005 	csrrd	$r5,0x80
     640:	09054a02 	0x09054a02
     644:	12054b06 	addu16i.d	$r6,$r24,-32430(0x8152)
     648:	2f050106 	0x2f050106
     64c:	01040200 	0x01040200
     650:	001e054a 	mulh.d	$r10,$r10,$r1
     654:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a0758 <_start-0x1bf5f8a8>
     658:	82bc0105 	0x82bc0105
     65c:	024a4a4a 	sltui	$r10,$r18,658(0x292)
     660:	01010008 	fadd.d	$f8,$f0,$f0
     664:	05000105 	0x05000105
     668:	00000002 	0x00000002
     66c:	00c10300 	bstrpick.d	$r0,$r24,0x1,0x0
     670:	13050501 	addu16i.d	$r1,$r8,-16063(0xc141)
     674:	060c0514 	cacop	0x14,$r8,769(0x301)
     678:	4a050501 	bcnez	$fcc0,394500(0x60504) # 60b7c <_start-0x1bf9f484>
     67c:	02000905 	slti	$r5,$r8,2(0x2)
     680:	4b060304 	0x4b060304
     684:	02002505 	slti	$r5,$r8,9(0x9)
     688:	01060304 	0x01060304
     68c:	02001405 	slti	$r5,$r0,5(0x5)
     690:	05820304 	0x05820304
     694:	04020012 	csrrd	$r18,0x80
     698:	1905f203 	pcaddi	$r3,-512112(0x82f90)
     69c:	03040200 	lu52i.d	$r0,$r16,256(0x100)
     6a0:	000505f1 	alsl.w	$r17,$r15,$r1,0x3
     6a4:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a07a8 <_start-0x1bf5f858>
     6a8:	05860c05 	0x05860c05
     6ac:	04020009 	csrrd	$r9,0x80
     6b0:	05830603 	0x05830603
     6b4:	04020012 	csrrd	$r18,0x80
     6b8:	05010603 	0x05010603
     6bc:	04020023 	csrwr	$r3,0x80
     6c0:	053b0803 	0x053b0803
     6c4:	04020015 	csrrd	$r21,0x80
     6c8:	05054a01 	0x05054a01
     6cc:	01040200 	0x01040200
     6d0:	4d0105f2 	jirl	$r18,$r15,65796(0x10104)
     6d4:	01000402 	0x01000402
     6d8:	00010501 	0x00010501
     6dc:	00000205 	0x00000205
     6e0:	ce030000 	0xce030000
     6e4:	05050100 	0x05050100
     6e8:	06070513 	cacop	0x13,$r8,449(0x1c1)
     6ec:	06050501 	cacop	0x1,$r8,321(0x141)
     6f0:	22057508 	ll.d	$r8,$r8,1396(0x574)
     6f4:	10050106 	addu16i.d	$r6,$r8,320(0x140)
     6f8:	4a0e05f2 	bcnez	$fcc7,-3535356(0x4a0e04) # ffca14fc <_edata+0x7fca04f8>
     6fc:	bb060505 	0xbb060505
     700:	01062305 	0x01062305
     704:	05f22b05 	0x05f22b05
     708:	0e054a10 	0x0e054a10
     70c:	060505ba 	cacop	0x1a,$r13,321(0x141)
     710:	0623054b 	cacop	0xb,$r10,-1855(0x8c1)
     714:	ba100501 	0xba100501
     718:	05ba0e05 	0x05ba0e05
     71c:	054b0605 	0x054b0605
     720:	05010610 	0x05010610
     724:	0905ba0e 	0x0905ba0e
     728:	05134d06 	0x05134d06
     72c:	05010610 	0x05010610
     730:	2b054a09 	fld.s	$f9,$r16,338(0x152)
     734:	03040200 	lu52i.d	$r0,$r16,256(0x100)
     738:	34054a06 	0x34054a06
     73c:	03040200 	lu52i.d	$r0,$r16,256(0x100)
     740:	27050106 	stptr.d	$r6,$r8,1280(0x500)
     744:	03040200 	lu52i.d	$r0,$r16,256(0x100)
     748:	19053c08 	pcaddi	$r8,-513568(0x829e0)
     74c:	01040200 	0x01040200
     750:	0009054a 	bytepick.w	$r10,$r10,$r1,0x2
     754:	f2010402 	0xf2010402
     758:	024c0105 	sltui	$r5,$r8,768(0x300)
     75c:	01010004 	fadd.d	$f4,$f0,$f0
     760:	05000105 	0x05000105
     764:	00000002 	0x00000002
     768:	00dc0300 	bstrpick.d	$r0,$r24,0x1c,0x0
     76c:	13050501 	addu16i.d	$r1,$r8,-16063(0xc141)
     770:	01061305 	0x01061305
     774:	f3060505 	0xf3060505
     778:	09051413 	0x09051413
     77c:	07050106 	0x07050106
     780:	060505f2 	cacop	0x12,$r15,321(0x141)
     784:	060a05bc 	cacop	0x1c,$r13,641(0x281)
     788:	06050501 	cacop	0x1,$r8,321(0x141)
     78c:	0a053d08 	0x0a053d08
     790:	02000106 	slti	$r6,$r8,0
     794:	05820104 	0x05820104
     798:	04020015 	csrrd	$r21,0x80
     79c:	0a058403 	0x0a058403
     7a0:	03040200 	lu52i.d	$r0,$r16,256(0x100)
     7a4:	00050548 	alsl.w	$r8,$r10,$r1,0x3
     7a8:	06080402 	cacop	0x2,$r0,513(0x201)
     7ac:	001005f6 	add.w	$r22,$r15,$r1
     7b0:	06080402 	cacop	0x2,$r0,513(0x201)
     7b4:	00050501 	alsl.w	$r1,$r8,$r1,0x3
     7b8:	06080402 	cacop	0x2,$r0,513(0x201)
     7bc:	002c05f3 	alsl.d	$r19,$r15,$r1,0x1
     7c0:	06080402 	cacop	0x2,$r0,513(0x201)
     7c4:	00120501 	slt	$r1,$r8,$r1
     7c8:	82080402 	0x82080402
     7cc:	02001005 	slti	$r5,$r0,4(0x4)
     7d0:	05820804 	0x05820804
     7d4:	04020005 	csrrd	$r5,0x80
     7d8:	05830608 	0x05830608
     7dc:	04020010 	csrrd	$r16,0x80
     7e0:	05010608 	0x05010608
     7e4:	04020005 	csrrd	$r5,0x80
     7e8:	054c0608 	0x054c0608
     7ec:	04020020 	csrwr	$r0,0x80
     7f0:	05010608 	0x05010608
     7f4:	0402000d 	csrrd	$r13,0x80
     7f8:	0b054a08 	0x0b054a08
     7fc:	08040200 	0x08040200
     800:	000105ba 	0x000105ba
     804:	bb080402 	0xbb080402
     808:	77030a05 	0x77030a05
     80c:	04024a4a 	csrxchg	$r10,$r18,0x92
     810:	2a010100 	ld.bu	$r0,$r8,64(0x40)
     814:	02000002 	slti	$r2,$r0,0
     818:	00007700 	0x00007700
     81c:	fb010100 	0xfb010100
     820:	01000d0e 	0x01000d0e
     824:	00010101 	0x00010101
     828:	00010000 	asrtle.d	$r0,$r0
     82c:	3a440100 	0x3a440100
     830:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
     834:	535f3233 	b	-120627408(0x8cf5f30) # f8cf6764 <_edata+0x78cf5760>
     838:	535f436f 	b	-37789888(0xdbf5f40) # fdbf6778 <_edata+0x7dbf5774>
     83c:	58455f57 	beq	$r26,$r23,17756(0x455c) # 4d98 <_start-0x1bffb268>
     840:	72642f50 	0x72642f50
     844:	72657669 	0x72657669
     848:	5f414c2f 	bne	$r1,$r15,-48820(0x3414c) # ffff4994 <_edata+0x7fff3990>
     84c:	454d4954 	bnez	$r10,-3060408(0x514d48) # ffd15594 <_edata+0x7fd14590>
     850:	3a440052 	0x3a440052
     854:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
     858:	535f3233 	b	-120627408(0x8cf5f30) # f8cf6788 <_edata+0x78cf5784>
     85c:	535f436f 	b	-37789888(0xdbf5f40) # fdbf679c <_edata+0x7dbf5798>
     860:	58455f57 	beq	$r26,$r23,17756(0x455c) # 4dbc <_start-0x1bffb244>
     864:	6e692f50 	bgeu	$r26,$r16,-104148(0x2692c) # fffe7190 <_edata+0x7ffe618c>
     868:	64756c63 	bge	$r3,$r3,30060(0x756c) # 7dd4 <_start-0x1bff822c>
     86c:	6c000065 	bgeu	$r3,$r5,0 # 86c <_start-0x1bfff794>
     870:	6d697461 	bgeu	$r3,$r1,92532(0x16974) # 171e4 <_start-0x1bfe8e1c>
     874:	632e7265 	blt	$r19,$r5,-53648(0x32e70) # ffff36e4 <_edata+0x7fff26e0>
     878:	00000100 	0x00000100
     87c:	74736574 	xvmin.w	$xr20,$xr11,$xr25
     880:	0200682e 	slti	$r14,$r1,26(0x1a)
     884:	616c0000 	blt	$r0,$r0,93184(0x16c00) # 17484 <_start-0x1bfe8b7c>
     888:	656d6974 	bge	$r11,$r20,93544(0x16d68) # 175f0 <_start-0x1bfe8a10>
     88c:	00682e72 	bstrins.w	$r18,$r19,0x8,0xb
     890:	00000001 	0x00000001
     894:	05000105 	0x05000105
     898:	0016e802 	andn	$r2,$r0,$r26
     89c:	010d031c 	fmaxa.d	$f28,$f24,$f0
     8a0:	13140505 	addu16i.d	$r5,$r8,-15103(0xc501)
     8a4:	0601054b 	cacop	0xb,$r10,65(0x41)
     8a8:	00040213 	alsl.w	$r19,$r16,$r0,0x1
     8ac:	01050101 	fmul.d	$f1,$f8,$f0
     8b0:	f0020500 	0xf0020500
     8b4:	031c0016 	lu52i.d	$r22,$r0,1792(0x700)
     8b8:	05050115 	0x05050115
     8bc:	06010513 	cacop	0x13,$r8,65(0x41)
     8c0:	00040283 	alsl.w	$r3,$r20,$r0,0x1
     8c4:	01050101 	fmul.d	$f1,$f8,$f0
     8c8:	fc020500 	0xfc020500
     8cc:	031c0016 	lu52i.d	$r22,$r0,1792(0x700)
     8d0:	05050119 	0x05050119
     8d4:	06010513 	cacop	0x13,$r8,65(0x41)
     8d8:	00040283 	alsl.w	$r3,$r20,$r0,0x1
     8dc:	01050101 	fmul.d	$f1,$f8,$f0
     8e0:	08020500 	0x08020500
     8e4:	031c0017 	lu52i.d	$r23,$r0,1792(0x700)
     8e8:	0106011e 	0x0106011e
     8ec:	f3060505 	0xf3060505
     8f0:	01061805 	0x01061805
     8f4:	4b060505 	bcnez	$fcc0,1508868(0x170604) # 170ef8 <_start-0x1be8f108>
     8f8:	01061605 	0x01061605
     8fc:	4c060505 	jirl	$r5,$r8,1540(0x604)
     900:	01061a05 	0x01061a05
     904:	054a1805 	0x054a1805
     908:	02824b01 	addi.w	$r1,$r24,146(0x92)
     90c:	01010008 	fadd.d	$f8,$f0,$f0
     910:	05000105 	0x05000105
     914:	00173802 	sll.w	$r2,$r0,$r14
     918:	0126031c 	0x0126031c
     91c:	05050106 	0x05050106
     920:	1805f406 	pcaddi	$r6,12192(0x2fa0)
     924:	16050106 	lu32i.d	$r6,10248(0x2808)
     928:	0605054a 	cacop	0xa,$r10,321(0x141)
     92c:	0627054b 	cacop	0xb,$r10,-1599(0x9c1)
     930:	4a070501 	bcnez	$fcc0,395012(0x60704) # 61034 <_start-0x1bf9efcc>
     934:	4c060905 	jirl	$r5,$r8,1544(0x608)
     938:	01062205 	0x01062205
     93c:	82510105 	0x82510105
     940:	7f060905 	0x7f060905
     944:	06150513 	cacop	0x13,$r8,1345(0x541)
     948:	4a2a0501 	bcnez	$fcc0,403972(0x62a04) # 6334c <_start-0x1bf9ccb4>
     94c:	01000802 	0x01000802
     950:	00010501 	0x00010501
     954:	17780205 	lu32i.d	$r5,-278512(0xbc010)
     958:	35031c00 	0x35031c00
     95c:	05010601 	0x05010601
     960:	13f30605 	addu16i.d	$r5,$r16,-831(0xfcc1)
     964:	01061105 	0x01061105
     968:	84060505 	0x84060505
     96c:	0e05844b 	0x0e05844b
     970:	017a0306 	0x017a0306
     974:	05500b05 	0x05500b05
     978:	054c0609 	0x054c0609
     97c:	4a010611 	0x4a010611
     980:	0605054a 	cacop	0xa,$r10,321(0x141)
     984:	0601054c 	cacop	0xc,$r10,65(0x41)
     988:	0802824b 	0x0802824b
     98c:	05010100 	0x05010100
     990:	02050001 	slti	$r1,$r0,320(0x140)
     994:	1c0017c4 	pcaddu12i	$r4,190(0xbe)
     998:	0100c403 	fadd.s	$f3,$f0,$f17
     99c:	05050106 	0x05050106
     9a0:	4a068306 	0x4a068306
     9a4:	024b0105 	sltui	$r5,$r8,704(0x2c0)
     9a8:	0101000c 	fadd.d	$f12,$f0,$f0
     9ac:	05000105 	0x05000105
     9b0:	00000002 	0x00000002
     9b4:	00c90300 	bstrpick.d	$r0,$r24,0x9,0x0
     9b8:	05010601 	0x05010601
     9bc:	06830605 	0x06830605
     9c0:	4b0105ba 	bcnez	$fcc5,-1375996(0x6b0104) # ffeb0ac4 <_edata+0x7feafac0>
     9c4:	01000c02 	0x01000c02
     9c8:	00010501 	0x00010501
     9cc:	00000205 	0x00000205
     9d0:	ce030000 	0xce030000
     9d4:	01060100 	0x01060100
     9d8:	83060505 	0x83060505
     9dc:	01058206 	0x01058206
     9e0:	000c024b 	bytepick.d	$r11,$r18,$r0,0x0
     9e4:	01050101 	fmul.d	$f1,$f8,$f0
     9e8:	00020500 	0x00020500
     9ec:	03000000 	lu52i.d	$r0,$r0,0
     9f0:	060100d3 	cacop	0x13,$r6,64(0x40)
     9f4:	06050501 	cacop	0x1,$r8,321(0x141)
     9f8:	1b057608 	pcalau12i	$r8,-513104(0x82bb0)
     9fc:	19050106 	pcaddi	$r6,-514040(0x82808)
     a00:	0605054a 	cacop	0xa,$r10,321(0x141)
     a04:	0625054b 	cacop	0xb,$r10,-1727(0x941)
     a08:	ba190501 	0xba190501
     a0c:	ba4b0105 	0xba4b0105
     a10:	01000802 	0x01000802
     a14:	00010501 	0x00010501
     a18:	00000205 	0x00000205
     a1c:	da030000 	0xda030000
     a20:	01060100 	0x01060100
     a24:	f4060505 	0xf4060505
     a28:	01060e05 	0x01060e05
     a2c:	054a2405 	0x054a2405
     a30:	3c054a1a 	0x3c054a1a
     a34:	4a31054a 	bcnez	$fcc2,2765060(0x2a3104) # 2a3b38 <_start-0x1bd5c4c8>
     a38:	ba4c0105 	0xba4c0105
     a3c:	01000802 	0x01000802
     a40:	00041901 	alsl.w	$r1,$r8,$r6,0x1
     a44:	63000200 	blt	$r16,$r0,-65536(0x30000) # ffff0a44 <_edata+0x7ffefa40>
     a48:	01000000 	0x01000000
     a4c:	0d0efb01 	0x0d0efb01
     a50:	01010100 	fadd.d	$f0,$f8,$f0
     a54:	00000001 	0x00000001
     a58:	01000001 	0x01000001
     a5c:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
     a60:	32333141 	0x32333141
     a64:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff79b4 <_edata+0x7fff69b0>
     a68:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff61b8 <_edata+0x7fff51b4>
     a6c:	2f505845 	0x2f505845
     a70:	76697264 	0x76697264
     a74:	552f7265 	bl	-107663504(0x9952f70) # f99539e4 <_edata+0x799529e0>
     a78:	00545241 	0x00545241
     a7c:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
     a80:	32333141 	0x32333141
     a84:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff79d4 <_edata+0x7fff69d0>
     a88:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff61d8 <_edata+0x7fff51d4>
     a8c:	2f505845 	0x2f505845
     a90:	6c636e69 	bgeu	$r19,$r9,25452(0x636c) # 6dfc <_start-0x1bff9204>
     a94:	00656475 	bstrins.w	$r21,$r3,0x5,0x19
     a98:	72617500 	0x72617500
     a9c:	00632e74 	bstrins.w	$r20,$r19,0x3,0xb
     aa0:	74000001 	xvseq.b	$xr1,$xr0,$xr0
     aa4:	2e747365 	0x2e747365
     aa8:	00020068 	0x00020068
     aac:	27050000 	stptr.d	$r0,$r0,1280(0x500)
     ab0:	00020500 	0x00020500
     ab4:	03000000 	lu52i.d	$r0,$r0,0
     ab8:	29050115 	st.b	$r21,$r8,320(0x140)
     abc:	06300501 	cacop	0x1,$r8,-1023(0xc01)
     ac0:	ba010501 	0xba010501
     ac4:	01000402 	0x01000402
     ac8:	00270501 	crcc.w.w.w	$r1,$r8,$r1
     acc:	00000205 	0x00000205
     ad0:	16030000 	lu32i.d	$r0,6144(0x1800)
     ad4:	01290501 	0x01290501
     ad8:	01063005 	0x01063005
     adc:	02ba0105 	addi.w	$r5,$r8,-384(0xe80)
     ae0:	01010004 	fadd.d	$f4,$f0,$f0
     ae4:	05002705 	0x05002705
     ae8:	00000002 	0x00000002
     aec:	01170300 	0x01170300
     af0:	05012905 	0x05012905
     af4:	05010630 	0x05010630
     af8:	0402ba01 	csrxchg	$r1,$r16,0xae
     afc:	05010100 	0x05010100
     b00:	02050001 	slti	$r1,$r0,320(0x140)
     b04:	1c0017e0 	pcaddu12i	$r0,191(0xbf)
     b08:	05011a03 	0x05011a03
     b0c:	0e051305 	0x0e051305
     b10:	01050106 	fmul.d	$f6,$f8,$f0
     b14:	04023d08 	csrxchg	$r8,$r8,0x8f
     b18:	05010100 	0x05010100
     b1c:	02050020 	slti	$r0,$r1,320(0x140)
     b20:	00000000 	0x00000000
     b24:	05012203 	0x05012203
     b28:	12051305 	addu16i.d	$r5,$r24,-32444(0x8144)
     b2c:	01050106 	fmul.d	$f6,$f8,$f0
     b30:	000402f3 	alsl.w	$r19,$r23,$r0,0x1
     b34:	01050101 	fmul.d	$f1,$f8,$f0
     b38:	f8020500 	0xf8020500
     b3c:	031c0017 	lu52i.d	$r23,$r0,1792(0x700)
     b40:	01060137 	0x01060137
     b44:	4b060505 	bcnez	$fcc0,1508868(0x170604) # 171148 <_start-0x1be8eeb8>
     b48:	061a0514 	cacop	0x14,$r8,1665(0x681)
     b4c:	05172402 	0x05172402
     b50:	054c0605 	0x054c0605
     b54:	05010617 	0x05010617
     b58:	1f054a37 	pcaddu18i	$r23,-513455(0x82a51)
     b5c:	04040200 	csrxchg	$r0,$r16,0x100
     b60:	00100582 	add.w	$r2,$r12,$r1
     b64:	4a040402 	bceqz	$fcc0,656388(0xa0404) # a0f68 <_start-0x1bf5f098>
     b68:	02000905 	slti	$r5,$r8,2(0x2)
     b6c:	03060404 	lu52i.d	$r4,$r0,385(0x181)
     b70:	0200ba0d 	slti	$r13,$r16,46(0x2e)
     b74:	05130404 	0x05130404
     b78:	04020010 	csrrd	$r16,0x80
     b7c:	05010604 	0x05010604
     b80:	04020009 	csrrd	$r9,0x80
     b84:	02004a04 	slti	$r4,$r16,18(0x12)
     b88:	054a0404 	0x054a0404
     b8c:	016d031a 	0x016d031a
     b90:	37058083 	0x37058083
     b94:	000d0588 	bytepick.d	$r8,$r12,$r1,0x2
     b98:	06030402 	cacop	0x2,$r0,193(0xc1)
     b9c:	05820f03 	0x05820f03
     ba0:	04020022 	csrwr	$r2,0x80
     ba4:	05110603 	0x05110603
     ba8:	04020017 	csrrd	$r23,0x80
     bac:	0905ba01 	0x0905ba01
     bb0:	01040200 	0x01040200
     bb4:	0310054a 	lu52i.d	$r10,$r10,1025(0x401)
     bb8:	0d05ba15 	0x0d05ba15
     bbc:	02040200 	slti	$r0,$r16,256(0x100)
     bc0:	18058706 	pcaddi	$r6,11320(0x2c38)
     bc4:	02040200 	slti	$r0,$r16,256(0x100)
     bc8:	1d050106 	pcaddu12i	$r6,-514040(0x82808)
     bcc:	02040200 	slti	$r0,$r16,256(0x100)
     bd0:	0009057d 	bytepick.w	$r29,$r11,$r1,0x2
     bd4:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a0cd8 <_start-0x1bf5f328>
     bd8:	05830f05 	0x05830f05
     bdc:	04020011 	csrrd	$r17,0x80
     be0:	054c0602 	0x054c0602
     be4:	04020016 	csrrd	$r22,0x80
     be8:	05110602 	0x05110602
     bec:	04020021 	csrwr	$r1,0x80
     bf0:	1305ba02 	addu16i.d	$r2,$r16,-16018(0xc16e)
     bf4:	02040200 	slti	$r0,$r16,256(0x100)
     bf8:	003b054a 	0x003b054a
     bfc:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a0d00 <_start-0x1bf5f300>
     c00:	01040200 	0x01040200
     c04:	f70b054a 	0xf70b054a
     c08:	02000d05 	slti	$r5,$r8,3(0x3)
     c0c:	4c060204 	jirl	$r4,$r16,1536(0x600)
     c10:	02001205 	slti	$r5,$r16,4(0x4)
     c14:	11060204 	addu16i.d	$r4,$r16,16768(0x4180)
     c18:	02001d05 	slti	$r5,$r8,7(0x7)
     c1c:	05ba0204 	0x05ba0204
     c20:	0402000f 	csrrd	$r15,0x80
     c24:	37054a02 	0x37054a02
     c28:	01040200 	0x01040200
     c2c:	0402004a 	csrxchg	$r10,$r2,0x80
     c30:	02004a01 	slti	$r1,$r16,18(0x12)
     c34:	05ba0104 	0x05ba0104
     c38:	08021601 	0x08021601
     c3c:	05010100 	0x05010100
     c40:	02050001 	slti	$r1,$r0,320(0x140)
     c44:	1c0018fc 	pcaddu12i	$r28,199(0xc7)
     c48:	0100ff03 	fadd.s	$f3,$f24,$f31
     c4c:	03130505 	lu52i.d	$r5,$r8,1217(0x4c1)
     c50:	1205010d 	addu16i.d	$r13,$r8,-32448(0x8140)
     c54:	01730306 	0x01730306
     c58:	0d030d05 	fsel	$f5,$f8,$f3,$fcc6
     c5c:	ba18054a 	0xba18054a
     c60:	054a0b05 	0x054a0b05
     c64:	054b0609 	0x054b0609
     c68:	4a01060c 	0x4a01060c
     c6c:	bb060d05 	0xbb060d05
     c70:	01061805 	0x01061805
     c74:	060d0582 	cacop	0x2,$r12,833(0x341)
     c78:	4d0505bb 	jirl	$r27,$r13,66820(0x10504)
     c7c:	01061005 	0x01061005
     c80:	02830105 	addi.w	$r5,$r8,192(0xc0)
     c84:	01010004 	fadd.d	$f4,$f0,$f0
     c88:	05000105 	0x05000105
     c8c:	00000002 	0x00000002
     c90:	01970300 	0x01970300
     c94:	05010601 	0x05010601
     c98:	05f30605 	0x05f30605
     c9c:	05010608 	0x05010608
     ca0:	0b054d0c 	0x0b054d0c
     ca4:	0609054a 	cacop	0xa,$r10,577(0x241)
     ca8:	0a05834b 	0x0a05834b
     cac:	054a0106 	0x054a0106
     cb0:	02824c01 	addi.w	$r1,$r0,147(0x93)
     cb4:	01010008 	fadd.d	$f8,$f0,$f0
     cb8:	05000105 	0x05000105
     cbc:	00194802 	srl.d	$r2,$r0,$r18
     cc0:	01b0031c 	0x01b0031c
     cc4:	13050501 	addu16i.d	$r1,$r8,-16063(0xc141)
     cc8:	01061905 	0x01061905
     ccc:	054a1305 	0x054a1305
     cd0:	0402bb01 	csrxchg	$r1,$r24,0xae
     cd4:	05010100 	0x05010100
     cd8:	02050001 	slti	$r1,$r0,320(0x140)
     cdc:	1c00195c 	pcaddu12i	$r28,202(0xca)
     ce0:	0101b503 	0x0101b503
     ce4:	05130505 	0x05130505
     ce8:	0501061b 	0x0501061b
     cec:	0505f209 	0x0505f209
     cf0:	0e05f406 	0x0e05f406
     cf4:	08050106 	0x08050106
     cf8:	060905ba 	cacop	0x1a,$r13,577(0x241)
     cfc:	0611054b 	cacop	0xb,$r10,1089(0x441)
     d00:	ba1d0501 	0xba1d0501
     d04:	f3060905 	0xf3060905
     d08:	01061305 	0x01061305
     d0c:	84060905 	0x84060905
     d10:	01061205 	0x01061205
     d14:	bc010582 	0xbc010582
     d18:	01000402 	0x01000402
     d1c:	00010501 	0x00010501
     d20:	00000205 	0x00000205
     d24:	c1030000 	0xc1030000
     d28:	05050101 	0x05050101
     d2c:	06170513 	cacop	0x13,$r8,1473(0x5c1)
     d30:	08090501 	0x08090501
     d34:	06050574 	cacop	0x14,$r11,321(0x141)
     d38:	0608054c 	cacop	0xc,$r10,513(0x201)
     d3c:	4e010501 	jirl	$r1,$r8,-130812(0x20104)
     d40:	47060905 	bnez	$r8,1508872(0x170608) # 171348 <_start-0x1be8ecb8>
     d44:	01060b05 	0x01060b05
     d48:	4c060505 	jirl	$r5,$r8,1540(0x604)
     d4c:	01060c05 	0x01060c05
     d50:	01000402 	0x01000402
     d54:	00010501 	0x00010501
     d58:	00000205 	0x00000205
     d5c:	cb030000 	0xcb030000
     d60:	05050101 	0x05050101
     d64:	060f0513 	cacop	0x13,$r8,961(0x3c1)
     d68:	08010501 	0x08010501
     d6c:	00040275 	alsl.w	$r21,$r19,$r0,0x1
     d70:	01050101 	fmul.d	$f1,$f8,$f0
     d74:	00020500 	0x00020500
     d78:	03000000 	lu52i.d	$r0,$r0,0
     d7c:	050101d4 	0x050101d4
     d80:	04020009 	csrrd	$r9,0x80
     d84:	0d051401 	0x0d051401
     d88:	01040200 	0x01040200
     d8c:	18051106 	pcaddi	$r6,10376(0x2888)
     d90:	01040200 	0x01040200
     d94:	000b05ba 	0x000b05ba
     d98:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a0e9c <_start-0x1bf5f164>
     d9c:	4c060505 	jirl	$r5,$r8,1540(0x604)
     da0:	01061c05 	0x01061c05
     da4:	02830105 	addi.w	$r5,$r8,192(0xc0)
     da8:	01010008 	fadd.d	$f8,$f0,$f0
     dac:	05000105 	0x05000105
     db0:	00000002 	0x00000002
     db4:	01de0300 	0x01de0300
     db8:	bb050501 	0xbb050501
     dbc:	0a051413 	0x0a051413
     dc0:	05050106 	0x05050106
     dc4:	0a058306 	0x0a058306
     dc8:	05050106 	0x05050106
     dcc:	08054b06 	0x08054b06
     dd0:	09050106 	0x09050106
     dd4:	20058506 	ll.w	$r6,$r8,1412(0x584)
     dd8:	054a0106 	0x054a0106
     ddc:	05054a0d 	0x05054a0d
     de0:	01058406 	0x01058406
     de4:	05821306 	0x05821306
     de8:	057d0609 	0x057d0609
     dec:	4a01060d 	0x4a01060d
     df0:	0004024a 	alsl.w	$r10,$r18,$r0,0x1
     df4:	01050101 	fmul.d	$f1,$f8,$f0
     df8:	00020500 	0x00020500
     dfc:	03000000 	lu52i.d	$r0,$r0,0
     e00:	050101f4 	0x050101f4
     e04:	05141305 	0x05141305
     e08:	05010613 	0x05010613
     e0c:	05740808 	0x05740808
     e10:	054b0609 	0x054b0609
     e14:	05010615 	0x05010615
     e18:	ad080609 	0xad080609
     e1c:	01062005 	0x01062005
     e20:	05822505 	0x05822505
     e24:	0905f213 	0x0905f213
     e28:	10054b06 	addu16i.d	$r6,$r24,338(0x152)
     e2c:	05050106 	0x05050106
     e30:	09054c06 	0x09054c06
     e34:	08050106 	0x08050106
     e38:	060505ba 	cacop	0x1a,$r13,321(0x141)
     e3c:	060a054d 	cacop	0xd,$r10,641(0x281)
     e40:	ba150501 	0xba150501
     e44:	054a0805 	0x054a0805
     e48:	054b0609 	0x054b0609
     e4c:	05010625 	0x05010625
     e50:	057f8210 	0x057f8210
     e54:	0105870c 	0x0105870c
     e58:	0004024b 	alsl.w	$r11,$r18,$r0,0x1
     e5c:	00b40101 	bstrins.d	$r1,$r8,0x34,0x0
     e60:	00020000 	0x00020000
     e64:	0000008f 	0x0000008f
     e68:	0efb0101 	0x0efb0101
     e6c:	0101000d 	fadd.d	$f13,$f0,$f0
     e70:	00000101 	0x00000101
     e74:	00000100 	0x00000100
     e78:	2f3a4401 	0x2f3a4401
     e7c:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
     e80:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff61dc <_edata+0x7fff51d8>
     e84:	57535f43 	bl	-49327268(0xd0f535c) # fd0f61e0 <_edata+0x7d0f51dc>
     e88:	5058455f 	b	92035140(0x57c5844) # 57c66cc <_start-0x16839934>
     e8c:	7073622f 	vmin.w	$vr15,$vr17,$vr24
     e90:	4952502f 	bceqz	$fcc1,4018768(0x3d5250) # 3d60e0 <_start-0x1bc29f20>
     e94:	0046544e 	0x0046544e
     e98:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
     e9c:	32333141 	0x32333141
     ea0:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff7df0 <_edata+0x7fff6dec>
     ea4:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff65f4 <_edata+0x7fff55f0>
     ea8:	2f505845 	0x2f505845
     eac:	6c636e69 	bgeu	$r19,$r9,25452(0x636c) # 7218 <_start-0x1bff8de8>
     eb0:	00656475 	bstrins.w	$r21,$r3,0x5,0x19
     eb4:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
     eb8:	32333141 	0x32333141
     ebc:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff7e0c <_edata+0x7fff6e08>
     ec0:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff6610 <_edata+0x7fff560c>
     ec4:	2f505845 	0x2f505845
     ec8:	76697264 	0x76697264
     ecc:	552f7265 	bl	-107663504(0x9952f70) # f9953e3c <_edata+0x79952e38>
     ed0:	00545241 	0x00545241
     ed4:	74757000 	xvmax.wu	$xr0,$xr0,$xr28
     ed8:	72616863 	0x72616863
     edc:	0100632e 	0x0100632e
     ee0:	65740000 	bge	$r0,$r0,95232(0x17400) # 182e0 <_start-0x1bfe7d20>
     ee4:	682e7473 	bltu	$r3,$r19,11892(0x2e74) # 3d58 <_start-0x1bffc2a8>
     ee8:	00000200 	0x00000200
     eec:	74726175 	xvmin.b	$xr21,$xr11,$xr24
     ef0:	0300682e 	lu52i.d	$r14,$r1,26(0x1a)
     ef4:	05000000 	0x05000000
     ef8:	02050001 	slti	$r1,$r0,320(0x140)
     efc:	1c0019c8 	pcaddu12i	$r8,206(0xce)
     f00:	06011c03 	cacop	0x3,$r0,71(0x47)
     f04:	06050501 	cacop	0x1,$r8,321(0x141)
     f08:	064a0683 	0x064a0683
     f0c:	0601054b 	cacop	0xb,$r10,65(0x41)
     f10:	00100213 	add.w	$r19,$r16,$r0
     f14:	0bee0101 	0x0bee0101
     f18:	00020000 	0x00020000
     f1c:	000000ca 	0x000000ca
     f20:	0efb0101 	0x0efb0101
     f24:	0101000d 	fadd.d	$f13,$f0,$f0
     f28:	00000101 	0x00000101
     f2c:	00000100 	0x00000100
     f30:	2f3a4401 	0x2f3a4401
     f34:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
     f38:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff6294 <_edata+0x7fff5290>
     f3c:	57535f43 	bl	-49327268(0xd0f535c) # fd0f6298 <_edata+0x7d0f5294>
     f40:	5058455f 	b	92035140(0x57c5844) # 57c6784 <_start-0x1683987c>
     f44:	7073622f 	vmin.w	$vr15,$vr17,$vr24
     f48:	4952502f 	bceqz	$fcc1,4018768(0x3d5250) # 3d6198 <_start-0x1bc29e68>
     f4c:	0046544e 	0x0046544e
     f50:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
     f54:	32333141 	0x32333141
     f58:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff7ea8 <_edata+0x7fff6ea4>
     f5c:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff66ac <_edata+0x7fff56a8>
     f60:	2f505845 	0x2f505845
     f64:	6c636e69 	bgeu	$r19,$r9,25452(0x636c) # 72d0 <_start-0x1bff8d30>
     f68:	00656475 	bstrins.w	$r21,$r3,0x5,0x19
     f6c:	6c5c3a64 	bgeu	$r19,$r4,23608(0x5c38) # 6ba4 <_start-0x1bff945c>
     f70:	65646961 	bge	$r11,$r1,91240(0x16468) # 173d8 <_start-0x1bfe8c28>
     f74:	5c32765f 	bne	$r18,$r31,12916(0x3274) # 41e8 <_start-0x1bffbe18>
     f78:	6c697562 	bgeu	$r11,$r2,26996(0x6974) # 78ec <_start-0x1bff8714>
     f7c:	6f6f7464 	bgeu	$r3,$r4,-37004(0x36f74) # ffff7ef0 <_edata+0x7fff6eec>
     f80:	616c5c6c 	blt	$r3,$r12,93276(0x16c5c) # 17bdc <_start-0x1bfe8424>
     f84:	742d3233 	0x742d3233
     f88:	5c6c6f6f 	bne	$r27,$r15,27756(0x6c6c) # 7bf4 <_start-0x1bff840c>
     f8c:	5c62696c 	bne	$r11,$r12,25192(0x6268) # 71f4 <_start-0x1bff8e0c>
     f90:	5c636367 	bne	$r27,$r7,25440(0x6360) # 72f0 <_start-0x1bff8d10>
     f94:	6e6f6f6c 	bgeu	$r27,$r12,-102548(0x26f6c) # fffe7f00 <_edata+0x7ffe6efc>
     f98:	63726167 	blt	$r11,$r7,-36256(0x37260) # ffff81f8 <_edata+0x7fff71f4>
     f9c:	2d323368 	0x2d323368
     fa0:	6c77656e 	bgeu	$r11,$r14,30564(0x7764) # 8704 <_start-0x1bff78fc>
     fa4:	652d6269 	bge	$r19,$r9,77152(0x12d60) # 13d04 <_start-0x1bfec2fc>
     fa8:	385c666c 	0x385c666c
     fac:	302e332e 	vldrepl.w	$vr14,$r25,-464(0xe30)
     fb0:	636e695c 	blt	$r10,$r28,-37272(0x36e68) # ffff7e18 <_edata+0x7fff6e14>
     fb4:	6564756c 	bge	$r11,$r12,91252(0x16474) # 17428 <_start-0x1bfe8bd8>
     fb8:	72700000 	0x72700000
     fbc:	66746e69 	bge	$r19,$r9,-101268(0x2746c) # fffe8428 <_edata+0x7ffe7424>
     fc0:	0100632e 	0x0100632e
     fc4:	65740000 	bge	$r0,$r0,95232(0x17400) # 183c4 <_start-0x1bfe7c3c>
     fc8:	682e7473 	bltu	$r3,$r19,11892(0x2e74) # 3e3c <_start-0x1bffc1c4>
     fcc:	00000200 	0x00000200
     fd0:	61647473 	blt	$r3,$r19,91252(0x16474) # 17444 <_start-0x1bfe8bbc>
     fd4:	682e6772 	bltu	$r27,$r18,11876(0x2e64) # 3e38 <_start-0x1bffc1c8>
     fd8:	00000300 	0x00000300
     fdc:	63747570 	blt	$r11,$r16,-35724(0x37474) # ffff8450 <_edata+0x7fff744c>
     fe0:	2e726168 	0x2e726168
     fe4:	00010068 	0x00010068
     fe8:	01050000 	fmul.d	$f0,$f0,$f0
     fec:	e8020500 	0xe8020500
     ff0:	031c0019 	lu52i.d	$r25,$r0,1792(0x700)
     ff4:	05050128 	0x05050128
     ff8:	01160513 	0x01160513
     ffc:	05012405 	0x05012405
    1000:	0105012f 	fmul.d	$f15,$f9,$f0
    1004:	04021306 	csrxchg	$r6,$r24,0x84
    1008:	05010100 	0x05010100
    100c:	02050001 	slti	$r1,$r0,320(0x140)
    1010:	1c0019ec 	pcaddu12i	$r12,207(0xcf)
    1014:	0100c803 	fadd.s	$f3,$f0,$f18
    1018:	13130505 	addu16i.d	$r5,$r8,-15167(0xc4c1)
    101c:	11061205 	addu16i.d	$r5,$r16,16772(0x4184)
    1020:	054b1705 	0x054b1705
    1024:	14054a0c 	lu12i.w	$r12,10832(0x2a50)
    1028:	4a770306 	0x4a770306
    102c:	05140505 	0x05140505
    1030:	4a010618 	0x4a010618
    1034:	190b054a 	pcaddi	$r10,-501718(0x8582a)
    1038:	84060905 	0x84060905
    103c:	01060f05 	0x01060f05
    1040:	05822e05 	0x05822e05
    1044:	15058226 	lu12i.w	$r6,-513007(0x82c11)
    1048:	4a0b054a 	bcnez	$fcc2,2755332(0x2a0b04) # 2a1b4c <_start-0x1bd5e4b4>
    104c:	0605054a 	cacop	0xa,$r10,321(0x141)
    1050:	0601054c 	cacop	0xc,$r10,65(0x41)
    1054:	04024a13 	csrxchg	$r19,$r16,0x92
    1058:	05010100 	0x05010100
    105c:	02050001 	slti	$r1,$r0,320(0x140)
    1060:	1c001a30 	pcaddu12i	$r16,209(0xd1)
    1064:	0100d403 	fadd.s	$f3,$f0,$f21
    1068:	05050106 	0x05050106
    106c:	13500206 	addu16i.d	$r6,$r16,-11264(0xd400)
    1070:	1f051513 	pcaddu18i	$r19,-513880(0x828a8)
    1074:	08050106 	0x08050106
    1078:	030b054a 	lu52i.d	$r10,$r10,705(0x2c1)
    107c:	09054a09 	0x09054a09
    1080:	10054c06 	addu16i.d	$r6,$r0,339(0x153)
    1084:	09054a06 	0x09054a06
    1088:	10054a4a 	addu16i.d	$r10,$r18,338(0x152)
    108c:	74087703 	xvslt.bu	$xr3,$xr24,$xr29
    1090:	02000905 	slti	$r5,$r8,2(0x2)
    1094:	054a0104 	0x054a0104
    1098:	0402000d 	csrrd	$r13,0x80
    109c:	004c0603 	0x004c0603
    10a0:	06030402 	cacop	0x2,$r0,193(0xc1)
    10a4:	0023054a 	div.du	$r10,$r10,$r1
    10a8:	f0030402 	0xf0030402
    10ac:	02000d05 	slti	$r5,$r8,3(0x3)
    10b0:	054c0304 	0x054c0304
    10b4:	0b030605 	0x0b030605
    10b8:	060f0582 	cacop	0x2,$r12,961(0x3c1)
    10bc:	4a080501 	bcnez	$fcc0,395268(0x60804) # 618c0 <_start-0x1bf9e740>
    10c0:	09030105 	0x09030105
    10c4:	4a3c084a 	bceqz	$fcc2,2767880(0x2a3c08) # 2a4ccc <_start-0x1bd5b334>
    10c8:	824a824a 	0x824a824a
    10cc:	79031405 	0x79031405
    10d0:	4a0f0582 	bcnez	$fcc4,659204(0xa0f04) # a1fd4 <_start-0x1bf5e02c>
    10d4:	4c060d05 	jirl	$r5,$r8,1548(0x60c)
    10d8:	18024a06 	pcaddi	$r6,4688(0x1250)
    10dc:	05010100 	0x05010100
    10e0:	02050001 	slti	$r1,$r0,320(0x140)
    10e4:	1c001b3c 	pcaddu12i	$r28,217(0xd9)
    10e8:	0100f703 	fadd.s	$f3,$f24,$f29
    10ec:	05050106 	0x05050106
    10f0:	053e0806 	0x053e0806
    10f4:	05010611 	0x05010611
    10f8:	09054a08 	0x09054a08
    10fc:	0c054c06 	0x0c054c06
    1100:	1d050106 	pcaddu12i	$r6,-514040(0x82808)
    1104:	01040200 	0x01040200
    1108:	0013054a 	maskeqz	$r10,$r10,$r1
    110c:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a1210 <_start-0x1bf5edf0>
    1110:	02002e05 	slti	$r5,$r16,11(0xb)
    1114:	054a0204 	0x054a0204
    1118:	04020045 	csrxchg	$r5,$r2,0x80
    111c:	3b054a03 	0x3b054a03
    1120:	03040200 	lu52i.d	$r0,$r16,256(0x100)
    1124:	060d054a 	cacop	0xa,$r10,833(0x341)
    1128:	0612054c 	cacop	0xc,$r10,1153(0x481)
    112c:	4d0f0501 	jirl	$r1,$r8,69380(0x10f04)
    1130:	02001d05 	slti	$r5,$r8,7(0x7)
    1134:	054a0104 	0x054a0104
    1138:	0584060d 	0x0584060d
    113c:	05010610 	0x05010610
    1140:	14054a18 	lu12i.w	$r24,10832(0x2a50)
    1144:	0d054a82 	0x0d054a82
    1148:	10054f06 	addu16i.d	$r6,$r24,339(0x153)
    114c:	18050106 	pcaddi	$r6,10248(0x2808)
    1150:	8214054a 	0x8214054a
    1154:	05481705 	0x05481705
    1158:	28054a0f 	ld.b	$r15,$r16,338(0x152)
    115c:	01040200 	0x01040200
    1160:	0039054a 	0x0039054a
    1164:	4a020402 	bceqz	$fcc0,655876(0xa0204) # a1368 <_start-0x1bf5ec98>
    1168:	89060505 	0x89060505
    116c:	01060f05 	0x01060f05
    1170:	054a0805 	0x054a0805
    1174:	054c0609 	0x054c0609
    1178:	05010615 	0x05010615
    117c:	28054a0c 	ld.b	$r12,$r16,338(0x152)
    1180:	01040200 	0x01040200
    1184:	002f054a 	0x002f054a
    1188:	4a020402 	bceqz	$fcc0,655876(0xa0204) # a138c <_start-0x1bf5ec74>
    118c:	02004105 	slti	$r5,$r8,16(0x10)
    1190:	054a0304 	0x054a0304
    1194:	09030609 	0x09030609
    1198:	060c054a 	cacop	0xa,$r10,769(0x301)
    119c:	060e0501 	cacop	0x1,$r8,897(0x381)
    11a0:	06110586 	cacop	0x6,$r12,1089(0x441)
    11a4:	060e0501 	cacop	0x1,$r8,897(0x381)
    11a8:	06110586 	cacop	0x6,$r12,1089(0x441)
    11ac:	06090501 	cacop	0x1,$r8,577(0x241)
    11b0:	060c0586 	cacop	0x6,$r12,769(0x301)
    11b4:	060d0501 	cacop	0x1,$r8,833(0x341)
    11b8:	06100584 	cacop	0x4,$r12,1025(0x401)
    11bc:	4a180501 	bcnez	$fcc0,399364(0x61804) # 629c0 <_start-0x1bf9d640>
    11c0:	05821405 	0x05821405
    11c4:	054e0605 	0x054e0605
    11c8:	05010608 	0x05010608
    11cc:	05840609 	0x05840609
    11d0:	0501060c 	0x0501060c
    11d4:	054c060d 	0x054c060d
    11d8:	05010610 	0x05010610
    11dc:	14054a18 	lu12i.w	$r24,10832(0x2a50)
    11e0:	06050582 	cacop	0x2,$r12,321(0x141)
    11e4:	054a0c03 	0x054a0c03
    11e8:	4a01060c 	0x4a01060c
    11ec:	4b01054a 	bcnez	$fcc2,2818308(0x2b0104) # 2b12f0 <_start-0x1bd4ed10>
    11f0:	060d0582 	cacop	0x2,$r12,833(0x341)
    11f4:	054a5603 	0x054a5603
    11f8:	05010610 	0x05010610
    11fc:	054b060d 	0x054b060d
    1200:	05010610 	0x05010610
    1204:	04020015 	csrrd	$r21,0x80
    1208:	10054a01 	addu16i.d	$r1,$r16,338(0x152)
    120c:	06110581 	cacop	0x1,$r12,1089(0x441)
    1210:	06140585 	cacop	0x5,$r12,1281(0x501)
    1214:	10054a01 	addu16i.d	$r1,$r16,338(0x152)
    1218:	00260547 	crcc.w.b.w	$r7,$r10,$r1
    121c:	89010402 	0x89010402
    1220:	02001b05 	slti	$r5,$r24,6(0x6)
    1224:	054a0104 	0x054a0104
    1228:	04020039 	csrwr	$r25,0x80
    122c:	0d054a02 	0x0d054a02
    1230:	10058406 	addu16i.d	$r6,$r0,353(0x161)
    1234:	18050106 	pcaddi	$r6,10248(0x2808)
    1238:	8214054a 	0x8214054a
    123c:	054a1805 	0x054a1805
    1240:	0402002a 	csrwr	$r10,0x80
    1244:	20054c01 	ll.w	$r1,$r0,1356(0x54c)
    1248:	01040200 	0x01040200
    124c:	003d054a 	0x003d054a
    1250:	4a020402 	bceqz	$fcc0,655876(0xa0204) # a1454 <_start-0x1bf5ebac>
    1254:	84060d05 	0x84060d05
    1258:	01061005 	0x01061005
    125c:	054a1805 	0x054a1805
    1260:	18058214 	pcaddi	$r20,11280(0x2c10)
    1264:	001f054a 	mulw.d.w	$r10,$r10,$r1
    1268:	4c010402 	jirl	$r2,$r0,260(0x104)
    126c:	84060d05 	0x84060d05
    1270:	01061005 	0x01061005
    1274:	054a1805 	0x054a1805
    1278:	054a8214 	0x054a8214
    127c:	0e03060e 	0x0e03060e
    1280:	0618054a 	cacop	0xa,$r10,1537(0x601)
    1284:	4a110501 	bcnez	$fcc0,397572(0x61104) # 62388 <_start-0x1bf9dc78>
    1288:	4c060d05 	jirl	$r5,$r8,1548(0x60c)
    128c:	01061005 	0x01061005
    1290:	054a1805 	0x054a1805
    1294:	054a8214 	0x054a8214
    1298:	054c060e 	0x054c060e
    129c:	05010618 	0x05010618
    12a0:	0d054a11 	0x0d054a11
    12a4:	10054c06 	addu16i.d	$r6,$r0,339(0x153)
    12a8:	18050106 	pcaddi	$r6,10248(0x2808)
    12ac:	8214054a 	0x8214054a
    12b0:	0004024a 	alsl.w	$r10,$r18,$r0,0x1
    12b4:	01050101 	fmul.d	$f1,$f8,$f0
    12b8:	fc020500 	0xfc020500
    12bc:	031c001c 	lu52i.d	$r28,$r0,1792(0x700)
    12c0:	060101c0 	cacop	0x0,$r14,64(0x40)
    12c4:	06050501 	cacop	0x1,$r8,321(0x141)
    12c8:	051513bb 	0x051513bb
    12cc:	05010608 	0x05010608
    12d0:	054c0609 	0x054c0609
    12d4:	0501060f 	0x0501060f
    12d8:	05860605 	0x05860605
    12dc:	05010611 	0x05010611
    12e0:	24054a08 	ldptr.w	$r8,$r16,1352(0x548)
    12e4:	01040200 	0x01040200
    12e8:	0032054a 	0x0032054a
    12ec:	c2020402 	0xc2020402
    12f0:	02005105 	slti	$r5,$r8,20(0x14)
    12f4:	4a4a0204 	0x4a4a0204
    12f8:	07040200 	0x07040200
    12fc:	005a054a 	0x005a054a
    1300:	82070402 	0x82070402
    1304:	02000c05 	slti	$r5,$r0,3(0x3)
    1308:	054a0704 	0x054a0704
    130c:	32058251 	0x32058251
    1310:	02040200 	slti	$r0,$r16,256(0x100)
    1314:	00510586 	0x00510586
    1318:	4a020402 	bceqz	$fcc0,655876(0xa0204) # a151c <_start-0x1bf5eae4>
    131c:	0402004a 	csrxchg	$r10,$r2,0x80
    1320:	02004a07 	slti	$r7,$r16,18(0x12)
    1324:	054a0704 	0x054a0704
    1328:	0402005a 	csrxchg	$r26,$r2,0x80
    132c:	0c054a07 	0x0c054a07
    1330:	07040200 	0x07040200
    1334:	8251054a 	0x8251054a
    1338:	0032054a 	0x0032054a
    133c:	4e020402 	jirl	$r2,$r0,-130556(0x20204)
    1340:	02005105 	slti	$r5,$r8,20(0x14)
    1344:	4a4a0204 	0x4a4a0204
    1348:	07040200 	0x07040200
    134c:	005a054a 	0x005a054a
    1350:	82070402 	0x82070402
    1354:	02000c05 	slti	$r5,$r0,3(0x3)
    1358:	004a0704 	0x004a0704
    135c:	4a070402 	bceqz	$fcc0,657156(0xa0704) # a1a60 <_start-0x1bf5e5a0>
    1360:	4a4a5105 	bcnez	$fcc0,1460816(0x164a50) # 165db0 <_start-0x1be9a250>
    1364:	02003205 	slti	$r5,$r16,12(0xc)
    1368:	054e0204 	0x054e0204
    136c:	04020051 	csrxchg	$r17,$r2,0x80
    1370:	004a4a02 	0x004a4a02
    1374:	4a070402 	bceqz	$fcc0,657156(0xa0704) # a1a78 <_start-0x1bf5e588>
    1378:	02005a05 	slti	$r5,$r16,22(0x16)
    137c:	05820704 	0x05820704
    1380:	0402000c 	csrrd	$r12,0x80
    1384:	51054a07 	b	-132315832(0x81d0548) # f81d18cc <_edata+0x781d08c8>
    1388:	030b0582 	lu52i.d	$r2,$r12,705(0x2c1)
    138c:	2d058275 	0x2d058275
    1390:	4a210545 	bcnez	$fcc2,1450244(0x162104) # 163494 <_start-0x1be9cb6c>
    1394:	054a1505 	0x054a1505
    1398:	14030604 	lu12i.w	$r4,6192(0x1830)
    139c:	0617054a 	cacop	0xa,$r10,1473(0x5c1)
    13a0:	4a260501 	bcnez	$fcc0,402948(0x62604) # 639a4 <_start-0x1bf9c65c>
    13a4:	054a1d05 	0x054a1d05
    13a8:	2c054a35 	vld	$vr21,$r17,338(0x152)
    13ac:	4a08054a 	bcnez	$fcc2,2754564(0x2a0804) # 2a1bb0 <_start-0x1bd5e450>
    13b0:	4b060d05 	bcnez	$fcc0,1508876(0x17060c) # 1719bc <_start-0x1be8e644>
    13b4:	01061605 	0x01061605
    13b8:	bb060405 	0xbb060405
    13bc:	01060705 	0x01060705
    13c0:	1309054a 	addu16i.d	$r10,$r10,-15807(0xc241)
    13c4:	02001805 	slti	$r5,$r0,6(0x6)
    13c8:	004a0104 	0x004a0104
    13cc:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a14d0 <_start-0x1bf5eb30>
    13d0:	03060905 	lu52i.d	$r5,$r8,386(0x182)
    13d4:	04054a67 	csrxchg	$r7,$r19,0x152
    13d8:	05051314 	0x05051314
    13dc:	061b0514 	cacop	0x14,$r8,1729(0x6c1)
    13e0:	ba0c0501 	0xba0c0501
    13e4:	4b060505 	bcnez	$fcc0,1508868(0x170604) # 1719e8 <_start-0x1be8e618>
    13e8:	01060c05 	0x01060c05
    13ec:	02002005 	slti	$r5,$r0,8(0x8)
    13f0:	05820104 	0x05820104
    13f4:	0402000c 	csrrd	$r12,0x80
    13f8:	05054a01 	0x05054a01
    13fc:	08040200 	0x08040200
    1400:	0b054b06 	0x0b054b06
    1404:	08040200 	0x08040200
    1408:	05050106 	0x05050106
    140c:	08040200 	0x08040200
    1410:	0805bb06 	0x0805bb06
    1414:	08040200 	0x08040200
    1418:	05050106 	0x05050106
    141c:	1b054b06 	pcalau12i	$r6,-513448(0x82a58)
    1420:	0c050106 	0x0c050106
    1424:	060505ba 	cacop	0x1a,$r13,321(0x141)
    1428:	060c054b 	cacop	0xb,$r10,769(0x301)
    142c:	00200501 	div.w	$r1,$r8,$r1
    1430:	82010402 	0x82010402
    1434:	02000c05 	slti	$r5,$r0,3(0x3)
    1438:	054a0104 	0x054a0104
    143c:	04020005 	csrrd	$r5,0x80
    1440:	054b0608 	0x054b0608
    1444:	0402000b 	csrrd	$r11,0x80
    1448:	05010608 	0x05010608
    144c:	04020005 	csrrd	$r5,0x80
    1450:	05bb0608 	0x05bb0608
    1454:	04020008 	csrrd	$r8,0x80
    1458:	05010608 	0x05010608
    145c:	054b0605 	0x054b0605
    1460:	0501061b 	0x0501061b
    1464:	0505ba0c 	0x0505ba0c
    1468:	0c054b06 	0x0c054b06
    146c:	20050106 	ll.w	$r6,$r8,1280(0x500)
    1470:	01040200 	0x01040200
    1474:	000c0582 	bytepick.d	$r2,$r12,$r1,0x0
    1478:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a157c <_start-0x1bf5ea84>
    147c:	02000505 	slti	$r5,$r8,1(0x1)
    1480:	4b060804 	bceqz	$fcc0,1246728(0x130608) # 131a88 <_start-0x1bece578>
    1484:	02000b05 	slti	$r5,$r24,2(0x2)
    1488:	01060804 	0x01060804
    148c:	02000505 	slti	$r5,$r8,1(0x1)
    1490:	bb060804 	0xbb060804
    1494:	02000805 	slti	$r5,$r0,2(0x2)
    1498:	01060804 	0x01060804
    149c:	4b060505 	bcnez	$fcc0,1508868(0x170604) # 171aa0 <_start-0x1be8e560>
    14a0:	01061b05 	0x01061b05
    14a4:	05ba0c05 	0x05ba0c05
    14a8:	054b0605 	0x054b0605
    14ac:	0501060c 	0x0501060c
    14b0:	04020020 	csrwr	$r0,0x80
    14b4:	0c058201 	0x0c058201
    14b8:	01040200 	0x01040200
    14bc:	0005054a 	alsl.w	$r10,$r10,$r1,0x3
    14c0:	06080402 	cacop	0x2,$r0,513(0x201)
    14c4:	000b054b 	0x000b054b
    14c8:	06080402 	cacop	0x2,$r0,513(0x201)
    14cc:	04020001 	csrrd	$r1,0x80
    14d0:	2d05ba08 	0x2d05ba08
    14d4:	054a6f03 	0x054a6f03
    14d8:	0b054a21 	0x0b054a21
    14dc:	05820d03 	0x05820d03
    14e0:	4a73032d 	0x4a73032d
    14e4:	030c0582 	lu52i.d	$r2,$r12,769(0x301)
    14e8:	09050173 	0x09050173
    14ec:	4a310306 	0x4a310306
    14f0:	06100513 	cacop	0x13,$r8,1025(0x401)
    14f4:	06090501 	cacop	0x1,$r8,577(0x241)
    14f8:	060f054b 	cacop	0xb,$r10,961(0x3c1)
    14fc:	4c130501 	jirl	$r1,$r8,4868(0x1304)
    1500:	05480f05 	0x05480f05
    1504:	0402001c 	csrrd	$r28,0x80
    1508:	17054a01 	lu32i.d	$r1,-513456(0x82a50)
    150c:	01040200 	0x01040200
    1510:	060905f2 	cacop	0x12,$r15,577(0x241)
    1514:	0501064e 	0x0501064e
    1518:	05150605 	0x05150605
    151c:	0801060c 	0x0801060c
    1520:	4a4a4a3c 	0x4a4a4a3c
    1524:	824b0105 	0x824b0105
    1528:	01000402 	0x01000402
    152c:	00010501 	0x00010501
    1530:	1f3c0205 	pcaddu18i	$r5,-401392(0x9e010)
    1534:	81031c00 	0x81031c00
    1538:	01060102 	0x01060102
    153c:	02060505 	slti	$r5,$r8,385(0x181)
    1540:	14131344 	lu12i.w	$r4,39066(0x989a)
    1544:	01060805 	0x01060805
    1548:	99031105 	0x99031105
    154c:	0c054a02 	0x0c054a02
    1550:	4a7ded03 	bcnez	$fcc0,949740(0xe7dec) # e933c <_start-0x1bf16cc4>
    1554:	05820b05 	0x05820b05
    1558:	054d0609 	0x054d0609
    155c:	0501060c 	0x0501060c
    1560:	0685060d 	0x0685060d
    1564:	05f3064a 	0x05f3064a
    1568:	05010613 	0x05010613
    156c:	06bb060d 	0x06bb060d
    1570:	4f064c10 	jirl	$r16,$r0,-63924(0x3064c)
    1574:	01061305 	0x01061305
    1578:	86060905 	0x86060905
    157c:	01060f05 	0x01060f05
    1580:	03060905 	lu52i.d	$r5,$r8,386(0x182)
    1584:	0513820f 	0x0513820f
    1588:	7e950314 	0x7e950314
    158c:	14050501 	lu12i.w	$r1,10280(0x2828)
    1590:	01061805 	0x01061805
    1594:	030c0582 	lu52i.d	$r2,$r12,769(0x301)
    1598:	050101e9 	0x050101e9
    159c:	0586060e 	0x0586060e
    15a0:	05010611 	0x05010611
    15a4:	09057d0f 	0x09057d0f
    15a8:	4a160306 	0x4a160306
    15ac:	060d0513 	cacop	0x13,$r8,833(0x341)
    15b0:	820c0501 	0x820c0501
    15b4:	05811305 	0x05811305
    15b8:	12030609 	addu16i.d	$r9,$r16,-32575(0x80c1)
    15bc:	0611054a 	cacop	0xa,$r10,1089(0x441)
    15c0:	82090501 	0x82090501
    15c4:	06110582 	cacop	0x2,$r12,1089(0x441)
    15c8:	3c081d03 	0x3c081d03
    15cc:	01061705 	0x01061705
    15d0:	4b061105 	bcnez	$fcc0,1508880(0x170610) # 171be0 <_start-0x1be8e420>
    15d4:	01061705 	0x01061705
    15d8:	83061105 	0x83061105
    15dc:	af031b05 	0xaf031b05
    15e0:	21054a7f 	sc.w	$r31,$r19,1352(0x548)
    15e4:	33050106 	0x33050106
    15e8:	39054a06 	0x39054a06
    15ec:	3d050106 	0x3d050106
    15f0:	45058206 	bnez	$r16,1639808(0x190580) # 191b70 <_start-0x1be6e490>
    15f4:	0e090501 	0x0e090501
    15f8:	05140d05 	0x05140d05
    15fc:	05010615 	0x05010615
    1600:	1b05820d 	pcalau12i	$r13,-513008(0x82c10)
    1604:	15240206 	lu12i.w	$r6,-450544(0x92010)
    1608:	01062105 	0x01062105
    160c:	4a063305 	0x4a063305
    1610:	01063905 	0x01063905
    1614:	82063d05 	0x82063d05
    1618:	06014505 	cacop	0x5,$r8,81(0x51)
    161c:	061b0501 	cacop	0x1,$r8,1729(0x6c1)
    1620:	0621054b 	cacop	0xb,$r10,-1983(0x841)
    1624:	06330501 	cacop	0x1,$r8,-831(0xcc1)
    1628:	0639054a 	cacop	0xa,$r10,-447(0xe41)
    162c:	063d0501 	cacop	0x1,$r8,-191(0xf41)
    1630:	01450582 	0x01450582
    1634:	1b050106 	pcalau12i	$r6,-514040(0x82808)
    1638:	21054b06 	sc.w	$r6,$r24,1352(0x548)
    163c:	33050106 	0x33050106
    1640:	39054a06 	0x39054a06
    1644:	3d050106 	0x3d050106
    1648:	45058206 	bnez	$r16,1639808(0x190580) # 191bc8 <_start-0x1be6e438>
    164c:	05010601 	0x05010601
    1650:	054b061b 	0x054b061b
    1654:	05010621 	0x05010621
    1658:	054a0633 	0x054a0633
    165c:	05010639 	0x05010639
    1660:	0582063d 	0x0582063d
    1664:	01060145 	0x01060145
    1668:	03060d05 	lu52i.d	$r5,$r8,387(0x183)
    166c:	15054a09 	lu12i.w	$r9,-513456(0x82a50)
    1670:	05ba0106 	0x05ba0106
    1674:	054e060d 	0x054e060d
    1678:	05010617 	0x05010617
    167c:	05f3060d 	0x05f3060d
    1680:	05010610 	0x05010610
    1684:	0a03060d 	0x0a03060d
    1688:	0613054a 	cacop	0xa,$r10,1217(0x4c1)
    168c:	06110501 	cacop	0x1,$r8,1089(0x441)
    1690:	05f27803 	0x05f27803
    1694:	05010617 	0x05010617
    1698:	054b0611 	0x054b0611
    169c:	4a010627 	0x4a010627
    16a0:	060d054a 	cacop	0xa,$r10,833(0x341)
    16a4:	05010e03 	0x05010e03
    16a8:	05010613 	0x05010613
    16ac:	054b060d 	0x054b060d
    16b0:	05010613 	0x05010613
    16b4:	0583060d 	0x0583060d
    16b8:	05010611 	0x05010611
    16bc:	fb030614 	0xfb030614
    16c0:	05054a7d 	0x05054a7d
    16c4:	06180514 	cacop	0x14,$r8,1537(0x601)
    16c8:	10058201 	addu16i.d	$r1,$r16,352(0x160)
    16cc:	01028303 	fsub.s	$f3,$f24,$f0
    16d0:	86061205 	0x86061205
    16d4:	01061505 	0x01061505
    16d8:	77031305 	0x77031305
    16dc:	06110582 	cacop	0x2,$r12,1089(0x441)
    16e0:	061d0589 	cacop	0x9,$r12,1857(0x741)
    16e4:	1105ba01 	addu16i.d	$r1,$r16,16750(0x416e)
    16e8:	1b054e06 	pcalau12i	$r6,-513424(0x82a70)
    16ec:	11050106 	addu16i.d	$r6,$r8,16704(0x4140)
    16f0:	3b05f306 	0x3b05f306
    16f4:	11050106 	addu16i.d	$r6,$r8,16704(0x4140)
    16f8:	17054b06 	lu32i.d	$r6,-513448(0x82a58)
    16fc:	3b050106 	0x3b050106
    1700:	090582f1 	0x090582f1
    1704:	06110518 	cacop	0x18,$r8,1089(0x441)
    1708:	05820d03 	0x05820d03
    170c:	05010617 	0x05010617
    1710:	054b0611 	0x054b0611
    1714:	05010617 	0x05010617
    1718:	05830611 	0x05830611
    171c:	05010615 	0x05010615
    1720:	17054a14 	lu32i.d	$r20,-513456(0x82a50)
    1724:	06110580 	cacop	0x0,$r12,1089(0x441)
    1728:	05827603 	0x05827603
    172c:	05010617 	0x05010617
    1730:	054b0611 	0x054b0611
    1734:	05010617 	0x05010617
    1738:	05830611 	0x05830611
    173c:	05010615 	0x05010615
    1740:	17054a14 	lu32i.d	$r20,-513456(0x82a50)
    1744:	06150580 	cacop	0x0,$r12,1345(0x541)
    1748:	061b0586 	cacop	0x6,$r12,1729(0x6c1)
    174c:	06150501 	cacop	0x1,$r8,1345(0x541)
    1750:	061b054b 	cacop	0xb,$r10,1729(0x6c1)
    1754:	06150501 	cacop	0x1,$r8,1345(0x541)
    1758:	05ba0903 	0x05ba0903
    175c:	0501061b 	0x0501061b
    1760:	054b0615 	0x054b0615
    1764:	0501061b 	0x0501061b
    1768:	05c00611 	0x05c00611
    176c:	05010617 	0x05010617
    1770:	054b0611 	0x054b0611
    1774:	05010617 	0x05010617
    1778:	05830611 	0x05830611
    177c:	010c0309 	0x010c0309
    1780:	01061105 	0x01061105
    1784:	f2820905 	0xf2820905
    1788:	03061105 	lu52i.d	$r5,$r8,388(0x184)
    178c:	133c080b 	addu16i.d	$r11,$r0,-12542(0xcf02)
    1790:	01061405 	0x01061405
    1794:	02002405 	slti	$r5,$r0,9(0x9)
    1798:	05820104 	0x05820104
    179c:	05860616 	0x05860616
    17a0:	05010619 	0x05010619
    17a4:	05860616 	0x05860616
    17a8:	05010619 	0x05010619
    17ac:	13880615 	addu16i.d	$r21,$r16,-7679(0xe201)
    17b0:	01061b05 	0x01061b05
    17b4:	03811a05 	ori	$r5,$r16,0x46
    17b8:	11058274 	addu16i.d	$r20,$r19,16736(0x4160)
    17bc:	4a110306 	0x4a110306
    17c0:	01061405 	0x01061405
    17c4:	88061105 	0x88061105
    17c8:	01061405 	0x01061405
    17cc:	02002605 	slti	$r5,$r16,9(0x9)
    17d0:	05820104 	0x05820104
    17d4:	05840615 	0x05840615
    17d8:	0501061b 	0x0501061b
    17dc:	05860611 	0x05860611
    17e0:	0501061b 	0x0501061b
    17e4:	15054a14 	lu12i.w	$r20,-513456(0x82a50)
    17e8:	1b054c06 	pcalau12i	$r6,-513440(0x82a60)
    17ec:	11050106 	addu16i.d	$r6,$r8,16704(0x4140)
    17f0:	14058606 	lu12i.w	$r6,11312(0x2c30)
    17f4:	26050106 	ldptr.d	$r6,$r8,1280(0x500)
    17f8:	01040200 	0x01040200
    17fc:	06150582 	cacop	0x2,$r12,1345(0x541)
    1800:	05821503 	0x05821503
    1804:	0501061f 	0x0501061f
    1808:	1a054a18 	pcalau12i	$r24,10832(0x2a50)
    180c:	24054e06 	ldptr.w	$r6,$r16,1356(0x54c)
    1810:	1d050106 	pcaddu12i	$r6,-514040(0x82808)
    1814:	0619054a 	cacop	0xa,$r10,1601(0x641)
    1818:	063b0550 	cacop	0x10,$r10,-319(0xec1)
    181c:	4a730501 	bcnez	$fcc0,422660(0x67304) # 68b20 <_start-0x1bf974e0>
    1820:	054a5a05 	0x054a5a05
    1824:	04020019 	csrrd	$r25,0x80
    1828:	05f50602 	0x05f50602
    182c:	0402001f 	csrrd	$r31,0x80
    1830:	00010602 	0x00010602
    1834:	02020402 	slti	$r2,$r0,129(0x81)
    1838:	02001224 	slti	$r4,$r17,4(0x4)
    183c:	004a0204 	0x004a0204
    1840:	4a020402 	bceqz	$fcc0,655876(0xa0204) # a1a44 <_start-0x1bf5e5bc>
    1844:	bb031a05 	0xbb031a05
    1848:	8686017f 	0x8686017f
    184c:	03061505 	lu52i.d	$r5,$r8,389(0x185)
    1850:	1b05820b 	pcalau12i	$r11,-513008(0x82c10)
    1854:	054a0106 	0x054a0106
    1858:	13030615 	addu16i.d	$r21,$r16,-16191(0xc0c1)
    185c:	061f054a 	cacop	0xa,$r10,1985(0x7c1)
    1860:	4a180501 	bcnez	$fcc0,399364(0x61804) # 63064 <_start-0x1bf9cf9c>
    1864:	4d061a05 	jirl	$r5,$r16,67096(0x10618)
    1868:	01062405 	0x01062405
    186c:	054a1d05 	0x054a1d05
    1870:	05510619 	0x05510619
    1874:	05010632 	0x05010632
    1878:	48054a58 	0x48054a58
    187c:	ba42054a 	0xba42054a
    1880:	02001905 	slti	$r5,$r8,6(0x6)
    1884:	4c060204 	jirl	$r4,$r16,1536(0x600)
    1888:	02004405 	slti	$r5,$r0,17(0x11)
    188c:	01060204 	0x01060204
    1890:	02001f05 	slti	$r5,$r24,7(0x7)
    1894:	00820204 	bstrins.d	$r4,$r16,0x2,0x0
    1898:	f2020402 	0xf2020402
    189c:	02040200 	slti	$r0,$r16,256(0x100)
    18a0:	02007408 	slti	$r8,$r0,29(0x1d)
    18a4:	054a0204 	0x054a0204
    18a8:	17030611 	lu32i.d	$r17,-518096(0x81830)
    18ac:	06170501 	cacop	0x1,$r8,1473(0x5c1)
    18b0:	06110501 	cacop	0x1,$r8,1089(0x441)
    18b4:	031905bb 	lu52i.d	$r27,$r13,1601(0x641)
    18b8:	24054a61 	ldptr.w	$r1,$r19,1352(0x548)
    18bc:	19050106 	pcaddi	$r6,-514040(0x82808)
    18c0:	4405f306 	bnez	$r24,1574384(0x1805f0) # 181eb0 <_start-0x1be7e150>
    18c4:	1f050106 	pcaddu18i	$r6,-514040(0x82808)
    18c8:	12280282 	addu16i.d	$r2,$r20,-30208(0x8a00)
    18cc:	4f13054a 	jirl	$r10,$r10,-60668(0x31304)
    18d0:	054a3f05 	0x054a3f05
    18d4:	24054a2f 	ldptr.w	$r15,$r17,1352(0x548)
    18d8:	823f05ba 	0x823f05ba
    18dc:	19053c08 	pcaddi	$r8,-513568(0x829e0)
    18e0:	010d0306 	fmaxa.d	$f6,$f24,$f0
    18e4:	01061f05 	0x01061f05
    18e8:	4a123402 	bceqz	$fcc0,660020(0xa1234) # a2b1c <_start-0x1bf5d4e4>
    18ec:	054f1505 	0x054f1505
    18f0:	3a054a53 	0x3a054a53
    18f4:	0853054a 	fmsub.s	$f10,$f10,$f1,$f6
    18f8:	053c083c 	0x053c083c
    18fc:	0c030611 	0x0c030611
    1900:	1d051401 	pcaddu12i	$r1,-513888(0x828a0)
    1904:	14050106 	lu12i.w	$r6,10248(0x2808)
    1908:	481e054a 	bcnez	$fcc2,2629124(0x281e04) # 28370c <_start-0x1bd7c8f4>
    190c:	03061105 	lu52i.d	$r5,$r8,388(0x184)
    1910:	1b054a0b 	pcalau12i	$r11,-513456(0x82a50)
    1914:	11050106 	addu16i.d	$r6,$r8,16704(0x4140)
    1918:	08064aba 	0x08064aba
    191c:	0614053e 	cacop	0x1e,$r9,1281(0x501)
    1920:	06110501 	cacop	0x1,$r8,1089(0x441)
    1924:	06170552 	cacop	0x12,$r10,1473(0x5c1)
    1928:	06110501 	cacop	0x1,$r8,1089(0x441)
    192c:	031905bb 	lu52i.d	$r27,$r13,1601(0x641)
    1930:	4a068270 	0x4a068270
    1934:	3a081d05 	0x3a081d05
    1938:	054c1905 	0x054c1905
    193c:	1b05481d 	pcalau12i	$r29,-513472(0x82a40)
    1940:	1e054a4a 	pcaddu18i	$r10,10834(0x2a52)
    1944:	06190546 	cacop	0x6,$r10,1601(0x641)
    1948:	06821103 	0x06821103
    194c:	081d054a 	fmadd.s	$f10,$f10,$f1,$f26
    1950:	4c19053a 	jirl	$r26,$r9,6404(0x1904)
    1954:	05481d05 	0x05481d05
    1958:	4a4a4a1b 	0x4a4a4a1b
    195c:	03061105 	lu52i.d	$r5,$r8,388(0x184)
    1960:	1d05010c 	pcaddu12i	$r12,-514040(0x82808)
    1964:	11050106 	addu16i.d	$r6,$r8,16704(0x4140)
    1968:	2205f306 	ll.d	$r6,$r24,1520(0x5f0)
    196c:	13050106 	addu16i.d	$r6,$r8,-16064(0xc140)
    1970:	ba7cc903 	0xba7cc903
    1974:	054a0505 	0x054a0505
    1978:	16054a20 	lu32i.d	$r0,10833(0x2a51)
    197c:	0628054a 	cacop	0xa,$r10,-1535(0xa01)
    1980:	0624054a 	cacop	0xa,$r10,-1791(0x901)
    1984:	4a200501 	bcnez	$fcc0,401412(0x62004) # 63988 <_start-0x1bf9c678>
    1988:	03220582 	lu52i.d	$r2,$r12,-1919(0x881)
    198c:	050103b7 	0x050103b7
    1990:	ca030605 	0xca030605
    1994:	1d05827c 	pcaddu12i	$r28,-513005(0x82c13)
    1998:	054a0106 	0x054a0106
    199c:	b8030611 	0xb8030611
    19a0:	1b050103 	pcalau12i	$r3,-514040(0x82808)
    19a4:	14050106 	lu12i.w	$r6,10248(0x2808)
    19a8:	0615054a 	cacop	0xa,$r10,1345(0x541)
    19ac:	0617054c 	cacop	0xc,$r10,1473(0x5c1)
    19b0:	11058201 	addu16i.d	$r1,$r16,16736(0x4160)
    19b4:	1d058506 	pcaddu12i	$r6,-512984(0x82c28)
    19b8:	14050106 	lu12i.w	$r6,10248(0x2808)
    19bc:	19054a82 	pcaddi	$r2,-513452(0x82a54)
    19c0:	82064e06 	0x82064e06
    19c4:	3a081d05 	0x3a081d05
    19c8:	054c1905 	0x054c1905
    19cc:	1b05481d 	pcalau12i	$r29,-513472(0x82a40)
    19d0:	4a1d054a 	bcnez	$fcc2,2759940(0x2a1d04) # 2a36d4 <_start-0x1bd5c92c>
    19d4:	05894d05 	0x05894d05
    19d8:	054c0615 	0x054c0615
    19dc:	0501061c 	0x0501061c
    19e0:	054a4a15 	0x054a4a15
    19e4:	053a0819 	0x053a0819
    19e8:	22054a17 	ll.d	$r23,$r16,1352(0x548)
    19ec:	01040200 	0x01040200
    19f0:	004d054a 	rotri.d	$r10,$r10,0x1
    19f4:	4a020402 	bceqz	$fcc0,655876(0xa0204) # a1bf8 <_start-0x1bf5e408>
    19f8:	02004105 	slti	$r5,$r8,16(0x10)
    19fc:	054a0204 	0x054a0204
    1a00:	05500611 	0x05500611
    1a04:	05010614 	0x05010614
    1a08:	058a0611 	0x058a0611
    1a0c:	05010617 	0x05010617
    1a10:	05bb0611 	0x05bb0611
    1a14:	4a064519 	bcnez	$fcc0,-1702332(0x660644) # ffe62058 <_edata+0x7fe61054>
    1a18:	3a081d05 	0x3a081d05
    1a1c:	054c1905 	0x054c1905
    1a20:	1b05481d 	pcalau12i	$r29,-513472(0x82a40)
    1a24:	054a4a4a 	0x054a4a4a
    1a28:	0c030611 	0x0c030611
    1a2c:	17051301 	lu32i.d	$r1,-513896(0x82898)
    1a30:	05050106 	0x05050106
    1a34:	48054b06 	0x48054b06
    1a38:	0b050106 	0x0b050106
    1a3c:	061105f2 	cacop	0x12,$r15,1089(0x441)
    1a40:	05133002 	0x05133002
    1a44:	05010617 	0x05010617
    1a48:	4ebb0611 	jirl	$r17,$r16,-83196(0x2bb04)
    1a4c:	08064a06 	0x08064a06
    1a50:	0617053d 	cacop	0x1d,$r9,1473(0x5c1)
    1a54:	06110501 	cacop	0x1,$r8,1089(0x441)
    1a58:	4c1006bb 	jirl	$r27,$r21,4100(0x1004)
    1a5c:	4a064d06 	bcnez	$fcc0,1705548(0x1a064c) # 1a20a8 <_start-0x1be5df58>
    1a60:	1705f306 	lu32i.d	$r6,-512104(0x82f98)
    1a64:	11050106 	addu16i.d	$r6,$r8,16704(0x4140)
    1a68:	1006bb06 	addu16i.d	$r6,$r24,430(0x1ae)
    1a6c:	030d054c 	lu52i.d	$r12,$r10,833(0x341)
    1a70:	054a7de3 	0x054a7de3
    1a74:	a2030605 	0xa2030605
    1a78:	0200ba02 	slti	$r2,$r16,46(0x2e)
    1a7c:	4a060104 	bcnez	$fcc0,1181184(0x120600) # 12207c <_start-0x1beddf84>
    1a80:	04040200 	csrxchg	$r0,$r16,0x100
    1a84:	0402004a 	csrxchg	$r10,$r2,0x80
    1a88:	05f50604 	0x05f50604
    1a8c:	04020001 	csrrd	$r1,0x80
    1a90:	00130604 	maskeqz	$r4,$r16,$r1
    1a94:	f2040402 	0xf2040402
    1a98:	04040200 	csrxchg	$r0,$r16,0x100
    1a9c:	0402004a 	csrxchg	$r10,$r2,0x80
    1aa0:	02004a04 	slti	$r4,$r16,18(0x12)
    1aa4:	054a0404 	0x054a0404
    1aa8:	02a80805 	addi.w	$r5,$r0,-1534(0xa02)
    1aac:	01010008 	fadd.d	$f8,$f0,$f0
    1ab0:	05000105 	0x05000105
    1ab4:	00270002 	crcc.w.w.w	$r2,$r0,$r0
    1ab8:	012e031c 	0x012e031c
    1abc:	05130505 	0x05130505
    1ac0:	1e050113 	pcaddu18i	$r19,10248(0x2808)
    1ac4:	13050501 	addu16i.d	$r1,$r8,-16063(0xc141)
    1ac8:	01060805 	0x01060805
    1acc:	05800105 	0x05800105
    1ad0:	05860609 	0x05860609
    1ad4:	024c0601 	sltui	$r1,$r16,769(0x301)
    1ad8:	0101000c 	fadd.d	$f12,$f0,$f0
    1adc:	05000105 	0x05000105
    1ae0:	00272002 	crcc.w.w.w	$r2,$r0,$r8
    1ae4:	04b1031c 	csrxchg	$r28,$r24,0x2c40
    1ae8:	05010601 	0x05010601
    1aec:	24020605 	ldptr.w	$r5,$r16,516(0x204)
    1af0:	13831313 	addu16i.d	$r19,$r24,-7996(0xe0c4)
    1af4:	01061505 	0x01061505
    1af8:	05053c08 	0x05053c08
    1afc:	05134b06 	0x05134b06
    1b00:	02130601 	slti	$r1,$r16,1217(0x4c1)
    1b04:	0101000c 	fadd.d	$f12,$f0,$f0
    1b08:	00000106 	0x00000106
    1b0c:	00d60002 	bstrpick.d	$r2,$r0,0x16,0x0
    1b10:	01010000 	fadd.d	$f0,$f0,$f0
    1b14:	000d0efb 	bytepick.d	$r27,$r23,$r3,0x2
    1b18:	01010101 	fadd.d	$f1,$f8,$f0
    1b1c:	01000000 	0x01000000
    1b20:	44010000 	bnez	$r0,256(0x100) # 1c20 <_start-0x1bffe3e0>
    1b24:	414c2f3a 	beqz	$r25,-1487828(0x694c2c) # ffe96750 <_edata+0x7fe9574c>
    1b28:	5f323331 	bne	$r25,$r17,-52688(0x33230) # ffff4d58 <_edata+0x7fff3d54>
    1b2c:	5f436f53 	bne	$r26,$r19,-48276(0x3436c) # ffff5e98 <_edata+0x7fff4e94>
    1b30:	455f5753 	bnez	$r26,-3317932(0x4d5f54) # ffcd7a84 <_edata+0x7fcd6a80>
    1b34:	752f5058 	xvsigncov.w	$xr24,$xr2,$xr20
    1b38:	00726573 	bstrins.w	$r19,$r11,0x12,0x19
    1b3c:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
    1b40:	32333141 	0x32333141
    1b44:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff8a94 <_edata+0x7fff7a90>
    1b48:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff7298 <_edata+0x7fff6294>
    1b4c:	2f505845 	0x2f505845
    1b50:	6c636e69 	bgeu	$r19,$r9,25452(0x636c) # 7ebc <_start-0x1bff8144>
    1b54:	00656475 	bstrins.w	$r21,$r3,0x5,0x19
    1b58:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
    1b5c:	32333141 	0x32333141
    1b60:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff8ab0 <_edata+0x7fff7aac>
    1b64:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff72b4 <_edata+0x7fff62b0>
    1b68:	2f505845 	0x2f505845
    1b6c:	76697264 	0x76697264
    1b70:	552f7265 	bl	-107663504(0x9952f70) # f9954ae0 <_edata+0x79953adc>
    1b74:	00545241 	0x00545241
    1b78:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
    1b7c:	32333141 	0x32333141
    1b80:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff8ad0 <_edata+0x7fff7acc>
    1b84:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff72d4 <_edata+0x7fff62d0>
    1b88:	2f505845 	0x2f505845
    1b8c:	2f707362 	0x2f707362
    1b90:	4e495250 	jirl	$r16,$r18,-112304(0x24950)
    1b94:	44004654 	bnez	$r18,-3145660(0x500044) # ffd01bd8 <_edata+0x7fd00bd4>
    1b98:	414c2f3a 	beqz	$r25,-1487828(0x694c2c) # ffe967c4 <_edata+0x7fe957c0>
    1b9c:	5f323331 	bne	$r25,$r17,-52688(0x33230) # ffff4dcc <_edata+0x7fff3dc8>
    1ba0:	5f436f53 	bne	$r26,$r19,-48276(0x3436c) # ffff5f0c <_edata+0x7fff4f08>
    1ba4:	455f5753 	bnez	$r26,-3317932(0x4d5f54) # ffcd7af8 <_edata+0x7fcd6af4>
    1ba8:	642f5058 	bge	$r2,$r24,12112(0x2f50) # 4af8 <_start-0x1bffb508>
    1bac:	65766972 	bge	$r11,$r18,95848(0x17668) # 19214 <_start-0x1bfe6dec>
    1bb0:	6d000072 	bgeu	$r3,$r18,65536(0x10000) # 11bb0 <_start-0x1bfee450>
    1bb4:	2e6e6961 	0x2e6e6961
    1bb8:	00010063 	0x00010063
    1bbc:	73657400 	vssrani.wu.d	$vr0,$vr0,0x1d
    1bc0:	00682e74 	bstrins.w	$r20,$r19,0x8,0xb
    1bc4:	75000002 	0x75000002
    1bc8:	2e747261 	0x2e747261
    1bcc:	00030068 	0x00030068
    1bd0:	69727000 	bltu	$r0,$r0,94832(0x17270) # 18e40 <_start-0x1bfe71c0>
    1bd4:	2e66746e 	0x2e66746e
    1bd8:	00040068 	alsl.w	$r8,$r3,$r0,0x1
    1bdc:	6d656400 	bgeu	$r0,$r0,91492(0x16564) # 18140 <_start-0x1bfe7ec0>
    1be0:	00682e6f 	bstrins.w	$r15,$r19,0x8,0xb
    1be4:	00000005 	0x00000005
    1be8:	05000105 	0x05000105
    1bec:	00277002 	crcc.w.w.w	$r2,$r0,$r28
    1bf0:	012c031c 	0x012c031c
    1bf4:	f4880505 	0xf4880505
    1bf8:	f203f3bb 	0xf203f3bb
    1bfc:	00bbba00 	bstrins.d	$r0,$r16,0x3b,0x2e
    1c00:	03010402 	lu52i.d	$r2,$r0,65(0x41)
    1c04:	09054a20 	0x09054a20
    1c08:	01040200 	0x01040200
    1c0c:	00040213 	alsl.w	$r19,$r16,$r0,0x1
    1c10:	025d0101 	sltui	$r1,$r8,1856(0x740)
    1c14:	00020000 	0x00020000
    1c18:	0000009a 	0x0000009a
    1c1c:	0efb0101 	0x0efb0101
    1c20:	0101000d 	fadd.d	$f13,$f0,$f0
    1c24:	00000101 	0x00000101
    1c28:	00000100 	0x00000100
    1c2c:	2f3a4401 	0x2f3a4401
    1c30:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
    1c34:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff6f90 <_edata+0x7fff5f8c>
    1c38:	57535f43 	bl	-49327268(0xd0f535c) # fd0f6f94 <_edata+0x7d0f5f90>
    1c3c:	5058455f 	b	92035140(0x57c5844) # 57c7480 <_start-0x16838b80>
    1c40:	6573752f 	bge	$r9,$r15,95092(0x17374) # 18fb4 <_start-0x1bfe704c>
    1c44:	3a440072 	0x3a440072
    1c48:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
    1c4c:	535f3233 	b	-120627408(0x8cf5f30) # f8cf7b7c <_edata+0x78cf6b78>
    1c50:	535f436f 	b	-37789888(0xdbf5f40) # fdbf7b90 <_edata+0x7dbf6b8c>
    1c54:	58455f57 	beq	$r26,$r23,17756(0x455c) # 61b0 <_start-0x1bff9e50>
    1c58:	6e692f50 	bgeu	$r26,$r16,-104148(0x2692c) # fffe8584 <_edata+0x7ffe7580>
    1c5c:	64756c63 	bge	$r3,$r3,30060(0x756c) # 91c8 <_start-0x1bff6e38>
    1c60:	3a440065 	0x3a440065
    1c64:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
    1c68:	535f3233 	b	-120627408(0x8cf5f30) # f8cf7b98 <_edata+0x78cf6b94>
    1c6c:	535f436f 	b	-37789888(0xdbf5f40) # fdbf7bac <_edata+0x7dbf6ba8>
    1c70:	58455f57 	beq	$r26,$r23,17756(0x455c) # 61cc <_start-0x1bff9e34>
    1c74:	72642f50 	0x72642f50
    1c78:	72657669 	0x72657669
    1c7c:	5241552f 	b	79577428(0x4be4154) # 4be5dd0 <_start-0x1741a230>
    1c80:	69000054 	bltu	$r2,$r20,65536(0x10000) # 11c80 <_start-0x1bfee380>
    1c84:	7265746e 	0x7265746e
    1c88:	74707572 	xvmax.b	$xr18,$xr11,$xr29
    1c8c:	0100632e 	0x0100632e
    1c90:	6e690000 	bgeu	$r0,$r0,-104192(0x26900) # fffe8590 <_edata+0x7ffe758c>
    1c94:	72726574 	0x72726574
    1c98:	2e747075 	0x2e747075
    1c9c:	00010068 	0x00010068
    1ca0:	73657400 	vssrani.wu.d	$vr0,$vr0,0x1d
    1ca4:	00682e74 	bstrins.w	$r20,$r19,0x8,0xb
    1ca8:	75000002 	0x75000002
    1cac:	2e747261 	0x2e747261
    1cb0:	00030068 	0x00030068
    1cb4:	01050000 	fmul.d	$f0,$f0,$f0
    1cb8:	00020500 	0x00020500
    1cbc:	03000000 	lu52i.d	$r0,$r0,0
    1cc0:	0505011b 	0x0505011b
    1cc4:	06010513 	cacop	0x13,$r8,65(0x41)
    1cc8:	00040285 	alsl.w	$r5,$r20,$r0,0x1
    1ccc:	01050101 	fmul.d	$f1,$f8,$f0
    1cd0:	c4020500 	0xc4020500
    1cd4:	031c0027 	lu52i.d	$r7,$r1,1792(0x700)
    1cd8:	05050121 	0x05050121
    1cdc:	06010513 	cacop	0x13,$r8,65(0x41)
    1ce0:	00040285 	alsl.w	$r5,$r20,$r0,0x1
    1ce4:	01050101 	fmul.d	$f1,$f8,$f0
    1ce8:	d0020500 	0xd0020500
    1cec:	031c0027 	lu52i.d	$r7,$r1,1792(0x700)
    1cf0:	05050127 	0x05050127
    1cf4:	06010513 	cacop	0x13,$r8,65(0x41)
    1cf8:	00040285 	alsl.w	$r5,$r20,$r0,0x1
    1cfc:	01050101 	fmul.d	$f1,$f8,$f0
    1d00:	00020500 	0x00020500
    1d04:	03000000 	lu52i.d	$r0,$r0,0
    1d08:	0505012e 	0x0505012e
    1d0c:	06010513 	cacop	0x13,$r8,65(0x41)
    1d10:	00040285 	alsl.w	$r5,$r20,$r0,0x1
    1d14:	01050101 	fmul.d	$f1,$f8,$f0
    1d18:	dc020500 	0xdc020500
    1d1c:	031c0027 	lu52i.d	$r7,$r1,1792(0x700)
    1d20:	05050134 	0x05050134
    1d24:	06010516 	cacop	0x16,$r8,65(0x41)
    1d28:	000402f7 	alsl.w	$r23,$r23,$r0,0x1
    1d2c:	01050101 	fmul.d	$f1,$f8,$f0
    1d30:	00020500 	0x00020500
    1d34:	03000000 	lu52i.d	$r0,$r0,0
    1d38:	0505013f 	0x0505013f
    1d3c:	06010513 	cacop	0x13,$r8,65(0x41)
    1d40:	000402f7 	alsl.w	$r23,$r23,$r0,0x1
    1d44:	01050101 	fmul.d	$f1,$f8,$f0
    1d48:	f0020500 	0xf0020500
    1d4c:	031c0027 	lu52i.d	$r7,$r1,1792(0x700)
    1d50:	050100c7 	0x050100c7
    1d54:	01051305 	fmul.d	$f5,$f24,$f4
    1d58:	0402be06 	csrxchg	$r6,$r16,0xaf
    1d5c:	05010100 	0x05010100
    1d60:	02050001 	slti	$r1,$r0,320(0x140)
    1d64:	1c002800 	pcaddu12i	$r0,320(0x140)
    1d68:	0100d203 	fadd.s	$f3,$f16,$f20
    1d6c:	4b830505 	bcnez	$fcc0,1540868(0x178304) # 17a070 <_start-0x1be85f90>
    1d70:	01058383 	0x01058383
    1d74:	0c024b06 	0x0c024b06
    1d78:	05010100 	0x05010100
    1d7c:	02050001 	slti	$r1,$r0,320(0x140)
    1d80:	1c00282c 	pcaddu12i	$r12,321(0x141)
    1d84:	0100e103 	fadd.s	$f3,$f8,$f24
    1d88:	05130505 	0x05130505
    1d8c:	05010608 	0x05010608
    1d90:	05830609 	0x05830609
    1d94:	ba010619 	0xba010619
    1d98:	024c0105 	sltui	$r5,$r8,768(0x300)
    1d9c:	01010004 	fadd.d	$f4,$f0,$f0
    1da0:	05000105 	0x05000105
    1da4:	00000002 	0x00000002
    1da8:	00e80300 	bstrpick.d	$r0,$r24,0x28,0x0
    1dac:	13050501 	addu16i.d	$r1,$r8,-16063(0xc141)
    1db0:	01060805 	0x01060805
    1db4:	83060905 	0x83060905
    1db8:	01061905 	0x01061905
    1dbc:	4c0105ba 	jirl	$r26,$r13,260(0x104)
    1dc0:	01000402 	0x01000402
    1dc4:	00010501 	0x00010501
    1dc8:	28480205 	ld.h	$r5,$r16,512(0x200)
    1dcc:	ef031c00 	0xef031c00
    1dd0:	05050100 	0x05050100
    1dd4:	06080513 	cacop	0x13,$r8,513(0x201)
    1dd8:	00230501 	div.du	$r1,$r8,$r1
    1ddc:	82010402 	0x82010402
    1de0:	01040200 	0x01040200
    1de4:	001505ba 	or	$r26,$r13,$r1
    1de8:	4a010402 	bceqz	$fcc0,655620(0xa0104) # a1eec <_start-0x1bf5e114>
    1dec:	05490105 	0x05490105
    1df0:	05840609 	0x05840609
    1df4:	024c0601 	sltui	$r1,$r16,769(0x301)
    1df8:	01010010 	fadd.d	$f16,$f0,$f0
    1dfc:	05000105 	0x05000105
    1e00:	00288002 	0x00288002
    1e04:	0186031c 	0x0186031c
    1e08:	f3050501 	0xf3050501
    1e0c:	054c1413 	0x054c1413
    1e10:	05010608 	0x05010608
    1e14:	05830605 	0x05830605
    1e18:	05010617 	0x05010617
    1e1c:	05058212 	0x05058212
    1e20:	09055006 	0x09055006
    1e24:	01740306 	0x01740306
    1e28:	0c030e05 	0x0c030e05
    1e2c:	ba19054a 	0xba19054a
    1e30:	054a0b05 	0x054a0b05
    1e34:	0402003b 	csrwr	$r27,0x80
    1e38:	32054a01 	0x32054a01
    1e3c:	01040200 	0x01040200
    1e40:	0609054a 	cacop	0xa,$r10,577(0x241)
    1e44:	06260583 	cacop	0x3,$r12,-1663(0x981)
    1e48:	82090501 	0x82090501
    1e4c:	05813b05 	0x05813b05
    1e50:	05860605 	0x05860605
    1e54:	0501060a 	0x0501060a
    1e58:	0805ba15 	0x0805ba15
    1e5c:	0605054a 	cacop	0xa,$r10,321(0x141)
    1e60:	06120552 	cacop	0x12,$r10,1153(0x481)
    1e64:	83010501 	0x83010501
    1e68:	060905ba 	cacop	0x1a,$r13,577(0x241)
    1e6c:	0402837d 	csrxchg	$r29,$r27,0xa0
    1e70:	Address 0x0000000000001e70 is out of bounds.


Disassembly of section .debug_info:

00000000 <.debug_info>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
       0:	00000022 	0x00000022
       4:	00000002 	0x00000002
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
       8:	01040000 	0x01040000
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
       c:	00000000 	0x00000000
      10:	1c000000 	pcaddu12i	$r0,0
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
      14:	1c00113c 	pcaddu12i	$r28,137(0x89)
D:/LA132_SoC_SW_EXP/user/interrupt.c:109
      18:	00000000 	0x00000000
delay_s():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:86
      1c:	00000021 	0x00000021
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
      20:	00000035 	0x00000035
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
      24:	047e8001 	csrrd	$r1,0x1fa0
      28:	00040000 	alsl.w	$r0,$r0,$r0,0x1
      2c:	00000014 	0x00000014
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
      30:	00cb0104 	bstrpick.d	$r4,$r8,0xb,0x0
      34:	250c0000 	stptr.w	$r0,$r0,3072(0xc00)
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
      38:	21000002 	sc.w	$r2,$r0,0
      3c:	30000000 	0x30000000
      40:	00000000 	0x00000000
uart_read_bcd_char():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
      44:	9f000000 	0x9f000000
      48:	02000000 	slti	$r0,$r0,0
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
      4c:	019a0801 	0x019a0801
      50:	25030000 	stptr.w	$r0,$r0,768(0x300)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
      54:	02000000 	slti	$r0,$r0,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
      58:	019c0601 	0x019c0601
      5c:	02020000 	slti	$r0,$r0,128(0x80)
      60:	0001ec07 	0x0001ec07
      64:	00380300 	0x00380300
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
      68:	02020000 	slti	$r0,$r0,128(0x80)
      6c:	00004b05 	bitrev.4b	$r5,$r24
      70:	07040200 	0x07040200
      74:	000001c6 	0x000001c6
      78:	00004b03 	bitrev.4b	$r3,$r24
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
      7c:	05040400 	0x05040400
      80:	00746e69 	bstrins.w	$r9,$r19,0x14,0x1b
      84:	bc070802 	0xbc070802
      88:	02000001 	slti	$r1,$r0,0
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:254
      8c:	00900508 	bstrins.d	$r8,$r8,0x10,0x1
      90:	04020000 	csrrd	$r0,0x80
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:259
      94:	00008a04 	0x00008a04
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:260
      98:	06010200 	cacop	0x0,$r16,64(0x40)
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 3)
      9c:	000001a3 	0x000001a3
      a0:	00007305 	0x00007305
      a4:	01d30600 	0x01d30600
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
      a8:	3e020000 	0x3e020000
      ac:	00004b16 	bitrev.4b	$r22,$r24
      b0:	00bc0700 	bstrins.d	$r0,$r24,0x3c,0x1
      b4:	62020000 	blt	$r0,$r0,-130560(0x20200) # fffe02b4 <_edata+0x7ffdf2b0>
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
      b8:	00007f11 	0x00007f11
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
      bc:	026c0700 	sltui	$r0,$r24,-1279(0xb01)
      c0:	64020000 	bge	$r0,$r0,512(0x200) # 2c0 <_start-0x1bfffd40>
      c4:	00007f11 	0x00007f11
      c8:	005e0700 	0x005e0700
      cc:	65020000 	bge	$r0,$r0,66048(0x10200) # 102cc <_start-0x1bfefd34>
      d0:	00007f11 	0x00007f11
      d4:	00690700 	bstrins.w	$r0,$r24,0x9,0x1
      d8:	66020000 	bge	$r0,$r0,-130560(0x20200) # fffe02d8 <_edata+0x7ffdf2d4>
      dc:	0000570c 	bitrev.d	$r12,$r24
      e0:	007a0800 	bstrins.w	$r0,$r0,0x1a,0x2
      e4:	00cb0000 	bstrpick.d	$r0,$r0,0xb,0x0
      e8:	4b090000 	bceqz	$fcc0,198912(0x30900) # 309e8 <_start-0x1bfcf618>
      ec:	0f000000 	0x0f000000
      f0:	00bb0500 	bstrins.d	$r0,$r8,0x3b,0x1
      f4:	ab0a0000 	0xab0a0000
      f8:	01000000 	0x01000000
      fc:	00cb132d 	bstrpick.d	$r13,$r25,0xb,0x4
     100:	03050000 	lu52i.d	$r0,$r0,320(0x140)
     104:	1c0029cc 	pcaddu12i	$r12,334(0x14e)
     108:	00002c08 	ctz.d	$r8,$r0
     10c:	0000f200 	0x0000f200
     110:	004b0900 	0x004b0900
     114:	000f0000 	bytepick.d	$r0,$r0,$r0,0x6
     118:	0000e203 	0x0000e203
     11c:	5f730b00 	bne	$r24,$r0,-36088(0x37308) # ffff7424 <_edata+0x7fff6420>
     120:	32010071 	0x32010071
     124:	0000f21f 	0x0000f21f
     128:	14030500 	lu12i.w	$r0,6184(0x1828)
     12c:	0a800000 	0x0a800000
     130:	00000285 	0x00000285
     134:	2c1f3301 	vld	$vr1,$r24,1996(0x7cc)
     138:	05000000 	0x05000000
     13c:	00001003 	clo.w	$r3,$r0
     140:	01dc0a80 	0x01dc0a80
     144:	33010000 	0x33010000
     148:	00002c29 	ctz.d	$r9,$r1
     14c:	0f030500 	0x0f030500
     150:	0a800000 	0x0a800000
     154:	000000c5 	0x000000c5
     158:	2c1f4d01 	vld	$vr1,$r8,2003(0x7d3)
     15c:	05000000 	0x05000000
     160:	00000e03 	0x00000e03
     164:	01b50a80 	0x01b50a80
     168:	4e010000 	jirl	$r0,$r0,-130816(0x20100)
     16c:	00003f20 	revb.d	$r0,$r25
     170:	0c030500 	0x0c030500
     174:	0a800000 	0x0a800000
     178:	0000021c 	0x0000021c
     17c:	3f204f01 	0x3f204f01
     180:	05000000 	0x05000000
     184:	00000a03 	0x00000a03
     188:	00840a80 	bstrins.d	$r0,$r20,0x4,0x2
     18c:	50010000 	b	256(0x100) # 28c <_start-0x1bfffd74>
     190:	00002c1f 	ctz.d	$r31,$r0
     194:	09030500 	0x09030500
     198:	0a800000 	0x0a800000
     19c:	000001e5 	0x000001e5
     1a0:	2c1f5101 	vld	$vr1,$r8,2004(0x7d4)
     1a4:	05000000 	0x05000000
     1a8:	00000803 	0x00000803
     1ac:	025d0a80 	sltui	$r0,$r20,1858(0x742)
     1b0:	52010000 	b	131328(0x20100) # 202b0 <_start-0x1bfdfd50>
     1b4:	0000521f 	bitrev.w	$r31,$r16
     1b8:	04030500 	csrxchg	$r0,$r8,0xc1
     1bc:	0a800000 	0x0a800000
     1c0:	00000267 	0x00000267
     1c4:	521f5301 	b	-66707632(0xc061f50) # fc062114 <_edata+0x7c061110>
     1c8:	05000000 	0x05000000
     1cc:	00000003 	0x00000003
     1d0:	020e0c80 	slti	$r0,$r4,899(0x383)
     1d4:	9f010000 	0x9f010000
     1d8:	00146406 	nor	$r6,$r0,$r25
     1dc:	0001601c 	0x0001601c
     1e0:	d69c0100 	0xd69c0100
     1e4:	0d000002 	fsel	$f2,$f0,$f0,$fcc0
     1e8:	00000043 	0x00000043
     1ec:	4b12a101 	bcnez	$fcc0,463520(0x712a0) # 7148c <_start-0x1bf8eb74>
     1f0:	04000000 	csrrd	$r0,0x0
     1f4:	00000000 	0x00000000
     1f8:	0e000000 	0x0e000000
     1fc:	a201006e 	0xa201006e
     200:	00004b12 	bitrev.4b	$r18,$r24
     204:	00002700 	clz.d	$r0,$r24
     208:	00002300 	clo.d	$r0,$r24
     20c:	00180f00 	sra.w	$r0,$r24,$r3
     210:	02780000 	sltui	$r0,$r0,-512(0xe00)
     214:	6b0e0000 	bltu	$r0,$r0,-61952(0x30e00) # ffff1014 <_edata+0x7fff0010>
     218:	0dbc0100 	0x0dbc0100
     21c:	00000057 	0x00000057
     220:	0000004c 	0x0000004c
     224:	00000046 	0x00000046
     228:	00155810 	or	$r16,$r0,$r22
     22c:	0000401c 	revh.2w	$r28,$r0
     230:	00025500 	0x00025500
     234:	00730b00 	bstrins.w	$r0,$r24,0x13,0x2
     238:	d612bf01 	0xd612bf01
     23c:	02000002 	slti	$r2,$r0,0
     240:	7c115c91 	0x7c115c91
     244:	391c0015 	0x391c0015
     248:	35000004 	0x35000004
     24c:	12000002 	addu16i.d	$r2,$r0,-32768(0x8000)
     250:	91025401 	0x91025401
     254:	5501125c 	bl	-110034672(0x9710110) # f9710364 <_edata+0x7970f360>
     258:	13003101 	addu16i.d	$r1,$r8,-16372(0xc00c)
     25c:	1c001590 	pcaddu12i	$r16,172(0xac)
     260:	00000445 	0x00000445
     264:	05540112 	0x05540112
     268:	0029a003 	0x0029a003
     26c:	5501121c 	bl	-126811888(0x8710110) # f871037c <_edata+0x7870f378>
     270:	12008702 	addu16i.d	$r2,$r24,-32735(0x8021)
     274:	89025601 	0x89025601
     278:	14000000 	lu12i.w	$r0,0
     27c:	1c001550 	pcaddu12i	$r16,170(0xaa)
     280:	000003d5 	0x000003d5
     284:	0015c013 	xor	$r19,$r0,$r16
     288:	0004451c 	alsl.w	$r28,$r8,$r17,0x1
     28c:	54011200 	bl	-134217456(0x8000110) # f800039c <_edata+0x77fff398>
     290:	29b00305 	st.w	$r5,$r24,-1024(0xc00)
     294:	01121c00 	0x01121c00
     298:	008a0255 	bstrins.d	$r21,$r18,0xa,0x0
     29c:	8c110000 	0x8c110000
     2a0:	451c0014 	bnez	$r0,-3073024(0x511c00) # ffd11ea0 <_edata+0x7fd10e9c>
     2a4:	94000004 	0x94000004
     2a8:	12000002 	addu16i.d	$r2,$r0,-32768(0x8000)
     2ac:	03055401 	lu52i.d	$r1,$r0,341(0x155)
     2b0:	1c002920 	pcaddu12i	$r0,329(0x149)
     2b4:	01550112 	0x01550112
     2b8:	98110038 	0x98110038
     2bc:	451c0014 	bnez	$r0,-3073024(0x511c00) # ffd11ebc <_edata+0x7fd10eb8>
     2c0:	ab000004 	0xab000004
     2c4:	12000002 	addu16i.d	$r2,$r0,-32768(0x8000)
     2c8:	03055401 	lu52i.d	$r1,$r0,341(0x155)
     2cc:	1c002964 	pcaddu12i	$r4,331(0x14b)
     2d0:	14c01400 	lu12i.w	$r0,393376(0x600a0)
     2d4:	04511c00 	csrrd	$r0,0x1447
     2d8:	c4140000 	0xc4140000
     2dc:	5d1c0014 	bne	$r0,$r20,72704(0x11c00) # 11edc <_start-0x1bfee124>
     2e0:	13000004 	addu16i.d	$r4,$r0,-16384(0xc000)
     2e4:	1c0014f0 	pcaddu12i	$r16,167(0xa7)
     2e8:	00000469 	0x00000469
     2ec:	01540112 	0x01540112
     2f0:	55011231 	bl	-121306864(0x8c50110) # f8c50400 <_edata+0x78c4f3fc>
     2f4:	12240305 	addu16i.d	$r5,$r24,-30464(0x8900)
     2f8:	00001c00 	ctz.w	$r0,$r0
     2fc:	00007308 	0x00007308
     300:	0002e600 	0x0002e600
     304:	004b0900 	0x004b0900
     308:	00030000 	0x00030000
     30c:	0001a815 	0x0001a815
     310:	0d650100 	xvshuf.b	$xr0,$xr8,$xr0,$xr10
     314:	1c001224 	pcaddu12i	$r4,145(0x91)
     318:	00000240 	0x00000240
     31c:	03969c01 	ori	$r1,$r0,0x5a7
     320:	6e0e0000 	bgeu	$r0,$r0,-127488(0x20e00) # fffe1120 <_edata+0x7ffe011c>
     324:	01006269 	0x01006269
     328:	00251367 	crc.w.w.w	$r7,$r27,$r4
     32c:	00790000 	bstrins.w	$r0,$r0,0x19,0x0
     330:	00750000 	bstrins.w	$r0,$r0,0x15,0x0
     334:	630e0000 	blt	$r0,$r0,-61952(0x30e00) # ffff1134 <_edata+0x7fff0130>
     338:	01006c6f 	0x01006c6f
     33c:	00251867 	crc.w.w.w	$r7,$r3,$r6
     340:	009d0000 	bstrins.d	$r0,$r0,0x1d,0x0
     344:	00970000 	bstrins.d	$r0,$r0,0x17,0x0
     348:	6f0e0000 	bgeu	$r0,$r0,-61952(0x30e00) # ffff1148 <_edata+0x7fff0144>
     34c:	01007475 	0x01007475
     350:	00251d67 	crc.w.w.w	$r7,$r11,$r7
     354:	00cb0000 	bstrpick.d	$r0,$r0,0xb,0x0
     358:	00c70000 	bstrpick.d	$r0,$r0,0x7,0x0
     35c:	8e0d0000 	0x8e0d0000
     360:	01000002 	0x01000002
     364:	00381468 	0x00381468
     368:	00f10000 	bstrpick.d	$r0,$r0,0x31,0x0
     36c:	00e90000 	bstrpick.d	$r0,$r0,0x29,0x0
     370:	9e160000 	0x9e160000
     374:	01000000 	0x01000000
     378:	13c0019a 	addu16i.d	$r26,$r12,-4096(0xf000)
     37c:	000f1c00 	bytepick.d	$r0,$r0,$r7,0x6
     380:	86000000 	0x86000000
     384:	0e000003 	0x0e000003
     388:	9001006b 	0x9001006b
     38c:	0000570d 	bitrev.d	$r13,$r24
     390:	00012b00 	asrtle.d	$r24,$r10
     394:	00012500 	asrtle.d	$r8,$r9
     398:	13a41400 	addu16i.d	$r0,$r0,-5883(0xe905)
     39c:	03961c00 	ori	$r0,$r0,0x587
     3a0:	2c140000 	vld	$vr0,$r0,1280(0x500)
     3a4:	021c0014 	slti	$r20,$r0,1792(0x700)
     3a8:	00000004 	0x00000004
     3ac:	00129413 	sltu	$r19,$r0,$r5
     3b0:	0004751c 	alsl.w	$r28,$r8,$r29,0x1
     3b4:	54011200 	bl	-134217456(0x8000110) # f80004c4 <_edata+0x77fff4c0>
     3b8:	00003501 	revb.4h	$r1,$r8
     3bc:	00018f17 	0x00018f17
     3c0:	0c560100 	vfcmp.cueq.s	$vr0,$vr8,$vr0
     3c4:	00000057 	0x00000057
     3c8:	1c0011f8 	pcaddu12i	$r24,143(0x8f)
     3cc:	0000002c 	0x0000002c
     3d0:	03d59c01 	xori	$r1,$r0,0x567
     3d4:	62180000 	blt	$r0,$r0,-124928(0x21800) # fffe1bd4 <_edata+0x7ffe0bd0>
     3d8:	26560100 	ldptr.d	$r0,$r8,22016(0x5600)
     3dc:	00000038 	0x00000038
     3e0:	00000158 	0x00000158
     3e4:	00000154 	0x00000154
     3e8:	0100690e 	0x0100690e
     3ec:	00570958 	0x00570958
     3f0:	017d0000 	0x017d0000
     3f4:	01790000 	0x01790000
     3f8:	17000000 	lu32i.d	$r0,-524288(0x80000)
     3fc:	000000b6 	0x000000b6
     400:	570c4001 	bl	461888(0x70c40) # 71040 <_start-0x1bf8efc0>
     404:	90000000 	0x90000000
     408:	681c0011 	bltu	$r0,$r17,7168(0x1c00) # 2008 <_start-0x1bffdff8>
     40c:	01000000 	0x01000000
     410:	0004029c 	alsl.w	$r28,$r20,$r0,0x1
     414:	00760e00 	bstrins.w	$r0,$r16,0x16,0x3
     418:	25134201 	stptr.w	$r1,$r16,4928(0x1340)
     41c:	9e000000 	0x9e000000
     420:	9c000001 	0x9c000001
     424:	00000001 	0x00000001
     428:	00029415 	0x00029415
     42c:	0d350100 	0x0d350100
     430:	1c00113c 	pcaddu12i	$r28,137(0x89)
     434:	00000054 	0x00000054
     438:	04399c01 	csrrd	$r1,0xe67
     43c:	76190000 	0x76190000
     440:	22350100 	ll.d	$r0,$r8,13568(0x3500)
     444:	00000025 	0x00000025
     448:	6e0e5401 	bgeu	$r0,$r1,-127404(0x20e54) # fffe129c <_edata+0x7ffe0298>
     44c:	01007478 	0x01007478
     450:	00251337 	crc.w.w.w	$r23,$r25,$r4
     454:	01b30000 	0x01b30000
     458:	01b10000 	0x01b10000
     45c:	1a000000 	pcalau12i	$r0,0
     460:	000001ff 	0x000001ff
     464:	000001ff 	0x000001ff
     468:	1a063303 	pcalau12i	$r3,12696(0x3198)
     46c:	00000639 	0x00000639
     470:	00000639 	0x00000639
     474:	1a050b04 	pcalau12i	$r4,10328(0x2858)
     478:	0000007a 	0x0000007a
     47c:	0000007a 	0x0000007a
     480:	1a062503 	pcalau12i	$r3,12584(0x3128)
     484:	00000277 	0x00000277
     488:	00000277 	0x00000277
     48c:	1a062505 	pcalau12i	$r5,12584(0x3128)
     490:	0000017f 	0x0000017f
     494:	0000017f 	0x0000017f
     498:	1a063005 	pcalau12i	$r5,12672(0x3180)
     49c:	00000055 	0x00000055
     4a0:	00000055 	0x00000055
     4a4:	00081e06 	bytepick.w	$r6,$r16,$r7,0x0
     4a8:	0000030d 	0x0000030d
     4ac:	01a60004 	0x01a60004
     4b0:	01040000 	0x01040000
     4b4:	000000cb 	0x000000cb
     4b8:	0002db0c 	0x0002db0c
     4bc:	00002100 	clo.d	$r0,$r8
     4c0:	00006000 	rdtimel.w	$r0,$r0
     4c4:	00000000 	0x00000000
     4c8:	0004b600 	alsl.w	$r0,$r16,$r13,0x2
     4cc:	08010200 	0x08010200
     4d0:	0000019a 	0x0000019a
     4d4:	00002503 	clz.d	$r3,$r8
     4d8:	00250400 	crc.w.w.w	$r0,$r0,$r1
     4dc:	01020000 	0x01020000
     4e0:	00019c06 	0x00019c06
     4e4:	07020200 	0x07020200
     4e8:	000001ec 	0x000001ec
     4ec:	4b050202 	0x4b050202
     4f0:	02000000 	slti	$r0,$r0,0
     4f4:	01c60704 	0x01c60704
     4f8:	04050000 	csrrd	$r0,0x140
     4fc:	746e6905 	0x746e6905
     500:	07080200 	0x07080200
     504:	000001bc 	0x000001bc
     508:	90050802 	0x90050802
     50c:	02000000 	slti	$r0,$r0,0
     510:	008a0404 	bstrins.d	$r4,$r0,0xa,0x1
     514:	01020000 	0x01020000
     518:	0001a306 	0x0001a306
     51c:	006e0300 	bstrins.w	$r0,$r24,0xe,0x0
     520:	d3060000 	0xd3060000
     524:	02000001 	slti	$r1,$r0,0
     528:	004b163e 	0x004b163e
     52c:	bc070000 	0xbc070000
     530:	02000000 	slti	$r0,$r0,0
     534:	007a1162 	bstrins.w	$r2,$r11,0x1a,0x4
     538:	6c070000 	bgeu	$r0,$r0,1792(0x700) # c38 <_start-0x1bfff3c8>
     53c:	02000002 	slti	$r2,$r0,0
     540:	007a1164 	bstrins.w	$r4,$r11,0x1a,0x4
     544:	5e070000 	bne	$r0,$r0,-129280(0x20700) # fffe0c44 <_edata+0x7ffdfc40>
     548:	02000000 	slti	$r0,$r0,0
     54c:	007a1165 	bstrins.w	$r5,$r11,0x1a,0x4
     550:	69070000 	bltu	$r0,$r0,67328(0x10700) # 10c50 <_start-0x1bfef3b0>
     554:	02000000 	slti	$r0,$r0,0
     558:	00520c66 	0x00520c66
     55c:	2c080000 	vld	$vr0,$r0,512(0x200)
     560:	c6000000 	0xc6000000
     564:	09000000 	0x09000000
     568:	0000004b 	0x0000004b
     56c:	b603000f 	0xb603000f
     570:	0a000000 	0x0a000000
     574:	00000302 	0x00000302
     578:	c61c0c01 	0xc61c0c01
     57c:	05000000 	0x05000000
     580:	00000003 	0x00000003
     584:	00310800 	0x00310800
     588:	00ed0000 	bstrpick.d	$r0,$r0,0x2d,0x0
     58c:	4b090000 	bceqz	$fcc0,198912(0x30900) # 30e8c <_start-0x1bfcf174>
     590:	07000000 	0x07000000
     594:	00dd0400 	bstrpick.d	$r0,$r0,0x1d,0x1
     598:	190a0000 	pcaddi	$r0,-503808(0x85000)
     59c:	01000003 	0x01000003
     5a0:	00ed1f14 	bstrpick.d	$r20,$r24,0x2d,0x7
     5a4:	03050000 	lu52i.d	$r0,$r0,320(0x140)
     5a8:	80000028 	0x80000028
     5ac:	0002a50a 	0x0002a50a
     5b0:	1f160100 	pcaddu18i	$r0,-479224(0x8b008)
     5b4:	00000031 	0x00000031
     5b8:	00240305 	crc.w.b.w	$r5,$r24,$r0
     5bc:	1f0a8000 	pcaddu18i	$r0,-502784(0x85400)
     5c0:	01000003 	0x01000003
     5c4:	00311f17 	0x00311f17
     5c8:	03050000 	lu52i.d	$r0,$r0,320(0x140)
     5cc:	80001000 	0x80001000
     5d0:	00029b0b 	0x00029b0b
     5d4:	065c0100 	0x065c0100
     5d8:	00000000 	0x00000000
     5dc:	000000b8 	0x000000b8
     5e0:	018a9c01 	0x018a9c01
     5e4:	6e0c0000 	bgeu	$r0,$r0,-128000(0x20c00) # fffe11e4 <_edata+0x7ffe01e0>
     5e8:	5e010064 	bne	$r3,$r4,-130816(0x20100) # fffe06e8 <_edata+0x7ffdf6e4>
     5ec:	00002513 	clz.d	$r19,$r8
     5f0:	0001c800 	asrtgt.d	$r0,$r18
     5f4:	0001c600 	asrtgt.d	$r16,$r17
     5f8:	00700c00 	bstrins.w	$r0,$r0,0x10,0x3
     5fc:	25135f01 	stptr.w	$r1,$r24,4956(0x135c)
     600:	e1000000 	0xe1000000
     604:	db000001 	0xdb000001
     608:	0c000001 	0x0c000001
     60c:	60010063 	blt	$r3,$r3,256(0x100) # 70c <_start-0x1bfff8f4>
     610:	00002513 	clz.d	$r19,$r8
     614:	00021000 	0x00021000
     618:	00020c00 	0x00020c00
     61c:	032b0d00 	lu52i.d	$r0,$r8,-1341(0xac3)
     620:	60010000 	blt	$r0,$r0,256(0x100) # 720 <_start-0x1bfff8e0>
     624:	00002516 	clz.d	$r22,$r8
     628:	00023200 	0x00023200
     62c:	00022e00 	0x00022e00
     630:	cc0b0000 	0xcc0b0000
     634:	01000002 	0x01000002
     638:	0000064e 	0x0000064e
     63c:	00c00000 	bstrpick.d	$r0,$r0,0x0,0x0
     640:	9c010000 	0x9c010000
     644:	000001cf 	0x000001cf
     648:	0100760e 	0x0100760e
     64c:	004b224e 	0x004b224e
     650:	02550000 	sltui	$r0,$r0,1344(0x540)
     654:	02510000 	sltui	$r0,$r0,1088(0x440)
     658:	000f0000 	bytepick.d	$r0,$r0,$r0,0x6
     65c:	34000000 	0x34000000
     660:	0c000000 	0x0c000000
     664:	57010069 	bl	27721984(0x1a70100) # 1a70764 <_start-0x1a58f89c>
     668:	0000520d 	bitrev.w	$r13,$r16
     66c:	00027700 	0x00027700
     670:	00027300 	0x00027300
     674:	0b000000 	0x0b000000
     678:	000002ab 	0x000002ab
     67c:	00064101 	alsl.wu	$r1,$r8,$r16,0x1
     680:	74000000 	xvseq.b	$xr0,$xr0,$xr0
     684:	01000000 	0x01000000
     688:	0002049c 	0x0002049c
     68c:	00641000 	bstrins.w	$r0,$r0,0x4,0x4
     690:	042a4101 	csrxchg	$r1,$r8,0xa90
     694:	01000002 	0x01000002
     698:	00690c54 	bstrins.w	$r20,$r2,0x9,0x3
     69c:	52094301 	b	-66713280(0xc060940) # fc060fdc <_edata+0x7c05ffd8>
     6a0:	9c000000 	0x9c000000
     6a4:	96000002 	0x96000002
     6a8:	00000002 	0x00000002
     6ac:	002c0411 	alsl.d	$r17,$r0,$r1,0x1
     6b0:	ff0b0000 	0xff0b0000
     6b4:	01000001 	0x01000001
     6b8:	165c0637 	lu32i.d	$r23,188465(0x2e031)
     6bc:	008c1c00 	bstrins.d	$r0,$r0,0xc,0x7
     6c0:	9c010000 	0x9c010000
     6c4:	00000273 	0x00000273
     6c8:	0100730e 	0x0100730e
     6cc:	02732137 	sltui	$r23,$r9,-824(0xcc8)
     6d0:	02cc0000 	addi.d	$r0,$r0,768(0x300)
     6d4:	02c60000 	addi.d	$r0,$r0,384(0x180)
     6d8:	6e0e0000 	bgeu	$r0,$r0,-127488(0x20e00) # fffe14d8 <_edata+0x7ffe04d4>
     6dc:	28370100 	ld.b	$r0,$r8,-576(0xdc0)
     6e0:	00000052 	0x00000052
     6e4:	000002fc 	0x000002fc
     6e8:	000002f8 	0x000002f8
     6ec:	0100690c 	0x0100690c
     6f0:	00520939 	0x00520939
     6f4:	031e0000 	lu52i.d	$r0,$r0,1920(0x780)
     6f8:	031a0000 	lu52i.d	$r0,$r0,1664(0x680)
     6fc:	6e0c0000 	bgeu	$r0,$r0,-128000(0x20c00) # fffe12fc <_edata+0x7ffe02f8>
     700:	39010064 	0x39010064
     704:	0000520c 	bitrev.w	$r12,$r16
     708:	00033f00 	0x00033f00
     70c:	00033d00 	0x00033d00
     710:	16c81200 	lu32i.d	$r0,409744(0x64090)
     714:	02791c00 	sltui	$r0,$r0,-441(0xe47)
     718:	11000000 	addu16i.d	$r0,$r0,16384(0x4000)
     71c:	00007504 	0x00007504
     720:	03091300 	lu52i.d	$r0,$r24,580(0x244)
     724:	2e010000 	0x2e010000
     728:	00002516 	clz.d	$r22,$r8
     72c:	0015c400 	xor	$r0,$r0,$r17
     730:	0000681c 	rdtime.d	$r28,$r0
     734:	a69c0100 	0xa69c0100
     738:	0e000002 	0x0e000002
     73c:	2e010063 	0x2e010063
     740:	00006e2b 	cpucfg	$r11,$r17
     744:	00035800 	0x00035800
     748:	00035200 	0x00035200
     74c:	bb0b0000 	0xbb0b0000
     750:	01000002 	0x01000002
     754:	00000627 	0x00000627
     758:	002c0000 	alsl.d	$r0,$r0,$r0,0x1
     75c:	9c010000 	0x9c010000
     760:	000002cf 	0x000002cf
     764:	01006e0e 	0x01006e0e
     768:	00252527 	crc.w.w.w	$r7,$r9,$r9
     76c:	03870000 	ori	$r0,$r0,0x1c0
     770:	03810000 	ori	$r0,$r0,0x40
     774:	14000000 	lu12i.w	$r0,0
     778:	00000326 	0x00000326
     77c:	250f2201 	stptr.w	$r1,$r16,3872(0xf20)
     780:	00000000 	0x00000000
     784:	24000000 	ldptr.w	$r0,$r0,0
     788:	01000000 	0x01000000
     78c:	0002fe9c 	0x0002fe9c
     790:	068a1500 	0x068a1500
     794:	22010000 	ll.d	$r0,$r0,256(0x100)
     798:	00002527 	clz.d	$r7,$r9
     79c:	0003b700 	0x0003b700
     7a0:	0003b300 	0x0003b300
     7a4:	7a160000 	0x7a160000
     7a8:	01000000 	0x01000000
     7ac:	162c0619 	lu32i.d	$r25,90160(0x16030)
     7b0:	00301c00 	0x00301c00
     7b4:	9c010000 	0x9c010000
     7b8:	0003b200 	0x0003b200
     7bc:	11000400 	addu16i.d	$r0,$r0,16385(0x4001)
     7c0:	04000003 	csrrd	$r3,0x0
     7c4:	0000cb01 	0x0000cb01
     7c8:	033c0c00 	lu52i.d	$r0,$r0,-253(0xf03)
     7cc:	00210000 	div.wu	$r0,$r0,$r0
     7d0:	00a80000 	bstrins.d	$r0,$r0,0x28,0x0
     7d4:	00000000 	0x00000000
     7d8:	08130000 	fmadd.s	$f0,$f0,$f0,$f6
     7dc:	01020000 	0x01020000
     7e0:	00019a08 	0x00019a08
     7e4:	06010200 	cacop	0x0,$r16,64(0x40)
     7e8:	0000019c 	0x0000019c
     7ec:	ec070202 	0xec070202
     7f0:	02000001 	slti	$r1,$r0,0
     7f4:	004b0502 	0x004b0502
     7f8:	04020000 	csrrd	$r0,0x80
     7fc:	0001c607 	0x0001c607
     800:	05040300 	0x05040300
     804:	00746e69 	bstrins.w	$r9,$r19,0x14,0x1b
     808:	bc070802 	0xbc070802
     80c:	02000001 	slti	$r1,$r0,0
     810:	00900508 	bstrins.d	$r8,$r8,0x10,0x1
     814:	04020000 	csrrd	$r0,0x80
     818:	00008a04 	0x00008a04
     81c:	06010200 	cacop	0x0,$r16,64(0x40)
     820:	000001a3 	0x000001a3
     824:	0001d304 	0x0001d304
     828:	163e0200 	lu32i.d	$r0,126992(0x1f010)
     82c:	00000041 	0x00000041
     830:	0003cf04 	0x0003cf04
     834:	17400200 	lu32i.d	$r0,-393200(0xa0010)
     838:	00000025 	0x00000025
     83c:	0000bc05 	0x0000bc05
     840:	11620200 	addu16i.d	$r0,$r16,22656(0x5880)
     844:	0000006b 	0x0000006b
     848:	00026c05 	0x00026c05
     84c:	11640200 	addu16i.d	$r0,$r16,22784(0x5900)
     850:	0000006b 	0x0000006b
     854:	00005e05 	ext.w.b	$r5,$r16
     858:	11650200 	addu16i.d	$r0,$r16,22848(0x5940)
     85c:	0000006b 	0x0000006b
     860:	00006905 	rdtime.d	$r5,$r8
     864:	0c660200 	vfcmp.cueq.d	$vr0,$vr16,$vr0
     868:	00000048 	0x00000048
     86c:	0c030806 	0x0c030806
     870:	0000d709 	0x0000d709
     874:	036a0700 	andi	$r0,$r24,0xa81
     878:	0e030000 	0x0e030000
     87c:	00006b0e 	rdtime.d	$r14,$r24
     880:	65080000 	bge	$r0,$r0,67584(0x10800) # 11080 <_start-0x1bfeef80>
     884:	0300646e 	lu52i.d	$r14,$r3,25(0x19)
     888:	006b0e0f 	bstrins.w	$r15,$r16,0xb,0x3
     88c:	00040000 	alsl.w	$r0,$r0,$r0,0x1
     890:	00033004 	0x00033004
     894:	03100300 	lu52i.d	$r0,$r24,1024(0x400)
     898:	000000b3 	0x000000b3
     89c:	12030806 	addu16i.d	$r6,$r0,-32574(0x80c2)
     8a0:	00010709 	0x00010709
     8a4:	03e30700 	xori	$r0,$r24,0x8c1
     8a8:	14030000 	lu12i.w	$r0,6144(0x1800)
     8ac:	00006b0e 	rdtime.d	$r14,$r24
     8b0:	ed070000 	0xed070000
     8b4:	03000003 	lu52i.d	$r3,$r0,0
     8b8:	006b0e15 	bstrins.w	$r21,$r16,0xb,0x3
     8bc:	00040000 	alsl.w	$r0,$r0,$r0,0x1
     8c0:	00040b04 	alsl.w	$r4,$r24,$r2,0x1
     8c4:	03170300 	lu52i.d	$r0,$r24,1472(0x5c0)
     8c8:	000000e3 	0x000000e3
     8cc:	0003ff09 	0x0003ff09
     8d0:	095a0100 	vfmsub.s	$vr0,$vr8,$vr0,$vr20
     8d4:	00000077 	0x00000077
     8d8:	00000000 	0x00000000
     8dc:	00000038 	0x00000038
     8e0:	014b9c01 	0x014b9c01
     8e4:	0d0a0000 	0x0d0a0000
     8e8:	01000004 	0x01000004
     8ec:	014b215a 	0x014b215a
     8f0:	03de0000 	xori	$r0,$r0,0x780
     8f4:	03d80000 	xori	$r0,$r0,0x600
     8f8:	000b0000 	0x000b0000
     8fc:	8a000000 	0x8a000000
     900:	00000003 	0x00000003
     904:	0107040c 	fdiv.d	$f12,$f0,$f1
     908:	860d0000 	0x860d0000
     90c:	01000003 	0x01000003
     910:	00000653 	0x00000653
     914:	00440000 	0x00440000
     918:	9c010000 	0x9c010000
     91c:	00000199 	0x00000199
     920:	00040d0a 	alsl.w	$r10,$r8,$r3,0x1
     924:	1a530100 	pcalau12i	$r0,169992(0x29808)
     928:	0000014b 	0x0000014b
     92c:	00000410 	0x00000410
     930:	0000040a 	0x0000040a
     934:	0003ed0a 	0x0003ed0a
     938:	2d530100 	0x2d530100
     93c:	0000006b 	0x0000006b
     940:	00000442 	0x00000442
     944:	0000043c 	0x0000043c
     948:	0000000b 	0x0000000b
     94c:	00038a00 	0x00038a00
     950:	f70d0000 	0xf70d0000
     954:	01000003 	0x01000003
     958:	0000064e 	0x0000064e
     95c:	00200000 	div.w	$r0,$r0,$r0
     960:	9c010000 	0x9c010000
     964:	000001d7 	0x000001d7
     968:	0100780e 	0x0100780e
     96c:	006b174e 	bstrins.w	$r14,$r26,0xb,0x5
     970:	04720000 	csrrd	$r0,0x1c80
     974:	046e0000 	csrrd	$r0,0x1b80
     978:	000f0000 	bytepick.d	$r0,$r0,$r0,0x6
     97c:	d7000000 	0xd7000000
     980:	10000001 	addu16i.d	$r1,$r0,0
     984:	f3075401 	0xf3075401
     988:	e80a5401 	0xe80a5401
     98c:	00001e03 	ctz.w	$r3,$r16
     990:	00038e0d 	0x00038e0d
     994:	06490100 	0x06490100
     998:	00000000 	0x00000000
     99c:	00000024 	0x00000024
     9a0:	02159c01 	slti	$r1,$r0,1383(0x567)
     9a4:	780e0000 	0x780e0000
     9a8:	18490100 	pcaddi	$r0,149512(0x24808)
     9ac:	0000006b 	0x0000006b
     9b0:	00000497 	0x00000497
     9b4:	00000493 	0x00000493
     9b8:	0000000f 	0x0000000f
     9bc:	00025100 	0x00025100
     9c0:	54011000 	bl	272(0x110) # ad0 <_start-0x1bfff530>
     9c4:	5401f307 	bl	-65273360(0xc1c01f0) # fc1c0bb4 <_edata+0x7c1bfbb0>
     9c8:	1e7d000a 	pcaddu18i	$r10,256000(0x3e800)
     9cc:	550d0000 	bl	68864(0x10d00) # 116cc <_start-0x1bfee934>
     9d0:	01000000 	0x01000000
     9d4:	17c40644 	lu32i.d	$r4,-122830(0xe2032)
     9d8:	001c1c00 	mul.w	$r0,$r0,$r7
     9dc:	9c010000 	0x9c010000
     9e0:	00000251 	0x00000251
     9e4:	0100780e 	0x0100780e
     9e8:	006b1844 	bstrins.w	$r4,$r2,0xb,0x6
     9ec:	04bc0000 	csrrd	$r0,0x2f00
     9f0:	04b80000 	csrrd	$r0,0x2e00
     9f4:	d40f0000 	0xd40f0000
     9f8:	511c0017 	b	6102016(0x5d1c00) # 5d25f8 <_start-0x1ba2da08>
     9fc:	10000002 	addu16i.d	$r2,$r0,0
     a00:	f3055401 	0xf3055401
     a04:	24355401 	ldptr.w	$r1,$r0,13652(0x3554)
     a08:	c30d0000 	0xc30d0000
     a0c:	01000003 	0x01000003
     a10:	17780635 	lu32i.d	$r21,-278479(0xbc031)
     a14:	004c1c00 	0x004c1c00
     a18:	9c010000 	0x9c010000
     a1c:	000002d9 	0x000002d9
     a20:	6d756e0e 	bgeu	$r16,$r14,95596(0x1756c) # 17f8c <_start-0x1bfe8074>
     a24:	1b350100 	pcalau12i	$r0,-415736(0x9a808)
     a28:	0000006b 	0x0000006b
     a2c:	000004e3 	0x000004e3
     a30:	000004dd 	0x000004dd
     a34:	0003b211 	0x0003b211
     a38:	0e370100 	0x0e370100
     a3c:	0000006b 	0x0000006b
     a40:	00000515 	0x00000515
     a44:	0000050f 	0x0000050f
     a48:	00037012 	0x00037012
     a4c:	11380100 	addu16i.d	$r0,$r8,19968(0x4e00)
     a50:	000000d7 	0x000000d7
     a54:	0b689102 	0x0b689102
     a58:	1c001794 	pcaddu12i	$r20,188(0xbc)
     a5c:	00000378 	0x00000378
     a60:	00179c13 	srl.w	$r19,$r0,$r7
     a64:	0003321c 	0x0003321c
     a68:	0002bb00 	0x0002bb00
     a6c:	54011000 	bl	272(0x110) # b7c <_start-0x1bfff484>
     a70:	00689102 	bstrpick.w	$r2,$r8,0x8,0x4
     a74:	0017ac13 	srl.w	$r19,$r0,$r11
     a78:	0002d91c 	0x0002d91c
     a7c:	0002cf00 	0x0002cf00
     a80:	54011000 	bl	272(0x110) # b90 <_start-0x1bfff470>
     a84:	00689102 	bstrpick.w	$r2,$r8,0x8,0x4
     a88:	0017b40b 	srl.w	$r11,$r0,$r13
     a8c:	0003661c 	0x0003661c
     a90:	b8090000 	0xb8090000
     a94:	01000003 	0x01000003
     a98:	006b0a26 	bstrins.w	$r6,$r17,0xb,0x2
     a9c:	17380000 	lu32i.d	$r0,-409600(0x9c000)
     aa0:	00401c00 	0x00401c00
     aa4:	9c010000 	0x9c010000
     aa8:	0000032c 	0x0000032c
     aac:	0003700a 	0x0003700a
     ab0:	22260100 	ll.d	$r0,$r8,9728(0x2600)
     ab4:	0000032c 	0x0000032c
     ab8:	00000547 	0x00000547
     abc:	0000053f 	0x0000053f
     ac0:	00176c14 	sll.w	$r20,$r0,$r27
     ac4:	00000c1c 	0x00000c1c
     ac8:	00032200 	0x00032200
     acc:	6e651500 	bgeu	$r8,$r0,-105196(0x26514) # fffe6fe0 <_edata+0x7ffe5fdc>
     ad0:	30010064 	0x30010064
     ad4:	00006b12 	rdtime.d	$r18,$r24
     ad8:	0b007f00 	0x0b007f00
     adc:	1c00174c 	pcaddu12i	$r12,186(0xba)
     ae0:	0000038a 	0x0000038a
     ae4:	d7040c00 	0xd7040c00
     ae8:	0d000000 	fsel	$f0,$f0,$f0,$fcc0
     aec:	000003d7 	0x000003d7
     af0:	08061e01 	0x08061e01
     af4:	301c0017 	0x301c0017
     af8:	01000000 	0x01000000
     afc:	0003669c 	0x0003669c
     b00:	03700a00 	andi	$r0,$r16,0xc02
     b04:	1e010000 	pcaddu18i	$r0,2048(0x800)
     b08:	00032c1f 	0x00032c1f
     b0c:	00058400 	alsl.w	$r0,$r0,$r1,0x4
     b10:	00057e00 	alsl.w	$r0,$r16,$r31,0x3
     b14:	17240b00 	lu32i.d	$r0,-450472(0x92058)
     b18:	038a1c00 	ori	$r0,$r0,0x287
     b1c:	16000000 	lu32i.d	$r0,0
     b20:	000003ac 	0x000003ac
     b24:	fc061901 	0xfc061901
     b28:	0c1c0016 	0x0c1c0016
     b2c:	01000000 	0x01000000
     b30:	0397169c 	ori	$r28,$r20,0x5c5
     b34:	15010000 	lu12i.w	$r0,-522240(0x80800)
     b38:	0016f006 	andn	$r6,$r0,$r28
     b3c:	00000c1c 	0x00000c1c
     b40:	179c0100 	lu32i.d	$r0,-204792(0xce008)
     b44:	0000037c 	0x0000037c
     b48:	6b0a0d01 	bltu	$r8,$r1,-62964(0x30a0c) # ffff1554 <_edata+0x7fff0550>
     b4c:	e8000000 	0xe8000000
     b50:	081c0016 	fmadd.s	$f22,$f0,$f0,$f24
     b54:	01000000 	0x01000000
     b58:	03a2119c 	ori	$r28,$r12,0x884
     b5c:	10010000 	addu16i.d	$r0,$r0,64(0x40)
     b60:	00006b0e 	rdtime.d	$r14,$r24
     b64:	0005b400 	alsl.w	$r0,$r0,$r13,0x4
     b68:	0005b000 	alsl.w	$r0,$r0,$r12,0x4
     b6c:	ec000000 	0xec000000
     b70:	04000003 	csrrd	$r3,0x0
     b74:	00049d00 	alsl.w	$r0,$r8,$r7,0x2
     b78:	cb010400 	0xcb010400
     b7c:	0c000000 	0x0c000000
     b80:	000004ae 	0x000004ae
     b84:	00000021 	0x00000021
     b88:	00000120 	0x00000120
     b8c:	00000000 	0x00000000
     b90:	00000a41 	0x00000a41
     b94:	9a080102 	0x9a080102
     b98:	02000001 	slti	$r1,$r0,0
     b9c:	019c0601 	0x019c0601
     ba0:	02020000 	slti	$r0,$r0,128(0x80)
     ba4:	0001ec07 	0x0001ec07
     ba8:	05020200 	0x05020200
     bac:	0000004b 	0x0000004b
     bb0:	c6070402 	0xc6070402
     bb4:	03000001 	lu52i.d	$r1,$r0,0
     bb8:	00000041 	0x00000041
     bbc:	69050404 	bltu	$r0,$r4,66820(0x10504) # 110c0 <_start-0x1bfeef40>
     bc0:	0300746e 	lu52i.d	$r14,$r3,29(0x1d)
     bc4:	0000004d 	0x0000004d
     bc8:	bc070802 	0xbc070802
     bcc:	02000001 	slti	$r1,$r0,0
     bd0:	00900508 	bstrins.d	$r8,$r8,0x10,0x1
     bd4:	04020000 	csrrd	$r0,0x80
     bd8:	00008a04 	0x00008a04
     bdc:	06010200 	cacop	0x0,$r16,64(0x40)
     be0:	000001a3 	0x000001a3
     be4:	00006e05 	cpucfg	$r5,$r16
     be8:	01d30600 	0x01d30600
     bec:	3e020000 	0x3e020000
     bf0:	00004116 	revh.2w	$r22,$r8
     bf4:	00bc0700 	bstrins.d	$r0,$r24,0x3c,0x1
     bf8:	62020000 	blt	$r0,$r0,-130560(0x20200) # fffe0df8 <_edata+0x7ffdfdf4>
     bfc:	00007a11 	0x00007a11
     c00:	026c0700 	sltui	$r0,$r24,-1279(0xb01)
     c04:	64020000 	bge	$r0,$r0,512(0x200) # e04 <_start-0x1bfff1fc>
     c08:	00007a11 	0x00007a11
     c0c:	005e0700 	0x005e0700
     c10:	65020000 	bge	$r0,$r0,66048(0x10200) # 10e10 <_start-0x1bfef1f0>
     c14:	00007a11 	0x00007a11
     c18:	00690700 	bstrins.w	$r0,$r24,0x9,0x1
     c1c:	66020000 	bge	$r0,$r0,-130560(0x20200) # fffe0e1c <_edata+0x7ffdfe18>
     c20:	00004d0c 	bitrev.8b	$r12,$r8
     c24:	025d0800 	sltui	$r0,$r0,1858(0x742)
     c28:	12010000 	addu16i.d	$r0,$r0,-32704(0x8040)
     c2c:	0000481e 	bitrev.4b	$r30,$r0
     c30:	84030500 	0x84030500
     c34:	08800000 	0x08800000
     c38:	0000048d 	0x0000048d
     c3c:	481e1301 	0x481e1301
     c40:	05000000 	0x05000000
     c44:	00008003 	0x00008003
     c48:	044b0880 	csrxchg	$r0,$r4,0x12c2
     c4c:	14010000 	lu12i.w	$r0,2048(0x800)
     c50:	0000481e 	bitrev.4b	$r30,$r0
     c54:	7c030500 	0x7c030500
     c58:	09800000 	0x09800000
     c5c:	00000025 	0x00000025
     c60:	000000fc 	0x000000fc
     c64:	0000410a 	revh.2w	$r10,$r8
     c68:	08003f00 	0x08003f00
     c6c:	00000484 	0x00000484
     c70:	ec16a901 	0xec16a901
     c74:	05000000 	0x05000000
     c78:	00003c03 	revb.d	$r3,$r0
     c7c:	04410880 	csrxchg	$r0,$r4,0x1042
     c80:	aa010000 	0xaa010000
     c84:	00005416 	bitrev.d	$r22,$r0
     c88:	38030500 	0x38030500
     c8c:	08800000 	0x08800000
     c90:	00000420 	0x00000420
     c94:	5416ab01 	bl	-66840920(0xc0416a8) # fc04233c <_edata+0x7c041338>
     c98:	05000000 	0x05000000
     c9c:	00003403 	revb.4h	$r3,$r0
     ca0:	04e90880 	csrxchg	$r0,$r4,0x3a42
     ca4:	ae010000 	0xae010000
     ca8:	00005416 	bitrev.d	$r22,$r0
     cac:	30030500 	0x30030500
     cb0:	0b800000 	0x0b800000
     cb4:	0000052c 	0x0000052c
     cb8:	4d05f401 	jirl	$r1,$r0,67060(0x105f4)
     cbc:	00000000 	0x00000000
     cc0:	9c000000 	0x9c000000
     cc4:	01000000 	0x01000000
     cc8:	0001719c 	0x0001719c
     ccc:	00630c00 	bstrins.w	$r0,$r0,0x3,0x3
     cd0:	4d09f601 	jirl	$r1,$r16,68084(0x109f4)
     cd4:	d5000000 	0xd5000000
     cd8:	d3000005 	0xd3000005
     cdc:	00000005 	0x00000005
     ce0:	0004f70b 	alsl.w	$r11,$r24,$r29,0x2
     ce4:	0fde0100 	0x0fde0100
     ce8:	00000025 	0x00000025
     cec:	00000000 	0x00000000
     cf0:	0000004c 	0x0000004c
     cf4:	01d89c01 	0x01d89c01
     cf8:	630c0000 	blt	$r0,$r0,-62464(0x30c00) # ffff18f8 <_edata+0x7fff08f4>
     cfc:	e0010031 	0xe0010031
     d00:	00002513 	clz.d	$r19,$r8
     d04:	0005ec00 	alsl.w	$r0,$r0,$r27,0x4
     d08:	0005e800 	alsl.w	$r0,$r0,$r26,0x4
     d0c:	30630c00 	0x30630c00
     d10:	17e00100 	lu32i.d	$r0,-65528(0xf0008)
     d14:	00000025 	0x00000025
     d18:	0000060e 	0x0000060e
     d1c:	0000060a 	0x0000060a
     d20:	6463620c 	bge	$r16,$r12,25440(0x6360) # 7080 <_start-0x1bff8f80>
     d24:	13e10100 	addu16i.d	$r0,$r8,-1984(0xf840)
     d28:	00000025 	0x00000025
     d2c:	00000630 	0x00000630
     d30:	0000062c 	0x0000062c
     d34:	0000000d 	0x0000000d
     d38:	0001d800 	asrtgt.d	$r0,$r22
     d3c:	00000d00 	0x00000d00
     d40:	01d80000 	0x01d80000
     d44:	0e000000 	0x0e000000
     d48:	0000050a 	0x0000050a
     d4c:	250fd401 	stptr.w	$r1,$r0,4052(0xfd4)
     d50:	00000000 	0x00000000
     d54:	24000000 	ldptr.w	$r0,$r0,0
     d58:	01000000 	0x01000000
     d5c:	04a00f9c 	csrxchg	$r28,$r28,0x2803
     d60:	cb010000 	0xcb010000
     d64:	00000006 	0x00000006
     d68:	00001c00 	ctz.w	$r0,$r0
     d6c:	0b9c0100 	0x0b9c0100
     d70:	00000469 	0x00000469
     d74:	4d05c101 	jirl	$r1,$r8,67008(0x105c0)
     d78:	00000000 	0x00000000
     d7c:	2c000000 	vld	$vr0,$r0,0
     d80:	01000000 	0x01000000
     d84:	00022d9c 	0x00022d9c
     d88:	006e0c00 	bstrins.w	$r0,$r0,0xe,0x3
     d8c:	4d09c301 	jirl	$r1,$r24,68032(0x109c0)
     d90:	50000000 	b	0 # d90 <_start-0x1bfff270>
     d94:	4e000006 	jirl	$r6,$r0,-131072(0x20000)
     d98:	00000006 	0x00000006
     d9c:	00047710 	alsl.w	$r16,$r24,$r29,0x1
     da0:	06b50100 	0x06b50100
     da4:	1c00195c 	pcaddu12i	$r28,202(0xca)
     da8:	0000006c 	0x0000006c
     dac:	02649c01 	sltui	$r1,$r0,-1753(0x927)
     db0:	63110000 	blt	$r0,$r0,-61184(0x31100) # ffff1eb0 <_edata+0x7fff0eac>
     db4:	21b50100 	sc.w	$r0,$r8,-19200(0xb500)
     db8:	00000025 	0x00000025
     dbc:	72125401 	0x72125401
     dc0:	01000005 	0x01000005
     dc4:	004d09b7 	rotri.d	$r23,$r13,0x2
     dc8:	06650000 	0x06650000
     dcc:	06630000 	0x06630000
     dd0:	10000000 	addu16i.d	$r0,$r0,0
     dd4:	00000430 	0x00000430
     dd8:	4806b001 	bceqz	$fcc0,263856(0x406b0) # 41488 <_start-0x1bfbeb78>
     ddc:	141c0019 	lu12i.w	$r25,57344(0xe000)
     de0:	01000000 	0x01000000
     de4:	00028e9c 	0x00028e9c
     de8:	6e6f1300 	bgeu	$r24,$r0,-102640(0x26f10) # fffe7cf8 <_edata+0x7ffe6cf4>
     dec:	1bb00100 	pcalau12i	$r0,-163832(0xd8008)
     df0:	0000004d 	0x0000004d
     df4:	0000067c 	0x0000067c
     df8:	00000678 	0x00000678
     dfc:	05681000 	0x05681000
     e00:	97010000 	0x97010000
     e04:	00000006 	0x00000006
     e08:	00003c00 	revb.d	$r0,$r0
     e0c:	c09c0100 	0xc09c0100
     e10:	13000002 	addu16i.d	$r2,$r0,-16384(0xc000)
     e14:	97010073 	0x97010073
     e18:	0002c01c 	0x0002c01c
     e1c:	0006a100 	alsl.wu	$r0,$r8,$r8,0x2
     e20:	00069d00 	alsl.wu	$r0,$r8,$r7,0x2
     e24:	00000d00 	0x00000d00
     e28:	02c60000 	addi.d	$r0,$r0,384(0x180)
     e2c:	14000000 	lu12i.w	$r0,0
     e30:	00007504 	0x00007504
     e34:	053c1000 	0x053c1000
     e38:	7f010000 	0x7f010000
     e3c:	0018fc06 	sll.d	$r6,$r0,$r31
     e40:	00004c1c 	bitrev.8b	$r28,$r0
     e44:	fd9c0100 	0xfd9c0100
     e48:	11000002 	addu16i.d	$r2,$r0,16384(0x4000)
     e4c:	7f010063 	0x7f010063
     e50:	0000251e 	clz.d	$r30,$r8
     e54:	12540100 	addu16i.d	$r0,$r8,-27392(0x9500)
     e58:	0000042a 	0x0000042a
     e5c:	41128101 	beqz	$r8,332416(0x51280) # 520dc <_start-0x1bfadf24>
     e60:	c5000000 	0xc5000000
     e64:	bf000006 	0xbf000006
     e68:	00000006 	0x00000006
     e6c:	00041610 	alsl.w	$r16,$r16,$r5,0x1
     e70:	06370100 	cacop	0x0,$r8,-576(0xdc0)
     e74:	1c0017f8 	pcaddu12i	$r24,191(0xbf)
     e78:	00000104 	0x00000104
     e7c:	03899c01 	ori	$r1,$r0,0x267
     e80:	97150000 	0x97150000
     e84:	01000004 	0x01000004
     e88:	004d1437 	rotri.d	$r23,$r1,0x5
     e8c:	54010000 	bl	256(0x100) # f8c <_start-0x1bfff074>
     e90:	64646f11 	bge	$r24,$r17,25708(0x646c) # 72fc <_start-0x1bff8d04>
     e94:	22370100 	ll.d	$r0,$r8,14080(0x3700)
     e98:	0000004d 	0x0000004d
     e9c:	730c5501 	vsllwil.wu.hu	$vr1,$vr8,0x5
     ea0:	01006c65 	0x01006c65
     ea4:	00411239 	slli.d	$r25,$r17,0x4
     ea8:	06f10000 	0x06f10000
     eac:	06ef0000 	0x06ef0000
     eb0:	08160000 	fmadd.s	$f0,$f0,$f0,$f12
     eb4:	5a000001 	beq	$r0,$r1,-131072(0x20000) # fffe0eb4 <_edata+0x7ffdfeb0>
     eb8:	17000003 	lu32i.d	$r3,-524288(0x80000)
     ebc:	4f010069 	jirl	$r9,$r3,-65280(0x30100)
     ec0:	0000481f 	bitrev.4b	$r31,$r0
     ec4:	7c910200 	0x7c910200
     ec8:	18841800 	pcaddi	$r0,270528(0x420c0)
     ecc:	00701c00 	bstrins.w	$r0,$r0,0x10,0x7
     ed0:	6b0c0000 	bltu	$r0,$r0,-62464(0x30c00) # ffff1ad0 <_edata+0x7fff0acc>
     ed4:	0d620100 	xvshuf.b	$xr0,$xr8,$xr0,$xr4
     ed8:	0000004d 	0x0000004d
     edc:	00000706 	0x00000706
     ee0:	00000704 	0x00000704
     ee4:	0100670c 	0x0100670c
     ee8:	00411663 	slli.d	$r3,$r19,0x5
     eec:	071f0000 	0x071f0000
     ef0:	07190000 	0x07190000
     ef4:	00000000 	0x00000000
     ef8:	0004d50f 	alsl.w	$r15,$r8,$r21,0x2
     efc:	06230100 	cacop	0x0,$r8,-1856(0x8c0)
     f00:	00000000 	0x00000000
     f04:	00000014 	0x00000014
     f08:	550f9c01 	bl	331676(0x50f9c) # 51ea4 <_start-0x1bfae15c>
     f0c:	01000005 	0x01000005
     f10:	17e0061a 	lu32i.d	$r26,-65488(0xf0030)
     f14:	00181c00 	sra.w	$r0,$r0,$r7
     f18:	9c010000 	0x9c010000
     f1c:	0005460e 	alsl.w	$r14,$r16,$r17,0x3
     f20:	0e180100 	0x0e180100
     f24:	00000041 	0x00000041
     f28:	00000000 	0x00000000
     f2c:	00000010 	0x00000010
     f30:	190e9c01 	pcaddi	$r1,-494368(0x874e0)
     f34:	01000005 	0x01000005
     f38:	00410e17 	slli.d	$r23,$r16,0x3
     f3c:	00000000 	0x00000000
     f40:	00100000 	add.w	$r0,$r0,$r0
     f44:	9c010000 	0x9c010000
     f48:	0004570e 	alsl.w	$r14,$r24,$r21,0x1
     f4c:	0e160100 	0x0e160100
     f50:	00000041 	0x00000041
     f54:	00000000 	0x00000000
     f58:	00000010 	0x00000010
     f5c:	ef009c01 	0xef009c01
     f60:	04000000 	csrrd	$r0,0x0
     f64:	00061f00 	alsl.wu	$r0,$r24,$r7,0x1
     f68:	cb010400 	0xcb010400
     f6c:	0c000000 	0x0c000000
     f70:	00000577 	0x00000577
     f74:	00000021 	0x00000021
     f78:	000001a0 	0x000001a0
     f7c:	00000000 	0x00000000
     f80:	00000e5e 	0x00000e5e
     f84:	9a080102 	0x9a080102
     f88:	02000001 	slti	$r1,$r0,0
     f8c:	019c0601 	0x019c0601
     f90:	02020000 	slti	$r0,$r0,128(0x80)
     f94:	0001ec07 	0x0001ec07
     f98:	05020200 	0x05020200
     f9c:	0000004b 	0x0000004b
     fa0:	c6070402 	0xc6070402
     fa4:	03000001 	lu52i.d	$r1,$r0,0
     fa8:	6e690504 	bgeu	$r8,$r4,-104188(0x26904) # fffe78ac <_edata+0x7ffe68a8>
     fac:	08020074 	0x08020074
     fb0:	0001bc07 	0x0001bc07
     fb4:	05080200 	0x05080200
     fb8:	00000090 	0x00000090
     fbc:	8a040402 	0x8a040402
     fc0:	02000000 	slti	$r0,$r0,0
     fc4:	01a30601 	0x01a30601
     fc8:	d3040000 	0xd3040000
     fcc:	02000001 	slti	$r1,$r0,0
     fd0:	0041163e 	slli.d	$r30,$r17,0x5
     fd4:	bc050000 	0xbc050000
     fd8:	02000000 	slti	$r0,$r0,0
     fdc:	006b1162 	bstrins.w	$r2,$r11,0xb,0x4
     fe0:	6c050000 	bgeu	$r0,$r0,1280(0x500) # 14e0 <_start-0x1bffeb20>
     fe4:	02000002 	slti	$r2,$r0,0
     fe8:	006b1164 	bstrins.w	$r4,$r11,0xb,0x4
     fec:	5e050000 	bne	$r0,$r0,-129792(0x20500) # fffe14ec <_edata+0x7ffe04e8>
     ff0:	02000000 	slti	$r0,$r0,0
     ff4:	006b1165 	bstrins.w	$r5,$r11,0xb,0x4
     ff8:	69050000 	bltu	$r0,$r0,66816(0x10500) # 114f8 <_start-0x1bfeeb08>
     ffc:	02000000 	slti	$r0,$r0,0
    1000:	00480c66 	0x00480c66
    1004:	a0060000 	0xa0060000
    1008:	01000005 	0x01000005
    100c:	0048051c 	0x0048051c
    1010:	19c80000 	pcaddi	$r0,-114688(0xe4000)
    1014:	00201c00 	div.w	$r0,$r0,$r7
    1018:	9c010000 	0x9c010000
    101c:	000000e6 	0x000000e6
    1020:	00686307 	bstrins.w	$r7,$r24,0x8,0x18
    1024:	48121c01 	bceqz	$fcc0,266780(0x4121c) # 42240 <_start-0x1bfbddc0>
    1028:	4c000000 	jirl	$r0,$r0,0
    102c:	48000007 	bceqz	$fcc0,1835008(0x1c0000) # 1c102c <_start-0x1be3efd4>
    1030:	08000007 	0x08000007
    1034:	1c0019d8 	pcaddu12i	$r24,206(0xce)
    1038:	000000e6 	0x000000e6
    103c:	03540109 	andi	$r9,$r8,0x500
    1040:	005401f3 	0x005401f3
    1044:	053c0a00 	0x053c0a00
    1048:	053c0000 	0x053c0000
    104c:	1a030000 	pcalau12i	$r0,6144(0x1800)
    1050:	0c870006 	0x0c870006
    1054:	00040000 	alsl.w	$r0,$r0,$r0,0x1
    1058:	000006c7 	0x000006c7
    105c:	00cb0104 	bstrpick.d	$r4,$r8,0xb,0x0
    1060:	e00c0000 	0xe00c0000
    1064:	21000005 	sc.w	$r5,$r0,0
    1068:	10000000 	addu16i.d	$r0,$r0,0
    106c:	00000002 	0x00000002
    1070:	16000000 	lu32i.d	$r0,0
    1074:	0200000f 	slti	$r15,$r0,0
    1078:	019a0801 	0x019a0801
    107c:	01020000 	0x01020000
    1080:	00019c06 	0x00019c06
    1084:	07020200 	0x07020200
    1088:	000001ec 	0x000001ec
    108c:	4b050202 	0x4b050202
    1090:	03000000 	lu52i.d	$r0,$r0,0
    1094:	00000608 	0x00000608
    1098:	4d161402 	jirl	$r2,$r0,71188(0x11614)
    109c:	02000000 	slti	$r0,$r0,0
    10a0:	01c60704 	0x01c60704
    10a4:	4d040000 	jirl	$r0,$r0,66560(0x10400)
    10a8:	05000000 	0x05000000
    10ac:	6e690504 	bgeu	$r8,$r4,-104188(0x26904) # fffe79b0 <_edata+0x7ffe69ac>
    10b0:	59040074 	beq	$r3,$r20,66560(0x10400) # 114b0 <_start-0x1bfeeb50>
    10b4:	02000000 	slti	$r0,$r0,0
    10b8:	01bc0708 	0x01bc0708
    10bc:	08020000 	0x08020000
    10c0:	00009005 	0x00009005
    10c4:	04040200 	csrxchg	$r0,$r16,0x100
    10c8:	0000008a 	0x0000008a
    10cc:	0005a903 	alsl.w	$r3,$r8,$r10,0x4
    10d0:	16220200 	lu32i.d	$r0,69648(0x11010)
    10d4:	0000004d 	0x0000004d
    10d8:	00007a04 	0x00007a04
    10dc:	06010200 	cacop	0x0,$r16,64(0x40)
    10e0:	000001a3 	0x000001a3
    10e4:	00008b04 	0x00008b04
    10e8:	01d30300 	0x01d30300
    10ec:	3e020000 	0x3e020000
    10f0:	00004d16 	bitrev.8b	$r22,$r8
    10f4:	00bc0600 	bstrins.d	$r0,$r16,0x3c,0x1
    10f8:	62020000 	blt	$r0,$r0,-130560(0x20200) # fffe12f8 <_edata+0x7ffe02f4>
    10fc:	00009711 	0x00009711
    1100:	026c0600 	sltui	$r0,$r16,-1279(0xb01)
    1104:	64020000 	bge	$r0,$r0,512(0x200) # 1304 <_start-0x1bffecfc>
    1108:	00009711 	0x00009711
    110c:	005e0600 	0x005e0600
    1110:	65020000 	bge	$r0,$r0,66048(0x10200) # 11310 <_start-0x1bfeecf0>
    1114:	00009711 	0x00009711
    1118:	00690600 	bstrins.w	$r0,$r16,0x9,0x1
    111c:	66020000 	bge	$r0,$r0,-130560(0x20200) # fffe131c <_edata+0x7ffe0318>
    1120:	0000590c 	ext.w.h	$r12,$r8
    1124:	06bf0300 	0x06bf0300
    1128:	28030000 	ld.b	$r0,$r0,192(0xc0)
    112c:	0000df1b 	0x0000df1b
    1130:	97040700 	0x97040700
    1134:	03000006 	lu52i.d	$r6,$r0,0
    1138:	000006c6 	0x000006c6
    113c:	d3186303 	0xd3186303
    1140:	03000000 	lu52i.d	$r0,$r0,0
    1144:	0000064a 	0x0000064a
    1148:	fd101e01 	0xfd101e01
    114c:	08000000 	0x08000000
    1150:	00010304 	0x00010304
    1154:	011d0900 	0x011d0900
    1158:	8b0a0000 	0x8b0a0000
    115c:	0a000000 	0x0a000000
    1160:	0000011d 	0x0000011d
    1164:	00007a0a 	0x00007a0a
    1168:	007a0a00 	bstrins.w	$r0,$r16,0x1a,0x2
    116c:	0b000000 	0x0b000000
    1170:	06390c04 	cacop	0x4,$r0,-445(0xe43)
    1174:	31010000 	0x31010000
    1178:	00590502 	0x00590502
    117c:	27200000 	stptr.d	$r0,$r0,8192(0x2000)
    1180:	00501c00 	0x00501c00
    1184:	9c010000 	0x9c010000
    1188:	000001b1 	0x000001b1
    118c:	00062e0d 	alsl.wu	$r13,$r16,$r11,0x1
    1190:	02310100 	slti	$r0,$r8,-960(0xc40)
    1194:	0001b118 	0x0001b118
    1198:	00077300 	alsl.wu	$r0,$r24,$r28,0x3
    119c:	00076d00 	alsl.wu	$r0,$r8,$r27,0x3
    11a0:	760f0e00 	0x760f0e00
    11a4:	33010061 	0x33010061
    11a8:	00e50d02 	bstrpick.d	$r2,$r8,0x25,0x3
    11ac:	91020000 	0x91020000
    11b0:	0690104c 	0x0690104c
    11b4:	35010000 	0x35010000
    11b8:	01b70a02 	0x01b70a02
    11bc:	91020000 	0x91020000
    11c0:	65721148 	bge	$r10,$r8,94736(0x17210) # 183d0 <_start-0x1bfe7c30>
    11c4:	36010074 	0x36010074
    11c8:	00600f02 	bstrins.w	$r2,$r24,0x0,0x3
    11cc:	07a10000 	0x07a10000
    11d0:	079f0000 	0x079f0000
    11d4:	64120000 	bge	$r0,$r0,4608(0x1200) # 23d4 <_start-0x1bffdc2c>
    11d8:	c71c0027 	0xc71c0027
    11dc:	13000001 	addu16i.d	$r1,$r0,-16384(0xc000)
    11e0:	03055401 	lu52i.d	$r1,$r0,341(0x155)
    11e4:	1c002700 	pcaddu12i	$r0,312(0x138)
    11e8:	02550113 	sltui	$r19,$r8,1344(0x540)
    11ec:	01134891 	fcopysign.d	$f17,$f4,$f18
    11f0:	ff090256 	0xff090256
    11f4:	03570113 	andi	$r19,$r8,0x5c0
    11f8:	135401f3 	addu16i.d	$r19,$r15,-11008(0xd500)
    11fc:	91025801 	0x91025801
    1200:	08000064 	0x08000064
    1204:	00009204 	0x00009204
    1208:	008b1400 	bstrins.d	$r0,$r0,0xb,0x5
    120c:	01c70000 	0x01c70000
    1210:	4d150000 	jirl	$r0,$r0,70912(0x11500)
    1214:	00000000 	0x00000000
    1218:	06351600 	cacop	0x0,$r16,-699(0xd45)
    121c:	01010000 	fadd.d	$f0,$f0,$f0
    1220:	00590c01 	0x00590c01
    1224:	1f3c0000 	pcaddu18i	$r0,-401408(0x9e000)
    1228:	07c41c00 	0x07c41c00
    122c:	9c010000 	0x9c010000
    1230:	000006bd 	0x000006bd
    1234:	74756f17 	xvmax.wu	$xr23,$xr24,$xr27
    1238:	01010100 	fadd.d	$f0,$f8,$f0
    123c:	0000f124 	0x0000f124
    1240:	0007be00 	alsl.wu	$r0,$r16,$r15,0x4
    1244:	0007b400 	alsl.wu	$r0,$r0,$r13,0x4
    1248:	06900d00 	0x06900d00
    124c:	01010000 	fadd.d	$f0,$f0,$f0
    1250:	06bd2f01 	0x06bd2f01
    1254:	08090000 	0x08090000
    1258:	07fd0000 	0x07fd0000
    125c:	680d0000 	bltu	$r0,$r0,3328(0xd00) # 1f5c <_start-0x1bffe0a4>
    1260:	01000006 	0x01000006
    1264:	86440101 	0x86440101
    1268:	62000000 	blt	$r0,$r0,-131072(0x20000) # fffe1268 <_edata+0x7ffe0264>
    126c:	56000008 	bl	2228224(0x220000) # 22126c <_start-0x1bdded94>
    1270:	0d000008 	fsel	$f8,$f0,$f0,$fcc0
    1274:	0000062e 	0x0000062e
    1278:	58010101 	beq	$r8,$r1,256(0x100) # 1378 <_start-0x1bffec88>
    127c:	000001b1 	0x000001b1
    1280:	000008b3 	0x000008b3
    1284:	000008af 	0x000008af
    1288:	00617617 	bstrins.w	$r23,$r16,0x1,0x1d
    128c:	68010101 	bltu	$r8,$r1,256(0x100) # 138c <_start-0x1bffec74>
    1290:	000000e5 	0x000000e5
    1294:	000008d5 	0x000008d5
    1298:	000008d1 	0x000008d1
    129c:	00066218 	alsl.wu	$r24,$r16,$r24,0x1
    12a0:	01030100 	fsub.d	$f0,$f8,$f0
    12a4:	00004d12 	bitrev.8b	$r18,$r8
    12a8:	00090700 	bytepick.w	$r0,$r24,$r1,0x2
    12ac:	0008f300 	bytepick.w	$r0,$r24,$r28,0x1
    12b0:	06191800 	cacop	0x0,$r0,1606(0x646)
    12b4:	03010000 	lu52i.d	$r0,$r0,64(0x40)
    12b8:	004d1901 	rotri.d	$r1,$r8,0x6
    12bc:	09920000 	vfnmadd.s	$vr0,$vr0,$vr0,$vr4
    12c0:	097e0000 	0x097e0000
    12c4:	d3180000 	0xd3180000
    12c8:	01000006 	0x01000006
    12cc:	4d200103 	jirl	$r3,$r8,73728(0x12000)
    12d0:	29000000 	st.b	$r0,$r0,0
    12d4:	0d00000a 	fsel	$f10,$f0,$f0,$fcc0
    12d8:	1100000a 	addu16i.d	$r10,$r0,16384(0x4000)
    12dc:	0301006e 	lu52i.d	$r14,$r3,64(0x40)
    12e0:	004d2b01 	rotri.d	$r1,$r24,0xa
    12e4:	0add0000 	xvfnmsub.s	$xr0,$xr0,$xr0,$xr26
    12e8:	0acf0000 	0x0acf0000
    12ec:	69110000 	bltu	$r0,$r0,69888(0x11100) # 123ec <_start-0x1bfedc14>
    12f0:	01007864 	0x01007864
    12f4:	7a0c0104 	0x7a0c0104
    12f8:	7d000000 	0x7d000000
    12fc:	3900000b 	0x3900000b
    1300:	1900000b 	pcaddi	$r11,-524288(0x80000)
    1304:	1c0020c0 	pcaddu12i	$r0,262(0x106)
    1308:	00000030 	0x00000030
    130c:	000002cc 	0x000002cc
    1310:	0100770f 	0x0100770f
    1314:	60170133 	blt	$r9,$r19,5888(0x1700) # 2a14 <_start-0x1bffd5ec>
    1318:	01000000 	0x01000000
    131c:	3019006f 	0x3019006f
    1320:	2c1c0021 	vld	$vr1,$r1,1792(0x700)
    1324:	e7000000 	0xe7000000
    1328:	1a000002 	pcalau12i	$r2,0
    132c:	000006ba 	0x000006ba
    1330:	1b014d01 	pcalau12i	$r1,-521624(0x80a68)
    1334:	00000060 	0x00000060
    1338:	21fc1900 	sc.w	$r0,$r8,-1000(0xfc18)
    133c:	02381c00 	slti	$r0,$r0,-505(0xe07)
    1340:	04470000 	csrrd	$r0,0x11c0
    1344:	ce180000 	0xce180000
    1348:	01000006 	0x01000006
    134c:	4d1e0185 	jirl	$r5,$r12,73216(0x11e00)
    1350:	0a000000 	0x0a000000
    1354:	fe00000d 	0xfe00000d
    1358:	1900000c 	pcaddi	$r12,-524288(0x80000)
    135c:	1c002350 	pcaddu12i	$r16,282(0x11a)
    1360:	00000044 	0x00000044
    1364:	0000035c 	0x0000035c
    1368:	0002d510 	0x0002d510
    136c:	01b30100 	0x01b30100
    1370:	0006ca24 	alsl.wu	$r4,$r17,$r18,0x2
    1374:	12590100 	addu16i.d	$r0,$r8,-27072(0x9640)
    1378:	1c002390 	pcaddu12i	$r16,284(0x11c)
    137c:	000006cf 	0x000006cf
    1380:	02540113 	sltui	$r19,$r8,1280(0x500)
    1384:	0113008a 	fcopysign.d	$f10,$f4,$f0
    1388:	00890255 	bstrins.d	$r21,$r18,0x9,0x0
    138c:	02560113 	sltui	$r19,$r8,1408(0x580)
    1390:	01130087 	fcopysign.d	$f7,$f4,$f0
    1394:	00880257 	bstrins.d	$r23,$r18,0x8,0x0
    1398:	025b0113 	sltui	$r19,$r8,1728(0x6c0)
    139c:	0213008d 	slti	$r13,$r4,1216(0x4c0)
    13a0:	8f020073 	0x8f020073
    13a4:	73021300 	0x73021300
    13a8:	008e0204 	bstrins.d	$r4,$r16,0xe,0x0
    13ac:	e01b0000 	0xe01b0000
    13b0:	b1000001 	0xb1000001
    13b4:	18000003 	pcaddi	$r3,0
    13b8:	000002d5 	0x000002d5
    13bc:	2301b801 	sc.d	$r1,$r0,440(0x1b8)
    13c0:	00000060 	0x00000060
    13c4:	00000d57 	0x00000d57
    13c8:	00000d55 	0x00000d55
    13cc:	00233c12 	div.du	$r18,$r0,$r15
    13d0:	0006cf1c 	alsl.wu	$r28,$r24,$r19,0x2
    13d4:	54011300 	bl	-67108592(0xc000110) # fc0014e4 <_edata+0x7c0004e0>
    13d8:	13008a02 	addu16i.d	$r2,$r16,-16350(0xc022)
    13dc:	89025501 	0x89025501
    13e0:	56011300 	bl	-66977520(0xc020110) # fc0214f0 <_edata+0x7c0204ec>
    13e4:	13008702 	addu16i.d	$r2,$r24,-16351(0xc021)
    13e8:	88025701 	0x88025701
    13ec:	5b011300 	beq	$r24,$r0,-65264(0x30110) # ffff14fc <_edata+0x7fff04f8>
    13f0:	13008d02 	addu16i.d	$r2,$r8,-16349(0xc023)
    13f4:	02007302 	slti	$r2,$r24,28(0x1c)
    13f8:	0213008f 	slti	$r15,$r4,1216(0x4c0)
    13fc:	8e020473 	0x8e020473
    1400:	1b000000 	pcalau12i	$r0,-524288(0x80000)
    1404:	000001c8 	0x000001c8
    1408:	0000040b 	0x0000040b
    140c:	0002d518 	0x0002d518
    1410:	01ca0100 	0x01ca0100
    1414:	0000542c 	bitrev.d	$r12,$r1
    1418:	000d6c00 	bytepick.d	$r0,$r0,$r27,0x2
    141c:	000d6a00 	bytepick.d	$r0,$r16,$r26,0x2
    1420:	22bc1200 	ll.d	$r0,$r16,-17392(0xbc10)
    1424:	06cf1c00 	0x06cf1c00
    1428:	01130000 	fcopysign.d	$f0,$f0,$f0
    142c:	008a0254 	bstrins.d	$r20,$r18,0xa,0x0
    1430:	02550113 	sltui	$r19,$r8,1344(0x540)
    1434:	01130089 	fcopysign.d	$f9,$f4,$f0
    1438:	00870256 	bstrins.d	$r22,$r18,0x7,0x0
    143c:	02570113 	sltui	$r19,$r8,1472(0x5c0)
    1440:	01130088 	fcopysign.d	$f8,$f4,$f0
    1444:	13300159 	addu16i.d	$r25,$r10,-13312(0xcc00)
    1448:	8d025b01 	0x8d025b01
    144c:	73021300 	0x73021300
    1450:	008f0200 	bstrins.d	$r0,$r16,0xf,0x0
    1454:	04730213 	csrxchg	$r19,$r16,0x1cc0
    1458:	00008e02 	0x00008e02
    145c:	23fc1200 	sc.d	$r0,$r16,-1008(0xfc10)
    1460:	06cf1c00 	0x06cf1c00
    1464:	01130000 	fcopysign.d	$f0,$f0,$f0
    1468:	008a0254 	bstrins.d	$r20,$r18,0xa,0x0
    146c:	02550113 	sltui	$r19,$r8,1344(0x540)
    1470:	01130089 	fcopysign.d	$f9,$f4,$f0
    1474:	00870256 	bstrins.d	$r22,$r18,0x7,0x0
    1478:	02570113 	sltui	$r19,$r8,1472(0x5c0)
    147c:	01130088 	fcopysign.d	$f8,$f4,$f0
    1480:	13300159 	addu16i.d	$r25,$r10,-13312(0xcc00)
    1484:	8d025b01 	0x8d025b01
    1488:	73021300 	0x73021300
    148c:	008f0200 	bstrins.d	$r0,$r16,0xf,0x0
    1490:	04730213 	csrxchg	$r19,$r16,0x1cc0
    1494:	00008e02 	0x00008e02
    1498:	24341900 	ldptr.w	$r0,$r8,13336(0x3418)
    149c:	00a81c00 	bstrins.d	$r0,$r0,0x28,0x7
    14a0:	04c40000 	csrrd	$r0,0x3100
    14a4:	6c110000 	bgeu	$r0,$r0,4352(0x1100) # 25a4 <_start-0x1bffda5c>
    14a8:	01d70100 	0x01d70100
    14ac:	00004d1e 	bitrev.8b	$r30,$r8
    14b0:	000d9100 	bytepick.d	$r0,$r8,$r4,0x3
    14b4:	000d7f00 	bytepick.d	$r0,$r24,$r31,0x2
    14b8:	24641c00 	ldptr.w	$r0,$r0,25628(0x641c)
    14bc:	04831c00 	csrrd	$r0,0x20c7
    14c0:	01130000 	fcopysign.d	$f0,$f0,$f0
    14c4:	00890255 	bstrins.d	$r21,$r18,0x9,0x0
    14c8:	02560113 	sltui	$r19,$r8,1408(0x580)
    14cc:	01130087 	fcopysign.d	$f7,$f4,$f0
    14d0:	00880257 	bstrins.d	$r23,$r18,0x8,0x0
    14d4:	24941c00 	ldptr.w	$r0,$r0,-27620(0x941c)
    14d8:	04a51c00 	csrrd	$r0,0x2947
    14dc:	01130000 	fcopysign.d	$f0,$f0,$f0
    14e0:	20080254 	ll.w	$r20,$r18,2048(0x800)
    14e4:	02550113 	sltui	$r19,$r8,1344(0x540)
    14e8:	01130089 	fcopysign.d	$f9,$f4,$f0
    14ec:	00870256 	bstrins.d	$r22,$r18,0x7,0x0
    14f0:	02570113 	sltui	$r19,$r8,1472(0x5c0)
    14f4:	1d000088 	pcaddu12i	$r8,-524284(0x80004)
    14f8:	1c0024c8 	pcaddu12i	$r8,294(0x126)
    14fc:	02540113 	sltui	$r19,$r8,1280(0x500)
    1500:	01132008 	fcopysign.d	$f8,$f0,$f8
    1504:	00890255 	bstrins.d	$r21,$r18,0x9,0x0
    1508:	02560113 	sltui	$r19,$r8,1408(0x580)
    150c:	0113008c 	fcopysign.d	$f12,$f4,$f0
    1510:	00880257 	bstrins.d	$r23,$r18,0x8,0x0
    1514:	dc190000 	0xdc190000
    1518:	181c0024 	pcaddi	$r4,57345(0xe001)
    151c:	8b000001 	0x8b000001
    1520:	11000005 	addu16i.d	$r5,$r0,16384(0x4000)
    1524:	f2010070 	0xf2010070
    1528:	01b11d01 	0x01b11d01
    152c:	0e000000 	0x0e000000
    1530:	0dfe0000 	0x0dfe0000
    1534:	6c110000 	bgeu	$r0,$r0,4352(0x1100) # 2634 <_start-0x1bffd9cc>
    1538:	01f30100 	0x01f30100
    153c:	00004d1e 	bitrev.8b	$r30,$r8
    1540:	000e2500 	bytepick.d	$r0,$r8,$r9,0x4
    1544:	000e1300 	bytepick.d	$r0,$r24,$r4,0x4
    1548:	0b8b1e00 	0x0b8b1e00
    154c:	01f80000 	0x01f80000
    1550:	f3010000 	0xf3010000
    1554:	052e2201 	0x052e2201
    1558:	a81f0000 	0xa81f0000
    155c:	9400000b 	0x9400000b
    1560:	9000000e 	0x9000000e
    1564:	2000000e 	ll.w	$r14,$r0,0
    1568:	00000b9c 	0x00000b9c
    156c:	0001f821 	0x0001f821
    1570:	0bb42200 	0x0bb42200
    1574:	0eb60000 	0x0eb60000
    1578:	0eb20000 	0x0eb20000
    157c:	00000000 	0x00000000
    1580:	0025641c 	crc.w.w.w	$r28,$r0,$r25
    1584:	0005501c 	alsl.w	$r28,$r0,$r20,0x3
    1588:	54011300 	bl	-67108592(0xc000110) # fc001698 <_edata+0x7c000694>
    158c:	13200802 	addu16i.d	$r2,$r0,-14334(0xc802)
    1590:	89025501 	0x89025501
    1594:	56011300 	bl	-66977520(0xc020110) # fc0216a4 <_edata+0x7c0206a0>
    1598:	13008702 	addu16i.d	$r2,$r24,-16351(0xc021)
    159c:	88025701 	0x88025701
    15a0:	981c0000 	0x981c0000
    15a4:	6c1c0025 	bgeu	$r1,$r5,7168(0x1c00) # 31a4 <_start-0x1bffce5c>
    15a8:	13000005 	addu16i.d	$r5,$r0,-16384(0xc000)
    15ac:	89025501 	0x89025501
    15b0:	56011300 	bl	-66977520(0xc020110) # fc0216c0 <_edata+0x7c0206bc>
    15b4:	13008702 	addu16i.d	$r2,$r24,-16351(0xc021)
    15b8:	88025701 	0x88025701
    15bc:	e01d0000 	0xe01d0000
    15c0:	131c0025 	addu16i.d	$r5,$r1,-14592(0xc700)
    15c4:	08025401 	0x08025401
    15c8:	55011320 	bl	-58654448(0xc810110) # fc8116d8 <_edata+0x7c8106d4>
    15cc:	13008902 	addu16i.d	$r2,$r8,-16350(0xc022)
    15d0:	87025601 	0x87025601
    15d4:	57011300 	bl	-66911984(0xc030110) # fc0316e4 <_edata+0x7c0306e0>
    15d8:	00008802 	0x00008802
    15dc:	0b6e2300 	0x0b6e2300
    15e0:	1fd40000 	pcaddu18i	$r0,-90112(0xea000)
    15e4:	00021c00 	0x00021c00
    15e8:	1c001fd4 	pcaddu12i	$r20,254(0xfe)
    15ec:	00000008 	0x00000008
    15f0:	0d012d01 	fsel	$f1,$f8,$f11,$fcc2
    15f4:	000005b4 	0x000005b4
    15f8:	000b7f1f 	0x000b7f1f
    15fc:	000ed600 	bytepick.d	$r0,$r16,$r21,0x5
    1600:	000ed400 	bytepick.d	$r0,$r0,$r21,0x5
    1604:	6e230000 	bgeu	$r0,$r0,-122112(0x22300) # fffe3904 <_edata+0x7ffe2900>
    1608:	0000000b 	0x0000000b
    160c:	001c0021 	mul.w	$r1,$r1,$r0
    1610:	00210000 	div.wu	$r0,$r0,$r0
    1614:	0000081c 	0x0000081c
    1618:	01470100 	0x01470100
    161c:	0005dd11 	alsl.w	$r17,$r8,$r23,0x4
    1620:	0b7f1f00 	0x0b7f1f00
    1624:	0eeb0000 	0x0eeb0000
    1628:	0ee90000 	0x0ee90000
    162c:	24000000 	ldptr.w	$r0,$r0,0
    1630:	1c001fb0 	pcaddu12i	$r16,253(0xfd)
    1634:	fc008a02 	0xfc008a02
    1638:	13000005 	addu16i.d	$r5,$r0,-16384(0xc000)
    163c:	89025501 	0x89025501
    1640:	56011300 	bl	-66977520(0xc020110) # fc021750 <_edata+0x7c02074c>
    1644:	13008702 	addu16i.d	$r2,$r24,-16351(0xc021)
    1648:	88025701 	0x88025701
    164c:	b8250000 	0xb8250000
    1650:	031c0020 	lu52i.d	$r0,$r1,1792(0x700)
    1654:	1000000b 	addu16i.d	$r11,$r0,0
    1658:	13000006 	addu16i.d	$r6,$r0,-16384(0xc000)
    165c:	91025401 	0x91025401
    1660:	2825004c 	ld.b	$r12,$r2,-1728(0x940)
    1664:	031c0021 	lu52i.d	$r1,$r1,1792(0x700)
    1668:	2400000b 	ldptr.w	$r11,$r0,0
    166c:	13000006 	addu16i.d	$r6,$r0,-16384(0xc000)
    1670:	91025401 	0x91025401
    1674:	3425004c 	0x3425004c
    1678:	cf1c0026 	0xcf1c0026
    167c:	67000006 	bge	$r0,$r6,-65536(0x30000) # ffff167c <_edata+0x7fff0678>
    1680:	13000006 	addu16i.d	$r6,$r0,-16384(0xc000)
    1684:	8a025401 	0x8a025401
    1688:	55011300 	bl	-67043056(0xc010110) # fc011798 <_edata+0x7c010794>
    168c:	13008902 	addu16i.d	$r2,$r8,-16350(0xc022)
    1690:	87025601 	0x87025601
    1694:	57011300 	bl	-66911984(0xc030110) # fc0317a4 <_edata+0x7c0307a0>
    1698:	13008802 	addu16i.d	$r2,$r0,-16350(0xc022)
    169c:	30015901 	0x30015901
    16a0:	015a0113 	0x015a0113
    16a4:	5b011340 	beq	$r26,$r0,-65264(0x30110) # ffff17b4 <_edata+0x7fff07b0>
    16a8:	13008d02 	addu16i.d	$r2,$r8,-16349(0xc023)
    16ac:	01007302 	0x01007302
    16b0:	73021338 	0x73021338
    16b4:	008e0204 	bstrins.d	$r4,$r16,0xe,0x0
    16b8:	26601c00 	ldptr.d	$r0,$r0,24604(0x601c)
    16bc:	06891c00 	0x06891c00
    16c0:	01130000 	fcopysign.d	$f0,$f0,$f0
    16c4:	25080254 	stptr.w	$r20,$r18,2048(0x800)
    16c8:	02550113 	sltui	$r19,$r8,1344(0x540)
    16cc:	01130089 	fcopysign.d	$f9,$f4,$f0
    16d0:	00870256 	bstrins.d	$r22,$r18,0x7,0x0
    16d4:	02570113 	sltui	$r19,$r8,1472(0x5c0)
    16d8:	1c000088 	pcaddu12i	$r8,4(0x4)
    16dc:	1c002688 	pcaddu12i	$r8,308(0x134)
    16e0:	000006a5 	0x000006a5
    16e4:	02550113 	sltui	$r19,$r8,1344(0x540)
    16e8:	01130089 	fcopysign.d	$f9,$f4,$f0
    16ec:	00870256 	bstrins.d	$r22,$r18,0x7,0x0
    16f0:	02570113 	sltui	$r19,$r8,1472(0x5c0)
    16f4:	1d000088 	pcaddu12i	$r8,-524284(0x80004)
    16f8:	1c0026c0 	pcaddu12i	$r0,310(0x136)
    16fc:	01540113 	0x01540113
    1700:	55011330 	bl	-54460144(0xcc10110) # fcc11810 <_edata+0x7cc1080c>
    1704:	13008902 	addu16i.d	$r2,$r8,-16350(0xc022)
    1708:	88025701 	0x88025701
    170c:	08000000 	0x08000000
    1710:	00008b04 	0x00008b04
    1714:	05040200 	0x05040200
    1718:	00000095 	0x00000095
    171c:	0006c304 	alsl.wu	$r4,$r24,$r16,0x2
    1720:	06572600 	0x06572600
    1724:	be010000 	0xbe010000
    1728:	00007a0f 	0x00007a0f
    172c:	001cfc00 	mulh.w	$r0,$r0,$r31
    1730:	0002401c 	0x0002401c
    1734:	a09c0100 	0xa09c0100
    1738:	27000008 	stptr.d	$r8,$r0,0
    173c:	0074756f 	bstrins.w	$r15,$r11,0x14,0x1d
    1740:	f127be01 	0xf127be01
    1744:	02000000 	slti	$r0,$r0,0
    1748:	fe00000f 	0xfe00000f
    174c:	2800000e 	ld.b	$r14,$r0,0
    1750:	00000690 	0x00000690
    1754:	bd32be01 	0xbd32be01
    1758:	27000006 	stptr.d	$r6,$r0,0
    175c:	2300000f 	sc.d	$r15,$r0,0
    1760:	2700000f 	stptr.d	$r15,$r0,0
    1764:	00786469 	bstrins.w	$r9,$r3,0x18,0x19
    1768:	7a41be01 	0x7a41be01
    176c:	4c000000 	jirl	$r0,$r0,0
    1770:	4800000f 	bceqz	$fcc0,3932160(0x3c0000) # 3c1770 <_start-0x1bc3e890>
    1774:	2800000f 	ld.b	$r15,$r0,0
    1778:	00000668 	0x00000668
    177c:	7a4dbe01 	0x7a4dbe01
    1780:	71000000 	0x71000000
    1784:	6d00000f 	bgeu	$r0,$r15,65536(0x10000) # 11784 <_start-0x1bfee87c>
    1788:	2800000f 	ld.b	$r15,$r0,0
    178c:	000002d5 	0x000002d5
    1790:	a016bf01 	0xa016bf01
    1794:	aa000008 	0xaa000008
    1798:	9200000f 	0x9200000f
    179c:	2800000f 	ld.b	$r15,$r0,0
    17a0:	0000061f 	0x0000061f
    17a4:	a722bf01 	0xa722bf01
    17a8:	3a000008 	0x3a000008
    17ac:	36000010 	0x36000010
    17b0:	28000010 	ld.b	$r16,$r0,0
    17b4:	000006ce 	0x000006ce
    17b8:	a03abf01 	0xa03abf01
    17bc:	61000008 	blt	$r0,$r8,65536(0x10000) # 117bc <_start-0x1bfee844>
    17c0:	5b000010 	beq	$r0,$r16,-65536(0x30000) # ffff17c0 <_edata+0x7fff07bc>
    17c4:	28000010 	ld.b	$r16,$r0,0
    17c8:	000006ba 	0x000006ba
    17cc:	4d15c001 	jirl	$r1,$r0,71104(0x115c0)
    17d0:	93000000 	0x93000000
    17d4:	8d000010 	0x8d000010
    17d8:	28000010 	ld.b	$r16,$r0,0
    17dc:	00000619 	0x00000619
    17e0:	4d28c001 	jirl	$r1,$r0,75968(0x128c0)
    17e4:	c4000000 	0xc4000000
    17e8:	c0000010 	0xc0000010
    17ec:	28000010 	ld.b	$r16,$r0,0
    17f0:	00000662 	0x00000662
    17f4:	4d3cc001 	jirl	$r1,$r0,81088(0x13cc0)
    17f8:	e8000000 	0xe8000000
    17fc:	e4000010 	0xe4000010
    1800:	29000010 	st.b	$r16,$r0,0
    1804:	00667562 	bstrins.w	$r2,$r11,0x6,0x1d
    1808:	ae09c201 	0xae09c201
    180c:	03000008 	lu52i.d	$r8,$r0,0
    1810:	2a7ef091 	ld.hu	$r17,$r4,-68(0xfbc)
    1814:	006e656c 	bstrins.w	$r12,$r11,0xe,0x19
    1818:	7a0cc301 	0x7a0cc301
    181c:	11000000 	addu16i.d	$r0,$r0,16384(0x4000)
    1820:	07000011 	0x07000011
    1824:	1b000011 	pcalau12i	$r17,-524288(0x80000)
    1828:	000001b0 	0x000001b0
    182c:	00000843 	0x00000843
    1830:	0005c42b 	alsl.w	$r11,$r1,$r17,0x4
    1834:	09d00100 	vfnmsub.s	$vr0,$vr8,$vr0,$vr0
    1838:	0000008b 	0x0000008b
    183c:	0000115c 	clo.w	$r28,$r10
    1840:	00001152 	clo.w	$r18,$r10
    1844:	0005cb2b 	alsl.w	$r11,$r25,$r18,0x4
    1848:	15d00100 	lu12i.w	$r0,-98296(0xe8008)
    184c:	0000008b 	0x0000008b
    1850:	000011b2 	clo.w	$r18,$r13
    1854:	0000119c 	clo.w	$r28,$r12
    1858:	0005d22b 	alsl.w	$r11,$r17,$r20,0x4
    185c:	21d00100 	sc.w	$r0,$r8,-12288(0xd000)
    1860:	0000008b 	0x0000008b
    1864:	00001255 	clo.w	$r21,$r18
    1868:	0000123b 	clo.w	$r27,$r17
    186c:	0005d92b 	alsl.w	$r11,$r9,$r22,0x4
    1870:	2dd00100 	0x2dd00100
    1874:	0000008b 	0x0000008b
    1878:	00001305 	clo.w	$r5,$r24
    187c:	000012f5 	clo.w	$r21,$r23
    1880:	00068a2b 	alsl.wu	$r11,$r17,$r2,0x2
    1884:	08e40100 	fnmsub.d	$f0,$f8,$f0,$f8
    1888:	00000059 	0x00000059
    188c:	0000136d 	clo.w	$r13,$r27
    1890:	00001369 	clo.w	$r9,$r27
    1894:	1ee81900 	pcaddu18i	$r0,475336(0x740c8)
    1898:	00241c00 	crc.w.b.w	$r0,$r0,$r7
    189c:	08770000 	0x08770000
    18a0:	702a0000 	0x702a0000
    18a4:	15f40100 	lu12i.w	$r0,-24568(0xfa008)
    18a8:	000001b1 	0x000001b1
    18ac:	00001395 	clo.w	$r21,$r28
    18b0:	0000138d 	clo.w	$r13,$r28
    18b4:	0002b42b 	0x0002b42b
    18b8:	10f50100 	addu16i.d	$r0,$r8,15680(0x3d40)
    18bc:	0000007a 	0x0000007a
    18c0:	000013d4 	clo.w	$r20,$r30
    18c4:	000013d2 	clo.w	$r18,$r30
    18c8:	1f301200 	pcaddu18i	$r0,-425840(0x98090)
    18cc:	08be1c00 	0x08be1c00
    18d0:	01130000 	fcopysign.d	$f0,$f0,$f0
    18d4:	f0910358 	0xf0910358
    18d8:	5b01137e 	beq	$r27,$r30,-65264(0x30110) # ffff19e8 <_edata+0x7fff09e4>
    18dc:	5a01f303 	beq	$r24,$r3,-130576(0x201f0) # fffe1acc <_edata+0x7ffe0ac8>
    18e0:	00730213 	bstrins.w	$r19,$r16,0x13,0x0
    18e4:	5b01f303 	beq	$r24,$r3,-65040(0x301f0) # ffff1ad4 <_edata+0x7fff0ad0>
    18e8:	04730213 	csrxchg	$r19,$r16,0x1cc0
    18ec:	06009103 	cacop	0x3,$r8,36(0x24)
    18f0:	04020000 	csrrd	$r0,0x80
    18f4:	0001c107 	0x0001c107
    18f8:	02010200 	slti	$r0,$r16,64(0x40)
    18fc:	00000680 	0x00000680
    1900:	00005914 	ext.w.h	$r20,$r8
    1904:	0008be00 	bytepick.w	$r0,$r16,$r15,0x1
    1908:	004d1500 	rotri.d	$r0,$r8,0x5
    190c:	001f0000 	mulw.d.w	$r0,$r0,$r0
    1910:	00062826 	alsl.wu	$r6,$r1,$r10,0x1
    1914:	0f750100 	0x0f750100
    1918:	0000007a 	0x0000007a
    191c:	1c001b3c 	pcaddu12i	$r28,217(0xd9)
    1920:	000001c0 	0x000001c0
    1924:	09c69c01 	0x09c69c01
    1928:	6f270000 	bgeu	$r0,$r0,-55552(0x32700) # ffff4028 <_edata+0x7fff3024>
    192c:	01007475 	0x01007475
    1930:	00f12975 	bstrpick.d	$r21,$r11,0x31,0xa
    1934:	13ed0000 	addu16i.d	$r0,$r0,-1216(0xfb40)
    1938:	13e70000 	addu16i.d	$r0,$r0,-1600(0xf9c0)
    193c:	90280000 	0x90280000
    1940:	01000006 	0x01000006
    1944:	06bd3475 	0x06bd3475
    1948:	141f0000 	lu12i.w	$r0,63488(0xf800)
    194c:	14190000 	lu12i.w	$r0,51200(0xc800)
    1950:	69270000 	bltu	$r0,$r0,75520(0x12700) # 14050 <_start-0x1bfebfb0>
    1954:	01007864 	0x01007864
    1958:	007a4375 	bstrins.w	$r21,$r27,0x1a,0x10
    195c:	14510000 	lu12i.w	$r0,165888(0x28800)
    1960:	144b0000 	lu12i.w	$r0,153600(0x25800)
    1964:	68280000 	bltu	$r0,$r0,10240(0x2800) # 4164 <_start-0x1bffbe9c>
    1968:	01000006 	0x01000006
    196c:	007a4f75 	bstrins.w	$r21,$r27,0x1a,0x13
    1970:	14830000 	lu12i.w	$r0,268288(0x41800)
    1974:	147d0000 	lu12i.w	$r0,256000(0x3e800)
    1978:	62270000 	blt	$r0,$r0,-121088(0x22700) # fffe4078 <_edata+0x7ffe3074>
    197c:	01006675 	0x01006675
    1980:	06bd0e76 	0x06bd0e76
    1984:	14b50000 	lu12i.w	$r0,370688(0x5a800)
    1988:	14af0000 	lu12i.w	$r0,358400(0x57800)
    198c:	6c270000 	bgeu	$r0,$r0,9984(0x2700) # 408c <_start-0x1bffbf74>
    1990:	01006e65 	0x01006e65
    1994:	007a1a76 	bstrins.w	$r22,$r19,0x1a,0x6
    1998:	15110000 	lu12i.w	$r0,-489472(0x88800)
    199c:	14e10000 	lu12i.w	$r0,460800(0x70800)
    19a0:	1f280000 	pcaddu18i	$r0,-442368(0x94000)
    19a4:	01000006 	0x01000006
    19a8:	08a72476 	fnmadd.d	$f22,$f3,$f9,$f14
    19ac:	16390000 	lu32i.d	$r0,116736(0x1c800)
    19b0:	16330000 	lu32i.d	$r0,104448(0x19800)
    19b4:	ce280000 	0xce280000
    19b8:	01000006 	0x01000006
    19bc:	004d3b76 	rotri.d	$r22,$r27,0xe
    19c0:	166b0000 	lu32i.d	$r0,219136(0x35800)
    19c4:	16650000 	lu32i.d	$r0,206848(0x32800)
    19c8:	ba280000 	0xba280000
    19cc:	01000006 	0x01000006
    19d0:	004d1577 	rotri.d	$r23,$r11,0x5
    19d4:	169d0000 	lu32i.d	$r0,321536(0x4e800)
    19d8:	16970000 	lu32i.d	$r0,309248(0x4b800)
    19dc:	19280000 	pcaddi	$r0,-442368(0x94000)
    19e0:	01000006 	0x01000006
    19e4:	004d2877 	rotri.d	$r23,$r3,0xa
    19e8:	16ce0000 	lu32i.d	$r0,421888(0x67000)
    19ec:	16c80000 	lu32i.d	$r0,409600(0x64000)
    19f0:	62280000 	blt	$r0,$r0,-120832(0x22800) # fffe41f0 <_edata+0x7ffe31ec>
    19f4:	01000006 	0x01000006
    19f8:	004d3c77 	rotri.d	$r23,$r3,0xf
    19fc:	17020000 	lu32i.d	$r0,-520192(0x81000)
    1a00:	16f80000 	lu32i.d	$r0,507904(0x7c000)
    1a04:	2c120000 	vld	$vr0,$r0,1152(0x480)
    1a08:	c61c001c 	0xc61c001c
    1a0c:	13000009 	addu16i.d	$r9,$r0,-16384(0xc000)
    1a10:	91035b01 	0x91035b01
    1a14:	00000608 	0x00000608
    1a18:	0006a926 	alsl.wu	$r6,$r9,$r10,0x2
    1a1c:	0f530100 	0x0f530100
    1a20:	0000007a 	0x0000007a
    1a24:	1c001a30 	pcaddu12i	$r16,209(0xd1)
    1a28:	0000010c 	0x0000010c
    1a2c:	0b039c01 	0x0b039c01
    1a30:	6f270000 	bgeu	$r0,$r0,-55552(0x32700) # ffff4130 <_edata+0x7fff312c>
    1a34:	01007475 	0x01007475
    1a38:	00f12553 	bstrpick.d	$r19,$r10,0x31,0x9
    1a3c:	17500000 	lu32i.d	$r0,-360448(0xa8000)
    1a40:	17440000 	lu32i.d	$r0,-385024(0xa2000)
    1a44:	90280000 	0x90280000
    1a48:	01000006 	0x01000006
    1a4c:	06bd3053 	0x06bd3053
    1a50:	17a90000 	lu32i.d	$r0,-178176(0xd4800)
    1a54:	179d0000 	lu32i.d	$r0,-202752(0xce800)
    1a58:	69270000 	bltu	$r0,$r0,75520(0x12700) # 14158 <_start-0x1bfebea8>
    1a5c:	01007864 	0x01007864
    1a60:	007a3f53 	bstrins.w	$r19,$r26,0x1a,0xf
    1a64:	18020000 	pcaddi	$r0,4096(0x1000)
    1a68:	17f60000 	lu32i.d	$r0,-20480(0xfb000)
    1a6c:	68280000 	bltu	$r0,$r0,10240(0x2800) # 426c <_start-0x1bffbd94>
    1a70:	01000006 	0x01000006
    1a74:	007a4b53 	bstrins.w	$r19,$r26,0x1a,0x12
    1a78:	18580000 	pcaddi	$r0,180224(0x2c000)
    1a7c:	184c0000 	pcaddi	$r0,155648(0x26000)
    1a80:	62270000 	blt	$r0,$r0,-121088(0x22700) # fffe4180 <_edata+0x7ffe317c>
    1a84:	01006675 	0x01006675
    1a88:	01b11354 	0x01b11354
    1a8c:	18b10000 	pcaddi	$r0,362496(0x58800)
    1a90:	18a50000 	pcaddi	$r0,337920(0x52800)
    1a94:	6c270000 	bgeu	$r0,$r0,9984(0x2700) # 4194 <_start-0x1bffbe6c>
    1a98:	01006e65 	0x01006e65
    1a9c:	007a1f54 	bstrins.w	$r20,$r26,0x1a,0x7
    1aa0:	19060000 	pcaddi	$r0,-512000(0x83000)
    1aa4:	18fe0000 	pcaddi	$r0,520192(0x7f000)
    1aa8:	19280000 	pcaddi	$r0,-442368(0x94000)
    1aac:	01000006 	0x01000006
    1ab0:	004d3154 	rotri.d	$r20,$r10,0xc
    1ab4:	19460000 	pcaddi	$r0,-380928(0xa3000)
    1ab8:	193a0000 	pcaddi	$r0,-405504(0x9d000)
    1abc:	62280000 	blt	$r0,$r0,-120832(0x22800) # fffe42bc <_edata+0x7ffe32b8>
    1ac0:	01000006 	0x01000006
    1ac4:	004d4554 	rotri.d	$r20,$r10,0x11
    1ac8:	199d0000 	pcaddi	$r0,-202752(0xce800)
    1acc:	19930000 	pcaddi	$r0,-223232(0xc9800)
    1ad0:	692a0000 	bltu	$r0,$r0,76288(0x12a00) # 144d0 <_start-0x1bfebb30>
    1ad4:	0c560100 	vfcmp.cueq.s	$vr0,$vr8,$vr0
    1ad8:	0000007a 	0x0000007a
    1adc:	000019e1 	cto.w	$r1,$r15
    1ae0:	000019df 	cto.w	$r31,$r14
    1ae4:	00060f2b 	alsl.wu	$r11,$r25,$r3,0x1
    1ae8:	12570100 	addu16i.d	$r0,$r8,-27200(0x95c0)
    1aec:	00000086 	0x00000086
    1af0:	00001a00 	cto.w	$r0,$r16
    1af4:	000019f4 	cto.w	$r20,$r15
    1af8:	001aa81c 	0x001aa81c
    1afc:	000ac21c 	0x000ac21c
    1b00:	55011300 	bl	-67043056(0xc010110) # fc011c10 <_edata+0x7c010c0c>
    1b04:	13008902 	addu16i.d	$r2,$r8,-16350(0xc022)
    1b08:	8b025601 	0x8b025601
    1b0c:	5701137f 	bl	-33619696(0xdff0110) # fdff1c1c <_edata+0x7dff0c18>
    1b10:	00008a02 	0x00008a02
    1b14:	001acc1c 	0x001acc1c
    1b18:	000ae41c 	0x000ae41c
    1b1c:	54011300 	bl	-67108592(0xc000110) # fc001c2c <_edata+0x7c000c28>
    1b20:	13200802 	addu16i.d	$r2,$r0,-14334(0xc802)
    1b24:	89025501 	0x89025501
    1b28:	56011300 	bl	-66977520(0xc020110) # fc021c38 <_edata+0x7c020c34>
    1b2c:	137f8e02 	addu16i.d	$r2,$r16,-8221(0xdfe3)
    1b30:	8a025701 	0x8a025701
    1b34:	341d0000 	0x341d0000
    1b38:	131c001b 	addu16i.d	$r27,$r0,-14592(0xc700)
    1b3c:	08025401 	0x08025401
    1b40:	55011320 	bl	-58654448(0xc810110) # fc811c50 <_edata+0x7c810c4c>
    1b44:	13008902 	addu16i.d	$r2,$r8,-16350(0xc022)
    1b48:	87025601 	0x87025601
    1b4c:	5701137f 	bl	-33619696(0xdff0110) # fdff1c5c <_edata+0x7dff0c58>
    1b50:	00008a02 	0x00008a02
    1b54:	066f2600 	0x066f2600
    1b58:	48010000 	bceqz	$fcc0,256(0x100) # 1c58 <_start-0x1bffe3a8>
    1b5c:	00004d15 	bitrev.8b	$r21,$r8
    1b60:	0019ec00 	sra.d	$r0,$r0,$r27
    1b64:	0000441c 	revh.d	$r28,$r0
    1b68:	689c0100 	bltu	$r8,$r0,39936(0x9c00) # b768 <_start-0x1bff4898>
    1b6c:	2700000b 	stptr.d	$r11,$r0,0
    1b70:	00727473 	bstrins.w	$r19,$r3,0x12,0x1d
    1b74:	68284801 	bltu	$r0,$r1,10312(0x2848) # 43bc <_start-0x1bffbc44>
    1b78:	5100000b 	b	2949120(0x2d0000) # 2d1b78 <_start-0x1bd2e488>
    1b7c:	4d00001a 	jirl	$r26,$r0,65536(0x10000)
    1b80:	2a00001a 	ld.bu	$r26,$r0,0
    1b84:	4a010069 	bceqz	$fcc3,2490624(0x260100) # 261c84 <_start-0x1bd9e37c>
    1b88:	00004d12 	bitrev.8b	$r18,$r8
    1b8c:	001a7800 	0x001a7800
    1b90:	001a7200 	0x001a7200
    1b94:	0b6e2c00 	0x0b6e2c00
    1b98:	19f80000 	pcaddi	$r0,-16384(0xfc000)
    1b9c:	00001c00 	ctz.w	$r0,$r0
    1ba0:	1c0019f8 	pcaddu12i	$r24,207(0xcf)
    1ba4:	00000008 	0x00000008
    1ba8:	1f0c4b01 	pcaddu18i	$r1,-499112(0x86258)
    1bac:	00000b7f 	0x00000b7f
    1bb0:	00001aa6 	cto.w	$r6,$r21
    1bb4:	00001aa2 	cto.w	$r2,$r21
    1bb8:	04080000 	csrrd	$r0,0x200
    1bbc:	000001b1 	0x000001b1
    1bc0:	0006862d 	alsl.wu	$r13,$r17,$r1,0x2
    1bc4:	14420100 	lu12i.w	$r0,135176(0x21008)
    1bc8:	000008a7 	0x000008a7
    1bcc:	000b8b03 	0x000b8b03
    1bd0:	68632e00 	bltu	$r16,$r0,25388(0x632c) # 7efc <_start-0x1bff8104>
    1bd4:	23420100 	sc.d	$r0,$r8,16896(0x4200)
    1bd8:	0000008b 	0x0000008b
    1bdc:	06752d00 	0x06752d00
    1be0:	39010000 	0x39010000
    1be4:	00004d1c 	bitrev.8b	$r28,$r8
    1be8:	0bbf0300 	0x0bbf0300
    1bec:	732e0000 	0x732e0000
    1bf0:	01007274 	0x01007274
    1bf4:	01b13339 	0x01b13339
    1bf8:	b22f0000 	0xb22f0000
    1bfc:	01000006 	0x01000006
    1c00:	007a3f39 	bstrins.w	$r25,$r25,0x1a,0xf
    1c04:	73300000 	0x73300000
    1c08:	113b0100 	addu16i.d	$r0,$r8,20160(0x4ec0)
    1c0c:	000001b1 	0x000001b1
    1c10:	05ba3100 	0x05ba3100
    1c14:	2e010000 	0x2e010000
    1c18:	00270014 	crcc.w.w.w	$r20,$r0,$r0
    1c1c:	0000201c 	clo.d	$r28,$r0
    1c20:	2f9c0100 	0x2f9c0100
    1c24:	2800000c 	ld.b	$r12,$r0,0
    1c28:	000005b0 	0x000005b0
    1c2c:	8b232e01 	0x8b232e01
    1c30:	ca000000 	0xca000000
    1c34:	c600001a 	0xc600001a
    1c38:	2800001a 	ld.b	$r26,$r0,0
    1c3c:	00000690 	0x00000690
    1c40:	1d342e01 	pcaddu12i	$r1,-417424(0x9a170)
    1c44:	ef000001 	0xef000001
    1c48:	eb00001a 	0xeb00001a
    1c4c:	2700001a 	stptr.d	$r26,$r0,0
    1c50:	00786469 	bstrins.w	$r9,$r3,0x18,0x19
    1c54:	7a432e01 	0x7a432e01
    1c58:	14000000 	lu12i.w	$r0,0
    1c5c:	1000001b 	addu16i.d	$r27,$r0,0
    1c60:	2800001b 	ld.b	$r27,$r0,0
    1c64:	00000668 	0x00000668
    1c68:	7a4f2e01 	0x7a4f2e01
    1c6c:	39000000 	0x39000000
    1c70:	3500001b 	0x3500001b
    1c74:	3200001b 	0x3200001b
    1c78:	1c002714 	pcaddu12i	$r20,312(0x138)
    1c7c:	00000c7e 	0x00000c7e
    1c80:	06403100 	lddir	$r0,$r8,0xc
    1c84:	28010000 	ld.b	$r0,$r0,64(0x40)
    1c88:	0019e814 	sra.d	$r20,$r0,$r26
    1c8c:	0000041c 	0x0000041c
    1c90:	7e9c0100 	0x7e9c0100
    1c94:	3300000c 	0x3300000c
    1c98:	000005b0 	0x000005b0
    1c9c:	8b232801 	0x8b232801
    1ca0:	01000000 	0x01000000
    1ca4:	06903354 	0x06903354
    1ca8:	28010000 	ld.b	$r0,$r0,64(0x40)
    1cac:	00011d34 	0x00011d34
    1cb0:	34550100 	0x34550100
    1cb4:	00786469 	bstrins.w	$r9,$r3,0x18,0x19
    1cb8:	7a432801 	0x7a432801
    1cbc:	01000000 	0x01000000
    1cc0:	06683356 	0x06683356
    1cc4:	28010000 	ld.b	$r0,$r0,64(0x40)
    1cc8:	00007a4f 	0x00007a4f
    1ccc:	00570100 	0x00570100
    1cd0:	0005a035 	alsl.w	$r21,$r1,$r8,0x4
    1cd4:	0005a000 	alsl.w	$r0,$r0,$r8,0x4
    1cd8:	05100400 	0x05100400
    1cdc:	00016800 	asrtle.d	$r0,$r26
    1ce0:	ed000400 	0xed000400
    1ce4:	04000009 	csrrd	$r9,0x0
    1ce8:	0000cb01 	0x0000cb01
    1cec:	06dd0c00 	0x06dd0c00
    1cf0:	00210000 	div.wu	$r0,$r0,$r0
    1cf4:	02580000 	sltui	$r0,$r0,1536(0x600)
    1cf8:	00000000 	0x00000000
    1cfc:	1b080000 	pcalau12i	$r0,-507904(0x84000)
    1d00:	01020000 	0x01020000
    1d04:	00019a08 	0x00019a08
    1d08:	06010200 	cacop	0x0,$r16,64(0x40)
    1d0c:	0000019c 	0x0000019c
    1d10:	ec070202 	0xec070202
    1d14:	02000001 	slti	$r1,$r0,0
    1d18:	004b0502 	0x004b0502
    1d1c:	04020000 	csrrd	$r0,0x80
    1d20:	0001c607 	0x0001c607
    1d24:	05040300 	0x05040300
    1d28:	00746e69 	bstrins.w	$r9,$r19,0x14,0x1b
    1d2c:	bc070802 	0xbc070802
    1d30:	02000001 	slti	$r1,$r0,0
    1d34:	00900508 	bstrins.d	$r8,$r8,0x10,0x1
    1d38:	04020000 	csrrd	$r0,0x80
    1d3c:	00008a04 	0x00008a04
    1d40:	06010200 	cacop	0x0,$r16,64(0x40)
    1d44:	000001a3 	0x000001a3
    1d48:	0001d304 	0x0001d304
    1d4c:	163e0200 	lu32i.d	$r0,126992(0x1f010)
    1d50:	00000041 	0x00000041
    1d54:	0000bc05 	0x0000bc05
    1d58:	11620200 	addu16i.d	$r0,$r16,22656(0x5880)
    1d5c:	0000006b 	0x0000006b
    1d60:	00026c05 	0x00026c05
    1d64:	11640200 	addu16i.d	$r0,$r16,22784(0x5900)
    1d68:	0000006b 	0x0000006b
    1d6c:	00005e05 	ext.w.b	$r5,$r16
    1d70:	11650200 	addu16i.d	$r0,$r16,22848(0x5940)
    1d74:	0000006b 	0x0000006b
    1d78:	00006905 	rdtime.d	$r5,$r8
    1d7c:	0c660200 	vfcmp.cueq.d	$vr0,$vr16,$vr0
    1d80:	00000048 	0x00000048
    1d84:	0006fd06 	alsl.wu	$r6,$r8,$r31,0x2
    1d88:	052c0100 	0x052c0100
    1d8c:	00000048 	0x00000048
    1d90:	1c002770 	pcaddu12i	$r16,315(0x13b)
    1d94:	00000054 	0x00000054
    1d98:	01479c01 	0x01479c01
    1d9c:	88070000 	0x88070000
    1da0:	471c0027 	bnez	$r1,2038784(0x1f1c00) # 1f39a0 <_start-0x1be0c660>
    1da4:	dc000001 	0xdc000001
    1da8:	08000000 	0x08000000
    1dac:	08045401 	0x08045401
    1db0:	082439e1 	fmadd.d	$f1,$f15,$f14,$f8
    1db4:	30015501 	0x30015501
    1db8:	27940700 	stptr.d	$r0,$r24,-27644(0x9404)
    1dbc:	01531c00 	0x01531c00
    1dc0:	00f30000 	bstrpick.d	$r0,$r0,0x33,0x0
    1dc4:	01080000 	0x01080000
    1dc8:	70030554 	vsle.w	$vr20,$vr10,$vr1
    1dcc:	001c002b 	mul.w	$r11,$r1,$r0
    1dd0:	0027a407 	crcc.w.d.w	$r7,$r0,$r9
    1dd4:	0001531c 	0x0001531c
    1dd8:	00010f00 	asrtle.d	$r24,$r3
    1ddc:	54010800 	bl	264(0x108) # 1ee4 <_start-0x1bffe11c>
    1de0:	2ba40305 	fld.d	$f5,$r24,-1792(0x900)
    1de4:	01081c00 	0x01081c00
    1de8:	004b0155 	0x004b0155
    1dec:	0027b007 	crcc.w.d.w	$r7,$r0,$r12
    1df0:	0001531c 	0x0001531c
    1df4:	00012600 	asrtle.d	$r16,$r9
    1df8:	54010800 	bl	264(0x108) # 1f00 <_start-0x1bffe100>
    1dfc:	2bc40305 	fst.d	$f5,$r24,256(0x100)
    1e00:	07001c00 	0x07001c00
    1e04:	1c0027bc 	pcaddu12i	$r28,317(0x13d)
    1e08:	00000153 	0x00000153
    1e0c:	0000013d 	0x0000013d
    1e10:	05540108 	0x05540108
    1e14:	002bf803 	0x002bf803
    1e18:	c009001c 	0xc009001c
    1e1c:	5f1c0027 	bne	$r1,$r7,-58368(0x31c00) # ffff3a1c <_edata+0x7fff2a18>
    1e20:	00000001 	0x00000001
    1e24:	0004160a 	alsl.w	$r10,$r16,$r5,0x1
    1e28:	00041600 	alsl.w	$r0,$r16,$r5,0x1
    1e2c:	06120300 	cacop	0x0,$r24,1152(0x480)
    1e30:	0006390a 	alsl.wu	$r10,$r8,$r14,0x1
    1e34:	00063900 	alsl.wu	$r0,$r8,$r14,0x1
    1e38:	050b0400 	0x050b0400
    1e3c:	00020e0a 	0x00020e0a
    1e40:	00020e00 	0x00020e00
    1e44:	067a0500 	0x067a0500
    1e48:	0002f000 	0x0002f000
    1e4c:	8e000400 	0x8e000400
    1e50:	0400000a 	csrrd	$r10,0x0
    1e54:	0000cb01 	0x0000cb01
    1e58:	079b0c00 	0x079b0c00
    1e5c:	00210000 	div.wu	$r0,$r0,$r0
    1e60:	02680000 	sltui	$r0,$r0,-1536(0xa00)
    1e64:	00000000 	0x00000000
    1e68:	1c120000 	pcaddu12i	$r0,36864(0x9000)
    1e6c:	cd020000 	0xcd020000
    1e70:	02000007 	slti	$r7,$r0,0
    1e74:	00311028 	0x00311028
    1e78:	04030000 	csrrd	$r0,0xc0
    1e7c:	00000037 	0x00000037
    1e80:	08010504 	0x08010504
    1e84:	0000019a 	0x0000019a
    1e88:	9c060105 	0x9c060105
    1e8c:	05000001 	0x05000001
    1e90:	01ec0702 	0x01ec0702
    1e94:	02050000 	slti	$r0,$r0,320(0x140)
    1e98:	00004b05 	bitrev.4b	$r5,$r24
    1e9c:	07040500 	0x07040500
    1ea0:	000001c6 	0x000001c6
    1ea4:	69050406 	bltu	$r0,$r6,66820(0x10504) # 123a8 <_start-0x1bfedc58>
    1ea8:	0500746e 	0x0500746e
    1eac:	01bc0708 	0x01bc0708
    1eb0:	08050000 	0x08050000
    1eb4:	00009005 	0x00009005
    1eb8:	04040500 	csrxchg	$r0,$r8,0x101
    1ebc:	0000008a 	0x0000008a
    1ec0:	a3060105 	0xa3060105
    1ec4:	02000001 	slti	$r1,$r0,0
    1ec8:	000001d3 	0x000001d3
    1ecc:	54163e03 	bl	-133425604(0x80c163c) # f80c3508 <_edata+0x780c2504>
    1ed0:	07000000 	0x07000000
    1ed4:	000000bc 	0x000000bc
    1ed8:	7e116203 	0x7e116203
    1edc:	07000000 	0x07000000
    1ee0:	0000026c 	0x0000026c
    1ee4:	7e116403 	0x7e116403
    1ee8:	07000000 	0x07000000
    1eec:	0000005e 	0x0000005e
    1ef0:	7e116503 	0x7e116503
    1ef4:	07000000 	0x07000000
    1ef8:	00000069 	0x00000069
    1efc:	5b0c6603 	beq	$r16,$r3,-62364(0x30c64) # ffff2b60 <_edata+0x7fff1b5c>
    1f00:	08000000 	0x08000000
    1f04:	00000025 	0x00000025
    1f08:	000000ca 	0x000000ca
    1f0c:	00005409 	bitrev.d	$r9,$r0
    1f10:	0a000f00 	0x0a000f00
    1f14:	00000790 	0x00000790
    1f18:	ba165f01 	0xba165f01
    1f1c:	05000000 	0x05000000
    1f20:	00008803 	0x00008803
    1f24:	07c00b80 	0x07c00b80
    1f28:	86010000 	0x86010000
    1f2c:	00288006 	0x00288006
    1f30:	0000a01c 	0x0000a01c
    1f34:	3b9c0100 	0x3b9c0100
    1f38:	0c000001 	0x0c000001
    1f3c:	0000042a 	0x0000042a
    1f40:	5b098801 	beq	$r0,$r1,-63096(0x30988) # ffff28c8 <_edata+0x7fff18c4>
    1f44:	60000000 	blt	$r0,$r0,0 # 1f44 <_start-0x1bffe0bc>
    1f48:	5a00001b 	beq	$r0,$r27,-131072(0x20000) # fffe1f48 <_edata+0x7ffe0f44>
    1f4c:	0d00001b 	fsel	$f27,$f0,$f0,$fcc0
    1f50:	01006e65 	0x01006e65
    1f54:	00541289 	0x00541289
    1f58:	1b8e0000 	pcalau12i	$r0,-233472(0xc7000)
    1f5c:	1b8a0000 	pcalau12i	$r0,-241664(0xc5000)
    1f60:	940e0000 	0x940e0000
    1f64:	cf1c0028 	0xcf1c0028
    1f68:	0e000002 	0x0e000002
    1f6c:	1c0028dc 	pcaddu12i	$r28,326(0x146)
    1f70:	000002db 	0x000002db
    1f74:	00291c0f 	0x00291c0f
    1f78:	0002e71c 	0x0002e71c
    1f7c:	54011000 	bl	272(0x110) # 208c <_start-0x1bffdf74>
    1f80:	00003001 	revb.2h	$r1,$r0
    1f84:	0007db11 	alsl.wu	$r17,$r24,$r22,0x4
    1f88:	066f0100 	0x066f0100
    1f8c:	1c002848 	pcaddu12i	$r8,322(0x142)
    1f90:	00000038 	0x00000038
    1f94:	01669c01 	0x01669c01
    1f98:	69120000 	bltu	$r0,$r0,70144(0x11200) # 13198 <_start-0x1bfece68>
    1f9c:	01007172 	0x01007172
    1fa0:	0054256f 	0x0054256f
    1fa4:	1bb00000 	pcalau12i	$r0,-163840(0xd8000)
    1fa8:	1bac0000 	pcalau12i	$r0,-172032(0xd6000)
    1fac:	0b000000 	0x0b000000
    1fb0:	0000072c 	0x0000072c
    1fb4:	00066801 	alsl.wu	$r1,$r0,$r26,0x1
    1fb8:	1c000000 	pcaddu12i	$r0,0
    1fbc:	01000000 	0x01000000
    1fc0:	0001919c 	0x0001919c
    1fc4:	72691200 	0x72691200
    1fc8:	68010071 	bltu	$r3,$r17,256(0x100) # 20c8 <_start-0x1bffdf38>
    1fcc:	00005423 	bitrev.d	$r3,$r1
    1fd0:	001bd500 	rotr.d	$r0,$r8,$r21
    1fd4:	001bd100 	rotr.d	$r0,$r8,$r20
    1fd8:	7f0b0000 	0x7f0b0000
    1fdc:	01000001 	0x01000001
    1fe0:	282c0661 	ld.b	$r1,$r19,-1279(0xb01)
    1fe4:	001c1c00 	mul.w	$r0,$r0,$r7
    1fe8:	9c010000 	0x9c010000
    1fec:	000001c9 	0x000001c9
    1ff0:	71726912 	0x71726912
    1ff4:	23610100 	sc.d	$r0,$r8,24832(0x6100)
    1ff8:	00000054 	0x00000054
    1ffc:	00001bfa 	cto.w	$r26,$r31
    2000:	00001bf6 	cto.w	$r22,$r31
    2004:	006e6613 	bstrins.w	$r19,$r16,0xe,0x19
    2008:	25366101 	stptr.w	$r1,$r8,13920(0x3660)
    200c:	01000000 	0x01000000
    2010:	770b0055 	0x770b0055
    2014:	01000002 	0x01000002
    2018:	28000652 	ld.b	$r18,$r18,1(0x1)
    201c:	002c1c00 	alsl.d	$r0,$r0,$r7,0x1
    2020:	9c010000 	0x9c010000
    2024:	00000218 	0x00000218
    2028:	00280c0e 	0x00280c0e
    202c:	0002ab1c 	0x0002ab1c
    2030:	28141400 	ld.b	$r0,$r0,1285(0x505)
    2034:	02181c00 	slti	$r0,$r0,1543(0x607)
    2038:	01fb0000 	0x01fb0000
    203c:	01100000 	0x01100000
    2040:	00300154 	0x00300154
    2044:	00281c14 	0x00281c14
    2048:	0002621c 	0x0002621c
    204c:	00020e00 	0x00020e00
    2050:	54011000 	bl	272(0x110) # 2160 <_start-0x1bffdea0>
    2054:	0e003401 	0x0e003401
    2058:	1c002820 	pcaddu12i	$r0,321(0x141)
    205c:	00000299 	0x00000299
    2060:	075e0b00 	0x075e0b00
    2064:	47010000 	bnez	$r0,196864(0x30100) # 32164 <_start-0x1bfcde9c>
    2068:	0027f006 	crcc.w.d.w	$r6,$r0,$r28
    206c:	0000101c 	clo.w	$r28,$r0
    2070:	3d9c0100 	0x3d9c0100
    2074:	15000002 	lu12i.w	$r2,-524288(0x80000)
    2078:	0000074d 	0x0000074d
    207c:	541d4701 	bl	-66839228(0xc041d44) # fc043dc0 <_edata+0x7c042dbc>
    2080:	01000000 	0x01000000
    2084:	170b0054 	lu32i.d	$r20,-501758(0x85802)
    2088:	01000007 	0x01000007
    208c:	0000063f 	0x0000063f
    2090:	00140000 	nor	$r0,$r0,$r0
    2094:	9c010000 	0x9c010000
    2098:	00000262 	0x00000262
    209c:	0007ed15 	alsl.wu	$r21,$r8,$r27,0x4
    20a0:	283f0100 	ld.b	$r0,$r8,-64(0xfc0)
    20a4:	00000054 	0x00000054
    20a8:	0b005401 	0x0b005401
    20ac:	0000077c 	0x0000077c
    20b0:	dc063401 	0xdc063401
    20b4:	141c0027 	lu12i.w	$r7,57345(0xe001)
    20b8:	01000000 	0x01000000
    20bc:	0002879c 	0x0002879c
    20c0:	07ed1500 	0x07ed1500
    20c4:	34010000 	0x34010000
    20c8:	00005427 	bitrev.d	$r7,$r1
    20cc:	00540100 	0x00540100
    20d0:	00070216 	alsl.wu	$r22,$r16,$r0,0x3
    20d4:	062e0100 	cacop	0x0,$r8,-1152(0xb80)
    20d8:	00000000 	0x00000000
    20dc:	0000000c 	0x0000000c
    20e0:	68169c01 	bltu	$r0,$r1,5788(0x169c) # 377c <_start-0x1bffc884>
    20e4:	01000007 	0x01000007
    20e8:	27d00627 	stptr.d	$r7,$r17,-12284(0xd004)
    20ec:	000c1c00 	bytepick.d	$r0,$r0,$r7,0x0
    20f0:	9c010000 	0x9c010000
    20f4:	00073c16 	alsl.wu	$r22,$r0,$r15,0x3
    20f8:	06210100 	cacop	0x0,$r8,-1984(0x840)
    20fc:	1c0027c4 	pcaddu12i	$r4,318(0x13e)
    2100:	0000000c 	0x0000000c
    2104:	54169c01 	bl	267932(0x4169c) # 437a0 <_start-0x1bfbc860>
    2108:	01000007 	0x01000007
    210c:	0000061b 	0x0000061b
    2110:	000c0000 	bytepick.d	$r0,$r0,$r0,0x0
    2114:	9c010000 	0x9c010000
    2118:	00055517 	alsl.w	$r23,$r8,$r21,0x3
    211c:	00055500 	alsl.w	$r0,$r8,$r21,0x3
    2120:	0f410400 	0x0f410400
    2124:	00047717 	alsl.w	$r23,$r24,$r29,0x1
    2128:	00047700 	alsl.w	$r0,$r24,$r29,0x1
    212c:	0f340400 	0x0f340400
    2130:	00043017 	alsl.w	$r23,$r0,$r12,0x1
    2134:	00043000 	alsl.w	$r0,$r0,$r12,0x1
    2138:	06240400 	cacop	0x0,$r0,-1791(0x901)
	...

Disassembly of section .debug_abbrev:

00000000 <.debug_abbrev>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
   0:	10001101 	addu16i.d	$r1,$r8,4(0x4)
   4:	12011106 	addu16i.d	$r6,$r8,-32700(0x8044)
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   8:	1b0e0301 	pcalau12i	$r1,-495592(0x87018)
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   c:	130e250e 	addu16i.d	$r14,$r8,-15479(0xc389)
  10:	00000005 	0x00000005
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
  14:	25011101 	stptr.w	$r1,$r8,272(0x110)
D:/LA132_SoC_SW_EXP/user/interrupt.c:109
  18:	030b130e 	lu52i.d	$r14,$r24,708(0x2c4)
delay_s():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:86
  1c:	550e1b0e 	bl	-63369704(0xc390e18) # fc390e34 <_edata+0x7c38fe30>
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  20:	10011117 	addu16i.d	$r23,$r8,68(0x44)
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  24:	02000017 	slti	$r23,$r0,0
  28:	0b0b0024 	0x0b0b0024
  2c:	0e030b3e 	0x0e030b3e
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  30:	35030000 	0x35030000
  34:	00134900 	maskeqz	$r0,$r8,$r18
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  38:	00240400 	crc.w.b.w	$r0,$r0,$r1
  3c:	0b3e0b0b 	0x0b3e0b0b
  40:	00000803 	0x00000803
uart_read_bcd_char():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  44:	49002605 	0x49002605
  48:	06000013 	cacop	0x13,$r0,0
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  4c:	0e030016 	0x0e030016
  50:	0b3b0b3a 	0x0b3b0b3a
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
  54:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
  58:	34070000 	0x34070000
  5c:	3a0e0300 	0x3a0e0300
  60:	390b3b0b 	0x390b3b0b
  64:	3f13490b 	0x3f13490b
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
  68:	00193c19 	srl.d	$r25,$r0,$r15
  6c:	01010800 	fadd.d	$f0,$f0,$f2
  70:	13011349 	addu16i.d	$r9,$r26,-16316(0xc044)
  74:	21090000 	sc.w	$r0,$r0,2304(0x900)
  78:	2f134900 	0x2f134900
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
  7c:	0a00000b 	0x0a00000b
  80:	0e030034 	0x0e030034
  84:	0b3b0b3a 	0x0b3b0b3a
  88:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:254
  8c:	00001802 	cto.w	$r2,$r0
  90:	0300340b 	lu52i.d	$r11,$r0,13(0xd)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:259
  94:	3b0b3a08 	0x3b0b3a08
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:260
  98:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d0bd0 <_start-0x1bd2f430>
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 3)
  9c:	00180213 	sra.w	$r19,$r16,$r0
  a0:	012e0c00 	0x012e0c00
  a4:	0e03193f 	0x0e03193f
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  a8:	0b3b0b3a 	0x0b3b0b3a
  ac:	19270b39 	pcaddi	$r25,-444327(0x93859)
  b0:	06120111 	cacop	0x11,$r8,1152(0x480)
  b4:	42971840 	beqz	$r2,169752(0x29718) # 297cc <_start-0x1bfd6834>
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  b8:	00130119 	maskeqz	$r25,$r8,$r0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
  bc:	00340d00 	0x00340d00
  c0:	0b3a0e03 	0x0b3a0e03
  c4:	0b390b3b 	0x0b390b3b
  c8:	17021349 	lu32i.d	$r9,-520038(0x8109a)
  cc:	001742b7 	sll.w	$r23,$r21,$r16
  d0:	00340e00 	0x00340e00
  d4:	0b3a0803 	0x0b3a0803
  d8:	0b390b3b 	0x0b390b3b
  dc:	17021349 	lu32i.d	$r9,-520038(0x8109a)
  e0:	001742b7 	sll.w	$r23,$r21,$r16
  e4:	010b0f00 	fmin.d	$f0,$f24,$f3
  e8:	13011755 	addu16i.d	$r21,$r26,-16315(0xc045)
  ec:	0b100000 	0x0b100000
  f0:	12011101 	addu16i.d	$r1,$r8,-32700(0x8044)
  f4:	00130106 	maskeqz	$r6,$r8,$r0
  f8:	82891100 	0x82891100
  fc:	01110101 	fscaleb.d	$f1,$f8,$f0
 100:	13011331 	addu16i.d	$r17,$r25,-16316(0xc044)
 104:	8a120000 	0x8a120000
 108:	02000182 	slti	$r2,$r12,0
 10c:	18429118 	pcaddi	$r24,136328(0x21488)
 110:	89130000 	0x89130000
 114:	11010182 	addu16i.d	$r2,$r12,16448(0x4040)
 118:	00133101 	maskeqz	$r1,$r8,$r12
 11c:	82891400 	0x82891400
 120:	01110001 	fscaleb.d	$f1,$f0,$f0
 124:	00001331 	clo.w	$r17,$r25
 128:	03012e15 	lu52i.d	$r21,$r16,75(0x4b)
 12c:	3b0b3a0e 	0x3b0b3a0e
 130:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 134:	12011119 	addu16i.d	$r25,$r8,-32700(0x8044)
 138:	97184006 	0x97184006
 13c:	13011942 	addu16i.d	$r2,$r10,-16314(0xc046)
 140:	0a160000 	xvfmadd.s	$xr0,$xr0,$xr0,$xr12
 144:	3a0e0300 	0x3a0e0300
 148:	390b3b0b 	0x390b3b0b
 14c:	0001110b 	0x0001110b
 150:	012e1700 	0x012e1700
 154:	0b3a0e03 	0x0b3a0e03
 158:	0b390b3b 	0x0b390b3b
 15c:	13491927 	addu16i.d	$r7,$r9,-11706(0xd246)
 160:	06120111 	cacop	0x11,$r8,1152(0x480)
 164:	42971840 	beqz	$r2,169752(0x29718) # 2987c <_start-0x1bfd6784>
 168:	00130119 	maskeqz	$r25,$r8,$r0
 16c:	00051800 	alsl.w	$r0,$r0,$r6,0x3
 170:	0b3a0803 	0x0b3a0803
 174:	0b390b3b 	0x0b390b3b
 178:	17021349 	lu32i.d	$r9,-520038(0x8109a)
 17c:	001742b7 	sll.w	$r23,$r21,$r16
 180:	00051900 	alsl.w	$r0,$r8,$r6,0x3
 184:	0b3a0803 	0x0b3a0803
 188:	0b390b3b 	0x0b390b3b
 18c:	18021349 	pcaddi	$r9,4250(0x109a)
 190:	2e1a0000 	0x2e1a0000
 194:	3c193f00 	0x3c193f00
 198:	030e6e19 	lu52i.d	$r25,$r16,923(0x39b)
 19c:	3b0b3a0e 	0x3b0b3a0e
 1a0:	000b390b 	0x000b390b
 1a4:	11010000 	addu16i.d	$r0,$r0,16448(0x4040)
 1a8:	130e2501 	addu16i.d	$r1,$r8,-15479(0xc389)
 1ac:	1b0e030b 	pcalau12i	$r11,-495592(0x87018)
 1b0:	1117550e 	addu16i.d	$r14,$r8,17877(0x45d5)
 1b4:	00171001 	sll.w	$r1,$r0,$r4
 1b8:	00240200 	crc.w.b.w	$r0,$r16,$r0
 1bc:	0b3e0b0b 	0x0b3e0b0b
 1c0:	00000e03 	0x00000e03
 1c4:	49002603 	0x49002603
 1c8:	04000013 	csrrd	$r19,0x0
 1cc:	13490035 	addu16i.d	$r21,$r1,-11712(0xd240)
 1d0:	24050000 	ldptr.w	$r0,$r0,1280(0x500)
 1d4:	3e0b0b00 	0x3e0b0b00
 1d8:	0008030b 	bytepick.w	$r11,$r24,$r0,0x0
 1dc:	00160600 	orn	$r0,$r16,$r1
 1e0:	0b3a0e03 	0x0b3a0e03
 1e4:	0b390b3b 	0x0b390b3b
 1e8:	00001349 	clo.w	$r9,$r26
 1ec:	03003407 	lu52i.d	$r7,$r0,13(0xd)
 1f0:	3b0b3a0e 	0x3b0b3a0e
 1f4:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d0d2c <_start-0x1bd2f2d4>
 1f8:	3c193f13 	0x3c193f13
 1fc:	08000019 	0x08000019
 200:	13490101 	addu16i.d	$r1,$r8,-11712(0xd240)
 204:	00001301 	clo.w	$r1,$r24
 208:	49002109 	bcnez	$fcc0,2424864(0x250020) # 250228 <_start-0x1bdafdd8>
 20c:	000b2f13 	0x000b2f13
 210:	00340a00 	0x00340a00
 214:	0b3a0e03 	0x0b3a0e03
 218:	0b390b3b 	0x0b390b3b
 21c:	18021349 	pcaddi	$r9,4250(0x109a)
 220:	2e0b0000 	0x2e0b0000
 224:	03193f01 	lu52i.d	$r1,$r24,1615(0x64f)
 228:	3b0b3a0e 	0x3b0b3a0e
 22c:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 230:	12011119 	addu16i.d	$r25,$r8,-32700(0x8044)
 234:	97184006 	0x97184006
 238:	13011942 	addu16i.d	$r2,$r10,-16314(0xc046)
 23c:	340c0000 	0x340c0000
 240:	3a080300 	0x3a080300
 244:	390b3b0b 	0x390b3b0b
 248:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 24c:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 250:	340d0000 	0x340d0000
 254:	3a0e0300 	0x3a0e0300
 258:	390b3b0b 	0x390b3b0b
 25c:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 260:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 264:	050e0000 	0x050e0000
 268:	3a080300 	0x3a080300
 26c:	390b3b0b 	0x390b3b0b
 270:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 274:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 278:	0b0f0000 	0x0b0f0000
 27c:	12011101 	addu16i.d	$r1,$r8,-32700(0x8044)
 280:	10000006 	addu16i.d	$r6,$r0,0
 284:	08030005 	0x08030005
 288:	0b3b0b3a 	0x0b3b0b3a
 28c:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 290:	00001802 	cto.w	$r2,$r0
 294:	0b000f11 	0x0b000f11
 298:	0013490b 	maskeqz	$r11,$r8,$r18
 29c:	82891200 	0x82891200
 2a0:	01110001 	fscaleb.d	$f1,$f0,$f0
 2a4:	00001331 	clo.w	$r17,$r25
 2a8:	03012e13 	lu52i.d	$r19,$r16,75(0x4b)
 2ac:	3b0b3a0e 	0x3b0b3a0e
 2b0:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 2b4:	11134919 	addu16i.d	$r25,$r8,17618(0x44d2)
 2b8:	40061201 	beqz	$r16,263696(0x40610) # 408c8 <_start-0x1bfbf738>
 2bc:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 2c0:	00001301 	clo.w	$r1,$r24
 2c4:	3f012e14 	0x3f012e14
 2c8:	3a0e0319 	0x3a0e0319
 2cc:	390b3b0b 	0x390b3b0b
 2d0:	4919270b 	0x4919270b
 2d4:	12011113 	addu16i.d	$r19,$r8,-32700(0x8044)
 2d8:	97184006 	0x97184006
 2dc:	13011942 	addu16i.d	$r2,$r10,-16314(0xc046)
 2e0:	05150000 	0x05150000
 2e4:	3a0e0300 	0x3a0e0300
 2e8:	390b3b0b 	0x390b3b0b
 2ec:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 2f0:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 2f4:	2e160000 	0x2e160000
 2f8:	03193f00 	lu52i.d	$r0,$r24,1615(0x64f)
 2fc:	3b0b3a0e 	0x3b0b3a0e
 300:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 304:	12011119 	addu16i.d	$r25,$r8,-32700(0x8044)
 308:	97184006 	0x97184006
 30c:	00001942 	cto.w	$r2,$r10
 310:	01110100 	fscaleb.d	$f0,$f8,$f0
 314:	0b130e25 	0x0b130e25
 318:	0e1b0e03 	0x0e1b0e03
 31c:	01111755 	fscaleb.d	$f21,$f26,$f5
 320:	00001710 	clz.w	$r16,$r24
 324:	0b002402 	0x0b002402
 328:	030b3e0b 	lu52i.d	$r11,$r16,719(0x2cf)
 32c:	0300000e 	lu52i.d	$r14,$r0,0
 330:	0b0b0024 	0x0b0b0024
 334:	08030b3e 	0x08030b3e
 338:	16040000 	lu32i.d	$r0,8192(0x2000)
 33c:	3a0e0300 	0x3a0e0300
 340:	390b3b0b 	0x390b3b0b
 344:	0013490b 	maskeqz	$r11,$r8,$r18
 348:	00340500 	0x00340500
 34c:	0b3a0e03 	0x0b3a0e03
 350:	0b390b3b 	0x0b390b3b
 354:	193f1349 	pcaddi	$r9,-395110(0x9f89a)
 358:	0000193c 	cto.w	$r28,$r9
 35c:	0b011306 	0x0b011306
 360:	3b0b3a0b 	0x3b0b3a0b
 364:	010b390b 	fmin.d	$f11,$f8,$f14
 368:	07000013 	0x07000013
 36c:	0e03000d 	0x0e03000d
 370:	0b3b0b3a 	0x0b3b0b3a
 374:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 378:	00000b38 	0x00000b38
 37c:	03000d08 	lu52i.d	$r8,$r8,3(0x3)
 380:	3b0b3a08 	0x3b0b3a08
 384:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d0ebc <_start-0x1bd2f144>
 388:	000b3813 	0x000b3813
 38c:	012e0900 	0x012e0900
 390:	0e03193f 	0x0e03193f
 394:	0b3b0b3a 	0x0b3b0b3a
 398:	19270b39 	pcaddi	$r25,-444327(0x93859)
 39c:	01111349 	fscaleb.d	$f9,$f26,$f4
 3a0:	18400612 	pcaddi	$r18,131120(0x20030)
 3a4:	01194297 	0x01194297
 3a8:	0a000013 	0x0a000013
 3ac:	0e030005 	0x0e030005
 3b0:	0b3b0b3a 	0x0b3b0b3a
 3b4:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 3b8:	42b71702 	beqz	$r24,702228(0xab714) # abacc <_start-0x1bf54534>
 3bc:	0b000017 	0x0b000017
 3c0:	00018289 	0x00018289
 3c4:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 3c8:	0f0c0000 	0x0f0c0000
 3cc:	490b0b00 	0x490b0b00
 3d0:	0d000013 	fsel	$f19,$f0,$f0,$fcc0
 3d4:	193f012e 	pcaddi	$r14,-395255(0x9f809)
 3d8:	0b3a0e03 	0x0b3a0e03
 3dc:	0b390b3b 	0x0b390b3b
 3e0:	01111927 	fscaleb.d	$f7,$f9,$f6
 3e4:	18400612 	pcaddi	$r18,131120(0x20030)
 3e8:	01194297 	0x01194297
 3ec:	0e000013 	0x0e000013
 3f0:	08030005 	0x08030005
 3f4:	0b3b0b3a 	0x0b3b0b3a
 3f8:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 3fc:	42b71702 	beqz	$r24,702228(0xab714) # abb10 <_start-0x1bf544f0>
 400:	0f000017 	0x0f000017
 404:	01018289 	0x01018289
 408:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 40c:	8a100000 	0x8a100000
 410:	02000182 	slti	$r2,$r12,0
 414:	18429118 	pcaddi	$r24,136328(0x21488)
 418:	34110000 	0x34110000
 41c:	3a0e0300 	0x3a0e0300
 420:	390b3b0b 	0x390b3b0b
 424:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 428:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 42c:	34120000 	0x34120000
 430:	3a0e0300 	0x3a0e0300
 434:	390b3b0b 	0x390b3b0b
 438:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 43c:	13000018 	addu16i.d	$r24,$r0,-16384(0xc000)
 440:	01018289 	0x01018289
 444:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 448:	00001301 	clo.w	$r1,$r24
 44c:	11010b14 	addu16i.d	$r20,$r24,16450(0x4042)
 450:	01061201 	0x01061201
 454:	15000013 	lu12i.w	$r19,-524288(0x80000)
 458:	08030034 	0x08030034
 45c:	0b3b0b3a 	0x0b3b0b3a
 460:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 464:	00000d1c 	0x00000d1c
 468:	3f002e16 	0x3f002e16
 46c:	3a0e0319 	0x3a0e0319
 470:	390b3b0b 	0x390b3b0b
 474:	1201110b 	addu16i.d	$r11,$r8,-32700(0x8044)
 478:	97184006 	0x97184006
 47c:	00001942 	cto.w	$r2,$r10
 480:	3f012e17 	0x3f012e17
 484:	3a0e0319 	0x3a0e0319
 488:	390b3b0b 	0x390b3b0b
 48c:	4919270b 	0x4919270b
 490:	12011113 	addu16i.d	$r19,$r8,-32700(0x8044)
 494:	97184006 	0x97184006
 498:	00001942 	cto.w	$r2,$r10
 49c:	01110100 	fscaleb.d	$f0,$f8,$f0
 4a0:	0b130e25 	0x0b130e25
 4a4:	0e1b0e03 	0x0e1b0e03
 4a8:	01111755 	fscaleb.d	$f21,$f26,$f5
 4ac:	00001710 	clz.w	$r16,$r24
 4b0:	0b002402 	0x0b002402
 4b4:	030b3e0b 	lu52i.d	$r11,$r16,719(0x2cf)
 4b8:	0300000e 	lu52i.d	$r14,$r0,0
 4bc:	13490035 	addu16i.d	$r21,$r1,-11712(0xd240)
 4c0:	24040000 	ldptr.w	$r0,$r0,1024(0x400)
 4c4:	3e0b0b00 	0x3e0b0b00
 4c8:	0008030b 	bytepick.w	$r11,$r24,$r0,0x0
 4cc:	00260500 	crcc.w.b.w	$r0,$r8,$r1
 4d0:	00001349 	clo.w	$r9,$r26
 4d4:	03001606 	lu52i.d	$r6,$r16,5(0x5)
 4d8:	3b0b3a0e 	0x3b0b3a0e
 4dc:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d1014 <_start-0x1bd2efec>
 4e0:	07000013 	0x07000013
 4e4:	0e030034 	0x0e030034
 4e8:	0b3b0b3a 	0x0b3b0b3a
 4ec:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 4f0:	193c193f 	pcaddi	$r31,-401207(0x9e0c9)
 4f4:	34080000 	0x34080000
 4f8:	3a0e0300 	0x3a0e0300
 4fc:	390b3b0b 	0x390b3b0b
 500:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 504:	09000018 	0x09000018
 508:	13490101 	addu16i.d	$r1,$r8,-11712(0xd240)
 50c:	00001301 	clo.w	$r1,$r24
 510:	4900210a 	bcnez	$fcc0,2687008(0x290020) # 290530 <_start-0x1bd6fad0>
 514:	000b2f13 	0x000b2f13
 518:	012e0b00 	0x012e0b00
 51c:	0e03193f 	0x0e03193f
 520:	0b3b0b3a 	0x0b3b0b3a
 524:	19270b39 	pcaddi	$r25,-444327(0x93859)
 528:	01111349 	fscaleb.d	$f9,$f26,$f4
 52c:	18400612 	pcaddi	$r18,131120(0x20030)
 530:	01194297 	0x01194297
 534:	0c000013 	0x0c000013
 538:	08030034 	0x08030034
 53c:	0b3b0b3a 	0x0b3b0b3a
 540:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 544:	42b71702 	beqz	$r24,702228(0xab714) # abc58 <_start-0x1bf543a8>
 548:	0d000017 	fsel	$f23,$f0,$f0,$fcc0
 54c:	00018289 	0x00018289
 550:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 554:	2e0e0000 	0x2e0e0000
 558:	03193f00 	lu52i.d	$r0,$r24,1615(0x64f)
 55c:	3b0b3a0e 	0x3b0b3a0e
 560:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 564:	11134919 	addu16i.d	$r25,$r8,17618(0x44d2)
 568:	40061201 	beqz	$r16,263696(0x40610) # 40b78 <_start-0x1bfbf488>
 56c:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 570:	2e0f0000 	0x2e0f0000
 574:	03193f00 	lu52i.d	$r0,$r24,1615(0x64f)
 578:	3b0b3a0e 	0x3b0b3a0e
 57c:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 580:	12011119 	addu16i.d	$r25,$r8,-32700(0x8044)
 584:	97184006 	0x97184006
 588:	00001942 	cto.w	$r2,$r10
 58c:	3f012e10 	0x3f012e10
 590:	3a0e0319 	0x3a0e0319
 594:	390b3b0b 	0x390b3b0b
 598:	1119270b 	addu16i.d	$r11,$r24,17993(0x4649)
 59c:	40061201 	beqz	$r16,263696(0x40610) # 40bac <_start-0x1bfbf454>
 5a0:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 5a4:	00001301 	clo.w	$r1,$r24
 5a8:	03000511 	lu52i.d	$r17,$r8,1(0x1)
 5ac:	3b0b3a08 	0x3b0b3a08
 5b0:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d10e8 <_start-0x1bd2ef18>
 5b4:	00180213 	sra.w	$r19,$r16,$r0
 5b8:	00341200 	0x00341200
 5bc:	0b3a0e03 	0x0b3a0e03
 5c0:	0b390b3b 	0x0b390b3b
 5c4:	17021349 	lu32i.d	$r9,-520038(0x8109a)
 5c8:	001742b7 	sll.w	$r23,$r21,$r16
 5cc:	00051300 	alsl.w	$r0,$r24,$r4,0x3
 5d0:	0b3a0803 	0x0b3a0803
 5d4:	0b390b3b 	0x0b390b3b
 5d8:	17021349 	lu32i.d	$r9,-520038(0x8109a)
 5dc:	001742b7 	sll.w	$r23,$r21,$r16
 5e0:	000f1400 	bytepick.d	$r0,$r0,$r5,0x6
 5e4:	13490b0b 	addu16i.d	$r11,$r24,-11710(0xd242)
 5e8:	05150000 	0x05150000
 5ec:	3a0e0300 	0x3a0e0300
 5f0:	390b3b0b 	0x390b3b0b
 5f4:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 5f8:	16000018 	lu32i.d	$r24,0
 5fc:	1755010b 	lu32i.d	$r11,-350200(0xaa808)
 600:	00001301 	clo.w	$r1,$r24
 604:	03003417 	lu52i.d	$r23,$r0,13(0xd)
 608:	3b0b3a08 	0x3b0b3a08
 60c:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d1144 <_start-0x1bd2eebc>
 610:	00180213 	sra.w	$r19,$r16,$r0
 614:	010b1800 	fmin.d	$f0,$f0,$f6
 618:	06120111 	cacop	0x11,$r8,1152(0x480)
 61c:	01000000 	0x01000000
 620:	0e250111 	0x0e250111
 624:	0e030b13 	0x0e030b13
 628:	17550e1b 	lu32i.d	$r27,-350096(0xaa870)
 62c:	17100111 	lu32i.d	$r17,-491512(0x88008)
 630:	24020000 	ldptr.w	$r0,$r0,512(0x200)
 634:	3e0b0b00 	0x3e0b0b00
 638:	000e030b 	bytepick.d	$r11,$r24,$r0,0x4
 63c:	00240300 	crc.w.b.w	$r0,$r24,$r0
 640:	0b3e0b0b 	0x0b3e0b0b
 644:	00000803 	0x00000803
 648:	03001604 	lu52i.d	$r4,$r16,5(0x5)
 64c:	3b0b3a0e 	0x3b0b3a0e
 650:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d1188 <_start-0x1bd2ee78>
 654:	05000013 	0x05000013
 658:	0e030034 	0x0e030034
 65c:	0b3b0b3a 	0x0b3b0b3a
 660:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 664:	193c193f 	pcaddi	$r31,-401207(0x9e0c9)
 668:	2e060000 	0x2e060000
 66c:	03193f01 	lu52i.d	$r1,$r24,1615(0x64f)
 670:	3b0b3a0e 	0x3b0b3a0e
 674:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 678:	11134919 	addu16i.d	$r25,$r8,17618(0x44d2)
 67c:	40061201 	beqz	$r16,263696(0x40610) # 40c8c <_start-0x1bfbf374>
 680:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 684:	00001301 	clo.w	$r1,$r24
 688:	03000507 	lu52i.d	$r7,$r8,1(0x1)
 68c:	3b0b3a08 	0x3b0b3a08
 690:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d11c8 <_start-0x1bd2ee38>
 694:	b7170213 	0xb7170213
 698:	00001742 	clz.w	$r2,$r26
 69c:	01828908 	0x01828908
 6a0:	31011101 	0x31011101
 6a4:	09000013 	0x09000013
 6a8:	0001828a 	0x0001828a
 6ac:	42911802 	beqz	$r0,692504(0xa9118) # a97c4 <_start-0x1bf5683c>
 6b0:	0a000018 	0x0a000018
 6b4:	193f002e 	pcaddi	$r14,-395263(0x9f801)
 6b8:	0e6e193c 	0x0e6e193c
 6bc:	0b3a0e03 	0x0b3a0e03
 6c0:	0b390b3b 	0x0b390b3b
 6c4:	01000000 	0x01000000
 6c8:	0e250111 	0x0e250111
 6cc:	0e030b13 	0x0e030b13
 6d0:	17550e1b 	lu32i.d	$r27,-350096(0xaa870)
 6d4:	17100111 	lu32i.d	$r17,-491512(0x88008)
 6d8:	24020000 	ldptr.w	$r0,$r0,512(0x200)
 6dc:	3e0b0b00 	0x3e0b0b00
 6e0:	000e030b 	bytepick.d	$r11,$r24,$r0,0x4
 6e4:	00160300 	orn	$r0,$r24,$r0
 6e8:	0b3a0e03 	0x0b3a0e03
 6ec:	0b390b3b 	0x0b390b3b
 6f0:	00001349 	clo.w	$r9,$r26
 6f4:	49002604 	0x49002604
 6f8:	05000013 	0x05000013
 6fc:	0b0b0024 	0x0b0b0024
 700:	08030b3e 	0x08030b3e
 704:	34060000 	0x34060000
 708:	3a0e0300 	0x3a0e0300
 70c:	390b3b0b 	0x390b3b0b
 710:	3f13490b 	0x3f13490b
 714:	00193c19 	srl.d	$r25,$r0,$r15
 718:	000f0700 	bytepick.d	$r0,$r24,$r1,0x6
 71c:	0e030b0b 	0x0e030b0b
 720:	0f080000 	0x0f080000
 724:	490b0b00 	0x490b0b00
 728:	09000013 	0x09000013
 72c:	19270115 	pcaddi	$r21,-444408(0x93808)
 730:	00001301 	clo.w	$r1,$r24
 734:	4900050a 	bcnez	$fcc0,2686980(0x290004) # 290738 <_start-0x1bd6f8c8>
 738:	0b000013 	0x0b000013
 73c:	0b0b000f 	0x0b0b000f
 740:	2e0c0000 	0x2e0c0000
 744:	03193f01 	lu52i.d	$r1,$r24,1615(0x64f)
 748:	3b0b3a0e 	0x3b0b3a0e
 74c:	270b3905 	stptr.d	$r5,$r8,2872(0xb38)
 750:	11134919 	addu16i.d	$r25,$r8,17618(0x44d2)
 754:	40061201 	beqz	$r16,263696(0x40610) # 40d64 <_start-0x1bfbf29c>
 758:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 75c:	00001301 	clo.w	$r1,$r24
 760:	0300050d 	lu52i.d	$r13,$r8,1(0x1)
 764:	3b0b3a0e 	0x3b0b3a0e
 768:	490b3905 	bcnez	$fcc0,1379128(0x150b38) # 1512a0 <_start-0x1beaed60>
 76c:	b7170213 	0xb7170213
 770:	00001742 	clz.w	$r2,$r26
 774:	0000180e 	cto.w	$r14,$r0
 778:	00340f00 	0x00340f00
 77c:	0b3a0803 	0x0b3a0803
 780:	0b39053b 	0x0b39053b
 784:	18021349 	pcaddi	$r9,4250(0x109a)
 788:	34100000 	0x34100000
 78c:	3a0e0300 	0x3a0e0300
 790:	39053b0b 	0x39053b0b
 794:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 798:	11000018 	addu16i.d	$r24,$r0,16384(0x4000)
 79c:	08030034 	0x08030034
 7a0:	053b0b3a 	0x053b0b3a
 7a4:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 7a8:	42b71702 	beqz	$r24,702228(0xab714) # abebc <_start-0x1bf54144>
 7ac:	12000017 	addu16i.d	$r23,$r0,-32768(0x8000)
 7b0:	01018289 	0x01018289
 7b4:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 7b8:	8a130000 	0x8a130000
 7bc:	02000182 	slti	$r2,$r12,0
 7c0:	18429118 	pcaddi	$r24,136328(0x21488)
 7c4:	01140000 	0x01140000
 7c8:	01134901 	fcopysign.d	$f1,$f8,$f18
 7cc:	15000013 	lu12i.w	$r19,-524288(0x80000)
 7d0:	13490021 	addu16i.d	$r1,$r1,-11712(0xd240)
 7d4:	00000b2f 	0x00000b2f
 7d8:	03012e16 	lu52i.d	$r22,$r16,75(0x4b)
 7dc:	3b0b3a0e 	0x3b0b3a0e
 7e0:	270b3905 	stptr.d	$r5,$r8,2872(0xb38)
 7e4:	11134919 	addu16i.d	$r25,$r8,17618(0x44d2)
 7e8:	40061201 	beqz	$r16,263696(0x40610) # 40df8 <_start-0x1bfbf208>
 7ec:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 7f0:	00001301 	clo.w	$r1,$r24
 7f4:	03000517 	lu52i.d	$r23,$r8,1(0x1)
 7f8:	3b0b3a08 	0x3b0b3a08
 7fc:	490b3905 	bcnez	$fcc0,1379128(0x150b38) # 151334 <_start-0x1beaeccc>
 800:	b7170213 	0xb7170213
 804:	00001742 	clz.w	$r2,$r26
 808:	03003418 	lu52i.d	$r24,$r0,13(0xd)
 80c:	3b0b3a0e 	0x3b0b3a0e
 810:	490b3905 	bcnez	$fcc0,1379128(0x150b38) # 151348 <_start-0x1beaecb8>
 814:	b7170213 	0xb7170213
 818:	00001742 	clz.w	$r2,$r26
 81c:	11010b19 	addu16i.d	$r25,$r24,16450(0x4042)
 820:	01061201 	0x01061201
 824:	1a000013 	pcalau12i	$r19,0
 828:	0e030034 	0x0e030034
 82c:	053b0b3a 	0x053b0b3a
 830:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 834:	0b1b0000 	0x0b1b0000
 838:	01175501 	0x01175501
 83c:	1c000013 	pcaddu12i	$r19,0
 840:	01018289 	0x01018289
 844:	13010111 	addu16i.d	$r17,$r8,-16320(0xc040)
 848:	891d0000 	0x891d0000
 84c:	11010182 	addu16i.d	$r2,$r12,16448(0x4040)
 850:	1e000001 	pcaddu18i	$r1,0
 854:	1331011d 	addu16i.d	$r29,$r8,-13248(0xcc40)
 858:	0b581755 	0x0b581755
 85c:	0b570559 	0x0b570559
 860:	00001301 	clo.w	$r1,$r24
 864:	3100051f 	0x3100051f
 868:	b7170213 	0xb7170213
 86c:	00001742 	clz.w	$r2,$r26
 870:	31000520 	0x31000520
 874:	21000013 	sc.w	$r19,$r0,0
 878:	1755010b 	lu32i.d	$r11,-350200(0xaa808)
 87c:	34220000 	0x34220000
 880:	02133100 	slti	$r0,$r8,1228(0x4cc)
 884:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 888:	1d230000 	pcaddu12i	$r0,-452608(0x91800)
 88c:	52133101 	b	67506992(0x4061330) # 4061bbc <_start-0x17f9e444>
 890:	0542b801 	0x0542b801
 894:	06120111 	cacop	0x11,$r8,1152(0x480)
 898:	05590b58 	0x05590b58
 89c:	13010b57 	addu16i.d	$r23,$r26,-16318(0xc042)
 8a0:	89240000 	0x89240000
 8a4:	11010182 	addu16i.d	$r2,$r12,16448(0x4040)
 8a8:	18429301 	pcaddi	$r1,136344(0x21498)
 8ac:	00001301 	clo.w	$r1,$r24
 8b0:	01828925 	0x01828925
 8b4:	31011101 	0x31011101
 8b8:	00130113 	maskeqz	$r19,$r8,$r0
 8bc:	012e2600 	0x012e2600
 8c0:	0b3a0e03 	0x0b3a0e03
 8c4:	0b390b3b 	0x0b390b3b
 8c8:	13491927 	addu16i.d	$r7,$r9,-11706(0xd246)
 8cc:	06120111 	cacop	0x11,$r8,1152(0x480)
 8d0:	42971840 	beqz	$r2,169752(0x29718) # 29fe8 <_start-0x1bfd6018>
 8d4:	00130119 	maskeqz	$r25,$r8,$r0
 8d8:	00052700 	alsl.w	$r0,$r24,$r9,0x3
 8dc:	0b3a0803 	0x0b3a0803
 8e0:	0b390b3b 	0x0b390b3b
 8e4:	17021349 	lu32i.d	$r9,-520038(0x8109a)
 8e8:	001742b7 	sll.w	$r23,$r21,$r16
 8ec:	00052800 	alsl.w	$r0,$r0,$r10,0x3
 8f0:	0b3a0e03 	0x0b3a0e03
 8f4:	0b390b3b 	0x0b390b3b
 8f8:	17021349 	lu32i.d	$r9,-520038(0x8109a)
 8fc:	001742b7 	sll.w	$r23,$r21,$r16
 900:	00342900 	0x00342900
 904:	0b3a0803 	0x0b3a0803
 908:	0b390b3b 	0x0b390b3b
 90c:	18021349 	pcaddi	$r9,4250(0x109a)
 910:	342a0000 	0x342a0000
 914:	3a080300 	0x3a080300
 918:	390b3b0b 	0x390b3b0b
 91c:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 920:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 924:	342b0000 	0x342b0000
 928:	3a0e0300 	0x3a0e0300
 92c:	390b3b0b 	0x390b3b0b
 930:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 934:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 938:	1d2c0000 	pcaddu12i	$r0,-434176(0x96000)
 93c:	52133101 	b	67506992(0x4061330) # 4061c6c <_start-0x17f9e394>
 940:	0542b801 	0x0542b801
 944:	06120111 	cacop	0x11,$r8,1152(0x480)
 948:	0b590b58 	0x0b590b58
 94c:	00000b57 	0x00000b57
 950:	03012e2d 	lu52i.d	$r13,$r17,75(0x4b)
 954:	3b0b3a0e 	0x3b0b3a0e
 958:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 95c:	20134919 	ll.w	$r25,$r8,4936(0x1348)
 960:	0013010b 	maskeqz	$r11,$r8,$r0
 964:	00052e00 	alsl.w	$r0,$r16,$r11,0x3
 968:	0b3a0803 	0x0b3a0803
 96c:	0b390b3b 	0x0b390b3b
 970:	00001349 	clo.w	$r9,$r26
 974:	0300052f 	lu52i.d	$r15,$r9,1(0x1)
 978:	3b0b3a0e 	0x3b0b3a0e
 97c:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d14b4 <_start-0x1bd2eb4c>
 980:	30000013 	0x30000013
 984:	08030034 	0x08030034
 988:	0b3b0b3a 	0x0b3b0b3a
 98c:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 990:	2e310000 	0x2e310000
 994:	3a0e0301 	0x3a0e0301
 998:	390b3b0b 	0x390b3b0b
 99c:	1119270b 	addu16i.d	$r11,$r24,17993(0x4649)
 9a0:	40061201 	beqz	$r16,263696(0x40610) # 40fb0 <_start-0x1bfbf050>
 9a4:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 9a8:	00001301 	clo.w	$r1,$r24
 9ac:	01828932 	0x01828932
 9b0:	31011100 	0x31011100
 9b4:	33000013 	0x33000013
 9b8:	0e030005 	0x0e030005
 9bc:	0b3b0b3a 	0x0b3b0b3a
 9c0:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 9c4:	00001802 	cto.w	$r2,$r0
 9c8:	03000534 	lu52i.d	$r20,$r9,1(0x1)
 9cc:	3b0b3a08 	0x3b0b3a08
 9d0:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d1508 <_start-0x1bd2eaf8>
 9d4:	00180213 	sra.w	$r19,$r16,$r0
 9d8:	002e3500 	0x002e3500
 9dc:	193c193f 	pcaddi	$r31,-401207(0x9e0c9)
 9e0:	0e030e6e 	0x0e030e6e
 9e4:	0b3b0b3a 	0x0b3b0b3a
 9e8:	00000b39 	0x00000b39
 9ec:	01110100 	fscaleb.d	$f0,$f8,$f0
 9f0:	0b130e25 	0x0b130e25
 9f4:	0e1b0e03 	0x0e1b0e03
 9f8:	01111755 	fscaleb.d	$f21,$f26,$f5
 9fc:	00001710 	clz.w	$r16,$r24
 a00:	0b002402 	0x0b002402
 a04:	030b3e0b 	lu52i.d	$r11,$r16,719(0x2cf)
 a08:	0300000e 	lu52i.d	$r14,$r0,0
 a0c:	0b0b0024 	0x0b0b0024
 a10:	08030b3e 	0x08030b3e
 a14:	16040000 	lu32i.d	$r0,8192(0x2000)
 a18:	3a0e0300 	0x3a0e0300
 a1c:	390b3b0b 	0x390b3b0b
 a20:	0013490b 	maskeqz	$r11,$r8,$r18
 a24:	00340500 	0x00340500
 a28:	0b3a0e03 	0x0b3a0e03
 a2c:	0b390b3b 	0x0b390b3b
 a30:	193f1349 	pcaddi	$r9,-395110(0x9f89a)
 a34:	0000193c 	cto.w	$r28,$r9
 a38:	3f012e06 	0x3f012e06
 a3c:	3a0e0319 	0x3a0e0319
 a40:	390b3b0b 	0x390b3b0b
 a44:	4919270b 	0x4919270b
 a48:	12011113 	addu16i.d	$r19,$r8,-32700(0x8044)
 a4c:	97184006 	0x97184006
 a50:	13011942 	addu16i.d	$r2,$r10,-16314(0xc046)
 a54:	89070000 	0x89070000
 a58:	11010182 	addu16i.d	$r2,$r12,16448(0x4040)
 a5c:	01133101 	fcopysign.d	$f1,$f8,$f12
 a60:	08000013 	0x08000013
 a64:	0001828a 	0x0001828a
 a68:	42911802 	beqz	$r0,692504(0xa9118) # a9b80 <_start-0x1bf56480>
 a6c:	09000018 	0x09000018
 a70:	00018289 	0x00018289
 a74:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 a78:	2e0a0000 	0x2e0a0000
 a7c:	3c193f00 	0x3c193f00
 a80:	030e6e19 	lu52i.d	$r25,$r16,923(0x39b)
 a84:	3b0b3a0e 	0x3b0b3a0e
 a88:	000b390b 	0x000b390b
 a8c:	11010000 	addu16i.d	$r0,$r0,16448(0x4040)
 a90:	130e2501 	addu16i.d	$r1,$r8,-15479(0xc389)
 a94:	1b0e030b 	pcalau12i	$r11,-495592(0x87018)
 a98:	1117550e 	addu16i.d	$r14,$r8,17877(0x45d5)
 a9c:	00171001 	sll.w	$r1,$r0,$r4
 aa0:	00160200 	orn	$r0,$r16,$r0
 aa4:	0b3a0e03 	0x0b3a0e03
 aa8:	0b390b3b 	0x0b390b3b
 aac:	00001349 	clo.w	$r9,$r26
 ab0:	0b000f03 	0x0b000f03
 ab4:	0013490b 	maskeqz	$r11,$r8,$r18
 ab8:	00150400 	or	$r0,$r0,$r1
 abc:	00001927 	cto.w	$r7,$r9
 ac0:	0b002405 	0x0b002405
 ac4:	030b3e0b 	lu52i.d	$r11,$r16,719(0x2cf)
 ac8:	0600000e 	cacop	0xe,$r0,0
 acc:	0b0b0024 	0x0b0b0024
 ad0:	08030b3e 	0x08030b3e
 ad4:	34070000 	0x34070000
 ad8:	3a0e0300 	0x3a0e0300
 adc:	390b3b0b 	0x390b3b0b
 ae0:	3f13490b 	0x3f13490b
 ae4:	00193c19 	srl.d	$r25,$r0,$r15
 ae8:	01010800 	fadd.d	$f0,$f0,$f2
 aec:	13011349 	addu16i.d	$r9,$r26,-16316(0xc044)
 af0:	21090000 	sc.w	$r0,$r0,2304(0x900)
 af4:	2f134900 	0x2f134900
 af8:	0a00000b 	0x0a00000b
 afc:	0e030034 	0x0e030034
 b00:	0b3b0b3a 	0x0b3b0b3a
 b04:	13490b39 	addu16i.d	$r25,$r25,-11710(0xd242)
 b08:	00001802 	cto.w	$r2,$r0
 b0c:	3f012e0b 	0x3f012e0b
 b10:	3a0e0319 	0x3a0e0319
 b14:	390b3b0b 	0x390b3b0b
 b18:	1119270b 	addu16i.d	$r11,$r24,17993(0x4649)
 b1c:	40061201 	beqz	$r16,263696(0x40610) # 4112c <_start-0x1bfbeed4>
 b20:	19429718 	pcaddi	$r24,-387912(0xa14b8)
 b24:	00001301 	clo.w	$r1,$r24
 b28:	0300340c 	lu52i.d	$r12,$r0,13(0xd)
 b2c:	3b0b3a0e 	0x3b0b3a0e
 b30:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d1668 <_start-0x1bd2e998>
 b34:	b7170213 	0xb7170213
 b38:	00001742 	clz.w	$r2,$r26
 b3c:	0300340d 	lu52i.d	$r13,$r0,13(0xd)
 b40:	3b0b3a08 	0x3b0b3a08
 b44:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d167c <_start-0x1bd2e984>
 b48:	b7170213 	0xb7170213
 b4c:	00001742 	clz.w	$r2,$r26
 b50:	0182890e 	0x0182890e
 b54:	31011100 	0x31011100
 b58:	0f000013 	0x0f000013
 b5c:	01018289 	0x01018289
 b60:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 b64:	8a100000 	0x8a100000
 b68:	02000182 	slti	$r2,$r12,0
 b6c:	18429118 	pcaddi	$r24,136328(0x21488)
 b70:	2e110000 	0x2e110000
 b74:	03193f01 	lu52i.d	$r1,$r24,1615(0x64f)
 b78:	3b0b3a0e 	0x3b0b3a0e
 b7c:	270b390b 	stptr.d	$r11,$r8,2872(0xb38)
 b80:	12011119 	addu16i.d	$r25,$r8,-32700(0x8044)
 b84:	96184006 	0x96184006
 b88:	13011942 	addu16i.d	$r2,$r10,-16314(0xc046)
 b8c:	05120000 	0x05120000
 b90:	3a080300 	0x3a080300
 b94:	390b3b0b 	0x390b3b0b
 b98:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 b9c:	1742b717 	lu32i.d	$r23,-387656(0xa15b8)
 ba0:	05130000 	0x05130000
 ba4:	3a080300 	0x3a080300
 ba8:	390b3b0b 	0x390b3b0b
 bac:	0213490b 	slti	$r11,$r8,1234(0x4d2)
 bb0:	14000018 	lu12i.w	$r24,0
 bb4:	01018289 	0x01018289
 bb8:	13310111 	addu16i.d	$r17,$r8,-13248(0xcc40)
 bbc:	00001301 	clo.w	$r1,$r24
 bc0:	03000515 	lu52i.d	$r21,$r8,1(0x1)
 bc4:	3b0b3a0e 	0x3b0b3a0e
 bc8:	490b390b 	bcnez	$fcc0,2951992(0x2d0b38) # 2d1700 <_start-0x1bd2e900>
 bcc:	00180213 	sra.w	$r19,$r16,$r0
 bd0:	002e1600 	0x002e1600
 bd4:	0e03193f 	0x0e03193f
 bd8:	0b3b0b3a 	0x0b3b0b3a
 bdc:	19270b39 	pcaddi	$r25,-444327(0x93859)
 be0:	06120111 	cacop	0x11,$r8,1152(0x480)
 be4:	42971840 	beqz	$r2,169752(0x29718) # 2a2fc <_start-0x1bfd5d04>
 be8:	17000019 	lu32i.d	$r25,-524288(0x80000)
 bec:	193f002e 	pcaddi	$r14,-395263(0x9f801)
 bf0:	0e6e193c 	0x0e6e193c
 bf4:	0b3a0e03 	0x0b3a0e03
 bf8:	0b390b3b 	0x0b390b3b
 bfc:	Address 0x0000000000000bfc is out of bounds.


Disassembly of section .debug_aranges:

00000000 <.debug_aranges>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
   0:	0000001c 	0x0000001c
   4:	00000002 	0x00000002
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   8:	00040000 	alsl.w	$r0,$r0,$r0,0x1
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   c:	00000000 	0x00000000
  10:	1c000000 	pcaddu12i	$r0,0
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
  14:	0000113c 	clo.w	$r28,$r9
	...
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  20:	0000003c 	0x0000003c
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  24:	00260002 	crcc.w.b.w	$r2,$r0,$r0
  28:	00040000 	alsl.w	$r0,$r0,$r0,0x1
  2c:	00000000 	0x00000000
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  30:	1c00113c 	pcaddu12i	$r28,137(0x89)
  34:	00000054 	0x00000054
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  38:	1c001190 	pcaddu12i	$r16,140(0x8c)
  3c:	00000068 	0x00000068
  40:	1c0011f8 	pcaddu12i	$r24,143(0x8f)
uart_read_bcd_char():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  44:	0000002c 	0x0000002c
  48:	1c001224 	pcaddu12i	$r4,145(0x91)
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  4c:	00000240 	0x00000240
  50:	1c001464 	pcaddu12i	$r4,163(0xa3)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
  54:	00000160 	0x00000160
	...
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
  60:	00000054 	0x00000054
  64:	04a80002 	csrrd	$r2,0x2a00
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
  68:	00040000 	alsl.w	$r0,$r0,$r0,0x1
  6c:	00000000 	0x00000000
  70:	1c0015c4 	pcaddu12i	$r4,174(0xae)
  74:	00000068 	0x00000068
  78:	1c00162c 	pcaddu12i	$r12,177(0xb1)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
  7c:	00000030 	0x00000030
  80:	00000000 	0x00000000
  84:	00000024 	0x00000024
  88:	00000000 	0x00000000
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:254
  8c:	0000002c 	0x0000002c
  90:	1c00165c 	pcaddu12i	$r28,178(0xb2)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:259
  94:	0000008c 	0x0000008c
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:260
  98:	00000000 	0x00000000
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 3)
  9c:	00000074 	0x00000074
  a0:	00000000 	0x00000000
  a4:	000000c0 	0x000000c0
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  a8:	00000000 	0x00000000
  ac:	000000b8 	0x000000b8
	...
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  b8:	0000006c 	0x0000006c
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
  bc:	07b90002 	0x07b90002
  c0:	00040000 	alsl.w	$r0,$r0,$r0,0x1
  c4:	00000000 	0x00000000
  c8:	1c0016e8 	pcaddu12i	$r8,183(0xb7)
  cc:	00000008 	0x00000008
  d0:	1c0016f0 	pcaddu12i	$r16,183(0xb7)
  d4:	0000000c 	0x0000000c
  d8:	1c0016fc 	pcaddu12i	$r28,183(0xb7)
  dc:	0000000c 	0x0000000c
  e0:	1c001708 	pcaddu12i	$r8,184(0xb8)
  e4:	00000030 	0x00000030
  e8:	1c001738 	pcaddu12i	$r24,185(0xb9)
  ec:	00000040 	0x00000040
  f0:	1c001778 	pcaddu12i	$r24,187(0xbb)
  f4:	0000004c 	0x0000004c
  f8:	1c0017c4 	pcaddu12i	$r4,190(0xbe)
  fc:	0000001c 	0x0000001c
 100:	00000000 	0x00000000
 104:	00000024 	0x00000024
 108:	00000000 	0x00000000
 10c:	00000020 	0x00000020
 110:	00000000 	0x00000000
 114:	00000044 	0x00000044
 118:	00000000 	0x00000000
 11c:	00000038 	0x00000038
	...
 128:	0000008c 	0x0000008c
 12c:	0b6f0002 	0x0b6f0002
 130:	00040000 	alsl.w	$r0,$r0,$r0,0x1
	...
 13c:	00000010 	0x00000010
 140:	00000000 	0x00000000
 144:	00000010 	0x00000010
 148:	00000000 	0x00000000
 14c:	00000010 	0x00000010
 150:	1c0017e0 	pcaddu12i	$r0,191(0xbf)
 154:	00000018 	0x00000018
 158:	00000000 	0x00000000
 15c:	00000014 	0x00000014
 160:	1c0017f8 	pcaddu12i	$r24,191(0xbf)
 164:	00000104 	0x00000104
 168:	1c0018fc 	pcaddu12i	$r28,199(0xc7)
 16c:	0000004c 	0x0000004c
 170:	00000000 	0x00000000
 174:	0000003c 	0x0000003c
 178:	1c001948 	pcaddu12i	$r8,202(0xca)
 17c:	00000014 	0x00000014
 180:	1c00195c 	pcaddu12i	$r28,202(0xca)
 184:	0000006c 	0x0000006c
 188:	00000000 	0x00000000
 18c:	0000002c 	0x0000002c
 190:	00000000 	0x00000000
 194:	0000001c 	0x0000001c
 198:	00000000 	0x00000000
 19c:	00000024 	0x00000024
 1a0:	00000000 	0x00000000
 1a4:	0000004c 	0x0000004c
 1a8:	00000000 	0x00000000
 1ac:	0000009c 	0x0000009c
	...
 1b8:	0000001c 	0x0000001c
 1bc:	0f5f0002 	0x0f5f0002
 1c0:	00040000 	alsl.w	$r0,$r0,$r0,0x1
 1c4:	00000000 	0x00000000
 1c8:	1c0019c8 	pcaddu12i	$r8,206(0xce)
 1cc:	00000020 	0x00000020
	...
 1d8:	00000054 	0x00000054
 1dc:	10520002 	addu16i.d	$r2,$r0,5248(0x1480)
 1e0:	00040000 	alsl.w	$r0,$r0,$r0,0x1
 1e4:	00000000 	0x00000000
 1e8:	1c0019e8 	pcaddu12i	$r8,207(0xcf)
 1ec:	00000004 	0x00000004
 1f0:	1c0019ec 	pcaddu12i	$r12,207(0xcf)
 1f4:	00000044 	0x00000044
 1f8:	1c001a30 	pcaddu12i	$r16,209(0xd1)
 1fc:	0000010c 	0x0000010c
 200:	1c001b3c 	pcaddu12i	$r28,217(0xd9)
 204:	000001c0 	0x000001c0
 208:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
 20c:	00000240 	0x00000240
 210:	1c001f3c 	pcaddu12i	$r28,249(0xf9)
 214:	000007c4 	0x000007c4
 218:	1c002700 	pcaddu12i	$r0,312(0x138)
 21c:	00000020 	0x00000020
 220:	1c002720 	pcaddu12i	$r0,313(0x139)
 224:	00000050 	0x00000050
	...
 230:	0000001c 	0x0000001c
 234:	1cdd0002 	pcaddu12i	$r2,452608(0x6e800)
 238:	00040000 	alsl.w	$r0,$r0,$r0,0x1
 23c:	00000000 	0x00000000
 240:	1c002770 	pcaddu12i	$r16,315(0x13b)
 244:	00000054 	0x00000054
	...
 250:	00000074 	0x00000074
 254:	1e490002 	pcaddu18i	$r2,149504(0x24800)
 258:	00040000 	alsl.w	$r0,$r0,$r0,0x1
	...
 264:	0000000c 	0x0000000c
 268:	1c0027c4 	pcaddu12i	$r4,318(0x13e)
 26c:	0000000c 	0x0000000c
 270:	1c0027d0 	pcaddu12i	$r16,318(0x13e)
 274:	0000000c 	0x0000000c
 278:	00000000 	0x00000000
 27c:	0000000c 	0x0000000c
 280:	1c0027dc 	pcaddu12i	$r28,318(0x13e)
 284:	00000014 	0x00000014
 288:	00000000 	0x00000000
 28c:	00000014 	0x00000014
 290:	1c0027f0 	pcaddu12i	$r16,319(0x13f)
 294:	00000010 	0x00000010
 298:	1c002800 	pcaddu12i	$r0,320(0x140)
 29c:	0000002c 	0x0000002c
 2a0:	1c00282c 	pcaddu12i	$r12,321(0x141)
 2a4:	0000001c 	0x0000001c
 2a8:	00000000 	0x00000000
 2ac:	0000001c 	0x0000001c
 2b0:	1c002848 	pcaddu12i	$r8,322(0x142)
 2b4:	00000038 	0x00000038
 2b8:	1c002880 	pcaddu12i	$r0,324(0x144)
 2bc:	000000a0 	0x000000a0
	...

Disassembly of section .debug_str:

00000000 <.debug_str>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
   0:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
   4:	32333141 	0x32333141
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   8:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff6f58 <_edata+0x7fff5f54>
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   c:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff575c <_edata+0x7fff4758>
  10:	2f505845 	0x2f505845
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
  14:	72657375 	0x72657375
D:/LA132_SoC_SW_EXP/user/interrupt.c:109
  18:	6174735c 	blt	$r26,$r28,95344(0x17470) # 17488 <_start-0x1bfe8b78>
delay_s():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:86
  1c:	532e7472 	b	30092916(0x1cb2e74) # 1cb2e90 <_start-0x1a34d170>
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  20:	5c3a4400 	bne	$r0,$r0,14916(0x3a44) # 3a64 <_start-0x1bffc59c>
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  24:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
  28:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff5384 <_edata+0x7fff4380>
  2c:	57535f43 	bl	-49327268(0xd0f535c) # fd0f5388 <_edata+0x7d0f4384>
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  30:	5058455f 	b	92035140(0x57c5844) # 57c5874 <_start-0x1683a78c>
  34:	554e4700 	bl	-67023292(0xc014e44) # fc014e78 <_edata+0x7c013e74>
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  38:	20534120 	ll.w	$r0,$r9,21312(0x5340)
  3c:	31332e32 	0x31332e32
  40:	6c00312e 	bgeu	$r9,$r14,48(0x30) # 70 <_start-0x1bffff90>
uart_read_bcd_char():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  44:	5f747361 	bne	$r27,$r1,-35728(0x37470) # ffff74b4 <_edata+0x7fff64b0>
  48:	73006268 	0x73006268
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  4c:	74726f68 	xvmin.b	$xr8,$xr27,$xr27
  50:	746e6920 	0x746e6920
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
  54:	6c656400 	bgeu	$r0,$r0,25956(0x6564) # 65b8 <_start-0x1bff9a48>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
  58:	755f7961 	0x755f7961
  5c:	6d6e0073 	bgeu	$r3,$r19,93696(0x16e00) # 16e5c <_start-0x1bfe91a4>
  60:	61635f69 	blt	$r27,$r9,90972(0x1635c) # 163bc <_start-0x1bfe9c44>
  64:	72656c6c 	0x72656c6c
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
  68:	67666300 	bge	$r24,$r0,-39328(0x36660) # ffff66c8 <_edata+0x7fff56c4>
  6c:	6961775f 	bltu	$r26,$r31,90484(0x16174) # 161e0 <_start-0x1bfe9e20>
  70:	5f706f74 	bne	$r27,$r20,-36756(0x3706c) # ffff70dc <_edata+0x7fff60d8>
  74:	65656c73 	bge	$r3,$r19,91500(0x1656c) # 165e0 <_start-0x1bfe9a20>
  78:	65730070 	bge	$r3,$r16,94976(0x17300) # 17378 <_start-0x1bfe8c88>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
  7c:	695f3767 	bltu	$r27,$r7,89908(0x15f34) # 15fb0 <_start-0x1bfea050>
  80:	0074696e 	bstrins.w	$r14,$r11,0x14,0x1a
  84:	65645f73 	bge	$r27,$r19,91228(0x1645c) # 164e0 <_start-0x1bfe9b20>
  88:	6c660062 	bgeu	$r3,$r2,26112(0x6600) # 6688 <_start-0x1bff9978>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:254
  8c:	0074616f 	bstrins.w	$r15,$r11,0x14,0x18
  90:	676e6f6c 	bge	$r27,$r12,-37268(0x36e6c) # ffff6efc <_edata+0x7fff5ef8>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:259
  94:	6e6f6c20 	bgeu	$r1,$r0,-102548(0x26f6c) # fffe7000 <_edata+0x7ffe5ffc>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:260
  98:	6e692067 	bgeu	$r3,$r7,-104160(0x26920) # fffe69b8 <_edata+0x7ffe59b4>
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 3)
  9c:	626b0074 	blt	$r3,$r20,-103680(0x26b00) # fffe6b9c <_edata+0x7ffe5b98>
  a0:	73695f64 	vssrarni.w.d	$vr4,$vr27,0x17
  a4:	78655f72 	0x78655f72
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  a8:	73007469 	0x73007469
  ac:	79656b5f 	0x79656b5f
  b0:	6168635f 	blt	$r26,$r31,92256(0x16860) # 16910 <_start-0x1bfe96f0>
  b4:	5f710072 	bne	$r3,$r18,-36608(0x37100) # ffff71b4 <_edata+0x7fff61b0>
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  b8:	00706f70 	bstrins.w	$r16,$r27,0x10,0x1b
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
  bc:	5f747865 	bne	$r3,$r5,-35720(0x37478) # ffff7534 <_edata+0x7fff6530>
  c0:	72746e69 	0x72746e69
  c4:	725f7300 	0x725f7300
  c8:	4700776f 	bnez	$r27,4128884(0x3f0074) # 3f013c <_start-0x1bc0fec4>
  cc:	4320554e 	beqz	$r10,3874900(0x3b2054) # 3b2120 <_start-0x1bc4dee0>
  d0:	38203939 	ldx.bu	$r25,$r9,$r14
  d4:	302e332e 	vldrepl.w	$vr14,$r25,-464(0xe30)
  d8:	616d2d20 	blt	$r9,$r0,93484(0x16d2c) # 16e04 <_start-0x1bfe91fc>
  dc:	693d6962 	bltu	$r11,$r2,81256(0x13d68) # 13e44 <_start-0x1bfec1bc>
  e0:	3233706c 	0x3233706c
  e4:	6d2d2073 	bgeu	$r3,$r19,77088(0x12d20) # 12e04 <_start-0x1bfed1fc>
  e8:	68637261 	bltu	$r19,$r1,25456(0x6370) # 6458 <_start-0x1bff9ba8>
  ec:	6f6f6c3d 	bgeu	$r1,$r29,-37012(0x36f6c) # ffff7058 <_edata+0x7fff6054>
  f0:	7261676e 	0x7261676e
  f4:	32336863 	0x32336863
  f8:	666d2d20 	bge	$r9,$r0,-103124(0x26d2c) # fffe6e24 <_edata+0x7ffe5e20>
  fc:	6e3d7570 	bgeu	$r11,$r16,-115340(0x23d74) # fffe3e70 <_edata+0x7ffe2e6c>
 100:	20656e6f 	ll.w	$r15,$r19,25964(0x656c)
 104:	6d636d2d 	bgeu	$r9,$r13,90988(0x1636c) # 16470 <_start-0x1bfe9b90>
 108:	6c65646f 	bgeu	$r3,$r15,25956(0x6564) # 666c <_start-0x1bff9994>
 10c:	726f6e3d 	0x726f6e3d
 110:	206c616d 	ll.w	$r13,$r11,27744(0x6c60)
 114:	75746d2d 	0x75746d2d
 118:	6c3d656e 	bgeu	$r11,$r14,15716(0x3d64) # 3e7c <_start-0x1bffc184>
 11c:	676e6f6f 	bge	$r27,$r15,-37268(0x36e6c) # ffff6f88 <_edata+0x7fff5f84>
 120:	68637261 	bltu	$r19,$r1,25456(0x6370) # 6490 <_start-0x1bff9b70>
 124:	2d203233 	0x2d203233
 128:	4f2d2067 	jirl	$r7,$r3,-53984(0x32d20)
 12c:	4f2d2030 	jirl	$r16,$r1,-53984(0x32d20)
 130:	732d2067 	vslli.d	$vr7,$vr3,0x8
 134:	673d6474 	bge	$r3,$r20,-49820(0x33d64) # ffff3e98 <_edata+0x7fff2e94>
 138:	3939756e 	0x3939756e
 13c:	66662d20 	bge	$r9,$r0,-104916(0x2662c) # fffe6768 <_edata+0x7ffe5764>
 140:	74636e75 	xvabsd.wu	$xr21,$xr19,$xr27
 144:	2d6e6f69 	0x2d6e6f69
 148:	74636573 	xvabsd.wu	$xr19,$xr11,$xr25
 14c:	736e6f69 	vssrarni.du.q	$vr9,$vr27,0x1b
 150:	64662d20 	bge	$r9,$r0,26156(0x662c) # 677c <_start-0x1bff9884>
 154:	2d617461 	0x2d617461
 158:	74636573 	xvabsd.wu	$xr19,$xr11,$xr25
 15c:	736e6f69 	vssrarni.du.q	$vr9,$vr27,0x1b
 160:	73662d20 	vssrani.du.q	$vr0,$vr9,0xb
 164:	64656863 	bge	$r3,$r3,25960(0x6568) # 66cc <_start-0x1bff9934>
 168:	6572702d 	bge	$r1,$r13,94832(0x17270) # 173d8 <_start-0x1bfe8c28>
 16c:	72757373 	0x72757373
 170:	662d2065 	bge	$r3,$r5,-119520(0x22d20) # fffe2e90 <_edata+0x7ffe1e8c>
 174:	622d6f6e 	blt	$r27,$r14,-119444(0x22d6c) # fffe2ee0 <_edata+0x7ffe1edc>
 178:	746c6975 	0x746c6975
 17c:	69006e69 	bltu	$r19,$r9,65644(0x1006c) # 101e8 <_start-0x1bfefe18>
 180:	5f63746e 	bne	$r3,$r14,-40076(0x36374) # ffff64f4 <_edata+0x7fff54f0>
 184:	5f717269 	bne	$r19,$r9,-36496(0x37170) # ffff72f4 <_edata+0x7fff62f0>
 188:	61747461 	blt	$r3,$r1,95348(0x17474) # 175fc <_start-0x1bfe8a04>
 18c:	62006863 	blt	$r3,$r3,-130968(0x20068) # fffe01f4 <_edata+0x7ffdf1f0>
 190:	5f737469 	bne	$r3,$r9,-35980(0x37374) # ffff7504 <_edata+0x7fff6500>
 194:	73726966 	0x73726966
 198:	6e750074 	bgeu	$r3,$r20,-101120(0x27500) # fffe7698 <_edata+0x7ffe6694>
 19c:	6e676973 	bgeu	$r11,$r19,-104600(0x26768) # fffe6904 <_edata+0x7ffe5900>
 1a0:	63206465 	blt	$r3,$r5,-57244(0x32064) # ffff2204 <_edata+0x7fff1200>
 1a4:	00726168 	bstrins.w	$r8,$r11,0x12,0x18
 1a8:	5f64626b 	bne	$r19,$r11,-39840(0x36460) # ffff6608 <_edata+0x7fff5604>
 1ac:	6e616373 	bgeu	$r27,$r19,-106144(0x26160) # fffe630c <_edata+0x7ffe5308>
 1b0:	7273695f 	0x7273695f
 1b4:	625f7300 	blt	$r24,$r0,-106640(0x25f70) # fffe6124 <_edata+0x7ffe5120>
 1b8:	00737469 	bstrins.w	$r9,$r3,0x13,0x1d
 1bc:	676e6f6c 	bge	$r27,$r12,-37268(0x36e6c) # ffff7028 <_edata+0x7fff6024>
 1c0:	6e6f6c20 	bgeu	$r1,$r0,-102548(0x26f6c) # fffe712c <_edata+0x7ffe6128>
 1c4:	6e752067 	bgeu	$r3,$r7,-101088(0x27520) # fffe76e4 <_edata+0x7ffe66e0>
 1c8:	6e676973 	bgeu	$r11,$r19,-104600(0x26768) # fffe6930 <_edata+0x7ffe592c>
 1cc:	69206465 	bltu	$r3,$r5,73828(0x12064) # 12230 <_start-0x1bfeddd0>
 1d0:	7500746e 	0x7500746e
 1d4:	33746e69 	xvstelm.h	$xr9,$r19,54(0x36),0xd
 1d8:	00745f32 	bstrins.w	$r18,$r25,0x14,0x17
 1dc:	5f715f73 	bne	$r27,$r19,-36516(0x3715c) # ffff7338 <_edata+0x7fff6334>
 1e0:	6c696174 	bgeu	$r11,$r20,26976(0x6960) # 6b40 <_start-0x1bff94c0>
 1e4:	685f7300 	bltu	$r24,$r0,24432(0x5f70) # 6154 <_start-0x1bff9eac>
 1e8:	00646c6f 	bstrins.w	$r15,$r3,0x4,0x1b
 1ec:	726f6873 	0x726f6873
 1f0:	6e752074 	bgeu	$r3,$r20,-101088(0x27520) # fffe7710 <_edata+0x7ffe670c>
 1f4:	6e676973 	bgeu	$r11,$r19,-104600(0x26768) # fffe695c <_edata+0x7ffe5958>
 1f8:	69206465 	bltu	$r3,$r5,73828(0x12064) # 1225c <_start-0x1bfedda4>
 1fc:	7300746e 	0x7300746e
 200:	5f376765 	bne	$r27,$r5,-51356(0x33764) # ffff3964 <_edata+0x7fff2960>
 204:	5f746573 	bne	$r11,$r19,-35740(0x37464) # ffff7668 <_edata+0x7fff6664>
 208:	72616863 	0x72616863
 20c:	626b0073 	blt	$r3,$r19,-103680(0x26b00) # fffe6d0c <_edata+0x7ffe5d08>
 210:	63735f64 	blt	$r27,$r4,-36004(0x3735c) # ffff756c <_edata+0x7fff6568>
 214:	645f6e61 	bge	$r19,$r1,24428(0x5f6c) # 6180 <_start-0x1bff9e80>
 218:	006f6d65 	bstrins.w	$r5,$r11,0xf,0x1b
 21c:	74735f73 	xvmin.w	$xr19,$xr27,$xr23
 220:	656c6261 	bge	$r19,$r1,93280(0x16c60) # 16e80 <_start-0x1bfe9180>
 224:	2f3a4400 	0x2f3a4400
 228:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
 22c:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff5588 <_edata+0x7fff4584>
 230:	57535f43 	bl	-49327268(0xd0f535c) # fd0f558c <_edata+0x7d0f4588>
 234:	5058455f 	b	92035140(0x57c5844) # 57c5a78 <_start-0x1683a588>
 238:	6972642f 	bltu	$r1,$r15,94820(0x17264) # 1749c <_start-0x1bfe8b64>
 23c:	2f726576 	0x2f726576
 240:	5f707865 	bne	$r3,$r5,-36744(0x37078) # ffff72b8 <_edata+0x7fff62b4>
 244:	5f64626b 	bne	$r19,$r11,-39840(0x36460) # ffff66a4 <_edata+0x7fff56a0>
 248:	6e616373 	bgeu	$r27,$r19,-106144(0x26160) # fffe63a8 <_edata+0x7ffe53a4>
 24c:	6d65642f 	bgeu	$r1,$r15,91492(0x16564) # 167b0 <_start-0x1bfe9850>
 250:	626b5f6f 	blt	$r27,$r15,-103588(0x26b5c) # fffe6dac <_edata+0x7ffe5da8>
 254:	63735f64 	blt	$r27,$r4,-36004(0x3735c) # ffff75b0 <_edata+0x7fff65ac>
 258:	632e6e61 	blt	$r19,$r1,-53652(0x32e6c) # ffff30c4 <_edata+0x7fff20c0>
 25c:	695f7300 	bltu	$r24,$r0,89968(0x15f70) # 161cc <_start-0x1bfe9e34>
 260:	635f7172 	blt	$r11,$r18,-41104(0x35f70) # ffff61d0 <_edata+0x7fff51cc>
 264:	7300746e 	0x7300746e
 268:	00736d5f 	bstrins.w	$r31,$r10,0x13,0x1b
 26c:	5f746477 	bne	$r3,$r23,-35740(0x37464) # ffff76d0 <_edata+0x7fff66cc>
 270:	6c6c6163 	bgeu	$r11,$r3,27744(0x6c60) # 6ed0 <_start-0x1bff9130>
 274:	69007265 	bltu	$r19,$r5,65648(0x10070) # 102e4 <_start-0x1bfefd1c>
 278:	5f63746e 	bne	$r3,$r14,-40076(0x36374) # ffff65ec <_edata+0x7fff55e8>
 27c:	5f717269 	bne	$r19,$r9,-36496(0x37170) # ffff73ec <_edata+0x7fff63e8>
 280:	74696e69 	xvavgr.w	$xr9,$xr19,$xr27
 284:	715f7300 	0x715f7300
 288:	6165685f 	blt	$r2,$r31,91496(0x16568) # 167f0 <_start-0x1bfe9810>
 28c:	6f720064 	bgeu	$r3,$r4,-36352(0x37200) # ffff748c <_edata+0x7fff6488>
 290:	00646e75 	bstrins.w	$r21,$r19,0x4,0x1b
 294:	75705f71 	0x75705f71
 298:	73006873 	0x73006873
 29c:	5f376765 	bne	$r27,$r5,-51356(0x33764) # ffff3a00 <_edata+0x7fff29fc>
 2a0:	6e616373 	bgeu	$r27,$r19,-106144(0x26160) # fffe6400 <_edata+0x7ffe53fc>
 2a4:	705f7300 	0x705f7300
 2a8:	7300736f 	0x7300736f
 2ac:	5f376765 	bne	$r27,$r5,-51356(0x33764) # ffff3a10 <_edata+0x7fff2a0c>
 2b0:	5f746573 	bne	$r11,$r19,-35740(0x37464) # ffff7714 <_edata+0x7fff6710>
 2b4:	69676964 	bltu	$r11,$r4,92008(0x16768) # 16a1c <_start-0x1bfe95e4>
 2b8:	73007374 	0x73007374
 2bc:	5f376765 	bne	$r27,$r5,-51356(0x33764) # ffff3a20 <_edata+0x7fff2a1c>
 2c0:	5f746573 	bne	$r11,$r19,-35740(0x37464) # ffff7724 <_edata+0x7fff6720>
 2c4:	6769646e 	bge	$r3,$r14,-38556(0x36964) # ffff6c28 <_edata+0x7fff5c24>
 2c8:	00737469 	bstrins.w	$r9,$r3,0x13,0x1d
 2cc:	37676573 	0x37676573
 2d0:	7465735f 	xvavg.w	$xr31,$xr26,$xr28
 2d4:	6c61765f 	bgeu	$r18,$r31,24948(0x6174) # 6448 <_start-0x1bff9bb8>
 2d8:	44006575 	bnez	$r11,-2883484(0x540064) # ffd4033c <_edata+0x7fd3f338>
 2dc:	414c2f3a 	beqz	$r25,-1487828(0x694c2c) # ffe94f08 <_edata+0x7fe93f04>
 2e0:	5f323331 	bne	$r25,$r17,-52688(0x33230) # ffff3510 <_edata+0x7fff250c>
 2e4:	5f436f53 	bne	$r26,$r19,-48276(0x3436c) # ffff4650 <_edata+0x7fff364c>
 2e8:	455f5753 	bnez	$r26,-3317932(0x4d5f54) # ffcd623c <_edata+0x7fcd5238>
 2ec:	642f5058 	bge	$r2,$r24,12112(0x2f50) # 323c <_start-0x1bffcdc4>
 2f0:	65766972 	bge	$r11,$r18,95848(0x17668) # 17958 <_start-0x1bfe86a8>
 2f4:	50472f72 	b	-37206228(0xdc8472c) # fdc84a20 <_edata+0x7dc83a1c>
 2f8:	732f4f49 	0x732f4f49
 2fc:	2e376765 	0x2e376765
 300:	5f730063 	bne	$r3,$r3,-36096(0x37300) # ffff7600 <_edata+0x7fff65fc>
 304:	65646f63 	bge	$r27,$r3,91244(0x1646c) # 16770 <_start-0x1bfe9890>
 308:	61686300 	blt	$r24,$r0,92256(0x16860) # 16b68 <_start-0x1bfe9498>
 30c:	6f745f72 	bgeu	$r27,$r18,-35748(0x3745c) # ffff7768 <_edata+0x7fff6764>
 310:	6765735f 	bge	$r26,$r31,-39568(0x36570) # ffff6880 <_edata+0x7fff587c>
 314:	65646f63 	bge	$r27,$r3,91244(0x1646c) # 16780 <_start-0x1bfe9880>
 318:	645f7300 	bge	$r24,$r0,24432(0x5f70) # 6288 <_start-0x1bff9d78>
 31c:	73006769 	0x73006769
 320:	69646e5f 	bltu	$r18,$r31,91244(0x1646c) # 1678c <_start-0x1bfe9874>
 324:	65730067 	bge	$r3,$r7,94976(0x17300) # 17624 <_start-0x1bfe89dc>
 328:	635f3767 	blt	$r27,$r7,-41164(0x35f34) # ffff625c <_edata+0x7fff5258>
 32c:	0065646f 	bstrins.w	$r15,$r3,0x5,0x19
 330:	454d4954 	bnez	$r10,-3060408(0x514d48) # ffd15078 <_edata+0x7fd14074>
 334:	4f435f52 	jirl	$r18,$r26,-48292(0x3435c)
 338:	00544e55 	0x00544e55
 33c:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
 340:	32333141 	0x32333141
 344:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff7294 <_edata+0x7fff6290>
 348:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff5a98 <_edata+0x7fff4a94>
 34c:	2f505845 	0x2f505845
 350:	76697264 	0x76697264
 354:	4c2f7265 	jirl	$r5,$r19,12144(0x2f70)
 358:	49545f41 	0x49545f41
 35c:	2f52454d 	0x2f52454d
 360:	6974616c 	bltu	$r11,$r12,95328(0x17460) # 177c0 <_start-0x1bfe8840>
 364:	2e72656d 	0x2e72656d
 368:	65620063 	bge	$r3,$r3,90624(0x16200) # 16568 <_start-0x1bfe9a98>
 36c:	006e6967 	bstrins.w	$r7,$r11,0xe,0x1a
 370:	656d6974 	bge	$r11,$r20,93544(0x16d68) # 170d8 <_start-0x1bfe8f28>
 374:	6f635f72 	bgeu	$r27,$r18,-40100(0x3635c) # ffff66d0 <_edata+0x7fff56cc>
 378:	00746e75 	bstrins.w	$r21,$r19,0x14,0x1b
 37c:	5f746567 	bne	$r11,$r7,-35740(0x37464) # ffff77e0 <_edata+0x7fff67dc>
 380:	6e756f63 	bgeu	$r27,$r3,-101012(0x2756c) # fffe78ec <_edata+0x7ffe68e8>
 384:	65530074 	bge	$r3,$r20,86784(0x15300) # 15684 <_start-0x1bfea97c>
 388:	6d695474 	bgeu	$r3,$r20,92500(0x16954) # 16cdc <_start-0x1bfe9324>
 38c:	65640065 	bge	$r3,$r5,91136(0x16400) # 1678c <_start-0x1bfe9874>
 390:	5f79616c 	bne	$r11,$r12,-34464(0x37960) # ffff7cf0 <_edata+0x7fff6cec>
 394:	6f00736d 	bgeu	$r27,$r13,-65424(0x30070) # ffff0404 <_edata+0x7ffef400>
 398:	5f6e6570 	bne	$r11,$r16,-37276(0x36e64) # ffff71fc <_edata+0x7fff61f8>
 39c:	6e756f63 	bgeu	$r27,$r3,-101012(0x2756c) # fffe7908 <_edata+0x7ffe6904>
 3a0:	65740074 	bge	$r3,$r20,95232(0x17400) # 177a0 <_start-0x1bfe8860>
 3a4:	6f635f6d 	bgeu	$r27,$r13,-40100(0x3635c) # ffff6700 <_edata+0x7fff56fc>
 3a8:	00746e75 	bstrins.w	$r21,$r19,0x14,0x1b
 3ac:	736f6c63 	vssrarni.du.q	$vr3,$vr3,0x5b
 3b0:	6f635f65 	bgeu	$r27,$r5,-40100(0x3635c) # ffff670c <_edata+0x7fff5708>
 3b4:	00746e75 	bstrins.w	$r21,$r19,0x14,0x1b
 3b8:	706f7473 	0x706f7473
 3bc:	756f635f 	0x756f635f
 3c0:	6400746e 	bge	$r3,$r14,116(0x74) # 434 <_start-0x1bfffbcc>
 3c4:	79616c65 	0x79616c65
 3c8:	6379635f 	blt	$r26,$r31,-34464(0x37960) # ffff7d28 <_edata+0x7fff6d24>
 3cc:	7500656c 	0x7500656c
 3d0:	38746e69 	fldgt.s	$f9,$r19,$r27
 3d4:	7300745f 	0x7300745f
 3d8:	74726174 	xvmin.b	$xr20,$xr11,$xr24
 3dc:	756f635f 	0x756f635f
 3e0:	5400746e 	bl	28835956(0x1b80074) # 1b80454 <_start-0x1a47fbac>
 3e4:	53656d69 	b	94856556(0x5a7656c) # 5a76950 <_start-0x165896b0>
 3e8:	74726174 	xvmin.b	$xr20,$xr11,$xr24
 3ec:	6d695400 	bgeu	$r0,$r0,92500(0x16954) # 16d40 <_start-0x1bfe92c0>
 3f0:	746e4965 	0x746e4965
 3f4:	64007265 	bge	$r19,$r5,112(0x70) # 464 <_start-0x1bfffb9c>
 3f8:	79616c65 	0x79616c65
 3fc:	4300735f 	beqz	$r26,-65424(0x7f0070) # ffff046c <_edata+0x7ffef468>
 400:	61706d6f 	blt	$r11,$r15,94316(0x1706c) # 1746c <_start-0x1bfe8b94>
 404:	69546572 	bltu	$r11,$r18,87140(0x15464) # 15868 <_start-0x1bfea798>
 408:	7400656d 	xvseq.b	$xr13,$xr11,$xr25
 40c:	6d695473 	bgeu	$r3,$r19,92500(0x16954) # 16d60 <_start-0x1bfe92a0>
 410:	70795465 	0x70795465
 414:	61750065 	blt	$r3,$r5,95488(0x17500) # 17914 <_start-0x1bfe86ec>
 418:	695f7472 	bltu	$r3,$r18,89972(0x15f74) # 1638c <_start-0x1bfe9c74>
 41c:	0074696e 	bstrins.w	$r14,$r11,0x14,0x1a
 420:	78725f73 	0x78725f73
 424:	6961745f 	bltu	$r2,$r31,90484(0x16174) # 16598 <_start-0x1bfe9a68>
 428:	7567006c 	0x7567006c
 42c:	00647261 	bstrins.w	$r1,$r19,0x4,0x1c
 430:	74726175 	xvmin.b	$xr21,$xr11,$xr24
 434:	7172695f 	0x7172695f
 438:	5f78725f 	bne	$r18,$r31,-34704(0x37870) # ffff7ca8 <_edata+0x7fff6ca4>
 43c:	65646f6d 	bge	$r27,$r13,91244(0x1646c) # 168a8 <_start-0x1bfe9758>
 440:	725f7300 	0x725f7300
 444:	65685f78 	bge	$r27,$r24,92252(0x1685c) # 16ca0 <_start-0x1bfe9360>
 448:	73006461 	0x73006461
 44c:	7475705f 	xvmax.wu	$xr31,$xr2,$xr28
 450:	72645f63 	0x72645f63
 454:	7500706f 	0x7500706f
 458:	5f747261 	bne	$r19,$r1,-35728(0x37470) # ffff78c8 <_edata+0x7fff68c4>
 45c:	695f7872 	bltu	$r3,$r18,89976(0x15f78) # 163d4 <_start-0x1bfe9c2c>
 460:	635f7172 	blt	$r11,$r18,-41104(0x35f70) # ffff63d0 <_edata+0x7fff53cc>
 464:	746e756f 	0x746e756f
 468:	72617500 	0x72617500
 46c:	78725f74 	0x78725f74
 470:	6165725f 	blt	$r18,$r31,91504(0x16570) # 169e0 <_start-0x1bfe9620>
 474:	75007964 	0x75007964
 478:	5f747261 	bne	$r19,$r1,-35728(0x37470) # ffff78e8 <_edata+0x7fff68e4>
 47c:	705f7872 	0x705f7872
 480:	00687375 	bstrins.w	$r21,$r27,0x8,0x1c
 484:	78725f73 	0x78725f73
 488:	6675625f 	bge	$r18,$r31,-101024(0x27560) # fffe79e8 <_edata+0x7ffe69e4>
 48c:	725f7300 	0x725f7300
 490:	72645f78 	0x72645f78
 494:	6200706f 	blt	$r3,$r15,-130960(0x20070) # fffe0504 <_edata+0x7ffdf500>
 498:	72647561 	0x72647561
 49c:	00657461 	bstrins.w	$r1,$r3,0x5,0x1d
 4a0:	74726175 	xvmin.b	$xr21,$xr11,$xr24
 4a4:	5f78725f 	bne	$r18,$r31,-34704(0x37870) # ffff7d14 <_edata+0x7fff6d10>
 4a8:	73756c66 	0x73756c66
 4ac:	3a440068 	0x3a440068
 4b0:	31414c2f 	vstelm.h	$vr15,$r1,166(0xa6),0x0
 4b4:	535f3233 	b	-120627408(0x8cf5f30) # f8cf63e4 <_edata+0x78cf53e0>
 4b8:	535f436f 	b	-37789888(0xdbf5f40) # fdbf63f8 <_edata+0x7dbf53f4>
 4bc:	58455f57 	beq	$r26,$r23,17756(0x455c) # 4a18 <_start-0x1bffb5e8>
 4c0:	72642f50 	0x72642f50
 4c4:	72657669 	0x72657669
 4c8:	5241552f 	b	79577428(0x4be4154) # 4be461c <_start-0x1741b9e4>
 4cc:	61752f54 	blt	$r26,$r20,95532(0x1752c) # 179f8 <_start-0x1bfe8608>
 4d0:	632e7472 	blt	$r3,$r18,-53644(0x32e74) # ffff3344 <_edata+0x7fff2340>
 4d4:	72617500 	0x72617500
 4d8:	6e695f74 	bgeu	$r27,$r20,-104100(0x2695c) # fffe6e34 <_edata+0x7ffe5e30>
 4dc:	72726574 	0x72726574
 4e0:	5f747075 	bne	$r3,$r21,-35728(0x37470) # ffff7950 <_edata+0x7fff694c>
 4e4:	74696e69 	xvavgr.w	$xr9,$xr19,$xr27
 4e8:	695f7300 	bltu	$r24,$r0,89968(0x15f70) # 16458 <_start-0x1bfe9ba8>
 4ec:	725f7172 	0x725f7172
 4f0:	6f6d5f78 	bgeu	$r27,$r24,-37540(0x36d5c) # ffff724c <_edata+0x7fff6248>
 4f4:	75006564 	0x75006564
 4f8:	5f747261 	bne	$r19,$r1,-35728(0x37470) # ffff7968 <_edata+0x7fff6964>
 4fc:	64616572 	bge	$r11,$r18,24932(0x6164) # 6660 <_start-0x1bff99a0>
 500:	6463625f 	bge	$r18,$r31,25440(0x6360) # 6860 <_start-0x1bff97a0>
 504:	6168635f 	blt	$r26,$r31,92256(0x16860) # 16d64 <_start-0x1bfe929c>
 508:	61750072 	blt	$r3,$r18,95488(0x17500) # 17a08 <_start-0x1bfe85f8>
 50c:	725f7472 	0x725f7472
 510:	5f646165 	bne	$r11,$r5,-39840(0x36460) # ffff6970 <_edata+0x7fff596c>
 514:	72616863 	0x72616863
 518:	72617500 	0x72617500
 51c:	78725f74 	0x78725f74
 520:	6f72645f 	bgeu	$r2,$r31,-36252(0x37264) # ffff7784 <_edata+0x7fff6780>
 524:	6f635f70 	bgeu	$r27,$r16,-40100(0x3635c) # ffff6880 <_edata+0x7fff587c>
 528:	00746e75 	bstrins.w	$r21,$r19,0x14,0x1b
 52c:	74726175 	xvmin.b	$xr21,$xr11,$xr24
 530:	7465675f 	xvavg.w	$xr31,$xr26,$xr25
 534:	72616863 	0x72616863
 538:	00626e5f 	bstrins.w	$r31,$r18,0x2,0x1b
 53c:	74726175 	xvmin.b	$xr21,$xr11,$xr24
 540:	7475705f 	xvmax.wu	$xr31,$xr2,$xr28
 544:	61750063 	blt	$r3,$r3,95488(0x17500) # 17a44 <_start-0x1bfe85bc>
 548:	705f7472 	0x705f7472
 54c:	5f637475 	bne	$r3,$r21,-40076(0x36374) # ffff68c0 <_edata+0x7fff58bc>
 550:	706f7264 	0x706f7264
 554:	72617500 	0x72617500
 558:	72695f74 	0x72695f74
 55c:	6f635f71 	bgeu	$r27,$r17,-40100(0x3635c) # ffff68b8 <_edata+0x7fff58b4>
 560:	5f746e75 	bne	$r19,$r21,-35732(0x3746c) # ffff79cc <_edata+0x7fff69c8>
 564:	00636e69 	bstrins.w	$r9,$r19,0x3,0x1b
 568:	74726175 	xvmin.b	$xr21,$xr11,$xr24
 56c:	7475705f 	xvmax.wu	$xr31,$xr2,$xr28
 570:	656e0073 	bge	$r3,$r19,93696(0x16e00) # 17370 <_start-0x1bfe8c90>
 574:	44007478 	bnez	$r3,-2097036(0x600074) # ffe005e8 <_edata+0x7fdff5e4>
 578:	414c2f3a 	beqz	$r25,-1487828(0x694c2c) # ffe951a4 <_edata+0x7fe941a0>
 57c:	5f323331 	bne	$r25,$r17,-52688(0x33230) # ffff37ac <_edata+0x7fff27a8>
 580:	5f436f53 	bne	$r26,$r19,-48276(0x3436c) # ffff48ec <_edata+0x7fff38e8>
 584:	455f5753 	bnez	$r26,-3317932(0x4d5f54) # ffcd64d8 <_edata+0x7fcd54d4>
 588:	622f5058 	blt	$r2,$r24,-118960(0x22f50) # fffe34d8 <_edata+0x7ffe24d4>
 58c:	502f7073 	b	30158704(0x1cc2f70) # 1cc34fc <_start-0x1a33cb04>
 590:	544e4952 	bl	88624712(0x5484e48) # 54853d8 <_start-0x16b7ac28>
 594:	75702f46 	0x75702f46
 598:	61686374 	blt	$r27,$r20,92256(0x16860) # 16df8 <_start-0x1bfe9208>
 59c:	00632e72 	bstrins.w	$r18,$r19,0x3,0xb
 5a0:	7475705f 	xvmax.wu	$xr31,$xr2,$xr28
 5a4:	72616863 	0x72616863
 5a8:	7a697300 	0x7a697300
 5ac:	00745f65 	bstrins.w	$r5,$r27,0x14,0x17
 5b0:	72616863 	0x72616863
 5b4:	65746361 	bge	$r27,$r1,95328(0x17460) # 17a14 <_start-0x1bfe85ec>
 5b8:	6f5f0072 	bgeu	$r3,$r18,-41216(0x35f00) # ffff64b8 <_edata+0x7fff54b4>
 5bc:	635f7475 	blt	$r3,$r21,-41100(0x35f74) # ffff6530 <_edata+0x7fff552c>
 5c0:	00726168 	bstrins.w	$r8,$r11,0x12,0x18
 5c4:	69676964 	bltu	$r11,$r4,92008(0x16768) # 16d2c <_start-0x1bfe92d4>
 5c8:	64003074 	bge	$r3,$r20,48(0x30) # 5f8 <_start-0x1bfffa08>
 5cc:	74696769 	xvavgr.w	$xr9,$xr27,$xr25
 5d0:	69640031 	bltu	$r1,$r17,91136(0x16400) # 169d0 <_start-0x1bfe9630>
 5d4:	32746967 	0x32746967
 5d8:	67696400 	bge	$r0,$r0,-38556(0x36964) # ffff6f3c <_edata+0x7fff5f38>
 5dc:	00337469 	0x00337469
 5e0:	4c2f3a44 	jirl	$r4,$r18,12088(0x2f38)
 5e4:	32333141 	0x32333141
 5e8:	436f535f 	beqz	$r26,-37040(0x7f6f50) # ffff7538 <_edata+0x7fff6534>
 5ec:	5f57535f 	bne	$r26,$r31,-43184(0x35750) # ffff5d3c <_edata+0x7fff4d38>
 5f0:	2f505845 	0x2f505845
 5f4:	2f707362 	0x2f707362
 5f8:	4e495250 	jirl	$r16,$r18,-112304(0x24950)
 5fc:	702f4654 	vaddwev.d.wu	$vr20,$vr18,$vr17
 600:	746e6972 	0x746e6972
 604:	00632e66 	bstrins.w	$r6,$r19,0x3,0xb
 608:	33544e49 	xvstelm.h	$xr9,$r18,38(0x26),0x5
 60c:	73005532 	0x73005532
 610:	74726174 	xvmin.b	$xr20,$xr11,$xr24
 614:	7864695f 	0x7864695f
 618:	64697700 	bge	$r24,$r0,26996(0x6974) # 6f8c <_start-0x1bff9074>
 61c:	6e006874 	bgeu	$r3,$r20,-130968(0x20068) # fffe0684 <_edata+0x7ffdf680>
 620:	74616765 	xvabsd.w	$xr5,$xr27,$xr25
 624:	00657669 	bstrins.w	$r9,$r19,0x5,0x1d
 628:	6f746e5f 	bgeu	$r18,$r31,-35732(0x3746c) # ffff7a94 <_edata+0x7fff6a90>
 62c:	6f665f61 	bgeu	$r27,$r1,-39332(0x3665c) # ffff6c88 <_edata+0x7fff5c84>
 630:	74616d72 	xvabsd.w	$xr18,$xr11,$xr27
 634:	73765f00 	0x73765f00
 638:	6972706e 	bltu	$r3,$r14,94832(0x17270) # 178a8 <_start-0x1bfe8758>
 63c:	0066746e 	bstrins.w	$r14,$r3,0x6,0x1d
 640:	74756f5f 	xvmax.wu	$xr31,$xr26,$xr27
 644:	6c756e5f 	bgeu	$r18,$r31,30060(0x756c) # 7bb0 <_start-0x1bff8450>
 648:	756f006c 	0x756f006c
 64c:	63665f74 	blt	$r27,$r20,-39332(0x3665c) # ffff6ca8 <_edata+0x7fff5ca4>
 650:	79745f74 	0x79745f74
 654:	5f006570 	bne	$r11,$r16,-65436(0x30064) # ffff06b8 <_edata+0x7ffef6b4>
 658:	616f746e 	blt	$r3,$r14,94068(0x16f74) # 175cc <_start-0x1bfe8a34>
 65c:	6e6f6c5f 	bgeu	$r2,$r31,-102548(0x26f6c) # fffe75c8 <_edata+0x7ffe65c4>
 660:	6c660067 	bgeu	$r3,$r7,26112(0x6600) # 6c60 <_start-0x1bff93a0>
 664:	00736761 	bstrins.w	$r1,$r27,0x13,0x19
 668:	6c78616d 	bgeu	$r11,$r13,30816(0x7860) # 7ec8 <_start-0x1bff8138>
 66c:	5f006e65 	bne	$r19,$r5,-65428(0x3006c) # ffff06d8 <_edata+0x7ffef6d4>
 670:	696f7461 	bltu	$r3,$r1,94068(0x16f74) # 175e4 <_start-0x1bfe8a1c>
 674:	74735f00 	xvmin.w	$xr0,$xr24,$xr23
 678:	656c6e72 	bge	$r19,$r18,93292(0x16c6c) # 172e4 <_start-0x1bfe8d1c>
 67c:	00735f6e 	bstrins.w	$r14,$r27,0x13,0x17
 680:	6f6f425f 	bgeu	$r18,$r31,-37056(0x36f40) # ffff75c0 <_edata+0x7fff65bc>
 684:	695f006c 	bltu	$r3,$r12,89856(0x15f00) # 16584 <_start-0x1bfe9a7c>
 688:	69645f73 	bltu	$r27,$r19,91228(0x1645c) # 16ae4 <_start-0x1bfe951c>
 68c:	00746967 	bstrins.w	$r7,$r11,0x14,0x1a
 690:	66667562 	bge	$r11,$r2,-104844(0x26674) # fffe6d04 <_edata+0x7ffe5d00>
 694:	5f007265 	bne	$r19,$r5,-65424(0x30070) # ffff0704 <_edata+0x7ffef700>
 698:	6975625f 	bltu	$r18,$r31,95584(0x17560) # 17bf8 <_start-0x1bfe8408>
 69c:	6e69746c 	bgeu	$r3,$r12,-104076(0x26974) # fffe7010 <_edata+0x7ffe600c>
 6a0:	5f61765f 	bne	$r18,$r31,-40588(0x36174) # ffff6814 <_edata+0x7fff5810>
 6a4:	7473696c 	xvmin.w	$xr12,$xr11,$xr26
 6a8:	756f5f00 	0x756f5f00
 6ac:	65725f74 	bge	$r27,$r20,94812(0x1725c) # 17908 <_start-0x1bfe86f8>
 6b0:	616d0076 	blt	$r3,$r22,93440(0x16d00) # 173b0 <_start-0x1bfe8c50>
 6b4:	7a697378 	0x7a697378
 6b8:	72700065 	0x72700065
 6bc:	5f006365 	bne	$r27,$r5,-65440(0x30060) # ffff071c <_edata+0x7ffef718>
 6c0:	756e675f 	0x756e675f
 6c4:	61765f63 	blt	$r27,$r3,95836(0x1765c) # 17d20 <_start-0x1bfe82e0>
 6c8:	73696c5f 	vssrarni.w.d	$vr31,$vr2,0x1b
 6cc:	61620074 	blt	$r3,$r20,90624(0x16200) # 168cc <_start-0x1bfe9734>
 6d0:	70006573 	vseq.b	$vr19,$vr11,$vr25
 6d4:	69636572 	bltu	$r11,$r18,90980(0x16364) # 16a38 <_start-0x1bfe95c8>
 6d8:	6e6f6973 	bgeu	$r11,$r19,-102552(0x26f68) # fffe7640 <_edata+0x7ffe663c>
 6dc:	2f3a4400 	0x2f3a4400
 6e0:	3331414c 	xvstelm.w	$xr12,$r10,320(0x140),0x4
 6e4:	6f535f32 	bgeu	$r25,$r18,-44196(0x3535c) # ffff5a40 <_edata+0x7fff4a3c>
 6e8:	57535f43 	bl	-49327268(0xd0f535c) # fd0f5a44 <_edata+0x7d0f4a40>
 6ec:	5058455f 	b	92035140(0x57c5844) # 57c5f30 <_start-0x1683a0d0>
 6f0:	6573752f 	bge	$r9,$r15,95092(0x17374) # 17a64 <_start-0x1bfe859c>
 6f4:	616d2f72 	blt	$r27,$r18,93484(0x16d2c) # 17420 <_start-0x1bfe8be0>
 6f8:	632e6e69 	blt	$r19,$r9,-53652(0x32e6c) # ffff3564 <_edata+0x7fff2560>
 6fc:	69616d00 	bltu	$r8,$r0,90476(0x1616c) # 16868 <_start-0x1bfe9798>
 700:	6944006e 	bltu	$r3,$r14,82944(0x14400) # 14b00 <_start-0x1bfeb500>
 704:	6c626173 	bgeu	$r11,$r19,25184(0x6260) # 6964 <_start-0x1bff969c>
 708:	414c5f65 	beqz	$r27,1395804(0x154c5c) # 155364 <_start-0x1beaac9c>
 70c:	6f6c475f 	bgeu	$r26,$r31,-37820(0x36c44) # ffff7350 <_edata+0x7fff634c>
 710:	495f6c62 	bceqz	$fcc3,614252(0x95f6c) # 9667c <_start-0x1bf69984>
 714:	4400746e 	bnez	$r3,3670132(0x380074) # 380788 <_start-0x1bc7f878>
 718:	62617369 	blt	$r27,$r9,-106128(0x26170) # fffe6888 <_edata+0x7ffe5884>
 71c:	4c5f656c 	jirl	$r12,$r11,24420(0x5f64)
 720:	6f4c5f41 	bgeu	$r26,$r1,-45988(0x34c5c) # ffff537c <_edata+0x7fff4378>
 724:	5f6c6163 	bne	$r11,$r3,-37792(0x36c60) # ffff7384 <_edata+0x7fff6380>
 728:	00746e49 	bstrins.w	$r9,$r18,0x14,0x1b
 72c:	63746e69 	blt	$r19,$r9,-35732(0x3746c) # ffff7b98 <_edata+0x7fff6b94>
 730:	7172695f 	0x7172695f
 734:	7465645f 	xvavg.w	$xr31,$xr2,$xr25
 738:	00686361 	bstrins.w	$r1,$r27,0x8,0x18
 73c:	74697257 	xvavgr.w	$xr23,$xr18,$xr28
 740:	4e495f65 	jirl	$r5,$r27,-112292(0x2495c)
 744:	45455f54 	bnez	$r26,-3062436(0x51455c) # ffd14ca0 <_edata+0x7fd13c9c>
 748:	5952544e 	beq	$r2,$r14,86612(0x15254) # 1599c <_start-0x1bfea664>
 74c:	5f737600 	bne	$r16,$r0,-35980(0x37374) # ffff7ac0 <_edata+0x7fff6abc>
 750:	006d756e 	bstrins.w	$r14,$r11,0xd,0x1d
 754:	62616e45 	blt	$r18,$r5,-106132(0x2616c) # fffe68c0 <_edata+0x7ffe58bc>
 758:	6e49656c 	bgeu	$r11,$r12,-112284(0x24964) # fffe50bc <_edata+0x7ffe40b8>
 75c:	65530074 	bge	$r3,$r20,86784(0x15300) # 15a5c <_start-0x1bfea5a4>
 760:	414c5f74 	beqz	$r27,-3060644(0x514c5c) # ffd153bc <_edata+0x7fd143b8>
 764:	0053565f 	0x0053565f
 768:	62616e45 	blt	$r18,$r5,-106132(0x2616c) # fffe68d4 <_edata+0x7ffe58d0>
 76c:	4c5f656c 	jirl	$r12,$r11,24420(0x5f64)
 770:	6c475f41 	bgeu	$r26,$r1,18268(0x475c) # 4ecc <_start-0x1bffb134>
 774:	5f6c626f 	bne	$r19,$r15,-37792(0x36c60) # ffff73d4 <_edata+0x7fff63d0>
 778:	00746e49 	bstrins.w	$r9,$r18,0x14,0x1b
 77c:	62616e45 	blt	$r18,$r5,-106132(0x2616c) # fffe68e8 <_edata+0x7ffe58e4>
 780:	4c5f656c 	jirl	$r12,$r11,24420(0x5f64)
 784:	6f4c5f41 	bgeu	$r26,$r1,-45988(0x34c5c) # ffff53e0 <_edata+0x7fff43dc>
 788:	5f6c6163 	bne	$r11,$r3,-37792(0x36c60) # ffff73e8 <_edata+0x7fff63e4>
 78c:	00746e49 	bstrins.w	$r9,$r18,0x14,0x1b
 790:	72695f73 	0x72695f73
 794:	6f685f71 	bgeu	$r27,$r17,-38820(0x3685c) # ffff6ff0 <_edata+0x7fff5fec>
 798:	44006b6f 	bnez	$r27,3932264(0x3c0068) # 3c0800 <_start-0x1bc3f800>
 79c:	414c2f3a 	beqz	$r25,-1487828(0x694c2c) # ffe953c8 <_edata+0x7fe943c4>
 7a0:	5f323331 	bne	$r25,$r17,-52688(0x33230) # ffff39d0 <_edata+0x7fff29cc>
 7a4:	5f436f53 	bne	$r26,$r19,-48276(0x3436c) # ffff4b10 <_edata+0x7fff3b0c>
 7a8:	455f5753 	bnez	$r26,-3317932(0x4d5f54) # ffcd66fc <_edata+0x7fcd56f8>
 7ac:	752f5058 	xvsigncov.w	$xr24,$xr2,$xr20
 7b0:	2f726573 	0x2f726573
 7b4:	65746e69 	bge	$r19,$r9,95340(0x1746c) # 17c20 <_start-0x1bfe83e0>
 7b8:	70757272 	vmax.wu	$vr18,$vr19,$vr28
 7bc:	00632e74 	bstrins.w	$r20,$r19,0x3,0xb
 7c0:	74726175 	xvmin.b	$xr21,$xr11,$xr24
 7c4:	6e61685f 	bgeu	$r2,$r31,-106136(0x26168) # fffe692c <_edata+0x7ffe5928>
 7c8:	72656c64 	0x72656c64
 7cc:	71726900 	0x71726900
 7d0:	6e61685f 	bgeu	$r2,$r31,-106136(0x26168) # fffe6938 <_edata+0x7ffe5934>
 7d4:	72656c64 	0x72656c64
 7d8:	6900745f 	bltu	$r2,$r31,65652(0x10074) # 1084c <_start-0x1bfef7b4>
 7dc:	5f63746e 	bne	$r3,$r14,-40076(0x36374) # ffff6b50 <_edata+0x7fff5b4c>
 7e0:	5f717269 	bne	$r19,$r9,-36496(0x37170) # ffff7950 <_edata+0x7fff694c>
 7e4:	70736964 	vmin.w	$vr4,$vr11,$vr26
 7e8:	68637461 	bltu	$r3,$r1,25460(0x6374) # 6b5c <_start-0x1bff94a4>
 7ec:	71726900 	0x71726900
 7f0:	6d756e5f 	bgeu	$r18,$r31,95596(0x1756c) # 17d5c <_start-0x1bfe82a4>
	...

Disassembly of section .debug_loc:

00000000 <.debug_loc>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
       0:	00000001 	0x00000001
       4:	1c00147c 	pcaddu12i	$r28,163(0xa3)
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
       8:	1c001534 	pcaddu12i	$r20,169(0xa9)
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
       c:	9f300002 	0x9f300002
      10:	1c001534 	pcaddu12i	$r20,169(0xa9)
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
      14:	1c0015c4 	pcaddu12i	$r4,174(0xae)
D:/LA132_SoC_SW_EXP/user/interrupt.c:109
      18:	00680001 	bstrins.w	$r1,$r0,0x8,0x0
delay_s():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:86
      1c:	00000000 	0x00000000
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
      20:	02000000 	slti	$r0,$r0,0
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
      24:	7c000000 	0x7c000000
      28:	341c0014 	0x341c0014
      2c:	021c0015 	slti	$r21,$r0,1792(0x700)
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
      30:	349f3000 	0x349f3000
      34:	c41c0015 	0xc41c0015
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
      38:	011c0015 	0x011c0015
      3c:	00006a00 	rdtime.d	$r0,$r16
	...
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
      4c:	1c001534 	pcaddu12i	$r20,169(0xa9)
      50:	1c00154c 	pcaddu12i	$r12,170(0xaa)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
      54:	54670001 	bl	288512(0x46700) # 46754 <_start-0x1bfb98ac>
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
      58:	781c0015 	0x781c0015
      5c:	011c0015 	0x011c0015
      60:	15785400 	lu12i.w	$r0,-277856(0xbc2a0)
      64:	15c41c00 	lu12i.w	$r0,-122656(0xe20e0)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
      68:	00011c00 	asrtle.d	$r0,$r7
      6c:	00000067 	0x00000067
	...
      78:	0012a000 	sltu	$r0,$r0,$r8
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
      7c:	0013a31c 	masknez	$r28,$r24,$r8
      80:	5f00011c 	bne	$r8,$r28,-65536(0x30000) # ffff0080 <_edata+0x7ffef07c>
      84:	1c0013ec 	pcaddu12i	$r12,159(0x9f)
      88:	1c001424 	pcaddu12i	$r4,161(0xa1)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:254
      8c:	005f0001 	0x005f0001
      90:	00000000 	0x00000000
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:259
      94:	01000000 	0x01000000
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:260
      98:	00000000 	0x00000000
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 3)
      9c:	0012a000 	sltu	$r0,$r0,$r8
      a0:	0012a81c 	sltu	$r28,$r0,$r10
      a4:	3000021c 	0x3000021c
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
      a8:	0012a89f 	sltu	$r31,$r4,$r10
      ac:	0012ac1c 	sltu	$r28,$r0,$r11
      b0:	5c00011c 	bne	$r8,$r28,0 # b0 <_start-0x1bffff50>
      b4:	1c0012b0 	pcaddu12i	$r16,149(0x95)
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
      b8:	1c00130c 	pcaddu12i	$r12,152(0x98)
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
      bc:	005c0001 	0x005c0001
	...
      c8:	68000000 	bltu	$r0,$r0,0 # c8 <_start-0x1bffff38>
      cc:	881c0012 	0x881c0012
      d0:	011c0012 	0x011c0012
      d4:	12885d00 	addu16i.d	$r0,$r8,-24041(0xa217)
      d8:	12931c00 	addu16i.d	$r0,$r0,-23353(0xa4c7)
      dc:	00011c00 	asrtle.d	$r0,$r7
      e0:	0000005c 	0x0000005c
	...
      f0:	00134800 	maskeqz	$r0,$r0,$r18
      f4:	0013781c 	maskeqz	$r28,$r0,$r30
      f8:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 100f8 <_start-0x1bfeff08>
      fc:	1c001378 	pcaddu12i	$r24,155(0x9b)
     100:	1c0013a3 	pcaddu12i	$r3,157(0x9d)
     104:	ec5e0001 	0xec5e0001
     108:	001c0013 	mul.w	$r19,$r0,$r0
     10c:	011c0014 	0x011c0014
     110:	14005d00 	lu12i.w	$r0,744(0x2e8)
     114:	14241c00 	lu12i.w	$r0,73952(0x120e0)
     118:	00011c00 	asrtle.d	$r0,$r7
     11c:	0000005e 	0x0000005e
	...
     128:	a4000000 	0xa4000000
     12c:	c01c0013 	0xc01c0013
     130:	011c0013 	0x011c0013
     134:	14245400 	lu12i.w	$r0,74400(0x122a0)
     138:	14281c00 	lu12i.w	$r0,82144(0x140e0)
     13c:	00011c00 	asrtle.d	$r0,$r7
     140:	00144054 	nor	$r20,$r2,$r16
     144:	0014641c 	nor	$r28,$r0,$r25
     148:	5400011c 	bl	74448896(0x4700000) # 4700148 <_start-0x178ffeb8>
	...
     158:	1c0011f8 	pcaddu12i	$r24,143(0x8f)
     15c:	1c001220 	pcaddu12i	$r0,145(0x91)
     160:	20540001 	ll.w	$r1,$r0,21504(0x5400)
     164:	241c0012 	ldptr.w	$r18,$r0,7168(0x1c00)
     168:	041c0012 	csrrd	$r18,0x700
     16c:	5401f300 	bl	-67108368(0xc0001f0) # fc00035c <_edata+0x7bfff358>
     170:	0000009f 	0x0000009f
     174:	00000000 	0x00000000
     178:	00000300 	0x00000300
     17c:	0011f800 	sub.d	$r0,$r0,$r30
     180:	0011fc1c 	sub.d	$r28,$r0,$r31
     184:	3000021c 	0x3000021c
     188:	0011fc9f 	sub.d	$r31,$r4,$r31
     18c:	00121c1c 	slt	$r28,$r0,$r7
     190:	5c00011c 	bne	$r8,$r28,0 # 190 <_start-0x1bfffe70>
	...
     19c:	11d40000 	addu16i.d	$r0,$r0,29952(0x7500)
     1a0:	11f01c00 	addu16i.d	$r0,$r0,31751(0x7c07)
     1a4:	00011c00 	asrtle.d	$r0,$r7
     1a8:	00000054 	0x00000054
     1ac:	00000000 	0x00000000
     1b0:	54000000 	bl	0 # 1b0 <_start-0x1bfffe50>
     1b4:	901c0011 	0x901c0011
     1b8:	011c0011 	0x011c0011
     1bc:	00005c00 	ext.w.b	$r0,$r0
	...
     1d0:	005e0001 	0x005e0001
	...
     1e8:	5f000100 	bne	$r8,$r0,-65536(0x30000) # ffff01e8 <_edata+0x7ffef1e4>
	...
     1f4:	7f7f0003 	0x7f7f0003
     1f8:	0000009f 	0x0000009f
     1fc:	00000000 	0x00000000
     200:	5f000100 	bne	$r8,$r0,-65536(0x30000) # ffff0200 <_edata+0x7ffef1fc>
	...
     218:	005d0001 	0x005d0001
     21c:	00000000 	0x00000000
     220:	01000000 	0x01000000
     224:	00005d00 	ext.w.b	$r0,$r8
	...
     238:	00010000 	asrtle.d	$r0,$r0
     23c:	0000005d 	0x0000005d
     240:	00000000 	0x00000000
     244:	81000200 	0x81000200
	...
     25c:	54000100 	bl	67108864(0x4000000) # 400025c <_start-0x17fffda4>
	...
     268:	00540001 	0x00540001
     26c:	00000000 	0x00000000
     270:	02000000 	slti	$r0,$r0,0
	...
     27c:	02000000 	slti	$r0,$r0,0
     280:	009f3400 	bstrins.d	$r0,$r0,0x1f,0xd
     284:	00000000 	0x00000000
     288:	01000000 	0x01000000
     28c:	00005d00 	ext.w.b	$r0,$r8
     290:	00000000 	0x00000000
     294:	00030000 	0x00030000
	...
     2a4:	9f300002 	0x9f300002
	...
     2b0:	005c0001 	0x005c0001
     2b4:	00000000 	0x00000000
     2b8:	01000000 	0x01000000
     2bc:	00005d00 	ext.w.b	$r0,$r8
	...
     2cc:	1c00165c 	pcaddu12i	$r28,178(0xb2)
     2d0:	1c00169c 	pcaddu12i	$r28,180(0xb4)
     2d4:	9c540001 	0x9c540001
     2d8:	e01c0016 	0xe01c0016
     2dc:	011c0016 	0x011c0016
     2e0:	16e06a00 	lu32i.d	$r0,459600(0x70350)
     2e4:	16e81c00 	lu32i.d	$r0,475360(0x740e0)
     2e8:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
     2ec:	9f5401f3 	0x9f5401f3
	...
     2fc:	1c00165c 	pcaddu12i	$r28,178(0xb2)
     300:	1c001694 	pcaddu12i	$r20,180(0xb4)
     304:	94550001 	0x94550001
     308:	dc1c0016 	0xdc1c0016
     30c:	011c0016 	0x011c0016
     310:	00006900 	rdtime.d	$r0,$r8
     314:	00000000 	0x00000000
     318:	00010000 	asrtle.d	$r0,$r0
     31c:	16940000 	lu32i.d	$r0,303104(0x4a000)
     320:	169c1c00 	lu32i.d	$r0,319712(0x4e0e0)
     324:	00021c00 	0x00021c00
     328:	169c9f30 	lu32i.d	$r16,320761(0x4e4f9)
     32c:	16d41c00 	lu32i.d	$r0,434400(0x6a0e0)
     330:	00011c00 	asrtle.d	$r0,$r7
     334:	00000067 	0x00000067
     338:	00000000 	0x00000000
     33c:	8c000000 	0x8c000000
     340:	d81c0016 	0xd81c0016
     344:	011c0016 	0x011c0016
     348:	00006800 	rdtime.d	$r0,$r0
	...
     358:	1c0015c4 	pcaddu12i	$r4,174(0xae)
     35c:	1c001608 	pcaddu12i	$r8,176(0xb0)
     360:	08540001 	fmsub.s	$f1,$f0,$f0,$f8
     364:	0c1c0016 	0x0c1c0016
     368:	011c0016 	0x011c0016
     36c:	160c5d00 	lu32i.d	$r0,25320(0x62e8)
     370:	162c1c00 	lu32i.d	$r0,90336(0x160e0)
     374:	00011c00 	asrtle.d	$r0,$r7
     378:	00000054 	0x00000054
	...
     38c:	01000000 	0x01000000
     390:	00005400 	bitrev.d	$r0,$r0
     394:	00000000 	0x00000000
     398:	00040000 	alsl.w	$r0,$r0,$r0,0x1
     39c:	9f5401f3 	0x9f5401f3
	...
     3a8:	00540001 	0x00540001
	...
     3bc:	01000000 	0x01000000
     3c0:	00005400 	bitrev.d	$r0,$r0
     3c4:	00000000 	0x00000000
     3c8:	00040000 	alsl.w	$r0,$r0,$r0,0x1
     3cc:	9f5401f3 	0x9f5401f3
	...
     3e4:	00010000 	asrtle.d	$r0,$r0
     3e8:	00000054 	0x00000054
     3ec:	00000000 	0x00000000
     3f0:	67000100 	bge	$r8,$r0,-65536(0x30000) # ffff03f0 <_edata+0x7ffef3ec>
	...
     3fc:	01f30004 	0x01f30004
     400:	00009f54 	0x00009f54
	...
     418:	00540001 	0x00540001
     41c:	00000000 	0x00000000
     420:	01000000 	0x01000000
     424:	00006800 	rdtime.d	$r0,$r0
     428:	00000000 	0x00000000
     42c:	00040000 	alsl.w	$r0,$r0,$r0,0x1
     430:	9f5401f3 	0x9f5401f3
	...
     448:	00010000 	asrtle.d	$r0,$r0
     44c:	00000055 	0x00000055
     450:	00000000 	0x00000000
     454:	67000100 	bge	$r8,$r0,-65536(0x30000) # ffff0454 <_edata+0x7ffef450>
	...
     460:	01f30004 	0x01f30004
     464:	00009f55 	0x00009f55
	...
     478:	00010000 	asrtle.d	$r0,$r0
     47c:	00000054 	0x00000054
     480:	00000000 	0x00000000
     484:	f3000400 	0xf3000400
     488:	009f5401 	bstrins.d	$r1,$r0,0x1f,0x15
	...
     49c:	01000000 	0x01000000
     4a0:	00005400 	bitrev.d	$r0,$r0
     4a4:	00000000 	0x00000000
     4a8:	00040000 	alsl.w	$r0,$r0,$r0,0x1
     4ac:	9f5401f3 	0x9f5401f3
	...
     4bc:	1c0017c4 	pcaddu12i	$r4,190(0xbe)
     4c0:	1c0017d0 	pcaddu12i	$r16,190(0xbe)
     4c4:	d0540001 	0xd0540001
     4c8:	e01c0017 	0xe01c0017
     4cc:	041c0017 	csrrd	$r23,0x700
     4d0:	5401f300 	bl	-67108368(0xc0001f0) # fc0006c0 <_edata+0x7bfff6bc>
     4d4:	0000009f 	0x0000009f
	...
     4e0:	78000000 	0x78000000
     4e4:	931c0017 	0x931c0017
     4e8:	011c0017 	0x011c0017
     4ec:	17935400 	lu32i.d	$r0,-222560(0xc9aa0)
     4f0:	17bc1c00 	lu32i.d	$r0,-139040(0xde0e0)
     4f4:	00011c00 	asrtle.d	$r0,$r7
     4f8:	0017bc67 	srl.w	$r7,$r3,$r15
     4fc:	0017c41c 	srl.w	$r28,$r0,$r17
     500:	f300041c 	0xf300041c
     504:	009f5401 	bstrins.d	$r1,$r0,0x1f,0x15
     508:	00000000 	0x00000000
     50c:	01000000 	0x01000000
     510:	00000000 	0x00000000
     514:	00178800 	srl.w	$r0,$r0,$r2
     518:	0017a01c 	srl.w	$r28,$r0,$r8
     51c:	3000021c 	0x3000021c
     520:	0017a09f 	srl.w	$r31,$r4,$r8
     524:	0017a81c 	srl.w	$r28,$r0,$r10
     528:	5400011c 	bl	74448896(0x4700000) # 4700528 <_start-0x178ffad8>
     52c:	1c0017ac 	pcaddu12i	$r12,189(0xbd)
     530:	1c0017b3 	pcaddu12i	$r19,189(0xbd)
     534:	00540001 	0x00540001
	...
     544:	38000000 	ldx.b	$r0,$r0,$r0
     548:	4b1c0017 	bceqz	$fcc0,-2155520(0x5f1c00) # ffdf2148 <_edata+0x7fdf1144>
     54c:	011c0017 	0x011c0017
     550:	174b5400 	lu32i.d	$r0,-370016(0xa5aa0)
     554:	17641c00 	lu32i.d	$r0,-319264(0xb20e0)
     558:	00011c00 	asrtle.d	$r0,$r7
     55c:	00176467 	sll.w	$r7,$r3,$r25
     560:	00176c1c 	sll.w	$r28,$r0,$r27
     564:	f300041c 	0xf300041c
     568:	6c9f5401 	bgeu	$r0,$r1,40788(0x9f54) # a4bc <_start-0x1bff5b44>
     56c:	781c0017 	0x781c0017
     570:	011c0017 	0x011c0017
     574:	00006700 	rdtimeh.w	$r0,$r24
	...
     584:	1c001708 	pcaddu12i	$r8,184(0xb8)
     588:	1c001723 	pcaddu12i	$r3,185(0xb9)
     58c:	23540001 	sc.d	$r1,$r0,21504(0x5400)
     590:	301c0017 	0x301c0017
     594:	011c0017 	0x011c0017
     598:	17306700 	lu32i.d	$r0,-425160(0x98338)
     59c:	17381c00 	lu32i.d	$r0,-409376(0x9c0e0)
     5a0:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
     5a4:	9f5401f3 	0x9f5401f3
	...
     5b0:	00000002 	0x00000002
     5b4:	1c0016e8 	pcaddu12i	$r8,183(0xb7)
     5b8:	1c0016ec 	pcaddu12i	$r12,183(0xb7)
     5bc:	9f300002 	0x9f300002
     5c0:	1c0016ec 	pcaddu12i	$r12,183(0xb7)
     5c4:	1c0016f0 	pcaddu12i	$r16,183(0xb7)
     5c8:	00540001 	0x00540001
	...
     5dc:	54000100 	bl	67108864(0x4000000) # 40005dc <_start-0x17fffa24>
	...
     5f4:	00670001 	bstrins.w	$r1,$r0,0x7,0x0
     5f8:	00000000 	0x00000000
     5fc:	01000000 	0x01000000
     600:	00006700 	rdtimeh.w	$r0,$r24
	...
     614:	00010000 	asrtle.d	$r0,$r0
     618:	00000054 	0x00000054
     61c:	00000000 	0x00000000
     620:	54000100 	bl	67108864(0x4000000) # 4000620 <_start-0x17fff9e0>
	...
     638:	00540001 	0x00540001
     63c:	00000000 	0x00000000
     640:	01000000 	0x01000000
     644:	00005400 	bitrev.d	$r0,$r0
	...
     658:	00540001 	0x00540001
	...
     664:	00197c00 	srl.d	$r0,$r0,$r31
     668:	0019b81c 	sra.d	$r28,$r0,$r14
     66c:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 1066c <_start-0x1bfef994>
	...
     67c:	1c001948 	pcaddu12i	$r8,202(0xca)
     680:	1c00194c 	pcaddu12i	$r12,202(0xca)
     684:	4c540001 	jirl	$r1,$r0,21504(0x5400)
     688:	5c1c0019 	bne	$r0,$r25,7168(0x1c00) # 2288 <_start-0x1bffdd78>
     68c:	041c0019 	csrrd	$r25,0x700
     690:	5401f300 	bl	-67108368(0xc0001f0) # fc000880 <_edata+0x7bfff87c>
     694:	0000009f 	0x0000009f
	...
     6a8:	54000100 	bl	67108864(0x4000000) # 40006a8 <_start-0x17fff958>
	...
     6b4:	00670001 	bstrins.w	$r1,$r0,0x7,0x0
     6b8:	00000000 	0x00000000
     6bc:	02000000 	slti	$r0,$r0,0
     6c0:	00000000 	0x00000000
     6c4:	0018fc00 	sll.d	$r0,$r0,$r31
     6c8:	0019001c 	srl.d	$r28,$r0,$r0
     6cc:	3000021c 	0x3000021c
     6d0:	0019009f 	srl.d	$r31,$r4,$r0
     6d4:	00192c1c 	srl.d	$r28,$r0,$r11
     6d8:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 106d8 <_start-0x1bfef928>
     6dc:	1c00193c 	pcaddu12i	$r28,201(0xc9)
     6e0:	1c001948 	pcaddu12i	$r8,202(0xca)
     6e4:	005d0001 	0x005d0001
	...
     6f0:	00182400 	sra.w	$r0,$r0,$r9
     6f4:	0018281c 	sra.w	$r28,$r0,$r10
     6f8:	5c00011c 	bne	$r8,$r28,0 # 6f8 <_start-0x1bfff908>
	...
     704:	188c0000 	pcaddi	$r0,286720(0x46000)
     708:	18fc1c00 	pcaddi	$r0,516320(0x7e0e0)
     70c:	00011c00 	asrtle.d	$r0,$r7
     710:	0000005e 	0x0000005e
	...
     71c:	8c000000 	0x8c000000
     720:	981c0018 	0x981c0018
     724:	011c0018 	0x011c0018
     728:	18a45d00 	pcaddi	$r0,336616(0x522e8)
     72c:	18cc1c00 	pcaddi	$r0,418016(0x660e0)
     730:	00011c00 	asrtle.d	$r0,$r7
     734:	0018d05d 	sll.d	$r29,$r2,$r20
     738:	0018fc1c 	sll.d	$r28,$r0,$r31
     73c:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 1073c <_start-0x1bfef8c4>
	...
     74c:	1c0019c8 	pcaddu12i	$r8,206(0xce)
     750:	1c0019d4 	pcaddu12i	$r20,206(0xce)
     754:	d4540001 	0xd4540001
     758:	e81c0019 	0xe81c0019
     75c:	041c0019 	csrrd	$r25,0x700
     760:	5401f300 	bl	-67108368(0xc0001f0) # fc000950 <_edata+0x7bfff94c>
     764:	0000009f 	0x0000009f
	...
     770:	20000000 	ll.w	$r0,$r0,0
     774:	601c0027 	blt	$r1,$r7,7168(0x1c00) # 2374 <_start-0x1bffdc8c>
     778:	011c0027 	0x011c0027
     77c:	27605400 	stptr.d	$r0,$r0,24660(0x6054)
     780:	27631c00 	stptr.d	$r0,$r0,25372(0x631c)
     784:	00011c00 	asrtle.d	$r0,$r7
     788:	00276357 	crcc.w.w.w	$r23,$r26,$r24
     78c:	0027701c 	crcc.w.w.w	$r28,$r0,$r28
     790:	f300041c 	0xf300041c
     794:	009f5401 	bstrins.d	$r1,$r0,0x1f,0x15
	...
     7a0:	00276400 	crcc.w.w.w	$r0,$r0,$r25
     7a4:	0027701c 	crcc.w.w.w	$r28,$r0,$r28
     7a8:	5400011c 	bl	74448896(0x4700000) # 47007a8 <_start-0x178ff858>
	...
     7bc:	1f3c0000 	pcaddu18i	$r0,-401408(0x9e000)
     7c0:	1f881c00 	pcaddu18i	$r0,-245536(0xc40e0)
     7c4:	00011c00 	asrtle.d	$r0,$r7
     7c8:	001f8854 	mulw.d.wu	$r20,$r2,$r2
     7cc:	00269c1c 	crcc.w.h.w	$r28,$r0,$r7
     7d0:	6a00011c 	bltu	$r8,$r28,-131072(0x20000) # fffe07d0 <_edata+0x7ffdf7cc>
     7d4:	1c00269c 	pcaddu12i	$r28,308(0x134)
     7d8:	1c0026a8 	pcaddu12i	$r8,309(0x135)
     7dc:	a8540001 	0xa8540001
     7e0:	dc1c0026 	0xdc1c0026
     7e4:	011c0026 	0x011c0026
     7e8:	26f86a00 	ldptr.d	$r0,$r16,-1944(0xf868)
     7ec:	27001c00 	stptr.d	$r0,$r0,28(0x1c)
     7f0:	00011c00 	asrtle.d	$r0,$r7
     7f4:	0000006a 	0x0000006a
	...
     808:	001f3c00 	mulw.d.w	$r0,$r0,$r15
     80c:	001f881c 	mulw.d.wu	$r28,$r0,$r2
     810:	5500011c 	bl	74514432(0x4710000) # 4710810 <_start-0x178ef7f0>
     814:	1c001f88 	pcaddu12i	$r8,252(0xfc)
     818:	1c00269c 	pcaddu12i	$r28,308(0x134)
     81c:	9c690001 	0x9c690001
     820:	a81c0026 	0xa81c0026
     824:	011c0026 	0x011c0026
     828:	26a85500 	ldptr.d	$r0,$r8,-22444(0xa854)
     82c:	26d81c00 	ldptr.d	$r0,$r0,-10212(0xd81c)
     830:	00011c00 	asrtle.d	$r0,$r7
     834:	0026d869 	crcc.w.h.w	$r9,$r3,$r22
     838:	0026f81c 	crcc.w.h.w	$r28,$r0,$r30
     83c:	f300041c 	0xf300041c
     840:	f89f5501 	0xf89f5501
     844:	001c0026 	mul.w	$r6,$r1,$r0
     848:	011c0027 	0x011c0027
     84c:	00006900 	rdtime.d	$r0,$r8
	...
     860:	1f3c0000 	pcaddu18i	$r0,-401408(0x9e000)
     864:	1f881c00 	pcaddu18i	$r0,-245536(0xc40e0)
     868:	00011c00 	asrtle.d	$r0,$r7
     86c:	001f8856 	mulw.d.wu	$r22,$r2,$r2
     870:	00269c1c 	crcc.w.h.w	$r28,$r0,$r7
     874:	6800011c 	bltu	$r8,$r28,0 # 874 <_start-0x1bfff78c>
     878:	1c00269c 	pcaddu12i	$r28,308(0x134)
     87c:	1c0026a8 	pcaddu12i	$r8,309(0x135)
     880:	a8560001 	0xa8560001
     884:	d41c0026 	0xd41c0026
     888:	011c0026 	0x011c0026
     88c:	26d46800 	ldptr.d	$r0,$r0,-11160(0xd468)
     890:	26f81c00 	ldptr.d	$r0,$r0,-2020(0xf81c)
     894:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
     898:	9f5601f3 	0x9f5601f3
     89c:	1c0026f8 	pcaddu12i	$r24,311(0x137)
     8a0:	1c002700 	pcaddu12i	$r0,312(0x138)
     8a4:	00680001 	bstrins.w	$r1,$r0,0x8,0x0
	...
     8b0:	3c000000 	0x3c000000
     8b4:	881c001f 	0x881c001f
     8b8:	011c001f 	0x011c001f
     8bc:	269c5700 	ldptr.d	$r0,$r24,-25516(0x9c54)
     8c0:	26a81c00 	ldptr.d	$r0,$r0,-22500(0xa81c)
     8c4:	00011c00 	asrtle.d	$r0,$r7
     8c8:	00000057 	0x00000057
	...
     8d4:	001f3c00 	mulw.d.w	$r0,$r0,$r15
     8d8:	001f881c 	mulw.d.wu	$r28,$r0,$r2
     8dc:	5800011c 	beq	$r8,$r28,0 # 8dc <_start-0x1bfff724>
     8e0:	1c00269c 	pcaddu12i	$r28,308(0x134)
     8e4:	1c0026a8 	pcaddu12i	$r8,309(0x135)
     8e8:	00580001 	0x00580001
     8ec:	00000000 	0x00000000
     8f0:	01000000 	0x01000000
	...
     904:	cc000000 	0xcc000000
     908:	d41c001f 	0xd41c001f
     90c:	021c001f 	slti	$r31,$r0,1792(0x700)
     910:	d49f3000 	0xd49f3000
     914:	681c001f 	bltu	$r0,$r31,7168(0x1c00) # 2514 <_start-0x1bffdaec>
     918:	011c0021 	0x011c0021
     91c:	21686e00 	sc.w	$r0,$r16,26732(0x686c)
     920:	21841c00 	sc.w	$r0,$r0,-31716(0x841c)
     924:	00011c00 	asrtle.d	$r0,$r7
     928:	0021845f 	mod.wu	$r31,$r2,$r1
     92c:	0021881c 	mod.wu	$r28,$r0,$r2
     930:	6e00011c 	bgeu	$r8,$r28,-131072(0x20000) # fffe0930 <_edata+0x7ffdf92c>
     934:	1c002188 	pcaddu12i	$r8,268(0x10c)
     938:	1c0021a8 	pcaddu12i	$r8,269(0x10d)
     93c:	a85f0001 	0xa85f0001
     940:	b41c0021 	0xb41c0021
     944:	011c0021 	0x011c0021
     948:	21b46e00 	sc.w	$r0,$r16,-19348(0xb46c)
     94c:	21b81c00 	sc.w	$r0,$r0,-18404(0xb81c)
     950:	00011c00 	asrtle.d	$r0,$r7
     954:	0021b85f 	mod.wu	$r31,$r2,$r14
     958:	0024381c 	crc.w.b.w	$r28,$r0,$r14
     95c:	6e00011c 	bgeu	$r8,$r28,-131072(0x20000) # fffe095c <_edata+0x7ffdf958>
     960:	1c0024dc 	pcaddu12i	$r28,294(0x126)
     964:	1c002548 	pcaddu12i	$r8,298(0x12a)
     968:	f46e0001 	0xf46e0001
     96c:	9c1c0025 	0x9c1c0025
     970:	011c0026 	0x011c0026
     974:	00006e00 	cpucfg	$r0,$r16
     978:	00000000 	0x00000000
     97c:	00010000 	asrtle.d	$r0,$r0
	...
     98c:	00020200 	0x00020200
     990:	1fd40000 	pcaddu18i	$r0,-90112(0xea000)
     994:	1ff01c00 	pcaddu18i	$r0,-32544(0xf80e0)
     998:	00021c00 	0x00021c00
     99c:	1ff09f30 	pcaddu18i	$r16,-31495(0xf84f9)
     9a0:	20381c00 	ll.w	$r0,$r0,14364(0x381c)
     9a4:	00011c00 	asrtle.d	$r0,$r7
     9a8:	0020b06f 	mod.w	$r15,$r3,$r12
     9ac:	0020bc1c 	mod.w	$r28,$r0,$r15
     9b0:	3000021c 	0x3000021c
     9b4:	0020bc9f 	mod.w	$r31,$r4,$r15
     9b8:	0020c01c 	mod.w	$r28,$r0,$r16
     9bc:	5400011c 	bl	74448896(0x4700000) # 47009bc <_start-0x178ff644>
     9c0:	1c0020c0 	pcaddu12i	$r0,262(0x106)
     9c4:	1c0020d4 	pcaddu12i	$r20,262(0x106)
     9c8:	9f300002 	0x9f300002
     9cc:	1c0020d4 	pcaddu12i	$r20,262(0x106)
     9d0:	1c0020e4 	pcaddu12i	$r4,263(0x107)
     9d4:	e46f0001 	0xe46f0001
     9d8:	ec1c0020 	0xec1c0020
     9dc:	021c0020 	slti	$r0,$r1,1792(0x700)
     9e0:	ec9f3000 	0xec9f3000
     9e4:	f41c0020 	0xf41c0020
     9e8:	011c0025 	0x011c0025
     9ec:	25f46f00 	stptr.w	$r0,$r24,-2964(0xf46c)
     9f0:	26481c00 	ldptr.d	$r0,$r0,18460(0x481c)
     9f4:	00021c00 	0x00021c00
     9f8:	26489f38 	ldptr.d	$r24,$r25,18588(0x489c)
     9fc:	269c1c00 	ldptr.d	$r0,$r0,-25572(0x9c1c)
     a00:	00011c00 	asrtle.d	$r0,$r7
     a04:	0000006f 	0x0000006f
     a08:	00000000 	0x00000000
     a0c:	00000100 	0x00000100
	...
     a28:	001ff000 	mulw.d.wu	$r0,$r0,$r28
     a2c:	0020041c 	div.w	$r28,$r0,$r1
     a30:	3000021c 	0x3000021c
     a34:	0020049f 	div.w	$r31,$r4,$r1
     a38:	0020381c 	div.w	$r28,$r0,$r14
     a3c:	6d00011c 	bgeu	$r8,$r28,65536(0x10000) # 10a3c <_start-0x1bfef5c4>
     a40:	1c0020f0 	pcaddu12i	$r16,263(0x107)
     a44:	1c00212c 	pcaddu12i	$r12,265(0x109)
     a48:	9f300002 	0x9f300002
     a4c:	1c00212c 	pcaddu12i	$r12,265(0x109)
     a50:	1c002130 	pcaddu12i	$r16,265(0x109)
     a54:	30540001 	vldrepl.h	$vr1,$r0,-1536(0xa00)
     a58:	441c0021 	bnez	$r1,269312(0x41c00) # 42658 <_start-0x1bfbd9a8>
     a5c:	021c0021 	slti	$r1,$r1,1792(0x700)
     a60:	449f3000 	bnez	$r0,40752(0x9f30) # a990 <_start-0x1bff5670>
     a64:	541c0021 	bl	8657920(0x841c00) # 842664 <_start-0x1b7bd99c>
     a68:	011c0021 	0x011c0021
     a6c:	21546d00 	sc.w	$r0,$r8,21612(0x546c)
     a70:	215c1c00 	sc.w	$r0,$r0,23580(0x5c1c)
     a74:	00021c00 	0x00021c00
     a78:	215c9f30 	sc.w	$r16,$r25,23708(0x5c9c)
     a7c:	24681c00 	ldptr.w	$r0,$r0,26652(0x681c)
     a80:	00011c00 	asrtle.d	$r0,$r7
     a84:	00247c6d 	crc.w.b.w	$r13,$r3,$r31
     a88:	0024b01c 	crc.w.h.w	$r28,$r0,$r12
     a8c:	6d00011c 	bgeu	$r8,$r28,65536(0x10000) # 10a8c <_start-0x1bfef574>
     a90:	1c0024dc 	pcaddu12i	$r28,294(0x126)
     a94:	1c00257c 	pcaddu12i	$r28,299(0x12b)
     a98:	7c6d0001 	0x7c6d0001
     a9c:	801c0025 	0x801c0025
     aa0:	011c0025 	0x011c0025
     aa4:	25805c00 	stptr.w	$r0,$r0,-32676(0x805c)
     aa8:	25ac1c00 	stptr.w	$r0,$r0,-21476(0xac1c)
     aac:	00011c00 	asrtle.d	$r0,$r7
     ab0:	0025ac6d 	crc.w.d.w	$r13,$r3,$r11
     ab4:	0025b01c 	crc.w.d.w	$r28,$r0,$r12
     ab8:	5c00011c 	bne	$r8,$r28,0 # ab8 <_start-0x1bfff548>
     abc:	1c0025f4 	pcaddu12i	$r20,303(0x12f)
     ac0:	1c00269c 	pcaddu12i	$r28,308(0x134)
     ac4:	006d0001 	bstrins.w	$r1,$r0,0xd,0x0
	...
     ad0:	01020100 	0x01020100
     ad4:	01000100 	0x01000100
     ad8:	00000100 	0x00000100
     adc:	001fd400 	mulw.d.wu	$r0,$r0,$r21
     ae0:	0020381c 	div.w	$r28,$r0,$r14
     ae4:	3000021c 	0x3000021c
     ae8:	0020449f 	div.w	$r31,$r4,$r17
     aec:	0020441c 	div.w	$r28,$r0,$r17
     af0:	3100021c 	0x3100021c
     af4:	00207c9f 	div.w	$r31,$r4,$r31
     af8:	0020801c 	mod.w	$r28,$r0,$r0
     afc:	3100021c 	0x3100021c
     b00:	00208c9f 	mod.w	$r31,$r4,$r3
     b04:	0020901c 	mod.w	$r28,$r0,$r4
     b08:	3100021c 	0x3100021c
     b0c:	00209c9f 	mod.w	$r31,$r4,$r7
     b10:	0020a01c 	mod.w	$r28,$r0,$r8
     b14:	3100021c 	0x3100021c
     b18:	0020ac9f 	mod.w	$r31,$r4,$r11
     b1c:	0020b01c 	mod.w	$r28,$r0,$r12
     b20:	3100021c 	0x3100021c
     b24:	0020b09f 	mod.w	$r31,$r4,$r12
     b28:	00269c1c 	crcc.w.h.w	$r28,$r0,$r7
     b2c:	3000021c 	0x3000021c
     b30:	0000009f 	0x0000009f
     b34:	00000000 	0x00000000
     b38:	00000200 	0x00000200
	...
     b7c:	001f8000 	mulw.d.wu	$r0,$r0,$r0
     b80:	001f881c 	mulw.d.wu	$r28,$r0,$r2
     b84:	3000021c 	0x3000021c
     b88:	001f889f 	mulw.d.wu	$r31,$r4,$r2
     b8c:	001fa01c 	mulw.d.wu	$r28,$r0,$r8
     b90:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0b90 <_edata+0x7ffefb8c>
     b94:	1c001fa0 	pcaddu12i	$r0,253(0xfd)
     b98:	1c001fc4 	pcaddu12i	$r4,254(0xfe)
     b9c:	c46b0001 	0xc46b0001
     ba0:	c01c001f 	0xc01c001f
     ba4:	011c0022 	0x011c0022
     ba8:	22c06700 	ll.d	$r0,$r24,-16284(0xc064)
     bac:	22c41c00 	ll.d	$r0,$r0,-15332(0xc41c)
     bb0:	00011c00 	asrtle.d	$r0,$r7
     bb4:	0022c454 	mod.d	$r20,$r2,$r17
     bb8:	0023941c 	mod.du	$r28,$r0,$r5
     bbc:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0bbc <_edata+0x7ffefbb8>
     bc0:	1c002394 	pcaddu12i	$r20,284(0x11c)
     bc4:	1c002398 	pcaddu12i	$r24,284(0x11c)
     bc8:	98540001 	0x98540001
     bcc:	001c0023 	mul.w	$r3,$r1,$r0
     bd0:	011c0024 	0x011c0024
     bd4:	24006700 	ldptr.w	$r0,$r24,100(0x64)
     bd8:	24041c00 	ldptr.w	$r0,$r0,1052(0x41c)
     bdc:	00011c00 	asrtle.d	$r0,$r7
     be0:	00240454 	crc.w.b.w	$r20,$r2,$r1
     be4:	0024501c 	crc.w.b.w	$r28,$r0,$r20
     be8:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0be8 <_edata+0x7ffefbe4>
     bec:	1c002450 	pcaddu12i	$r16,290(0x122)
     bf0:	1c00247c 	pcaddu12i	$r28,291(0x123)
     bf4:	7c6c0001 	0x7c6c0001
     bf8:	801c0024 	0x801c0024
     bfc:	011c0024 	0x011c0024
     c00:	24806700 	ldptr.w	$r0,$r24,-32668(0x8064)
     c04:	249c1c00 	ldptr.w	$r0,$r0,-25572(0x9c1c)
     c08:	00011c00 	asrtle.d	$r0,$r7
     c0c:	00249c6c 	crc.w.h.w	$r12,$r3,$r7
     c10:	0024b01c 	crc.w.h.w	$r28,$r0,$r12
     c14:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0c14 <_edata+0x7ffefc10>
     c18:	1c0024b0 	pcaddu12i	$r16,293(0x125)
     c1c:	1c0024b4 	pcaddu12i	$r20,293(0x125)
     c20:	b46c0001 	0xb46c0001
     c24:	d01c0024 	0xd01c0024
     c28:	011c0024 	0x011c0024
     c2c:	24d06d00 	ldptr.w	$r0,$r8,-12180(0xd06c)
     c30:	24dc1c00 	ldptr.w	$r0,$r0,-9188(0xdc1c)
     c34:	00011c00 	asrtle.d	$r0,$r7
     c38:	0024dc6c 	crc.w.h.w	$r12,$r3,$r23
     c3c:	0025501c 	crc.w.w.w	$r28,$r0,$r20
     c40:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0c40 <_edata+0x7ffefc3c>
     c44:	1c002550 	pcaddu12i	$r16,298(0x12a)
     c48:	1c002563 	pcaddu12i	$r3,299(0x12b)
     c4c:	635c0001 	blt	$r0,$r1,-41984(0x35c00) # ffff684c <_edata+0x7fff5848>
     c50:	6c1c0025 	bgeu	$r1,$r5,7168(0x1c00) # 2850 <_start-0x1bffd7b0>
     c54:	021c0025 	slti	$r5,$r1,1792(0x700)
     c58:	6c409100 	bgeu	$r8,$r0,16528(0x4090) # 4ce8 <_start-0x1bffb318>
     c5c:	881c0025 	0x881c0025
     c60:	011c0025 	0x011c0025
     c64:	25886700 	stptr.w	$r0,$r24,-30620(0x8864)
     c68:	259c1c00 	stptr.w	$r0,$r0,-25572(0x9c1c)
     c6c:	00011c00 	asrtle.d	$r0,$r7
     c70:	00259c6e 	crc.w.d.w	$r14,$r3,$r7
     c74:	0025cc1c 	crc.w.d.w	$r28,$r0,$r19
     c78:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0c78 <_edata+0x7ffefc74>
     c7c:	1c0025cc 	pcaddu12i	$r12,302(0x12e)
     c80:	1c0025e8 	pcaddu12i	$r8,303(0x12f)
     c84:	e86d0001 	0xe86d0001
     c88:	381c0025 	stx.d	$r5,$r1,$r0
     c8c:	011c0026 	0x011c0026
     c90:	26386700 	ldptr.d	$r0,$r24,14436(0x3864)
     c94:	26481c00 	ldptr.d	$r0,$r0,18460(0x481c)
     c98:	00011c00 	asrtle.d	$r0,$r7
     c9c:	00264854 	crcc.w.b.w	$r20,$r2,$r18
     ca0:	00264c1c 	crcc.w.b.w	$r28,$r0,$r19
     ca4:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0ca4 <_edata+0x7ffefca0>
     ca8:	1c00264c 	pcaddu12i	$r12,306(0x132)
     cac:	1c002674 	pcaddu12i	$r20,307(0x133)
     cb0:	746b0001 	xvavgr.wu	$xr1,$xr0,$xr0
     cb4:	781c0026 	0x781c0026
     cb8:	011c0026 	0x011c0026
     cbc:	26786700 	ldptr.d	$r0,$r24,30820(0x7864)
     cc0:	269c1c00 	ldptr.d	$r0,$r0,-25572(0x9c1c)
     cc4:	00011c00 	asrtle.d	$r0,$r7
     cc8:	00269c6b 	crcc.w.h.w	$r11,$r3,$r7
     ccc:	0026a81c 	crcc.w.h.w	$r28,$r0,$r10
     cd0:	3000021c 	0x3000021c
     cd4:	0026a89f 	crcc.w.h.w	$r31,$r4,$r10
     cd8:	0026d01c 	crcc.w.h.w	$r28,$r0,$r20
     cdc:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0cdc <_edata+0x7ffefcd8>
     ce0:	1c0026d0 	pcaddu12i	$r16,310(0x136)
     ce4:	1c0026f8 	pcaddu12i	$r24,311(0x137)
     ce8:	f8540001 	0xf8540001
     cec:	001c0026 	mul.w	$r6,$r1,$r0
     cf0:	011c0027 	0x011c0027
     cf4:	00006700 	rdtimeh.w	$r0,$r24
     cf8:	00000000 	0x00000000
     cfc:	00010000 	asrtle.d	$r0,$r0
	...
     d08:	221c0000 	ll.d	$r0,$r0,7168(0x1c00)
     d0c:	222c1c00 	ll.d	$r0,$r0,11292(0x2c1c)
     d10:	00021c00 	0x00021c00
     d14:	22309f3a 	ll.d	$r26,$r25,12444(0x309c)
     d18:	22bb1c00 	ll.d	$r0,$r0,-17636(0xbb1c)
     d1c:	00011c00 	asrtle.d	$r0,$r7
     d20:	0022dc5a 	mod.d	$r26,$r2,$r23
     d24:	00233b1c 	div.du	$r28,$r24,$r14
     d28:	5a00011c 	beq	$r8,$r28,-131072(0x20000) # fffe0d28 <_edata+0x7ffdfd24>
     d2c:	1c002350 	pcaddu12i	$r16,282(0x11a)
     d30:	1c00238f 	pcaddu12i	$r15,284(0x11c)
     d34:	985a0001 	0x985a0001
     d38:	fb1c0023 	0xfb1c0023
     d3c:	011c0023 	0x011c0023
     d40:	24045a00 	ldptr.w	$r0,$r16,1112(0x458)
     d44:	24341c00 	ldptr.w	$r0,$r0,13340(0x341c)
     d48:	00011c00 	asrtle.d	$r0,$r7
     d4c:	0000005a 	0x0000005a
     d50:	00000000 	0x00000000
     d54:	0c000000 	0x0c000000
     d58:	241c0023 	ldptr.w	$r3,$r1,7168(0x1c00)
     d5c:	011c0023 	0x011c0023
     d60:	00005900 	ext.w.h	$r0,$r8
	...
     d6c:	1c002298 	pcaddu12i	$r24,276(0x114)
     d70:	1c0022bb 	pcaddu12i	$r27,277(0x115)
     d74:	00580001 	0x00580001
     d78:	00000000 	0x00000000
     d7c:	02000000 	slti	$r0,$r0,0
	...
     d90:	00243400 	crc.w.b.w	$r0,$r0,$r13
     d94:	0024401c 	crc.w.b.w	$r28,$r0,$r16
     d98:	3100021c 	0x3100021c
     d9c:	0024409f 	crc.w.b.w	$r31,$r4,$r16
     da0:	0024681c 	crc.w.b.w	$r28,$r0,$r26
     da4:	6b00011c 	bltu	$r8,$r28,-65536(0x30000) # ffff0da4 <_edata+0x7ffefda0>
     da8:	1c00247c 	pcaddu12i	$r28,291(0x123)
     dac:	1c00249c 	pcaddu12i	$r28,292(0x124)
     db0:	9c6b0001 	0x9c6b0001
     db4:	a01c0024 	0xa01c0024
     db8:	011c0024 	0x011c0024
     dbc:	24a05c00 	ldptr.w	$r0,$r0,-24484(0xa05c)
     dc0:	24a81c00 	ldptr.w	$r0,$r0,-22500(0xa81c)
     dc4:	00011c00 	asrtle.d	$r0,$r7
     dc8:	0024a86b 	crc.w.h.w	$r11,$r3,$r10
     dcc:	0024b01c 	crc.w.h.w	$r28,$r0,$r12
     dd0:	3100021c 	0x3100021c
     dd4:	0024b09f 	crc.w.h.w	$r31,$r4,$r12
     dd8:	0024d01c 	crc.w.h.w	$r28,$r0,$r20
     ddc:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff0ddc <_edata+0x7ffefdd8>
     de0:	1c0024d0 	pcaddu12i	$r16,294(0x126)
     de4:	1c0024d4 	pcaddu12i	$r20,294(0x126)
     de8:	d46b0001 	0xd46b0001
     dec:	dc1c0024 	0xdc1c0024
     df0:	011c0024 	0x011c0024
     df4:	00006700 	rdtimeh.w	$r0,$r24
	...
     e00:	1c00257c 	pcaddu12i	$r28,299(0x12b)
     e04:	1c0025b8 	pcaddu12i	$r24,301(0x12d)
     e08:	006c0001 	bstrins.w	$r1,$r0,0xc,0x0
	...
     e24:	00252000 	crc.w.w.w	$r0,$r0,$r8
     e28:	0025301c 	crc.w.w.w	$r28,$r0,$r12
     e2c:	6b00011c 	bltu	$r8,$r28,-65536(0x30000) # ffff0e2c <_edata+0x7ffefe28>
     e30:	1c002538 	pcaddu12i	$r24,297(0x129)
     e34:	1c002548 	pcaddu12i	$r8,298(0x12a)
     e38:	486b0001 	bceqz	$fcc0,289536(0x46b00) # 47938 <_start-0x1bfb86c8>
     e3c:	6c1c0025 	bgeu	$r1,$r5,7168(0x1c00) # 2a3c <_start-0x1bffd5c4>
     e40:	011c0025 	0x011c0025
     e44:	256c6e00 	stptr.w	$r0,$r16,27756(0x6c6c)
     e48:	25701c00 	stptr.w	$r0,$r0,28700(0x701c)
     e4c:	00011c00 	asrtle.d	$r0,$r7
     e50:	0025706b 	crc.w.w.w	$r11,$r3,$r28
     e54:	00257c1c 	crc.w.w.w	$r28,$r0,$r31
     e58:	6e00011c 	bgeu	$r8,$r28,-131072(0x20000) # fffe0e58 <_edata+0x7ffdfe54>
     e5c:	1c00257c 	pcaddu12i	$r28,299(0x12b)
     e60:	1c0025b8 	pcaddu12i	$r24,301(0x12d)
     e64:	c86b0001 	0xc86b0001
     e68:	e81c0025 	0xe81c0025
     e6c:	011c0025 	0x011c0025
     e70:	25e86c00 	stptr.w	$r0,$r0,-6036(0xe86c)
     e74:	25ec1c00 	stptr.w	$r0,$r0,-5092(0xec1c)
     e78:	00011c00 	asrtle.d	$r0,$r7
     e7c:	0025ec6b 	crc.w.d.w	$r11,$r3,$r27
     e80:	0025f41c 	crc.w.d.w	$r28,$r0,$r29
     e84:	6c00011c 	bgeu	$r8,$r28,0 # e84 <_start-0x1bfff17c>
	...
     e94:	1c0024f8 	pcaddu12i	$r24,295(0x127)
     e98:	1c002504 	pcaddu12i	$r4,296(0x128)
     e9c:	045c0001 	csrrd	$r1,0x1700
     ea0:	141c0025 	lu12i.w	$r5,57345(0xe001)
     ea4:	011c0025 	0x011c0025
     ea8:	00005d00 	ext.w.b	$r0,$r8
	...
     eb4:	24f80000 	ldptr.w	$r0,$r0,-2048(0xf800)
     eb8:	25141c00 	stptr.w	$r0,$r0,5148(0x141c)
     ebc:	00011c00 	asrtle.d	$r0,$r7
     ec0:	00251c6b 	crc.w.w.w	$r11,$r3,$r7
     ec4:	0025201c 	crc.w.w.w	$r28,$r0,$r8
     ec8:	6b00011c 	bltu	$r8,$r28,-65536(0x30000) # ffff0ec8 <_edata+0x7ffefec4>
	...
     ed4:	1fd40002 	pcaddu18i	$r2,-90112(0xea000)
     ed8:	1fdc1c00 	pcaddu18i	$r0,-73504(0xee0e0)
     edc:	00011c00 	asrtle.d	$r0,$r7
     ee0:	0000005e 	0x0000005e
	...
     eec:	081c0021 	fmadd.s	$f1,$f1,$f0,$f24
     ef0:	011c0021 	0x011c0021
     ef4:	00005d00 	ext.w.b	$r0,$r8
	...
     f00:	1cfc0000 	pcaddu12i	$r0,516096(0x7e000)
     f04:	1f2f1c00 	pcaddu18i	$r0,-427808(0x978e0)
     f08:	00011c00 	asrtle.d	$r0,$r7
     f0c:	001f2f54 	mulw.d.w	$r20,$r26,$r11
     f10:	001f3c1c 	mulw.d.w	$r28,$r0,$r15
     f14:	f300041c 	0xf300041c
     f18:	009f5401 	bstrins.d	$r1,$r0,0x1f,0x15
	...
     f24:	fc000000 	0xfc000000
     f28:	2f1c001c 	0x2f1c001c
     f2c:	011c001f 	0x011c001f
     f30:	1f2f5500 	pcaddu18i	$r0,-427352(0x97aa8)
     f34:	1f3c1c00 	pcaddu18i	$r0,-401184(0x9e0e0)
     f38:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
     f3c:	9f5501f3 	0x9f5501f3
	...
     f4c:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
     f50:	1c001f2f 	pcaddu12i	$r15,249(0xf9)
     f54:	2f560001 	0x2f560001
     f58:	3c1c001f 	0x3c1c001f
     f5c:	041c001f 	csrrd	$r31,0x700
     f60:	5601f300 	bl	-66977296(0xc0201f0) # fc021150 <_edata+0x7c02014c>
     f64:	0000009f 	0x0000009f
	...
     f70:	001cfc00 	mulh.w	$r0,$r0,$r31
     f74:	001f2f1c 	mulw.d.w	$r28,$r24,$r11
     f78:	5700011c 	bl	74645504(0x4730000) # 4730f78 <_start-0x178cf088>
     f7c:	1c001f2f 	pcaddu12i	$r15,249(0xf9)
     f80:	1c001f3c 	pcaddu12i	$r28,249(0xf9)
     f84:	01f30004 	0x01f30004
     f88:	00009f57 	0x00009f57
	...
     fa8:	1cfc0000 	pcaddu12i	$r0,516096(0x7e000)
     fac:	1d501c00 	pcaddu12i	$r0,-360224(0xa80e0)
     fb0:	00011c00 	asrtle.d	$r0,$r7
     fb4:	001d5058 	mulh.wu	$r24,$r2,$r20
     fb8:	001d781c 	mulh.wu	$r28,$r0,$r30
     fbc:	6000011c 	blt	$r8,$r28,0 # fbc <_start-0x1bfff044>
     fc0:	1c001d78 	pcaddu12i	$r24,235(0xeb)
     fc4:	1c001da0 	pcaddu12i	$r0,237(0xed)
     fc8:	a0580001 	0xa0580001
     fcc:	c81c001d 	0xc81c001d
     fd0:	011c001d 	0x011c001d
     fd4:	1dc86300 	pcaddu12i	$r0,-113896(0xe4318)
     fd8:	1dd41c00 	pcaddu12i	$r0,-89888(0xea0e0)
     fdc:	00011c00 	asrtle.d	$r0,$r7
     fe0:	001dd460 	mul.d	$r0,$r3,$r21
     fe4:	001e381c 	mulh.d	$r28,$r0,$r14
     fe8:	5800011c 	beq	$r8,$r28,0 # fe8 <_start-0x1bfff018>
     fec:	1c001e38 	pcaddu12i	$r24,241(0xf1)
     ff0:	1c001e68 	pcaddu12i	$r8,243(0xf3)
     ff4:	68600001 	bltu	$r0,$r1,24576(0x6000) # 6ff4 <_start-0x1bff900c>
     ff8:	981c001e 	0x981c001e
     ffc:	011c001e 	0x011c001e
    1000:	1e985800 	pcaddu18i	$r0,312000(0x4c2c0)
    1004:	1ec81c00 	pcaddu18i	$r0,409824(0x640e0)
    1008:	00011c00 	asrtle.d	$r0,$r7
    100c:	001ec863 	mulh.du	$r3,$r3,$r18
    1010:	001ed81c 	mulh.du	$r28,$r0,$r22
    1014:	5800011c 	beq	$r8,$r28,0 # 1014 <_start-0x1bffefec>
    1018:	1c001ed8 	pcaddu12i	$r24,246(0xf6)
    101c:	1c001ee4 	pcaddu12i	$r4,247(0xf7)
    1020:	e4630001 	0xe4630001
    1024:	2c1c001e 	vld	$vr30,$r0,1792(0x700)
    1028:	011c001f 	0x011c001f
    102c:	00005800 	ext.w.h	$r0,$r0
	...
    1038:	1cfc0000 	pcaddu12i	$r0,516096(0x7e000)
    103c:	1f281c00 	pcaddu18i	$r0,-442144(0x940e0)
    1040:	00011c00 	asrtle.d	$r0,$r7
    1044:	001f2859 	mulw.d.w	$r25,$r2,$r10
    1048:	001f3c1c 	mulw.d.w	$r28,$r0,$r15
    104c:	f300041c 	0xf300041c
    1050:	009f5901 	bstrins.d	$r1,$r8,0x1f,0x16
	...
    1060:	001cfc00 	mulh.w	$r0,$r0,$r31
    1064:	001f241c 	mulw.d.w	$r28,$r0,$r9
    1068:	5a00011c 	beq	$r8,$r28,-131072(0x20000) # fffe1068 <_edata+0x7ffe0064>
    106c:	1c001f24 	pcaddu12i	$r4,249(0xf9)
    1070:	1c001f2f 	pcaddu12i	$r15,249(0xf9)
    1074:	2f5b0001 	0x2f5b0001
    1078:	3c1c001f 	0x3c1c001f
    107c:	041c001f 	csrrd	$r31,0x700
    1080:	5a01f300 	beq	$r24,$r0,-130576(0x201f0) # fffe1270 <_edata+0x7ffe026c>
    1084:	0000009f 	0x0000009f
	...
    1090:	fc000000 	0xfc000000
    1094:	201c001c 	ll.w	$r28,$r0,7168(0x1c00)
    1098:	011c001f 	0x011c001f
    109c:	1f205b00 	pcaddu18i	$r0,-458024(0x902d8)
    10a0:	1f2f1c00 	pcaddu18i	$r0,-427808(0x978e0)
    10a4:	00021c00 	0x00021c00
    10a8:	1f2f0073 	pcaddu18i	$r19,-428029(0x97803)
    10ac:	1f3c1c00 	pcaddu18i	$r0,-401184(0x9e0e0)
    10b0:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    10b4:	9f5b01f3 	0x9f5b01f3
	...
    10c4:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
    10c8:	1c001f38 	pcaddu12i	$r24,249(0xf9)
    10cc:	00910002 	bstrins.d	$r2,$r0,0x11,0x0
    10d0:	1c001f38 	pcaddu12i	$r24,249(0xf9)
    10d4:	1c001f3c 	pcaddu12i	$r28,249(0xf9)
    10d8:	00730002 	bstrins.w	$r2,$r0,0x13,0x0
	...
    10e8:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
    10ec:	1c001d14 	pcaddu12i	$r20,232(0xe8)
    10f0:	04910002 	csrrd	$r2,0x2440
    10f4:	1c001d14 	pcaddu12i	$r20,232(0xe8)
    10f8:	1c001f2f 	pcaddu12i	$r15,249(0xf9)
    10fc:	00610001 	bstrins.w	$r1,$r0,0x1,0x0
    1100:	00000000 	0x00000000
    1104:	02000000 	slti	$r0,$r0,0
    1108:	00000000 	0x00000000
    110c:	01000000 	0x01000000
    1110:	001d0800 	mulh.wu	$r0,$r0,$r2
    1114:	001d281c 	mulh.wu	$r28,$r0,$r10
    1118:	3000021c 	0x3000021c
    111c:	001d289f 	mulh.wu	$r31,$r4,$r10
    1120:	001ee41c 	mulh.du	$r28,$r0,$r25
    1124:	5e00011c 	bne	$r8,$r28,-131072(0x20000) # fffe1124 <_edata+0x7ffe0120>
    1128:	1c001ee4 	pcaddu12i	$r4,247(0xf7)
    112c:	1c001ee8 	pcaddu12i	$r8,247(0xf7)
    1130:	9f300002 	0x9f300002
    1134:	1c001ee8 	pcaddu12i	$r8,247(0xf7)
    1138:	1c001eec 	pcaddu12i	$r12,247(0xf7)
    113c:	0c5e0001 	0x0c5e0001
    1140:	2f1c001f 	0x2f1c001f
    1144:	011c001f 	0x011c001f
    1148:	00005e00 	ext.w.b	$r0,$r16
	...
    1154:	00020000 	0x00020000
    1158:	00000000 	0x00000000
    115c:	1c001d28 	pcaddu12i	$r8,233(0xe9)
    1160:	1c001d50 	pcaddu12i	$r16,234(0xea)
    1164:	505d0001 	b	285952(0x45d00) # 46e64 <_start-0x1bfb919c>
    1168:	0c1c001d 	0x0c1c001d
    116c:	011c001e 	0x011c001e
    1170:	1e0c5f00 	pcaddu18i	$r0,25336(0x62f8)
    1174:	1e1c1c00 	pcaddu18i	$r0,57568(0xe0e0)
    1178:	00021c00 	0x00021c00
    117c:	1e1c9f30 	pcaddu18i	$r16,58617(0xe4f9)
    1180:	1e2c1c00 	pcaddu18i	$r0,90336(0x160e0)
    1184:	00011c00 	asrtle.d	$r0,$r7
    1188:	001e2c5d 	mulh.d	$r29,$r2,$r11
    118c:	001ee41c 	mulh.du	$r28,$r0,$r25
    1190:	5f00011c 	bne	$r8,$r28,-65536(0x30000) # ffff1190 <_edata+0x7fff018c>
	...
    11ac:	00020000 	0x00020000
    11b0:	1d280000 	pcaddu12i	$r0,-442368(0x94000)
    11b4:	1d501c00 	pcaddu12i	$r0,-360224(0xa80e0)
    11b8:	00021c00 	0x00021c00
    11bc:	1d509f30 	pcaddu12i	$r16,-359175(0xa84f9)
    11c0:	1d5c1c00 	pcaddu12i	$r0,-335648(0xae0e0)
    11c4:	00011c00 	asrtle.d	$r0,$r7
    11c8:	001d5c62 	mulh.wu	$r2,$r3,$r23
    11cc:	001d601c 	mulh.wu	$r28,$r0,$r24
    11d0:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 111d0 <_start-0x1bfeee30>
    11d4:	1c001d60 	pcaddu12i	$r0,235(0xeb)
    11d8:	1c001d70 	pcaddu12i	$r16,235(0xeb)
    11dc:	00800006 	bstrins.d	$r6,$r0,0x0,0x0
    11e0:	9f1d007a 	0x9f1d007a
    11e4:	1c001d70 	pcaddu12i	$r16,235(0xeb)
    11e8:	1c001d74 	pcaddu12i	$r20,235(0xeb)
    11ec:	74620001 	xvabsd.bu	$xr1,$xr0,$xr0
    11f0:	781c001d 	0x781c001d
    11f4:	011c001d 	0x011c001d
    11f8:	1d785d00 	pcaddu12i	$r0,-277784(0xbc2e8)
    11fc:	1dc81c00 	pcaddu12i	$r0,-114464(0xe40e0)
    1200:	00011c00 	asrtle.d	$r0,$r7
    1204:	001dc862 	mul.d	$r2,$r3,$r18
    1208:	001dd81c 	mul.d	$r28,$r0,$r22
    120c:	3000021c 	0x3000021c
    1210:	001dd89f 	mul.d	$r31,$r4,$r22
    1214:	001e0c1c 	mulh.d	$r28,$r0,$r3
    1218:	6200011c 	blt	$r8,$r28,-131072(0x20000) # fffe1218 <_edata+0x7ffe0214>
    121c:	1c001e0c 	pcaddu12i	$r12,240(0xf0)
    1220:	1c001e4c 	pcaddu12i	$r12,242(0xf2)
    1224:	9f300002 	0x9f300002
    1228:	1c001e4c 	pcaddu12i	$r12,242(0xf2)
    122c:	1c001ee4 	pcaddu12i	$r4,247(0xf7)
    1230:	00620001 	bstrins.w	$r1,$r0,0x2,0x0
	...
    1248:	02000000 	slti	$r0,$r0,0
	...
    1254:	001d2800 	mulh.wu	$r0,$r0,$r10
    1258:	001d781c 	mulh.wu	$r28,$r0,$r30
    125c:	3000021c 	0x3000021c
    1260:	001d789f 	mulh.wu	$r31,$r4,$r30
    1264:	001d841c 	mul.d	$r28,$r0,$r1
    1268:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 11268 <_start-0x1bfeed98>
    126c:	1c001d84 	pcaddu12i	$r4,236(0xec)
    1270:	1c001d94 	pcaddu12i	$r20,236(0xec)
    1274:	94600001 	0x94600001
    1278:	981c001d 	0x981c001d
    127c:	061c001d 	cacop	0x1d,$r0,1792(0x700)
    1280:	7a007800 	0x7a007800
    1284:	989f1d00 	0x989f1d00
    1288:	9c1c001d 	0x9c1c001d
    128c:	011c001d 	0x011c001d
    1290:	1d9c5d00 	pcaddu12i	$r0,-204056(0xce2e8)
    1294:	1dc81c00 	pcaddu12i	$r0,-114464(0xe40e0)
    1298:	00011c00 	asrtle.d	$r0,$r7
    129c:	001dc860 	mul.d	$r0,$r3,$r18
    12a0:	001dd81c 	mul.d	$r28,$r0,$r22
    12a4:	3000021c 	0x3000021c
    12a8:	001dd89f 	mul.d	$r31,$r4,$r22
    12ac:	001e0c1c 	mulh.d	$r28,$r0,$r3
    12b0:	6000011c 	blt	$r8,$r28,0 # 12b0 <_start-0x1bffed50>
    12b4:	1c001e0c 	pcaddu12i	$r12,240(0xf0)
    12b8:	1c001e7c 	pcaddu12i	$r28,243(0xf3)
    12bc:	9f300002 	0x9f300002
    12c0:	1c001e7c 	pcaddu12i	$r28,243(0xf3)
    12c4:	1c001e88 	pcaddu12i	$r8,244(0xf4)
    12c8:	885d0001 	0x885d0001
    12cc:	cc1c001e 	0xcc1c001e
    12d0:	011c001e 	0x011c001e
    12d4:	1ecc6000 	pcaddu18i	$r0,418560(0x66300)
    12d8:	1ed81c00 	pcaddu18i	$r0,442592(0x6c0e0)
    12dc:	00021c00 	0x00021c00
    12e0:	1ed89f30 	pcaddu18i	$r16,443641(0x6c4f9)
    12e4:	1ee41c00 	pcaddu18i	$r0,467168(0x720e0)
    12e8:	00011c00 	asrtle.d	$r0,$r7
    12ec:	00000060 	0x00000060
	...
    12fc:	00000200 	0x00000200
    1300:	00000000 	0x00000000
    1304:	001d2800 	mulh.wu	$r0,$r0,$r10
    1308:	001da01c 	mul.d	$r28,$r0,$r8
    130c:	3000021c 	0x3000021c
    1310:	001da09f 	mul.d	$r31,$r4,$r8
    1314:	001dc81c 	mul.d	$r28,$r0,$r18
    1318:	6400011c 	bge	$r8,$r28,0 # 1318 <_start-0x1bffece8>
    131c:	1c001dc8 	pcaddu12i	$r8,238(0xee)
    1320:	1c001dd8 	pcaddu12i	$r24,238(0xee)
    1324:	9f300002 	0x9f300002
    1328:	1c001dd8 	pcaddu12i	$r24,238(0xee)
    132c:	1c001ddc 	pcaddu12i	$r28,238(0xee)
    1330:	0c5c0001 	vfcmp.cune.s	$vr1,$vr0,$vr0
    1334:	ac1c001e 	0xac1c001e
    1338:	021c001e 	slti	$r30,$r0,1792(0x700)
    133c:	ac9f3000 	0xac9f3000
    1340:	bc1c001e 	0xbc1c001e
    1344:	011c001e 	0x011c001e
    1348:	1ebc6400 	pcaddu18i	$r0,385824(0x5e320)
    134c:	1ecc1c00 	pcaddu18i	$r0,418016(0x660e0)
    1350:	00011c00 	asrtle.d	$r0,$r7
    1354:	001ecc5c 	mulh.du	$r28,$r2,$r19
    1358:	001ee41c 	mulh.du	$r28,$r0,$r25
    135c:	3000021c 	0x3000021c
    1360:	0000009f 	0x0000009f
	...
    136c:	001df000 	mul.d	$r0,$r0,$r28
    1370:	001e081c 	mulh.d	$r28,$r0,$r2
    1374:	5c00011c 	bne	$r8,$r28,0 # 1374 <_start-0x1bffec8c>
    1378:	1c001e08 	pcaddu12i	$r8,240(0xf0)
    137c:	1c001e0c 	pcaddu12i	$r12,240(0xf0)
    1380:	807d0003 	0x807d0003
    1384:	0000007f 	0x0000007f
    1388:	00000000 	0x00000000
    138c:	00000100 	0x00000100
    1390:	00000000 	0x00000000
    1394:	001ee800 	mulh.du	$r0,$r0,$r26
    1398:	001f2c1c 	mulw.d.w	$r28,$r0,$r11
    139c:	9100041c 	0x9100041c
    13a0:	2c9f7ef0 	xvld	$xr16,$r23,2015(0x7df)
    13a4:	2f1c001f 	0x2f1c001f
    13a8:	011c001f 	0x011c001f
    13ac:	1f2f5800 	pcaddu18i	$r0,-427328(0x97ac0)
    13b0:	1f381c00 	pcaddu18i	$r0,-409376(0x9c0e0)
    13b4:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    13b8:	9f7ef091 	0x9f7ef091
    13bc:	1c001f38 	pcaddu12i	$r24,249(0xf9)
    13c0:	1c001f3c 	pcaddu12i	$r28,249(0xf9)
    13c4:	f0730004 	0xf0730004
    13c8:	00009f7e 	0x00009f7e
	...
    13d4:	1c001eec 	pcaddu12i	$r12,247(0xf7)
    13d8:	1c001f2f 	pcaddu12i	$r15,249(0xf9)
    13dc:	005e0001 	0x005e0001
	...
    13ec:	001b3c00 	rotr.w	$r0,$r0,$r15
    13f0:	001c2b1c 	mul.w	$r28,$r24,$r10
    13f4:	5400011c 	bl	74448896(0x4700000) # 47013f4 <_start-0x178fec0c>
    13f8:	1c001c2b 	pcaddu12i	$r11,225(0xe1)
    13fc:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    1400:	01f30004 	0x01f30004
    1404:	1c389f54 	pcaddu12i	$r20,115962(0x1c4fa)
    1408:	1cfc1c00 	pcaddu12i	$r0,516320(0x7e0e0)
    140c:	00011c00 	asrtle.d	$r0,$r7
    1410:	00000054 	0x00000054
	...
    141c:	3c000000 	0x3c000000
    1420:	2b1c001b 	fld.s	$f27,$r0,1792(0x700)
    1424:	011c001c 	0x011c001c
    1428:	1c2b5500 	pcaddu12i	$r0,88744(0x15aa8)
    142c:	1c381c00 	pcaddu12i	$r0,114912(0x1c0e0)
    1430:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    1434:	9f5501f3 	0x9f5501f3
    1438:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    143c:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
    1440:	00550001 	0x00550001
	...
    1450:	001b3c00 	rotr.w	$r0,$r0,$r15
    1454:	001c2b1c 	mul.w	$r28,$r24,$r10
    1458:	5600011c 	bl	74579968(0x4720000) # 4721458 <_start-0x178deba8>
    145c:	1c001c2b 	pcaddu12i	$r11,225(0xe1)
    1460:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    1464:	01f30004 	0x01f30004
    1468:	1c389f56 	pcaddu12i	$r22,115962(0x1c4fa)
    146c:	1cfc1c00 	pcaddu12i	$r0,516320(0x7e0e0)
    1470:	00011c00 	asrtle.d	$r0,$r7
    1474:	00000056 	0x00000056
	...
    1480:	3c000000 	0x3c000000
    1484:	2b1c001b 	fld.s	$f27,$r0,1792(0x700)
    1488:	011c001c 	0x011c001c
    148c:	1c2b5700 	pcaddu12i	$r0,88760(0x15ab8)
    1490:	1c381c00 	pcaddu12i	$r0,114912(0x1c0e0)
    1494:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    1498:	9f5701f3 	0x9f5701f3
    149c:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    14a0:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
    14a4:	00570001 	0x00570001
	...
    14b4:	001b3c00 	rotr.w	$r0,$r0,$r15
    14b8:	001c2b1c 	mul.w	$r28,$r24,$r10
    14bc:	5800011c 	beq	$r8,$r28,0 # 14bc <_start-0x1bffeb44>
    14c0:	1c001c2b 	pcaddu12i	$r11,225(0xe1)
    14c4:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    14c8:	01f30004 	0x01f30004
    14cc:	1c389f58 	pcaddu12i	$r24,115962(0x1c4fa)
    14d0:	1cfc1c00 	pcaddu12i	$r0,516320(0x7e0e0)
    14d4:	00011c00 	asrtle.d	$r0,$r7
    14d8:	00000058 	0x00000058
    14dc:	00000000 	0x00000000
    14e0:	01010000 	fadd.d	$f0,$f0,$f0
    14e4:	01010000 	fadd.d	$f0,$f0,$f0
    14e8:	01010000 	fadd.d	$f0,$f0,$f0
    14ec:	01010000 	fadd.d	$f0,$f0,$f0
	...
    14fc:	00000101 	0x00000101
    1500:	00000101 	0x00000101
    1504:	00000101 	0x00000101
    1508:	00000101 	0x00000101
    150c:	00000101 	0x00000101
    1510:	001b3c00 	rotr.w	$r0,$r0,$r15
    1514:	001b801c 	rotr.d	$r28,$r0,$r0
    1518:	5900011c 	beq	$r8,$r28,65536(0x10000) # 11518 <_start-0x1bfeeae8>
    151c:	1c001b80 	pcaddu12i	$r0,220(0xdc)
    1520:	1c001b90 	pcaddu12i	$r16,220(0xdc)
    1524:	01790003 	0x01790003
    1528:	001b909f 	rotr.d	$r31,$r4,$r4
    152c:	001b941c 	rotr.d	$r28,$r0,$r5
    1530:	5900011c 	beq	$r8,$r28,65536(0x10000) # 11530 <_start-0x1bfeead0>
    1534:	1c001b94 	pcaddu12i	$r20,220(0xdc)
    1538:	1c001ba4 	pcaddu12i	$r4,221(0xdd)
    153c:	01790003 	0x01790003
    1540:	001ba49f 	rotr.d	$r31,$r4,$r9
    1544:	001bf41c 	rotr.d	$r28,$r0,$r29
    1548:	5900011c 	beq	$r8,$r28,65536(0x10000) # 11548 <_start-0x1bfeeab8>
    154c:	1c001bf4 	pcaddu12i	$r20,223(0xdf)
    1550:	1c001c04 	pcaddu12i	$r4,224(0xe0)
    1554:	01790003 	0x01790003
    1558:	001c049f 	mul.w	$r31,$r4,$r1
    155c:	001c101c 	mul.w	$r28,$r0,$r4
    1560:	5900011c 	beq	$r8,$r28,65536(0x10000) # 11560 <_start-0x1bfeeaa0>
    1564:	1c001c10 	pcaddu12i	$r16,224(0xe0)
    1568:	1c001c20 	pcaddu12i	$r0,225(0xe1)
    156c:	01790003 	0x01790003
    1570:	001c209f 	mul.w	$r31,$r4,$r8
    1574:	001c2b1c 	mul.w	$r28,$r24,$r10
    1578:	5900011c 	beq	$r8,$r28,65536(0x10000) # 11578 <_start-0x1bfeea88>
    157c:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    1580:	1c001c3c 	pcaddu12i	$r28,225(0xe1)
    1584:	3c590001 	0x3c590001
    1588:	541c001c 	bl	7347200(0x701c00) # 703188 <_start-0x1b8fce78>
    158c:	011c001c 	0x011c001c
    1590:	1c545d00 	pcaddu12i	$r0,172776(0x2a2e8)
    1594:	1c581c00 	pcaddu12i	$r0,180448(0x2c0e0)
    1598:	00011c00 	asrtle.d	$r0,$r7
    159c:	001c5859 	mul.w	$r25,$r2,$r22
    15a0:	001c601c 	mul.w	$r28,$r0,$r24
    15a4:	5d00011c 	bne	$r8,$r28,65536(0x10000) # 115a4 <_start-0x1bfeea5c>
    15a8:	1c001c60 	pcaddu12i	$r0,227(0xe3)
    15ac:	1c001c70 	pcaddu12i	$r16,227(0xe3)
    15b0:	70590001 	vhaddw.du.wu	$vr1,$vr0,$vr0
    15b4:	801c001c 	0x801c001c
    15b8:	031c001c 	lu52i.d	$r28,$r0,1792(0x700)
    15bc:	9f017900 	0x9f017900
    15c0:	1c001c80 	pcaddu12i	$r0,228(0xe4)
    15c4:	1c001c94 	pcaddu12i	$r20,228(0xe4)
    15c8:	94590001 	0x94590001
    15cc:	a41c001c 	0xa41c001c
    15d0:	031c001c 	lu52i.d	$r28,$r0,1792(0x700)
    15d4:	9f017900 	0x9f017900
    15d8:	1c001ca4 	pcaddu12i	$r4,229(0xe5)
    15dc:	1c001cb0 	pcaddu12i	$r16,229(0xe5)
    15e0:	b0590001 	0xb0590001
    15e4:	c01c001c 	0xc01c001c
    15e8:	031c001c 	lu52i.d	$r28,$r0,1792(0x700)
    15ec:	9f017900 	0x9f017900
    15f0:	1c001cc0 	pcaddu12i	$r0,230(0xe6)
    15f4:	1c001ccc 	pcaddu12i	$r12,230(0xe6)
    15f8:	cc590001 	0xcc590001
    15fc:	dc1c001c 	0xdc1c001c
    1600:	031c001c 	lu52i.d	$r28,$r0,1792(0x700)
    1604:	9f017900 	0x9f017900
    1608:	1c001cdc 	pcaddu12i	$r28,230(0xe6)
    160c:	1c001ce8 	pcaddu12i	$r8,231(0xe7)
    1610:	e8590001 	0xe8590001
    1614:	f81c001c 	0xf81c001c
    1618:	031c001c 	lu52i.d	$r28,$r0,1792(0x700)
    161c:	9f017900 	0x9f017900
    1620:	1c001cf8 	pcaddu12i	$r24,231(0xe7)
    1624:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
    1628:	00590001 	0x00590001
	...
    1638:	001b3c00 	rotr.w	$r0,$r0,$r15
    163c:	001c281c 	mul.w	$r28,$r0,$r10
    1640:	5a00011c 	beq	$r8,$r28,-131072(0x20000) # fffe1640 <_edata+0x7ffe063c>
    1644:	1c001c28 	pcaddu12i	$r8,225(0xe1)
    1648:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    164c:	01f30004 	0x01f30004
    1650:	1c389f5a 	pcaddu12i	$r26,115962(0x1c4fa)
    1654:	1cfc1c00 	pcaddu12i	$r0,516320(0x7e0e0)
    1658:	00011c00 	asrtle.d	$r0,$r7
    165c:	0000005a 	0x0000005a
	...
    1668:	3c000000 	0x3c000000
    166c:	241c001b 	ldptr.w	$r27,$r0,7168(0x1c00)
    1670:	011c001c 	0x011c001c
    1674:	1c245b00 	pcaddu12i	$r0,74456(0x122d8)
    1678:	1c381c00 	pcaddu12i	$r0,114912(0x1c0e0)
    167c:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    1680:	9f5b01f3 	0x9f5b01f3
    1684:	1c001c38 	pcaddu12i	$r24,225(0xe1)
    1688:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
    168c:	005b0001 	0x005b0001
	...
    169c:	001b3c00 	rotr.w	$r0,$r0,$r15
    16a0:	001c341c 	mul.w	$r28,$r0,$r13
    16a4:	9100021c 	0x9100021c
    16a8:	001c3400 	mul.w	$r0,$r0,$r13
    16ac:	001c381c 	mul.w	$r28,$r0,$r14
    16b0:	7300021c 	0x7300021c
    16b4:	001c3800 	mul.w	$r0,$r0,$r14
    16b8:	001cfc1c 	mulh.w	$r28,$r0,$r31
    16bc:	6000011c 	blt	$r8,$r28,0 # 16bc <_start-0x1bffe944>
	...
    16cc:	1b3c0000 	pcalau12i	$r0,-401408(0x9e000)
    16d0:	1b741c00 	pcalau12i	$r0,-286496(0xba0e0)
    16d4:	00021c00 	0x00021c00
    16d8:	1b740491 	pcalau12i	$r17,-286684(0xba024)
    16dc:	1c2b1c00 	pcaddu12i	$r0,88288(0x158e0)
    16e0:	00011c00 	asrtle.d	$r0,$r7
    16e4:	001c385f 	mul.w	$r31,$r2,$r14
    16e8:	001cfc1c 	mulh.w	$r28,$r0,$r31
    16ec:	5f00011c 	bne	$r8,$r28,-65536(0x30000) # ffff16ec <_edata+0x7fff06e8>
	...
    1700:	1b3c0000 	pcalau12i	$r0,-401408(0x9e000)
    1704:	1b941c00 	pcalau12i	$r0,-220960(0xca0e0)
    1708:	00021c00 	0x00021c00
    170c:	1b940891 	pcalau12i	$r17,-221116(0xca044)
    1710:	1c2b1c00 	pcaddu12i	$r0,88288(0x158e0)
    1714:	00011c00 	asrtle.d	$r0,$r7
    1718:	001c2b5c 	mul.w	$r28,$r26,$r10
    171c:	001c341c 	mul.w	$r28,$r0,$r13
    1720:	9100021c 	0x9100021c
    1724:	001c3408 	mul.w	$r8,$r0,$r13
    1728:	001c381c 	mul.w	$r28,$r0,$r14
    172c:	7300021c 	0x7300021c
    1730:	001c3808 	mul.w	$r8,$r0,$r14
    1734:	001cfc1c 	mulh.w	$r28,$r0,$r31
    1738:	5c00011c 	bne	$r8,$r28,0 # 1738 <_start-0x1bffe8c8>
	...
    1750:	1c001a30 	pcaddu12i	$r16,209(0xd1)
    1754:	1c001a88 	pcaddu12i	$r8,212(0xd4)
    1758:	88540001 	0x88540001
    175c:	b01c001a 	0xb01c001a
    1760:	011c001a 	0x011c001a
    1764:	1ab06800 	pcalau12i	$r0,361280(0x58340)
    1768:	1ab41c00 	pcalau12i	$r0,368864(0x5a0e0)
    176c:	00011c00 	asrtle.d	$r0,$r7
    1770:	001ab454 	0x001ab454
    1774:	001af41c 	0x001af41c
    1778:	6800011c 	bltu	$r8,$r28,0 # 1778 <_start-0x1bffe888>
    177c:	1c001af4 	pcaddu12i	$r20,215(0xd7)
    1780:	1c001b18 	pcaddu12i	$r24,216(0xd8)
    1784:	01f30004 	0x01f30004
    1788:	1b189f54 	pcalau12i	$r20,-473862(0x8c4fa)
    178c:	1b3c1c00 	pcalau12i	$r0,-401184(0x9e0e0)
    1790:	00011c00 	asrtle.d	$r0,$r7
    1794:	00000068 	0x00000068
	...
    17a8:	001a3000 	0x001a3000
    17ac:	001a881c 	0x001a881c
    17b0:	5500011c 	bl	74514432(0x4710000) # 47117b0 <_start-0x178ee850>
    17b4:	1c001a88 	pcaddu12i	$r8,212(0xd4)
    17b8:	1c001ab0 	pcaddu12i	$r16,213(0xd5)
    17bc:	b0690001 	0xb0690001
    17c0:	b41c001a 	0xb41c001a
    17c4:	011c001a 	0x011c001a
    17c8:	1ab45500 	pcalau12i	$r0,369320(0x5a2a8)
    17cc:	1af81c00 	pcalau12i	$r0,508128(0x7c0e0)
    17d0:	00011c00 	asrtle.d	$r0,$r7
    17d4:	001af869 	0x001af869
    17d8:	001b181c 	rotr.w	$r28,$r0,$r6
    17dc:	f300041c 	0xf300041c
    17e0:	189f5501 	pcaddi	$r1,326312(0x4faa8)
    17e4:	3c1c001b 	0x3c1c001b
    17e8:	011c001b 	0x011c001b
    17ec:	00006900 	rdtime.d	$r0,$r8
	...
    1800:	1a300000 	pcalau12i	$r0,98304(0x18000)
    1804:	1a981c00 	pcalau12i	$r0,311520(0x4c0e0)
    1808:	00011c00 	asrtle.d	$r0,$r7
    180c:	001a9856 	0x001a9856
    1810:	001ab01c 	0x001ab01c
    1814:	6b00011c 	bltu	$r8,$r28,-65536(0x30000) # ffff1814 <_edata+0x7fff0810>
    1818:	1c001ab0 	pcaddu12i	$r16,213(0xd5)
    181c:	1c001abc 	pcaddu12i	$r28,213(0xd5)
    1820:	bc560001 	0xbc560001
    1824:	d81c001a 	0xd81c001a
    1828:	011c001a 	0x011c001a
    182c:	1ad86e00 	pcalau12i	$r0,443248(0x6c370)
    1830:	1b241c00 	pcalau12i	$r0,-450336(0x920e0)
    1834:	00011c00 	asrtle.d	$r0,$r7
    1838:	001b2456 	rotr.w	$r22,$r2,$r9
    183c:	001b3c1c 	rotr.w	$r28,$r0,$r15
    1840:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff1840 <_edata+0x7fff083c>
	...
    1858:	1c001a30 	pcaddu12i	$r16,209(0xd1)
    185c:	1c001a88 	pcaddu12i	$r8,212(0xd4)
    1860:	88570001 	0x88570001
    1864:	b01c001a 	0xb01c001a
    1868:	011c001a 	0x011c001a
    186c:	1ab06a00 	pcalau12i	$r0,361296(0x58350)
    1870:	1ab41c00 	pcalau12i	$r0,368864(0x5a0e0)
    1874:	00011c00 	asrtle.d	$r0,$r7
    1878:	001ab457 	0x001ab457
    187c:	001afc1c 	0x001afc1c
    1880:	6a00011c 	bltu	$r8,$r28,-131072(0x20000) # fffe1880 <_edata+0x7ffe087c>
    1884:	1c001afc 	pcaddu12i	$r28,215(0xd7)
    1888:	1c001b18 	pcaddu12i	$r24,216(0xd8)
    188c:	01f30004 	0x01f30004
    1890:	1b189f57 	pcalau12i	$r23,-473862(0x8c4fa)
    1894:	1b3c1c00 	pcalau12i	$r0,-401184(0x9e0e0)
    1898:	00011c00 	asrtle.d	$r0,$r7
    189c:	0000006a 	0x0000006a
	...
    18b0:	001a3000 	0x001a3000
    18b4:	001a881c 	0x001a881c
    18b8:	5800011c 	beq	$r8,$r28,0 # 18b8 <_start-0x1bffe748>
    18bc:	1c001a88 	pcaddu12i	$r8,212(0xd4)
    18c0:	1c001ab0 	pcaddu12i	$r16,213(0xd5)
    18c4:	b06d0001 	0xb06d0001
    18c8:	b41c001a 	0xb41c001a
    18cc:	011c001a 	0x011c001a
    18d0:	1ab45800 	pcalau12i	$r0,369344(0x5a2c0)
    18d4:	1b081c00 	pcalau12i	$r0,-507680(0x840e0)
    18d8:	00011c00 	asrtle.d	$r0,$r7
    18dc:	001b086d 	rotr.w	$r13,$r3,$r2
    18e0:	001b181c 	rotr.w	$r28,$r0,$r6
    18e4:	f300041c 	0xf300041c
    18e8:	189f5801 	pcaddi	$r1,326336(0x4fac0)
    18ec:	3c1c001b 	0x3c1c001b
    18f0:	011c001b 	0x011c001b
    18f4:	00006d00 	cpucfg	$r0,$r8
	...
    1904:	1a300000 	pcalau12i	$r0,98304(0x18000)
    1908:	1a881c00 	pcalau12i	$r0,278752(0x440e0)
    190c:	00011c00 	asrtle.d	$r0,$r7
    1910:	001a8859 	0x001a8859
    1914:	001ab01c 	0x001ab01c
    1918:	6700011c 	bge	$r8,$r28,-65536(0x30000) # ffff1918 <_edata+0x7fff0914>
    191c:	1c001ab0 	pcaddu12i	$r16,213(0xd5)
    1920:	1c001ab4 	pcaddu12i	$r20,213(0xd5)
    1924:	b4590001 	0xb4590001
    1928:	e01c001a 	0xe01c001a
    192c:	011c001a 	0x011c001a
    1930:	00006700 	rdtimeh.w	$r0,$r24
	...
    1944:	1a300000 	pcalau12i	$r0,98304(0x18000)
    1948:	1a881c00 	pcalau12i	$r0,278752(0x440e0)
    194c:	00011c00 	asrtle.d	$r0,$r7
    1950:	001a885a 	0x001a885a
    1954:	001ab01c 	0x001ab01c
    1958:	6c00011c 	bgeu	$r8,$r28,0 # 1958 <_start-0x1bffe6a8>
    195c:	1c001ab0 	pcaddu12i	$r16,213(0xd5)
    1960:	1c001ab4 	pcaddu12i	$r20,213(0xd5)
    1964:	b45a0001 	0xb45a0001
    1968:	041c001a 	csrrd	$r26,0x700
    196c:	011c001b 	0x011c001b
    1970:	1b046c00 	pcalau12i	$r0,-515232(0x82360)
    1974:	1b181c00 	pcalau12i	$r0,-474912(0x8c0e0)
    1978:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    197c:	9f5a01f3 	0x9f5a01f3
    1980:	1c001b18 	pcaddu12i	$r24,216(0xd8)
    1984:	1c001b3c 	pcaddu12i	$r28,217(0xd9)
    1988:	006c0001 	bstrins.w	$r1,$r0,0xc,0x0
	...
    199c:	001a3000 	0x001a3000
    19a0:	001a881c 	0x001a881c
    19a4:	5b00011c 	beq	$r8,$r28,-65536(0x30000) # ffff19a4 <_edata+0x7fff09a0>
    19a8:	1c001a88 	pcaddu12i	$r8,212(0xd4)
    19ac:	1c001ab0 	pcaddu12i	$r16,213(0xd5)
    19b0:	b0660001 	0xb0660001
    19b4:	b41c001a 	0xb41c001a
    19b8:	011c001a 	0x011c001a
    19bc:	1ab45b00 	pcalau12i	$r0,369368(0x5a2d8)
    19c0:	1adc1c00 	pcalau12i	$r0,450784(0x6e0e0)
    19c4:	00011c00 	asrtle.d	$r0,$r7
    19c8:	001adc66 	0x001adc66
    19cc:	001b3c1c 	rotr.w	$r28,$r0,$r15
    19d0:	f300041c 	0xf300041c
    19d4:	009f5b01 	bstrins.d	$r1,$r24,0x1f,0x16
	...
    19e0:	001ab400 	0x001ab400
    19e4:	001ad81c 	0x001ad81c
    19e8:	6b00011c 	bltu	$r8,$r28,-65536(0x30000) # ffff19e8 <_edata+0x7fff09e4>
	...
    19f4:	00000002 	0x00000002
	...
    1a00:	1c001a80 	pcaddu12i	$r0,212(0xd4)
    1a04:	1c001a88 	pcaddu12i	$r8,212(0xd4)
    1a08:	88560001 	0x88560001
    1a0c:	b01c001a 	0xb01c001a
    1a10:	011c001a 	0x011c001a
    1a14:	1ab06f00 	pcalau12i	$r0,361336(0x58378)
    1a18:	1ab41c00 	pcalau12i	$r0,368864(0x5a0e0)
    1a1c:	00011c00 	asrtle.d	$r0,$r7
    1a20:	001ab456 	0x001ab456
    1a24:	001b101c 	rotr.w	$r28,$r0,$r4
    1a28:	6f00011c 	bgeu	$r8,$r28,-65536(0x30000) # ffff1a28 <_edata+0x7fff0a24>
    1a2c:	1c001b10 	pcaddu12i	$r16,216(0xd8)
    1a30:	1c001b18 	pcaddu12i	$r24,216(0xd8)
    1a34:	01f30004 	0x01f30004
    1a38:	1b189f56 	pcalau12i	$r22,-473862(0x8c4fa)
    1a3c:	1b3c1c00 	pcalau12i	$r0,-401184(0x9e0e0)
    1a40:	00011c00 	asrtle.d	$r0,$r7
    1a44:	0000006f 	0x0000006f
	...
    1a50:	0019ec00 	sra.d	$r0,$r0,$r27
    1a54:	001a2c1c 	0x001a2c1c
    1a58:	5400011c 	bl	74448896(0x4700000) # 4701a58 <_start-0x178fe5a8>
    1a5c:	1c001a2c 	pcaddu12i	$r12,209(0xd1)
    1a60:	1c001a30 	pcaddu12i	$r16,209(0xd1)
    1a64:	01f30004 	0x01f30004
    1a68:	00009f54 	0x00009f54
    1a6c:	00000000 	0x00000000
    1a70:	00020000 	0x00020000
    1a74:	00000000 	0x00000000
    1a78:	1c0019ec 	pcaddu12i	$r12,207(0xcf)
    1a7c:	1c0019f0 	pcaddu12i	$r16,207(0xcf)
    1a80:	9f300002 	0x9f300002
    1a84:	1c0019f0 	pcaddu12i	$r16,207(0xcf)
    1a88:	1c001a10 	pcaddu12i	$r16,208(0xd0)
    1a8c:	245d0001 	ldptr.w	$r1,$r0,23808(0x5d00)
    1a90:	301c001a 	0x301c001a
    1a94:	011c001a 	0x011c001a
    1a98:	00005d00 	ext.w.b	$r0,$r8
	...
    1aa4:	19f80000 	pcaddi	$r0,-16384(0xfc000)
    1aa8:	19fc1c00 	pcaddi	$r0,-7968(0xfe0e0)
    1aac:	00011c00 	asrtle.d	$r0,$r7
    1ab0:	0019fc5c 	sra.d	$r28,$r2,$r31
    1ab4:	001a001c 	0x001a001c
    1ab8:	7c00031c 	0x7c00031c
    1abc:	00009f30 	0x00009f30
	...
    1ac8:	27000000 	stptr.d	$r0,$r0,0
    1acc:	27131c00 	stptr.d	$r0,$r0,4892(0x131c)
    1ad0:	00011c00 	asrtle.d	$r0,$r7
    1ad4:	00271354 	crcc.w.w.w	$r20,$r26,$r4
    1ad8:	0027201c 	crcc.w.w.w	$r28,$r0,$r8
    1adc:	f300041c 	0xf300041c
    1ae0:	009f5401 	bstrins.d	$r1,$r0,0x1f,0x15
	...
    1af0:	131c0027 	addu16i.d	$r7,$r1,-14592(0xc700)
    1af4:	011c0027 	0x011c0027
    1af8:	27135500 	stptr.d	$r0,$r8,4948(0x1354)
    1afc:	27201c00 	stptr.d	$r0,$r0,8220(0x201c)
    1b00:	00041c00 	alsl.w	$r0,$r0,$r7,0x1
    1b04:	9f5501f3 	0x9f5501f3
	...
    1b14:	1c002700 	pcaddu12i	$r0,312(0x138)
    1b18:	1c002713 	pcaddu12i	$r19,312(0x138)
    1b1c:	13560001 	addu16i.d	$r1,$r0,-10880(0xd580)
    1b20:	201c0027 	ll.w	$r7,$r1,7168(0x1c00)
    1b24:	041c0027 	csrwr	$r7,0x700
    1b28:	5601f300 	bl	-66977296(0xc0201f0) # fc021d18 <_edata+0x7c020d14>
    1b2c:	0000009f 	0x0000009f
	...
    1b38:	00270000 	crcc.w.w.w	$r0,$r0,$r0
    1b3c:	0027131c 	crcc.w.w.w	$r28,$r24,$r4
    1b40:	5700011c 	bl	74645504(0x4730000) # 4731b40 <_start-0x178ce4c0>
    1b44:	1c002713 	pcaddu12i	$r19,312(0x138)
    1b48:	1c002720 	pcaddu12i	$r0,313(0x139)
    1b4c:	01f30004 	0x01f30004
    1b50:	00009f57 	0x00009f57
    1b54:	00000000 	0x00000000
    1b58:	00010000 	asrtle.d	$r0,$r0
    1b5c:	00000000 	0x00000000
    1b60:	1c002890 	pcaddu12i	$r16,324(0x144)
    1b64:	1c0028ac 	pcaddu12i	$r12,325(0x145)
    1b68:	9f300002 	0x9f300002
    1b6c:	1c0028ac 	pcaddu12i	$r12,325(0x145)
    1b70:	1c0028c4 	pcaddu12i	$r4,326(0x146)
    1b74:	c45d0001 	0xc45d0001
    1b78:	e41c0028 	0xe41c0028
    1b7c:	011c0028 	0x011c0028
    1b80:	00006700 	rdtimeh.w	$r0,$r24
	...
    1b8c:	289c0000 	ld.w	$r0,$r0,1792(0x700)
    1b90:	290c1c00 	st.b	$r0,$r0,775(0x307)
    1b94:	00011c00 	asrtle.d	$r0,$r7
    1b98:	00291468 	0x00291468
    1b9c:	0029201c 	0x0029201c
    1ba0:	6800011c 	bltu	$r8,$r28,0 # 1ba0 <_start-0x1bffe460>
	...
    1bb0:	1c002848 	pcaddu12i	$r8,322(0x142)
    1bb4:	1c00285c 	pcaddu12i	$r28,322(0x142)
    1bb8:	5c540001 	bne	$r0,$r1,21504(0x5400) # 6fb8 <_start-0x1bff9048>
    1bbc:	801c0028 	0x801c0028
    1bc0:	041c0028 	csrwr	$r8,0x700
    1bc4:	5401f300 	bl	-67108368(0xc0001f0) # fc001db4 <_edata+0x7c000db0>
    1bc8:	0000009f 	0x0000009f
	...
    1bdc:	54000100 	bl	67108864(0x4000000) # 4001bdc <_start-0x17ffe424>
	...
    1be8:	01f30004 	0x01f30004
    1bec:	00009f54 	0x00009f54
	...
    1bf8:	282c0000 	ld.b	$r0,$r0,-1280(0xb00)
    1bfc:	28401c00 	ld.h	$r0,$r0,7(0x7)
    1c00:	00011c00 	asrtle.d	$r0,$r7
    1c04:	00284054 	0x00284054
    1c08:	0028481c 	0x0028481c
    1c0c:	f300041c 	0xf300041c
    1c10:	009f5401 	bstrins.d	$r1,$r0,0x1f,0x15
    1c14:	00000000 	0x00000000
    1c18:	Address 0x0000000000001c18 is out of bounds.


Disassembly of section .debug_ranges:

00000000 <.debug_ranges>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
   0:	1c001390 	pcaddu12i	$r16,156(0x9c)
   4:	1c0013c0 	pcaddu12i	$r0,158(0x9e)
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   8:	1c001424 	pcaddu12i	$r4,161(0xa1)
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   c:	1c001464 	pcaddu12i	$r4,163(0xa3)
	...
intc_irq_detach():
D:/LA132_SoC_SW_EXP/user/interrupt.c:109
  18:	1c001534 	pcaddu12i	$r20,169(0xa9)
delay_s():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:86
  1c:	1c00154c 	pcaddu12i	$r12,170(0xaa)
delay_ms():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  20:	1c00154c 	pcaddu12i	$r12,170(0xaa)
CompareTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:87
  24:	1c0015c4 	pcaddu12i	$r4,174(0xae)
	...
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  30:	1c00113c 	pcaddu12i	$r28,137(0x89)
  34:	1c001190 	pcaddu12i	$r16,140(0x8c)
SetTime():
D:/LA132_SoC_SW_EXP/driver/LA_TIMER/latimer.c:88
  38:	1c001190 	pcaddu12i	$r16,140(0x8c)
  3c:	1c0011f8 	pcaddu12i	$r24,143(0x8f)
  40:	1c0011f8 	pcaddu12i	$r24,143(0x8f)
uart_read_bcd_char():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  44:	1c001224 	pcaddu12i	$r4,145(0x91)
  48:	1c001224 	pcaddu12i	$r4,145(0x91)
uart_getchar_nb():
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:250
  4c:	1c001464 	pcaddu12i	$r4,163(0xa3)
  50:	1c001464 	pcaddu12i	$r4,163(0xa3)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:251
  54:	1c0015c4 	pcaddu12i	$r4,174(0xae)
	...
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:253
  60:	1c0015c4 	pcaddu12i	$r4,174(0xae)
  64:	1c00162c 	pcaddu12i	$r12,177(0xb1)
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:256
  68:	1c00162c 	pcaddu12i	$r12,177(0xb1)
  6c:	1c00165c 	pcaddu12i	$r28,178(0xb2)
	...
D:/LA132_SoC_SW_EXP/driver/UART/uart.c:257
  80:	1c00165c 	pcaddu12i	$r28,178(0xb2)
  84:	1c0016e8 	pcaddu12i	$r8,183(0xb7)
	...
seg7_scan():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  a8:	1c0016e8 	pcaddu12i	$r8,183(0xb7)
  ac:	1c0016f0 	pcaddu12i	$r16,183(0xb7)
  b0:	1c0016f0 	pcaddu12i	$r16,183(0xb7)
  b4:	1c0016fc 	pcaddu12i	$r28,183(0xb7)
seg7_set_value():
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:88 (discriminator 1)
  b8:	1c0016fc 	pcaddu12i	$r28,183(0xb7)
D:/LA132_SoC_SW_EXP/driver/GPIO/seg7.c:90
  bc:	1c001708 	pcaddu12i	$r8,184(0xb8)
  c0:	1c001708 	pcaddu12i	$r8,184(0xb8)
  c4:	1c001738 	pcaddu12i	$r24,185(0xb9)
  c8:	1c001738 	pcaddu12i	$r24,185(0xb9)
  cc:	1c001778 	pcaddu12i	$r24,187(0xbb)
  d0:	1c001778 	pcaddu12i	$r24,187(0xbb)
  d4:	1c0017c4 	pcaddu12i	$r4,190(0xbe)
  d8:	1c0017c4 	pcaddu12i	$r4,190(0xbe)
  dc:	1c0017e0 	pcaddu12i	$r0,191(0xbf)
	...
 108:	1c001840 	pcaddu12i	$r0,194(0xc2)
 10c:	1c001848 	pcaddu12i	$r8,194(0xc2)
 110:	1c001868 	pcaddu12i	$r8,195(0xc3)
 114:	1c001884 	pcaddu12i	$r4,196(0xc4)
	...
 138:	1c0017e0 	pcaddu12i	$r0,191(0xbf)
 13c:	1c0017f8 	pcaddu12i	$r24,191(0xbf)
	...
 148:	1c0017f8 	pcaddu12i	$r24,191(0xbf)
 14c:	1c0018fc 	pcaddu12i	$r28,199(0xc7)
 150:	1c0018fc 	pcaddu12i	$r28,199(0xc7)
 154:	1c001948 	pcaddu12i	$r8,202(0xca)
	...
 160:	1c001948 	pcaddu12i	$r8,202(0xca)
 164:	1c00195c 	pcaddu12i	$r28,202(0xca)
 168:	1c00195c 	pcaddu12i	$r28,202(0xca)
 16c:	1c0019c8 	pcaddu12i	$r8,206(0xce)
	...
 1a0:	1c0019c8 	pcaddu12i	$r8,206(0xce)
 1a4:	1c0019e8 	pcaddu12i	$r8,207(0xcf)
	...
 1b0:	1c001d28 	pcaddu12i	$r8,233(0xe9)
 1b4:	1c001e00 	pcaddu12i	$r0,240(0xf0)
 1b8:	1c001e0c 	pcaddu12i	$r12,240(0xf0)
 1bc:	1c001ee4 	pcaddu12i	$r4,247(0xf7)
	...
 1c8:	1c002280 	pcaddu12i	$r0,276(0x114)
 1cc:	1c0022c4 	pcaddu12i	$r4,278(0x116)
 1d0:	1c002404 	pcaddu12i	$r4,288(0x120)
 1d4:	1c002434 	pcaddu12i	$r20,289(0x121)
	...
 1e0:	1c0022f4 	pcaddu12i	$r20,279(0x117)
 1e4:	1c002340 	pcaddu12i	$r0,282(0x11a)
 1e8:	1c002398 	pcaddu12i	$r24,284(0x11c)
 1ec:	1c0023c8 	pcaddu12i	$r8,286(0x11e)
	...
 1f8:	1c0024f8 	pcaddu12i	$r24,295(0x127)
 1fc:	1c002514 	pcaddu12i	$r20,296(0x128)
 200:	1c00251c 	pcaddu12i	$r28,296(0x128)
 204:	1c002520 	pcaddu12i	$r0,297(0x129)
	...
 210:	1c0019e8 	pcaddu12i	$r8,207(0xcf)
 214:	1c0019ec 	pcaddu12i	$r12,207(0xcf)
 218:	1c0019ec 	pcaddu12i	$r12,207(0xcf)
 21c:	1c001a30 	pcaddu12i	$r16,209(0xd1)
 220:	1c001a30 	pcaddu12i	$r16,209(0xd1)
 224:	1c001b3c 	pcaddu12i	$r28,217(0xd9)
 228:	1c001b3c 	pcaddu12i	$r28,217(0xd9)
 22c:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
 230:	1c001cfc 	pcaddu12i	$r28,231(0xe7)
 234:	1c001f3c 	pcaddu12i	$r28,249(0xf9)
 238:	1c001f3c 	pcaddu12i	$r28,249(0xf9)
 23c:	1c002700 	pcaddu12i	$r0,312(0x138)
 240:	1c002700 	pcaddu12i	$r0,312(0x138)
 244:	1c002720 	pcaddu12i	$r0,313(0x139)
 248:	1c002720 	pcaddu12i	$r0,313(0x139)
 24c:	1c002770 	pcaddu12i	$r16,315(0x13b)
	...
 258:	1c002770 	pcaddu12i	$r16,315(0x13b)
 25c:	1c0027c4 	pcaddu12i	$r4,318(0x13e)
	...
 270:	1c0027c4 	pcaddu12i	$r4,318(0x13e)
 274:	1c0027d0 	pcaddu12i	$r16,318(0x13e)
 278:	1c0027d0 	pcaddu12i	$r16,318(0x13e)
 27c:	1c0027dc 	pcaddu12i	$r28,318(0x13e)
	...
 288:	1c0027dc 	pcaddu12i	$r28,318(0x13e)
 28c:	1c0027f0 	pcaddu12i	$r16,319(0x13f)
	...
 298:	1c0027f0 	pcaddu12i	$r16,319(0x13f)
 29c:	1c002800 	pcaddu12i	$r0,320(0x140)
 2a0:	1c002800 	pcaddu12i	$r0,320(0x140)
 2a4:	1c00282c 	pcaddu12i	$r12,321(0x141)
 2a8:	1c00282c 	pcaddu12i	$r12,321(0x141)
 2ac:	1c002848 	pcaddu12i	$r8,322(0x142)
	...
 2b8:	1c002848 	pcaddu12i	$r8,322(0x142)
 2bc:	1c002880 	pcaddu12i	$r0,324(0x144)
 2c0:	1c002880 	pcaddu12i	$r0,324(0x144)
 2c4:	1c002920 	pcaddu12i	$r0,329(0x149)
	...

Disassembly of section .comment:

00000000 <.comment>:
EnableInt():
D:/LA132_SoC_SW_EXP/user/interrupt.c:106
   0:	3a434347 	0x3a434347
   4:	4e472820 	jirl	$r0,$r1,-112856(0x24728)
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   8:	38202955 	ldx.bu	$r21,$r10,$r10
Disable_LA_Local_Int():
D:/LA132_SoC_SW_EXP/user/interrupt.c:107
   c:	302e332e 	vldrepl.w	$vr14,$r25,-464(0xe30)
	...
