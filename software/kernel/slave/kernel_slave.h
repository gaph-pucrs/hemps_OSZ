/*!\file kernel_slave.h
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Edited by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * kernel_slave is the core of the OS running into the slave processors
 *
 * \detailed
 * Its job is to runs the user's task. It communicates whit the kernel_master to receive new tasks
 * and also notifying its finish.
 * The kernel_slave file uses several modules that implement specific functions
 */

#ifndef __KERNEL_SLAVE_H__
#define __KERNEL_SLAVE_H__

#define SLAVEpeHERE 1

#include "../../modules/task_control.h"
#include "../../include/api.h"

/*
 * ENABLE MODULES
 */

int get_cluster_ID(int x, int y);
 
#define MIGRATION_ENABLED			1		//!< Enable or disable the migration module
#define AP_THRESHOLD_VALUE			4		// (N-1) IOs < 4 = 5 IOs>
// #define AUTH_PROTOCOL


extern unsigned int ASM_SetInterruptEnable(unsigned int);
extern void ASM_SaveRemainingContext(TCB*);
extern void ASM_RunScheduledTask(TCB*);
void OS_InterruptServiceRoutine(unsigned int);

// ISR
unsigned int OS_InterruptMaskSet(unsigned int);
unsigned int OS_InterruptMaskClear(unsigned int);

void OS_Init();
void OS_Idle();

void Scheduler();

#endif
