/**
 * @file    font.c
 * @brief   字模数据的唯一编译单元
 * @Author: WorkBuddy
 * @Date:   2026-10-31
 *
 *  font.h 里的两张点阵表以前是**在头文件里定义**的, 一旦被两个 .c 同时
 *  包含就报 multiple definition。现在只在编译本文件时定义 FONT_DATA_DEFINE,
 *  其余文件包含 font.h 只得到 extern 声明。
 *
 *  字库内容 (来自 hw 提供的 font.h, 未改动):
 *      Char_Font_24x48[][24]   '0'~'9XYZ' 24x48 大字号
 *      Char_Font_16x16[][16]   '!'(0x21) ~ '~'(0x7E) 共 94 个 16x16
 *                              逐行式、低位在左
 */
#define FONT_DATA_DEFINE
#include "font.h"
