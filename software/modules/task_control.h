/*!\file task_control.h
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 *  This module defines function relative to task control block (TCB)
 * \detailed
 * The TCB structure is defined, this structure stores information of the user's task
 * that are running into each slave processor.
 */

#ifndef TASK_CONTROL_H_
#define TASK_CONTROL_H_

#include "local_scheduler.h"

/**
 * \brief This structure stores information of the user's task
 * that are running into each slave processor.
 */
typedef struct {
    unsigned int reg[30];       	//!<30 registers (Vn,An,Tn,Sn,RA)
    unsigned int pc;            	//!<program counter
    unsigned int offset;        	//!<initial address of the task code in page
    int       	 id;            	//!<identifier
	unsigned int text_lenght;   	//!<Memory TEXT section lenght in bytes
    unsigned int data_lenght;		//!<Memory DATA section lenght in bytes
    unsigned int bss_lenght;		//!<Memory BSS section lenght in bytes
    unsigned int proc_to_migrate;	//!<Processor to migrate the task
    unsigned int master_address;	//!<Master address of the task

    unsigned int    secure;     //!<Task belong a secure application: 1 - yes; 0 - no
    unsigned int    MAC_status;  //!<MAC calculated is equal MAC received: 1 - yes; 0 - no

    Scheduling * scheduling_ptr;    //!<Scheduling structure used by task scheduler
    
} TCB;

void init_TCBs();

TCB * search_free_TCB();

TCB * searchTCB(unsigned int);

int is_another_task_running(int app_id);

int unblock_tasks_of_App(int app_id);

int freeze_tasks_of_cluster(int master);

int unfreeze_tasks_of_cluster(int master, int new_master);

int freeze_tasks_of_App(int );

int unfreeze_tasks_of_App(int master);

void clear_all_memory_areas(int app_id);

TCB * get_tcb_index_ptr(unsigned int);

void print_task();

void printTaskInformations(TCB *task_tcb, int text, int bss_data, int stack);


#endif /* TASK_CONTROL_BLOCK_H_ */
