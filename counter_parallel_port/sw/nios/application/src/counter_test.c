/*
 * counter_test.c
 *
 *  Created on: Mar 24, 2020
 *      Author: vm
 */
#include "counter_test.h"

void test_counter()
{
	IOWR(INTERRUPT_COUNTER_0_BASE, IRESETVAL, RESETVAL);
	//Reset value is loaded
	IOWR(INTERRUPT_COUNTER_0_BASE, IRZ, ARBITVAL);
	//Reset activated to load the counter with the reset value
	alt_printf("iCounter after reset= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));
	//Check that counter is loaded with the reset value
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTART, ARBITVAL);
	//Start the counter
	alt_printf("iCounter after start= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));
	//Read a value from the running counter
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTOP, ARBITVAL);
	alt_printf("iCounter after stop1= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));
	alt_printf("iCounter after stop2= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));
	//Two consecutive reads to test that the counter is stopped. They shouldgive the same result
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTART, ARBITVAL);
	//Restart the counter
	alt_printf("iCounter after restart1=%x\n",IORD(INTERRUPT_COUNTER_0_BASE,ICOUNTER));
	alt_printf("iCounter after restart2=%x\n",IORD(INTERRUPT_COUNTER_0_BASE,ICOUNTER));
	//Two consecutive reads to test that the counter is stopped. They should give different results
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTOP, ARBITVAL);
}
