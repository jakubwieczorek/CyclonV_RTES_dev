#include "parallel_port.h"

void test_parallel_port()
{
	volatile unsigned int k;

	IOWR_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR, MODE_ALL_OUTPUT);
	//Select Parport as output
	alt_printf("iRegDir=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR));
	//Read iRegDir to check whether it is written correct
	IOWR_8DIRECT(PARALLEL_PORT_0_BASE, IREGPORT, 0x9b);
	//Write Parport 0x9b as the output value
	alt_printf("iRegPort=%x\n",
			IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPORT));
	//Read iRegPort to check whether it is written correct
	//Switch LEDS should give 0x9b, observe it
	for (k = 0; k < 1000000; k++); //software delay
	IOWR_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR, MODE_ALL_INPUT);
	//Select Parport as input
	alt_printf("iRegDir=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGDIR));
	//Read iRegDir to check whether it is written correct
	//Change the input value to a value different than 0x9b by changing switch
	//positions
	alt_printf("iRegPin=%x\n", IORD_8DIRECT(PARALLEL_PORT_0_BASE, IREGPIN));
	//Read iRegPin to take the input Parport value
	for (k = 0; k < 1000000; k++)
		; //software delay
}
