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

#include "counter.h"
#include "leds_service.h"
#include "interrupts_measurment.h"
#include "parallel_port_test.h"

#define SLEEP_DELAY_US (100 * 1000)

int main() {
	printf("DE1-SoC nios demo\n");

	test_parallel_port();
	usleep(SLEEP_DELAY_US);

	test_counter();
	usleep(SLEEP_DELAY_US);

	setup_leds();

	//setup_response_timer();
	setup_recovery_timer();

	while (true)
	{
		//measure_response_time();
		measure_recovery_time();

		handle_leds();
		usleep(SLEEP_DELAY_US);
	}

	return 0;
}
