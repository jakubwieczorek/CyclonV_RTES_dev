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
#include "altera_avalon_mailbox_simple.h"

void ReceiveCallBack(void* message)
{
	/* Get message read from mailbox */
	alt_u32* data = (alt_u32*) message;
	if (message!= NULL)
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b00110000); // Success
	else
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b00011000); // Fail
}


int main(void)
{
	alt_u32* rmessage[2];
	int timeout     = 50000;
	altera_avalon_mailbox_dev* mailbox_rcv;

	/* This example is running on receiver processor */
	mailbox_rcv = altera_avalon_mailbox_open("/dev/mailbox_simple_1", NULL, ReceiveCallBack);

	/* For interrupt disable system */
	altera_avalon_mailbox_retrieve_poll(mailbox_rcv, rmessage, timeout);

	if (rmessage == NULL)
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b00010000); // Fail
	else
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b00100000); // Success

	altera_avalon_mailbox_close (mailbox_rcv);
	return 0;
}
