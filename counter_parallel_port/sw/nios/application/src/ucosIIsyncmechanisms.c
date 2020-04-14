/*************************************************************************
* Copyright (c) 2004 Altera Corporation, San Jose, California, USA.      *
* All rights reserved. All use of this software and documentation is     *
* subject to the License Agreement located at the end of this file below.*
**************************************************************************
* Description:                                                           *
* The following is a simple hello world program running MicroC/OS-II.The * 
* purpose of the design is to be a very simple application that just     *
* demonstrates MicroC/OS-II running on NIOS II.The design doesn't account*
* for issues such as checking system call return codes. etc.             *
*                                                                        *
* Requirements:                                                          *
*   -Supported Example Hardware Platforms                                *
*     Standard                                                           *
*     Full Featured                                                      *
*     Low Cost                                                           *
*   -Supported Development Boards                                        *
*     Nios II Development Board, Stratix II Edition                      *
*     Nios Development Board, Stratix Professional Edition               *
*     Nios Development Board, Stratix Edition                            *
*     Nios Development Board, Cyclone Edition                            *
*   -System Library Settings                                             *
*     RTOS Type - MicroC/OS-II                                           *
*     Periodic System Timer                                              *
*   -Know Issues                                                         *
*     If this design is run on the ISS, terminal output will take several*
*     minutes per iteration.                                             *
**************************************************************************/


#include <stdio.h>
#include <io.h>
#include <string.h>
#include "includes.h"
#include "system.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "altera_avalon_pio_regs.h"

#define ARBITVAL 0X0000FFFF
#define  ICOUNTER 0
#define  ISTART 2

/* Definition of Task Stacks */
#define   TASK_STACKSIZE       2048
OS_STK    semTask_stk[TASK_STACKSIZE];
OS_STK    flagTask_stk[TASK_STACKSIZE];
OS_STK    mailboxTask_stk[TASK_STACKSIZE];
OS_STK    queueTask_stk[TASK_STACKSIZE];

/* Definition of Task Priorities */

#define SEMTASK_PRIORITY      1
#define FLAGTASK_PRIORITY      2
#define MAILBOXTASK_PRIORITY      3
#define QUEUETASK_PRIORITY      4

typedef struct MailboxInfo{
	char edge[10];
	int time;
	int button;
} MBInfo;

OS_EVENT* mainSem;
OS_FLAG_GRP* mainFlagGrp;
OS_FLAGS mainFlags;
OS_EVENT* mailbox;
void* message;
OS_EVENT* queue;
void* queueMsg[10];
INT8U err;

unsigned int customTimerStart;
unsigned int customTimerFinish;
MBInfo myMBInfo;

void semTask(void* pdata)
{
	int semcounter = 0;
	while (1)
	{
		printf("Hello from semaphore wait %d\n", semcounter++);
		OSSemPend(mainSem, 0 , &err);
		customTimerFinish = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);

		printf("Time elapsed : %d\n", customTimerStart-customTimerFinish);

		IOWR_32DIRECT(NIOS_LEDS_BASE, 0, 0b0001000000);
	}
}

void flagTask(void* pdata)
{
	while (1)
	{
		printf("Hello from flag wait\n");

		//OSFlagPend(mainFlagGrp, 0b111, OS_FLAG_WAIT_SET_ANY, 0, &err);
		OSFlagPend(mainFlagGrp, 0b111, OS_FLAG_WAIT_SET_ALL, 0, &err);

		customTimerFinish = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);

		OSFlagPost(mainFlagGrp, 0b111 , OS_FLAG_CLR, &err);

		printf("Time elapsed : %d\n", customTimerStart-customTimerFinish);
		IOWR_32DIRECT(NIOS_LEDS_BASE, 0, 0b0001100000);
	}
}

void mailboxTask(void* pdata)
{
	while (1)
	{
		printf("Hello from mailbox wait\n");

		MBInfo* pmb = OSMboxPend(mailbox, 0, &err);
		customTimerFinish = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);
		pmb->time -= customTimerFinish;
		printf("message from mailbox : %d, %s, %d \n", pmb->button, pmb->edge, pmb->time);

		printf("Time elapsed : %d\n", customTimerStart-customTimerFinish);
		IOWR_32DIRECT(NIOS_LEDS_BASE, 0, 0b0001110000);
	}
}

