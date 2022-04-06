/*!\file processors.h
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module defines function relative to the slave processor management by the manager kernel.
 * \detailed
 * The Processor structure is defined, this structure stores information relative the slave processor, which are used by the
 * kernel master to search task locations and get the number of free pages of each slave during the mapping processes
 */

#ifndef PROCESSOR_H_
#define PROCESSOR_H_

#include "../../include/kernel_pkg.h"


#define MAX_MIGRATIONS 10

#define OFF             0
#define ACTIVE          1
#define FREEZING        2
#define MAPPING         3
#define MIGRATING       4


/**
 * \brief This structure store variables used to manage the processors attributed by the kernel master
 */
typedef struct {
	int address;						//!<Processor address in XY
	int free_pages;						//!<Number of free memory pages // FOCHI MODIFICAR
	int slack_time;						//!<Slack time (idle time), represented in percentage
	unsigned int total_slack_samples;	//!<Number of slack time samples
	int task[MAX_LOCAL_TASKS]; 			//!<Array with the ID of all task allocated in a given processor
} Processor;

typedef struct 
{
  int status;
  int actual_address;
  int actual_taskID;
  int new_address;
} Migrations;

Migrations migration_list[MAX_MIGRATIONS];
Processor processors[MAX_CLUSTER_PEs];	//!<Processor array

int shape_index;

void init_processors();

void update_proc_slack_time(int, int);

int get_proc_slack_time(int);

void add_processor(int);

void add_task(int, int);
void print_processors();

void remove_task(int, int);

int get_proc_free_pages(int);

int get_proc_address(int);

int get_task_location(int);

int get_free_processor(); //Add by Fochi

int get_free_processor_or_any_processor(); //Add by Fochi

int get_task_id_processor(int proc_address); //Add by Fochi

void clear_free_page_processor(int proc_address); //Add by Fochi

int get_shape_index(int);

int proc_is_migrating(int proc_address);

int remove_from_migration_list(int, int );

void print_migrating_list();

int get_task_id_FREEZING_in_migration_list(int proc_address);

int set_migration_list_status(int proc_address, int status);

void freeze_application();

#endif /* PROCESSOR_H_ */
