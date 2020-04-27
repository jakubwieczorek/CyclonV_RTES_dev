/*
 * leds_service.h
 *
 *  Created on: Mar 27, 2020
 *      Author: vm
 */

#ifndef LEDS_SERVICE_H_
#define LEDS_SERVICE_H_

#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"

#include "sys/alt_stdio.h"

void setup_leds();

void handle_leds();

#endif /* LEDS_SERVICE_H_ */
