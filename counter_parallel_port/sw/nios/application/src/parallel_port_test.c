#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "sys/alt_stdio.h"

#define IREGDIR   0  //Change the values if your register map is different than
#define IREGPIN   1
#define IREGPORT  2
#define PARIRQEN  5
#define PARIRQCLR 6
#define MODE_ALL_OUTPUT 0xFF
#define MODE_ALL_INPUT  0X00
#define ALL_IRQ_EN      0XFF
#define ALL_IRQ_CLR     0xFF

void test_parallel_port() {
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
