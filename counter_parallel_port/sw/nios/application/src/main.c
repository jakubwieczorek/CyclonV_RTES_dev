/*
 * main.c
 *
 *  Created on: Mar 21, 2020
 *      Author: vm
 */

#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"

#include "sys/alt_stdio.h"

#include "counter_test.h"
#include "interrupts_measurment.h"
#include "parallel_port_test.h"

#define SLEEP_DELAY_US (100 * 1000)

void setup_leds()
{
	// Switch on first LED only
	IOWR_ALTERA_AVALON_PIO_DATA(NIOS_LEDS_BASE, 0x1);
}

void handle_leds()
{
	uint32_t leds_mask = IORD_ALTERA_AVALON_PIO_DATA(NIOS_LEDS_BASE);

	// if current leds status is different then 1 on the most significant bit
	if (leds_mask != (0x01 << (NIOS_LEDS_DATA_WIDTH - 1)))
	{
		// rotate leds
		leds_mask <<= 1;
	} else
	{
		// reset leds
		leds_mask = 0x1;
	}

	IOWR_ALTERA_AVALON_PIO_DATA(NIOS_LEDS_BASE, leds_mask);
}

#define IREGDIR   0  //Change the values if your register map is different than
#define IREGPIN   1
#define IREGPORT  2
#define PARIRQEN  5
#define PARIRQCLR 6
#define MODE_ALL_OUTPUT 0xFF
#define MODE_ALL_INPUT  0X00
#define ALL_IRQ_EN      0XFF
#define ALL_IRQ_CLR     0xFF

int main() {
	printf("DE1-SoC nios demo\n");

	test_parallel_port();
	usleep(SLEEP_DELAY_US);

	test_counter();
	usleep(SLEEP_DELAY_US);

	setup_leds();

	setup_timer();

	while (true)
	{
		if(flag)
		{
			alt_printf("snapl = %x \n", snapl);
			alt_printf("snaph = %x \n", snapl);
			alt_printf("0xffff-snap+1 = %x \n",0xffff-snapl+1);
			alt_printf("snaph-snap+1 = %x \n",snaph-snapl+1);

			flag=0;
			IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,7); //Enable IRQ and Start timer
		}

		handle_leds();
		usleep(SLEEP_DELAY_US);
	}

	return 0;
}
