/*
 * main.c
 *
 *  Created on: Mar 21, 2020
 *      Author: vm
 */

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"

#include "sys/alt_stdio.h"

#include "leds_service.h"
#include "service.h"

#define SLEEP_DELAY_US (100 * 1000)

#define size 1000000
unsigned int data[size], result[size];

int main() {
	printf("DE1-SoC nios demo\n");

	setup_leds();

	for(int i = 0; i < size; i++) {
		IOWR_32DIRECT(&data[i], 0, 0x12345678);
		IOWR_32DIRECT(&result[i], 0, 0x00000000);
		//IOWR_32DIRECT(&result[i], 0, 0x78563412);
	}
	printf("A\n");
	bit_reshuffle_hardware_accelerator(&data[0], &result[0], size);
	printf("B\n");
//	for(int i = 0; i < size; i++){
//		printf("result      =0x%x, 0x%x\n",   &result[i], IORD_32DIRECT(&result[i], 0));
//	}
//
//	while (true)
//	{
//		handle_leds();
//		usleep(SLEEP_DELAY_US);
//	}

	printf("DE1-SoC nios done\n");
	//exit(EXIT_SUCCESS);
}
