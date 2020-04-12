///*
// * interrupts_measurment.h
// *
// *  Created on: Mar 22, 2020
// *      Author: vm
// */
//
#ifndef INTERRUPTS_MEASURMENT_H_
#define INTERRUPTS_MEASURMENT_H_

#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "altera_avalon_timer.h"
#include "altera_avalon_timer_regs.h"

#define IRESETVAL 0 //Change the values if your register map is different thanhre
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

volatile int flag;
int snapl;
int snaph;

void setup_response_timer();
void setup_recovery_timer();
void measure_recovery_time();
void measure_response_time();
void measure_response_recovery_time_par_port();

#endif /* INTERRUPTS_MEASURMENT_H_ */
