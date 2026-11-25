/**
 * @file    demo_ddr_test.h
 * @brief   DDR3 1GB 存储空间读写测试
 */
#ifndef _DEMO_DDR_TEST_H_
#define _DEMO_DDR_TEST_H_

#ifdef __cplusplus
extern "C" {
#endif

/** DDR3 1GB 读写测试入口 (不返回, 测完死循环) */
void ddr_test_demo(void);

#ifdef __cplusplus
}
#endif

#endif /* _DEMO_DDR_TEST_H_ */
