///*
// * interrupts_measurment.c
// *
// *  Created on: Mar 22, 2020
// *      Author: vm
// */
//
#include "interrupts_measurment.h"
#include "counter.h"

static void response_isr(void* context);
static void recovery_isr(void* context);

static void response_isr(void* context)
{
	IOWR_ALTERA_AVALON_TIMER_SNAPL(TIMER_0_BASE, ARBITVAL);
	snapl = IORD_ALTERA_AVALON_TIMER_SNAPL(TIMER_0_BASE);
	snaph = IORD_ALTERA_AVALON_TIMER_SNAPH(TIMER_0_BASE);

	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,0); //Clear interrupt (ITO)
	IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0); //CLEAR TO
	flag=1; //Flag is a global variable
}

static void recovery_isr(void* context)
{
    IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,0);
    IOWR_ALTERA_AVALON_TIMER_STATUS(TIMER_0_BASE, 0);
    IOWR(INTERRUPT_COUNTER_0_BASE, ISTART, ARBITVAL); // start int timer
}

void setup_response_timer()
{
	alt_ic_isr_register(TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID,TIMER_0_IRQ, response_isr, NULL,NULL);
	flag=0 ; //Flag is a global variable
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,0); //Clear control register
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,2); //Continuous mode ON
	IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_0_BASE, 0xFFFF); //Set initial value
	IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_0_BASE, 0x00FF);//Set initial value
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,3); //Enable timer interrupt
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,7); //Start timer
}

void setup_recovery_timer()
{
	alt_ic_isr_register(TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID,TIMER_0_IRQ,recovery_isr, NULL,NULL);
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,0); //Clear control register
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,2); //Continuous mode ON
	IOWR_ALTERA_AVALON_TIMER_PERIODL(TIMER_0_BASE, 0xFFFF); //Set initial value
	IOWR_ALTERA_AVALON_TIMER_PERIODH(TIMER_0_BASE, 0x00FF); //Set initial value

	IOWR(INTERRUPT_COUNTER_0_BASE, IRZ, ARBITVAL); // reset interrupt_timer

	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,3); // enable timer interrupt
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,7); //Start timer
}

void measure_response_time()
{
	if(flag)
	{
		alt_printf("response time = %x \n",0xffff-snapl+1);

		flag=0;
		IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,7); //Enable IRQ and Start timer
	}
}

void measure_recovery_time()
{
	while(IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER)==0); // value of a timer is recovery time
	alt_printf("recovery time%x \n",IORD(INTERRUPT_COUNTER_0_BASE, ICOUNTER));

	// run it again
	IOWR(INTERRUPT_COUNTER_0_BASE, ISTOP, ARBITVAL);
	IOWR(INTERRUPT_COUNTER_0_BASE, IRZ, ARBITVAL);
	IOWR_ALTERA_AVALON_TIMER_CONTROL(TIMER_0_BASE,7);
}
