#include "parallel_port_test.h"

void test_parallel_port()
{
	volatile unsigned int k;

	IOWR_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR, MODE_ALL_OUTPUT);
	alt_printf("iRegPort=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPORT));
	alt_printf("iRegPin=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPIN_READ)); // the same value as IREGPORT
	alt_printf("iRegDir=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR));

//	IOWR_8DIRECT(PARALLEL_PORT_0_BASE, IREGPORT, 0x9b);
//	alt_printf("iRegPort=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPORT));
//	alt_printf("iRegPin=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPIN_READ)); // the same value as IREGPORT
//	alt_printf("iRegDir=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR));

	//Read iRegPort to check whether it is written correct
	//Switch LEDS should give 0x9b, observe it
//	for (k = 0; k < 1000000; k++); //software delay
//	IOWR_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR, MODE_ALL_INPUT);
//	//Select Parport as input
//	alt_printf("iRegDir=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR));
//	//Read iRegDir to check whether it is written correct
//	//Change the input value to a value different than 0x9b by changing switch
//	//positions
//	alt_printf("iRegPin=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPIN)); // 00 CAUSE GPIO_1 not changed
//	//Read iRegPin to take the input Parport value
//	for (k = 0; k < 1000000; k++)
//		; //software delay
}
