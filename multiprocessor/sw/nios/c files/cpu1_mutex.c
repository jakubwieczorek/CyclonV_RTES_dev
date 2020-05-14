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
#include "altera_avalon_mutex_regs.h"
#include "altera_avalon_mutex.h"

int main(void)
{
	alt_mutex_dev* mutex = altera_avalon_mutex_open("/dev/mutex_0");
	int i;

	for(i = 0;i <1500000;i++);

	while(1)
	{
		altera_avalon_mutex_lock(mutex, 2);
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b0000000010);
		altera_avalon_mutex_unlock(mutex);
		for(i = 0;i <3000000;i++);
	}
  return 0;
}