void queueTask(void* pdata)
{
	while (1)
	{
		printf("Hello from queue wait\n");

		MBInfo * pmb = OSQPend(queue, 0, &err);
		/*customTimerFinish = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);
		pmb->time -= customTimerFinish;
		if(pmb)
			printf("message from queue : %d, %s, %d \n", pmb->button, pmb->edge, pmb->time);
		else
			printf("queue is empty :(\n");

		printf("Time elapsed : %d\n", customTimerStart-customTimerFinish);*/
		IOWR_32DIRECT(NIOS_LEDS_BASE, 0, 0b0001111000);
	}
}




static void my_isr(void* context)
{
	int buttonNumber = 0b111^IORD_32DIRECT(NIOS_BUTTONS_BASE, 0);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(NIOS_BUTTONS_BASE, 1);

	/*	------------------ SEMAPHORE ------------------------- */

	//OSSemPost(mainSem);


	/* ------------------ FLAGS ------------------------- */
/*
	OS_FLAGS buttonLocalFlag = 0b111^IORD_32DIRECT(NIOS_BUTTONS_BASE, 0);
	//OSFlagPost(mainFlagGrp, 0b111 , OS_FLAG_CLR, &err);
	OSFlagPost(mainFlagGrp, buttonLocalFlag, OS_FLAG_SET, &err);
*/

	/* ------------------ MAILBOX ------------------------- */

/*
	myMBInfo.button = buttonNumber;
	if(buttonNumber > 0)
		strcpy(myMBInfo.edge ,"RISING");
	else
		strcpy(myMBInfo.edge ,"FALLING");

	OSMboxPost(mailbox, &myMBInfo);
	myMBInfo.time = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);
*/

	/* ------------------ QUEUE ------------------------- */


	myMBInfo.button = buttonNumber;
	if(buttonNumber > 0)
		strcpy(myMBInfo.edge ,"RISING");
	else
		strcpy(myMBInfo.edge ,"FALLING");


	OSQPost(queue, &myMBInfo);
	//myMBInfo.time = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);




	/* ------------------ Timing measurements start ------------------------- */


	//customTimerStart = IORD(INTERRUPT_COUNTER_0_BASE , ICOUNTER);

	IOWR_32DIRECT(NIOS_LEDS_BASE, 0, 0b111^IORD_32DIRECT(NIOS_BUTTONS_BASE, 0));

}

void setup_isr ()
{
	IOWR_32DIRECT(NIOS_LEDS_BASE, 0, 0b1000000001);
	alt_ic_isr_register(NIOS_BUTTONS_IRQ_INTERRUPT_CONTROLLER_ID ,NIOS_BUTTONS_IRQ ,my_isr , NULL ,NULL);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(NIOS_BUTTONS_BASE, 1);
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(NIOS_BUTTONS_BASE, 7);
}

int main(void)
{
	setup_isr();
	IOWR(INTERRUPT_COUNTER_0_BASE , ISTART , ARBITVAL);
	mainSem = OSSemCreate(0);
	mainFlagGrp = OSFlagCreate(mainFlags, &err);
	mailbox = OSMboxCreate(message);
	queue = OSQCreate(&queueMsg[0],10);

	/* ------------------ UCOS-II METHOD ------------------------- */


	OSTaskCreateExt(semTask,
					  NULL,
					  (void *)&semTask_stk[TASK_STACKSIZE-1],
					  SEMTASK_PRIORITY,
					  SEMTASK_PRIORITY,
					  semTask_stk,
					  TASK_STACKSIZE,
					  NULL,
					  0);

	OSTaskCreateExt(flagTask,
					  NULL,
					  (void *)&flagTask_stk[TASK_STACKSIZE-1],
					  FLAGTASK_PRIORITY,
					  FLAGTASK_PRIORITY,
					  flagTask_stk,
					  TASK_STACKSIZE,
					  NULL,
					  0);

	OSTaskCreateExt(mailboxTask,
					  NULL,
					  (void *)&mailboxTask_stk[TASK_STACKSIZE-1],
					  MAILBOXTASK_PRIORITY,
					  MAILBOXTASK_PRIORITY,
					  mailboxTask_stk,
					  TASK_STACKSIZE,
					  NULL,
					  0);

	OSTaskCreateExt(queueTask,
					  NULL,
					  (void *)&queueTask_stk[TASK_STACKSIZE-1],
					  QUEUETASK_PRIORITY,
					  QUEUETASK_PRIORITY,
					  queueTask_stk,
					  TASK_STACKSIZE,
					  NULL,
					  0);


	OSStart();

	return 0;
}

