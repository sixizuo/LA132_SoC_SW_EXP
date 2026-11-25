#ifndef LA_IO_H			/* prevent circular inclusions */
#define LA_IO_H			/* by using protection macros */
#include "test.h"
#ifdef __cplusplus
extern "C" {
#endif

typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
/***************** Macros (Inline Functions) Definitions *********************/

/*
 * The following macros allow optimized I/O operations for memory mapped I/O.
 * It should be noted that macros cannot be used if synchronization of the I/O
 * operation is needed as it will likely break some code.
 */

/*****************************************************************************/
/**
*
* Performs an input operation for an 8-bit memory location by reading from the
* specified address and returning the value read from that address.
*
* @param	InputPtr contains the address to perform the input operation at.
*
* @return	The value read from the specified input address.
*
* @note		None.
*
******************************************************************************/
#define La_In8(InputPtr)  (*(volatile u8  *)(InputPtr))

/*****************************************************************************/
/**
*
* Performs an input operation for a 16-bit memory location by reading from the
* specified address and returning the value read from that address.
*
* @param	InputPtr contains the address to perform the input operation at.
*
* @return	The value read from the specified input address.
*
* @note		None.
*
******************************************************************************/
#define La_In16(InputPtr) (*(volatile u16 *)(InputPtr))

/*****************************************************************************/
/**
*
* Performs an input operation for a 32-bit memory location by reading from the
* specified address and returning the value read from that address.
*
* @param	InputPtr contains the address to perform the input operation at.
*
* @return	The value read from the specified input address.
*
* @note		None.
*
******************************************************************************/
#define La_In32(InputPtr)  (*(volatile u32 *)(InputPtr))


/*****************************************************************************/
/**
*
* Performs an output operation for an 8-bit memory location by writing the
* specified value to the the specified address.
*
* @param	OutputPtr contains the address to perform the output operation
*		at.
* @param	Value contains the value to be output at the specified address.
*
* @return	None
*
* @note		None.
*
******************************************************************************/
#define La_Out8(OutputPtr, Value)  \
	(*(volatile u8  *)((OutputPtr)) = (Value))

/*****************************************************************************/
/**
*
* Performs an output operation for a 16-bit memory location by writing the
* specified value to the the specified address.
*
* @param	OutputPtr contains the address to perform the output operation
*		at.
* @param	Value contains the value to be output at the specified address.
*
* @return	None
*
* @note		None.
*
******************************************************************************/
#define La_Out16(OutputPtr, Value) \
	(*(volatile u16 *)((OutputPtr)) = (Value))

/*****************************************************************************/
/**
*
* Performs an output operation for a 32-bit memory location by writing the
* specified value to the the specified address.
*
* @param	OutputPtr contains the address to perform the output operation
*		at.
* @param	Value contains the value to be output at the specified address.
*
* @return	None
*
* @note		None.
*
******************************************************************************/
#define La_Out32(OutputPtr, Value) \
	(*(volatile u32 *)((OutputPtr)) = (Value))


#ifdef __cplusplus
}
#endif

#endif