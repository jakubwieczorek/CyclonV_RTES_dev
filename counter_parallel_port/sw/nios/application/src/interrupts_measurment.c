///*
// * interrupts_measurment.c
// *
// *  Created on: Mar 22, 2020
// *      Author: vm
// */
//
#include "interrupts_measurment.h"

static void my_isr(void* context);

static void my_isr(void* context)
{
	IOWR_ALTERA_AVALON_TIMER_SNAPL(TIMER_0_BASE, ARBITVAL);
	snapl = IORD_ALTERA_AVALON_TIMER_SNAPL(TIMER_0_BASE);
	snaph = IORD_ALTERA_AVALON_TIMER_SNAPH(TIMER_0_BASE);

	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,0); //Clear interrupt (ITO)
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0); //CLEAR TO
	flag=1; //Flag is a global variable
}

void setup_timer()
{
	alt_ic_isr_register(TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID,TIMER_0_IRQ, my_isr, NULL,NULL);
	flag=0 ; //Flag is a global variable
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,0); //Clear control register
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,2); //Continuous mode ON
	IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_0_BASE, 0xFFFF); //Set initial value
	IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_0_BASE, 0x00FF);//Set initial value
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,3); //Enable timer interrupt
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,7); //Start timer
}
