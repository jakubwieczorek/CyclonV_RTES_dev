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

#include "leds_service.h"
#include "service.h"

#define SLEEP_DELAY_US (100 * 1000)

int main() {
	printf("DE1-SoC nios demo\n");

	setup_leds();

	bit_reshuffle_hardware_accelerator();

	while (true)
	{
		handle_leds();
		usleep(SLEEP_DELAY_US);
	}

	return 0;
}
