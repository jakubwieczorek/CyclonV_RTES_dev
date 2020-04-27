/*
 * leds_service.c
 *
 *  Created on: Mar 27, 2020
 *      Author: vm
 */
#include "leds_service.h"

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
