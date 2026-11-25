#ifndef _PRINTF_H_
#define _PRINTF_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdarg.h>
#include <stddef.h>

int printf(const char* format, ...);

#ifdef __cplusplus
}
#endif

#endif  // _PRINTF_H_
