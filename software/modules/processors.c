/*!\file processors.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module implements function relative to the slave processor management by the manager kernel.
 * This modules is used only by the manager kernel
 */

#include "processors.h"
#include "utils.h"
#include "define_pairs.h"
#include "seek.h"

extern int clusterID;
extern int PE_belong_SZ(int PE_x, int PE_y);
//Processor processors[MAX_CLUSTER_PEs];	//!<Processor array
//Shapes shapes[MAX_SHAPES];
//int shape_index;

/**Internal function to search by a processor - not visible to the other software part
 * \param proc_address Processor address to be searched
 * \return The processor pointer
 */
Processor * search_processor(int proc_address){

	for(int i=0; i<MAX_CLUSTER_PEs; i++){
		if (processors[i].address == proc_address){
			return &processors[i];
		}
	}

	puts("ERROR: Processor not found "); puts(itoh(proc_address)); puts("\n");
	while(1);
	return 0;
}

Processor * search_free_processor(){

    for(int i=0; i<MAX_CLUSTER_PEs; i++){
        if (processors[i].address == -1){
            return &processors[i];
        }
    }

    puts("ERROR: Free processor not found\n"); 
    while(1);
    return 0;
}

/**Gets the processor address stored in the index parameter
 * \param index Index of the processor address
 * \return The processor address (XY)
 */
int get_proc_address(int index){

	return processors[index].address;
}

/**Updates the processor slack time
 * \param proc_address Processor address
 * \param slack_time Slack time in percentage
 */
void update_proc_slack_time(int proc_address, int slack_time){

	Processor * p = search_processor(proc_address);

	p->slack_time += slack_time;

	p->total_slack_samples++;

}

/**Gets the processor slack time
 * \param proc_address Processor address
 * \return The processor slack time in percentage
 */
int get_proc_slack_time(int proc_address){

	Processor * p = search_processor(proc_address);

	if (p->total_slack_samples == 0){
		return 0;
	}

	return (p->slack_time/p->total_slack_samples);
}

/**Add a valid processor to the processors' array
 * \param proc_address Processor address to be added
 */
void add_processor(int proc_address){
	extern int net_address;
	//net_address = get_net_address();

	Processor * p = search_free_processor(); //Searches for a free slot

	if(proc_address != net_address)
		p->free_pages = MAX_LOCAL_TASKS;

	p->address = proc_address;

	p->slack_time = 0;

	p->total_slack_samples = 0;

	for(int i=0; i<MAX_LOCAL_TASKS; i++){
		p->task[i] = -1;
	}

}

/**Add a task into a processor. Called evenly when a task is mapped into a processor.
 * \param proc_address Processor address
 * \param task_id Task ID to be added
 */
void add_task(int proc_address, int task_id){

	Processor * p = search_processor(proc_address);

	//Index to add the task
	int add_i = -1;

	if (p->free_pages == 0){
        //putsv("ERROR: Free pages is 0 - not add task enabled for proc", proc_address);
		puts("ERROR: Free pages is 0 - not add task enabled for proc "); puts(itoh(proc_address)); puts("\n");
		while(1);
	}

	for(int i=0; i<MAX_LOCAL_TASKS; i++){
		if (p->task[i] == -1){
			add_i = i;
		}
		if (p->task[i] == task_id){
			putsv("ERROR: Task already added ", task_id);
			while(1);
		}
	}

	//add_i will be -1 when there is not more slots free into proc
	if (add_i > -1){
		p->task[add_i] = task_id;
		p->free_pages--;
	} else {
		putsv("ERROR: Not free slot into processor ", proc_address);
		while(1);
	}
}


void change_task(int proc_address, int task_id){

    int actual_taskID;
    Processor * p = search_processor(proc_address);
    //Application *app;
    //print_migrating_list();



    actual_taskID = get_task_id_FREEZING_in_migration_list(proc_address);
    set_migration_list_status(proc_address, MAPPING);

    for(int i=0; i<MAX_LOCAL_TASKS; i++){
        if (p->task[i] == actual_taskID){
            puts("Change taskID processor\n");
            p->task[i] = task_id;
        }
    }

//    app = get_application_ptr(taskID0>>4);  
//
//    for (int i=0; i<app->tasks_number; i++){
//        if(t->allocated_proc == proc_address){
//            t->allocated_proc = proc_address;
//            puts("Change taskID task\n");
//        }
//    }


}


