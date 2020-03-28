///*
// * parallel_port.h
// *
// *  Created on: Mar 21, 2020
// *      Author: vm
// */
//
#ifndef PARALLEL_PORT_TEST_H_
#define PARALLEL_PORT_TEST_H_

#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <unistd.h>
#include "io.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"
#include "sys/alt_stdio.h"

#define IREGDIR   0  //Change the values if your register map is different than
#define IREGPIN   1
#define IREGPORT  2
#define PARIRQEN  5
#define PARIRQCLR 6
#define MODE_ALL_OUTPUT 0xFFFF
#define MODE_ALL_INPUT  0X0000
#define ALL_IRQ_EN      0XFF
#define ALL_IRQ_CLR     0xFF

void test_parallel_port();

#endif /* PARALLEL_PORT_TEST_H_ */
