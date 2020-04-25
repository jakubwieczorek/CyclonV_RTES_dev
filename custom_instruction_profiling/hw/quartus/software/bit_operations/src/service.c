/*
 * service.c
 *
 *  Created on: Apr 22, 2020
 *      Author: vm
 */
#include "service.h"

unsigned int RegAddStart 		= 0*4;
unsigned int RegLgt 	  		= 1*4;
unsigned int ResultRegAddStart  = 3*4;
unsigned int start 				= 2*4;
unsigned int operation 			= 4*4;
unsigned int finish 			= 5*4;

void bit_reshuffle_hardware_accelerator()
{
	unsigned int size = 1;
	unsigned int data[size], result[size];

	IOWR_32DIRECT(&data[0], 0, 0x12345678);
	IOWR_32DIRECT(&result[0], 0, 0x00000000);
	printf("data      =0x%x\n",   IORD_32DIRECT(&data[0], 0));
	printf("result      =0x%x\n",   IORD_32DIRECT(&result[0], 0));

	// prepare accelerator
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, RegAddStart, (unsigned int)&data[0]);
	printRegisters();
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, RegLgt, size);
	printRegisters();
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, ResultRegAddStart, (unsigned int)&result[0]);
	printRegisters();
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, operation, 0x00000001);
	printRegisters();
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, start, 0x00000001); // start
	printRegisters();

	// check if addresses in DMA(accelerator) and in CPU (NIOS) are the same
	printf("Address in DMA      =0x%x\n",   IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, RegAddStart));
	printf("Address in CPU      =0x%x\n\n",   (unsigned int)&data[0]);

	// wait for accelerator finish
	while(!IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, finish)) {;}

	// print result
	printf("data      =0x%x\n",   IORD_32DIRECT(&data[0], 0));
	printf("result      =0x%x\n",   IORD_32DIRECT(&result[0], 0));

	// prepare for second operation
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, operation, 0x00000000);
	printRegisters();
	IOWR_32DIRECT(SWAP_ACCELERATOR_0_BASE, start, 0x00000001); // start
	printRegisters();

	// check addresses once again, wait and finaly print the result
	printf("Address in DMA      =0x%x\n",   IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, RegAddStart));
	printf("Address in CPU      =0x%x\n\n",   (unsigned int)&data[0]);

	while(!IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, finish)) {;}

	printf("data      =0x%x\n",   IORD_32DIRECT(&data[0], 0));
	printf("result      =0x%x\n",   IORD_32DIRECT(&result[0], 0));
}

void printRegisters()
{
	printf("RegAddStart      =0x%x\n",   IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, RegAddStart));
	printf("RegLgt           =0x%x\n", 	 IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, RegLgt));
	printf("ResultRegAddStart=0x%x\n",   IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, ResultRegAddStart));
	printf("start            =0x%x\n\n", IORD_32DIRECT(SWAP_ACCELERATOR_0_BASE, start));
}