/**Remove a task from a processor. Called evenly when a task is unmapped (removed) from a processor.
 * \param proc_address Processor address
 * \param task_id Task ID to be removed
 */
void remove_task(int proc_address, int task_id){

	Processor * p = search_processor(proc_address);

	if (p->free_pages == MAX_LOCAL_TASKS){
		putsv("ERROR: All pages free for proc", proc_address);
		// while(1);
		return;
	}

	for(int i=0; i<MAX_LOCAL_TASKS; i++){
		if (p->task[i] == task_id){
			p->task[i] = -1;
			p->free_pages++;
			return;
		}
	}

	putsv("ERROR: Task not found to remove ", task_id);
	//while(1);

}

/**Gets the total of free pages of a given processor
 * \param proc_address Processor address
 * \return The number of free pages
 */
int get_proc_free_pages(int proc_address){

	Processor * p = search_processor(proc_address);

	return p->free_pages;

}

/**Searches for a task location by walking for all processors within processors' array
 * \param task_id Task ID
 * \return The task location, i.e., the processor address that the task is allocated
 */
int get_task_location(int task_id){

	for(int i=0; i<MAX_CLUSTER_PEs; i++){

		if (processors[i].free_pages == MAX_LOCAL_TASKS || processors[i].address == -1){
			continue;
		}

		for(int t=0; t<MAX_LOCAL_TASKS; t++){

			if (processors[i].task[t] == task_id){

				return processors[i].address;
			}
		}
	}

	putsv("Warning: Task not found at any processor ", task_id);
	return -1;
}


/**Searches for all processors within processors' array with no taks
 * \param task_id Task ID
 * \return The task location, i.e., the processor address that the task is allocated
 FOCHI
 */
int get_free_processor(){ // retorna -1 se estiver nenhum PE sem tarefas SENAO volta o endereço do primeiro PE que encontrar sem tarefas
	int processors_with_task, PE_x, PE_y; 
	int processor_with_less_resources, processor_free_pages;

    processor_with_less_resources = -1;

	processor_free_pages = processors[1].free_pages;
    //for(int i=1; i<MAX_CLUSTER_PEs; i++){
	for(int i = MAX_CLUSTER_PEs -1; i > 0; i--){
			
		if (processors[i].free_pages == MAX_LOCAL_TASKS){
			processors_with_task = processors[i].address;
            PE_x = processors_with_task >> 8;
            PE_y = processors_with_task & 0XFF;
            if(PE_belong_SZ(PE_x, PE_y) != 1)
			     return processors_with_task;
            else
                continue;
		}
		else{
			if (processors[i].free_pages > processor_free_pages){
                    		PE_x = processors[i].address >> 8;
                    		PE_y = processors[i].address & 0XFF; 
                    		//puts("Conferindo2 Proc: \n");puts(itoh(processors[i].address));      
                    		if(PE_belong_SZ(PE_x, PE_y) != 1){
					processor_with_less_resources = processors[i].address;
					processor_free_pages = processors[i].free_pages;
                    		}
                    		else
                        		continue;                    
			}
		}		
	}

	return processor_with_less_resources;
}

int get_task_id_processor(int proc_address){ //Add by Fochi
//	int aux;
	Processor * p = search_processor(proc_address);
	if (MAX_LOCAL_TASKS == 1){
		//puts("\n"); puts("1p->task[0] ");puts(itoh(p->task[0]));
		//puts("\n"); puts("1p->task[1] ");puts(itoh(p->task[1])); puts("\n"); 
		//return (p->task[0]<<8)|0xff;
		//return (p->task[0]);
		return (0xFFFF<<16)|p->task[0]; //caimi
    }
    else{
        //puts("\n"); puts("p->task[0] ");puts(itoh(p->task[0]));
        //puts("\n"); puts("p->task[1] ");puts(itoh(p->task[1])); puts("\n");   
        return (p->task[0]<<16)|p->task[1];
	}
	
	
}


