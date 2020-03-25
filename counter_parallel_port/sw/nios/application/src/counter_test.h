/*
 * counter_test.h
 *
 *  Created on: Mar 24, 2020
 *      Author: vm
 */

#ifndef COUNTER_TEST_H_
#define COUNTER_TEST_H_

#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "sys/alt_stdio.h"

#define IRESETVAL 0 //Change the values if your register map is different than here
#define ICOUNTER 0
#define IRZ 1
#define ISTART 2
#define ISTOP 3
#define IIRQEN 4
#define ICLREOT 5
#define RESETVAL 0XFF000000 //Counter starts counting from this value
#define IRQENVAL 1
#define IRQDISVAL 0
#define CLREOTVAL 1
#define ARBITVAL 0X0000FFFF //Arbitrary writedata value used for addresses 1,2,3

void test_counter();

#endif /* COUNTER_TEST_H_ */
