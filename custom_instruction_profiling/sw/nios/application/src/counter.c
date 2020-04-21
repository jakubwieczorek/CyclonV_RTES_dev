///*
// * counter_test.c
// *
// *  Created on: Mar 24, 2020
// *      Author: vm
// */
#include "counter.h"

void test_counter()
{
	// reset
	IOWR(INTERRUPT_COUNTER_0_BASE, IRZ, ARBITVAL); // ARBITVAL does not matter
	alt_printf("iCounter after reset= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));

	//start
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTART, ARBITVAL);
	alt_printf("iCounter after start= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));

	// stop two times,  should give the same result
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTOP, ARBITVAL);
	alt_printf("iCounter after stop1= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));
	alt_printf("iCounter after stop2= %x\n", IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));

	// restart and read two times, should give different result
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTART, ARBITVAL);
	alt_printf("iCounter after restart1=%x\n",IORD(INTERRUPT_COUNTER_0_BASE,ICOUNTER));
	alt_printf("iCounter after restart2=%x\n",IORD(INTERRUPT_COUNTER_0_BASE,ICOUNTER));

	IOWR(INTERRUPT_COUNTER_0_BASE, ISTOP, ARBITVAL);
}
