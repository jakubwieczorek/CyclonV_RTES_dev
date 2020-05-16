/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include "system.h"
#include "io.h"
#include "altera_avalon_mutex.h"

#define COUNTER_ADD_WR_ADRESS 7*4
#define COUNTER_VALUE_RD_ADRESS 0*4

int main(void)
{
	int value = 0;
	alt_mutex_dev* mutex = altera_avalon_mutex_open(MUTEX_0_NAME);
	int i;
	while(1)
	{
		for(i = 0;i <1000000;i++);
		altera_avalon_mutex_lock(mutex, 2);
		IOWR_32DIRECT(INTERRUPT_COUNTER_0_BASE, COUNTER_ADD_WR_ADRESS, 1);
		value = IORD_32DIRECT(INTERRUPT_COUNTER_0_BASE, COUNTER_VALUE_RD_ADRESS);
		IOWR_32DIRECT(LEDS_0_BASE, 0, value);
		altera_avalon_mutex_unlock(mutex);
	}
	return 0;
}
