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


void TransferCallback(void* report, int status)
{
	if (!status)
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b11000000); // Success
	else
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b01100000); // Fail
}

int main(void)
{
	alt_u32 message[2] = {0x00000001, 0xaa55aa55};
	int timeout     = 50000;
	alt_u32 status;
	int i;
	altera_avalon_mailbox_dev* mailbox_sender;

	mailbox_sender = altera_avalon_mailbox_open(MAILBOX_SIMPLE_0_NAME, TransferCallback, NULL);

	for(i=0;i<3000000;i++);
	timeout = 0;
	status = altera_avalon_mailbox_send (mailbox_sender, message, timeout, POLL);

	if (status)
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b01000000); // Fail
	else
		IOWR_32DIRECT(LEDS_0_BASE, 0, 0b10000000); // Success

	altera_avalon_mailbox_close (mailbox_sender);
	return 0;
}
