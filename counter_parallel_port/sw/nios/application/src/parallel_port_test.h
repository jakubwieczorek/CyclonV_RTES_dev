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

// 2 downto 0: when 001 it means 0x04 instead of 0x01
#define IREGDIR   		0
#define IREGPORT  		(4*1)
#define IREGPIN_READ  	(0x02*4)
//#define PARIRQEN  		(0x05*4)
//#define PARIRQCLR 6
#define MODE_ALL_OUTPUT 0xFFFFFFFF
#define MODE_ALL_INPUT  0x00000000
//#define ALL_IRQ_EN      0xFF
//#define ALL_IRQ_CLR     0xFF

void test_parallel_port();

#endif /* PARALLEL_PORT_TEST_H_ */
