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

#define size (44*10)

unsigned int data[size], result[size];

int main() {
	printf("DE1-SoC nios demo\n");

	for(int i = 0; i < size; i++) {
		IOWR_32DIRECT(&data[i], 0, 0x12345678);
		IOWR_32DIRECT(&result[i], 0, 0x00000000);
	}
	printf("aaa");
	bit_reshuffle_hardware_accelerator(&data[0], &result[0], size/44);
	printf("bbb");
	for(int i = 0; i < size; i+=1)
	{
		printf("0x%x, 0x%x\n",   IORD_32DIRECT(&data[i], 0), IORD_32DIRECT(&result[i], 0));
	}

	exit(EXIT_SUCCESS);
}
