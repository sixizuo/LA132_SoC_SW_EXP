/**
 * @file    demo_at24c64.c
 * @brief   EEPROM AT24C64 读写测试 (I2C 400 kHz)
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 * 来源: user/EEPROM_IIC_POLLING.c_backup
 *
 * 改动:
 *   1) 老例程写死 8 个字节 (i -> i) 只测一遍就死循环; 现在每轮换一组
 *      数据 (i + round), 每 2 秒测一轮, 可以长时间观察稳定性。
 *   2) 每一轮都逐字节打印比对结果, 有错直接标出来。
 *
 * 注意: EEPROM 每次写操作后硬件需要约 5 ms 的内部写周期,
 *       所以 AT24C64_WriteByte 之后必须 delay_ms(5)。
 *
 * 现象: 串口打印 8 个字节的写/读结果, 每 2 秒一轮, 都应 PASS。
 */
#include "main.h"
#include "I2C/i2c.h"
#include "AT24C64/AT24C64.h"

#define EE_TEST_LEN   8

void at24c64_demo(void)
{
    unsigned int  round = 0;
    unsigned char expect;
    unsigned char got;
    int i;
    int err;

    *iic_sel =1;  /* I2C0, select I2C0 */
    I2C_Init(400000);                 /* SCL 400 kHz */

    printf("eeprom at24c64 demo: dev addr 0x%02x, test %d bytes\r\n",
           (unsigned int)DEV_ADDR, EE_TEST_LEN);

    for (;;) {
        printf("---- round %u : write ----\r\n", round);

        for (i = 0; i < EE_TEST_LEN; i++) {
            expect = (unsigned char)((i + (int)round) & 0xFF);
            AT24C64_WriteByte((uint16_t)i, expect);
            delay_ms(5);              /* EEPROM 内部写周期 */
            printf("  addr %d <= 0x%02x\r\n", i, expect);
        }

        printf("---- round %u : read  ----\r\n", round);

        err = 0;
        for (i = 0; i < EE_TEST_LEN; i++) {
            expect = (unsigned char)((i + (int)round) & 0xFF);
            got    = AT24C64_ReadByte((uint16_t)i);

            if (got != expect) {
                err = 1;
                printf("  addr %d : 0x%02x  MISMATCH (expect 0x%02x)\r\n",
                       i, got, expect);
            } else {
                printf("  addr %d : 0x%02x  ok\r\n", i, got);
            }
        }

        printf("EEPROM TEST %s\r\n\r\n", err ? "FAIL" : "PASS");

        round++;
        delay_s(2);
    }
}
