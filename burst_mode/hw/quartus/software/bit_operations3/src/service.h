/*
 * service.h
 *
 *  Created on: Apr 22, 2020
 *      Author: vm
 */

#ifndef SRC_SERVICE_H_
#define SRC_SERVICE_H_

#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "sys/alt_stdio.h"

void bit_reshuffle_hardware_accelerator(unsigned int *data, unsigned int *result, unsigned int size);
void bit_reshuffle_hardware_accelerator_test();
void printRegisters();

#endif /* SRC_SERVICE_H_ */