void clear_free_page_processor(int proc_address){ //Add by Fochi

	for(int i=0; i<MAX_CLUSTER_PEs; i++){			
		if (processors[i].address == proc_address)
			processors[i].free_pages = 0;		
	}	
}

void print_processors(){
	for(int i=0; i<MAX_CLUSTER_PEs; i++){
		puts("Index: "); puts(itoa(i));
		puts("  Endereco: "); puts(itoh(processors[i].address)); puts("\n");
	}
}


/**Initializes the processors's array with invalid values 
 */
void init_processors(){
    for(int i=0; i<MAX_CLUSTER_PEs; i++){
        processors[i].address = -1;
        processors[i].free_pages = 0;
        for(int t=0; t<MAX_LOCAL_TASKS; t++){
            processors[i].task[t] = -1;
        }
    }
    //print_processors();
}


void freeze_application(){
    int index, last_appID = -1, appID = 0;
    for(index = 0; index < MAX_MIGRATIONS; index++){

        if(migration_list[index].status == ACTIVE){
            migration_list[index].status = FREEZING;
            appID = migration_list[index].actual_taskID >> 8; 

            if(add_migrations(appID) == 1){
                Seek(FREEZE_TASK_SERVICE,  ((appID<<16) | (get_net_address()&0xffff)), appID, 0);
            }
        }
    }
}



void initialize_migration_list(){
    int index;

    for(index = 0; index < MAX_MIGRATIONS; index++){

        migration_list[index].status = OFF;

    }
}

void manage_SZ_migration(){
    int new_address, index;

    for(index = 0; index < MAX_MIGRATIONS; index++){
        if(migration_list[index].status == MAPPING){
            new_address = get_free_processor();
            puts("New processor: "); puts(itoh(new_address)); puts("\n");
            migration_list[index].status = MIGRATING;
            migration_list[index].new_address = new_address;
            page_used(clusterID, new_address, migration_list[index].actual_taskID);
            send_full_task_migration(migration_list[index].actual_taskID, migration_list[index].actual_address, new_address);
            break;
        }

    }
}


void print_migrating_list(){
    int index;

    for(index = 0; index < MAX_MIGRATIONS; index++){

        if(migration_list[index].status != OFF){
            puts("Actual processor: "); puts(itoh(migration_list[index].actual_address)); puts("\n");
            puts("         task ID: "); puts(itoh(migration_list[index].actual_taskID)); puts("\n");
            puts("          status: "); puts(itoh(migration_list[index].status)); puts("\n");

        }
    }
}

int get_task_id_FREEZING_in_migration_list(int proc_address){
    int index;
    for(index = 0; index < MAX_MIGRATIONS; index++){
        if((migration_list[index].status == FREEZING)&&(migration_list[index].actual_address == proc_address)){
            return migration_list[index].actual_taskID;
        }
    }
    return -1;
}


int remove_from_migration_list(int proc_address ,int task_ID){
    int index;
    print_migrating_list();


            puts("-------> processor: "); puts(itoh(proc_address)); puts("\n");
            puts("           task ID: "); puts(itoh(task_ID)); puts("\n");

    for(index = 0; index < MAX_MIGRATIONS; index++){
        if((migration_list[index].status == MIGRATING)&&(migration_list[index].actual_address == proc_address)&&(migration_list[index].actual_taskID == task_ID)){
            puts("found END MIGRATION \n");
            migration_list[index].status = OFF;
            return 1;
        }
    }
    puts("NOT found END MIGRATION \n");
    return 0;
}

int set_migration_list_status(int proc_address, int status){
    int index;
    for(index = 0; index < MAX_MIGRATIONS; index++){
        if((migration_list[index].status == FREEZING)&&(migration_list[index].actual_address == proc_address)){
            //puts("found freezing \n");
            migration_list[index].status = status;
            return 1;
        }
    }
    return 0;
}


int proc_is_migrating(int proc_address){
    int index;

    for(index = 0; index < MAX_MIGRATIONS; index++){

        if((migration_list[index].actual_address == proc_address) && (migration_list[index].status != OFF))
            return 1;
    }
    return 0;
}
