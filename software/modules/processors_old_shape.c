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

Processor processors[MAX_CLUSTER_PEs];	//!<Processor array
Shapes shapes[MAX_SHAPES];

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

	putsv("ERROR: Processor not found ", proc_address);
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
void add_procesor(int proc_address){
	extern int net_address;
	//net_address = get_net_address();

	Processor * p = search_processor(-1); //Searches for a free slot

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
		putsv("ERROR: Free pages is 0 - not add task enabled for proc", proc_address);
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
	while(1);

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
	int processors_with_task; 
	int processor_with_less_resources, processor_free_pages;

	processor_with_less_resources = processors[0].address;
	processor_free_pages = processors[0].free_pages;
	for(int i=0; i<MAX_CLUSTER_PEs; i++){
			
		if (processors[i].free_pages == MAX_LOCAL_TASKS){
			processors_with_task=processors[i].address;
			return processors_with_task;
		}
		else{
				if (processors[i].free_pages > processor_free_pages){
						processor_with_less_resources = processors[i].address;
						processor_free_pages = processors[i].free_pages;
				}
		}		
	}
	return processor_with_less_resources;
}

void set_free_page_processor(int proc_address){ //Add by Fochi

	for(int i=0; i<MAX_CLUSTER_PEs; i++){			
		if (processors[i].address == proc_address)
			processors[i].free_pages = 0;		
	}	
}

/**Initializes the processors's array with invalid values
 */
void init_procesors(){
	for(int i=0; i<MAX_CLUSTER_PEs; i++){
		processors[i].address = -1;
		processors[i].free_pages = 0;
		for(int t=0; t<MAX_LOCAL_TASKS; t++){
			processors[i].task[t] = -1;
		}
	}
}


/**Initializes the processors's array with invalid values
 */
//void print_processors(){
//	for(int i=0; i<MAX_CLUSTER_PEs; i++){
//		puts("Index: "), puts(itoh(i));
//		puts("  Endereco: "), puts(itoh(processors[i].address)); puts("\n");
//	}
//}

//*********************************************************************************************
/** Shape search and recognition
*/
int shape_recog(int X_size, int Y_size, int X_init, int Y_init){
	int  x, y, desl_Y;
	//int X_init, Y_init;

	//sucess = 1;
	for(y = 0; y<Y_size; y++){
		desl_Y = (y+Y_init)*XCLUSTER;
		for(x = 0 + X_init; x<X_size+X_init; x++){
			//printf("\nIndex: %d", x+desl_Y);
			//if(processor_resources[x+desl_Y] == MAX_TASKS)
			if(processors[x+desl_Y].free_pages == MAX_LOCAL_TASKS){
				//puts("Endereco: "), puts(itoh(processors[x+desl_Y].address)); puts("\n");
				continue;
			}
			else{
				//x = X_CLUSTER_DIM;
				//y = Y_CLUSTER_DIM;
				//sucess = 0;
				//printf("\nMiss Resources: %d", x+desl_Y);
				return 0;
			}
		}
	}
	return 1;
}


int search_shape_in_cluster(int X_size, int Y_size){
	int x, y, found;
	for(y = 0; y<=YCLUSTER-Y_size; y++)
		for(x = 0; x<=XCLUSTER-X_size; x++){
			//printf("\nX: %d Y: %d - X0: %d Y0: %d", X_size, Y_size, x, y);
			found = shape_recog(X_size, Y_size, x, y);
			//printf("\nFOUND = %d", found);
			if(found == 1)
				return (x<<8) + y;
				//return processors[x+(y*XCLUSTER)].address;
		}
	return -1;
}

int search_shape(int PEs_number){
	int x, result;

	for(x = 0; x < MAX_SHAPES; x++){
		if(shapes[x].processors == PEs_number){
			result = search_shape_in_cluster(shapes[x].X_size, shapes[x].Y_size);
			if(result != -1){
				result = (shapes[x].X_size << 24 | shapes[x].Y_size << 16) | result;
				//result = ( (( shapes[x].X_size  + (result >> 8) -1) << 24) | ((shapes[x].Y_size + (result & 0xFF) -1) << 16)) | result;
				return result;
			}
		}
		if(shapes[x].processors > PEs_number)
			result = -1;
	}
	return result;
}

void init_shapes(){
	shapes[0].processors = 1;
	shapes[0].X_size = 1;
	shapes[0].Y_size = 1;

	shapes[1].processors = 2;
	shapes[1].X_size = 1;
	shapes[1].Y_size = 2;

	shapes[2].processors = 2;
	shapes[2].X_size = 2;
	shapes[2].Y_size = 1;

	shapes[3].processors = 3;
	shapes[3].X_size = 2;
	shapes[3].Y_size = 2;

	shapes[4].processors = 3;
	shapes[4].X_size = 1;
	shapes[4].Y_size = 3;

	shapes[5].processors = 3;
	shapes[5].X_size = 3;
	shapes[5].Y_size = 1;

	shapes[6].processors = 4;
	shapes[6].X_size = 2;
	shapes[6].Y_size = 2;

	shapes[7].processors = 5;
	shapes[7].X_size = 2;
	shapes[7].Y_size = 3;

	shapes[8].processors = 5;
	shapes[8].X_size = 3;
	shapes[8].Y_size = 2;

	shapes[9].processors = 6;
	shapes[9].X_size = 3;
	shapes[9].Y_size = 2;	

	shapes[10].processors = 7;
	shapes[10].X_size = 3;
	shapes[10].Y_size = 3;

	shapes[11].processors = 8;
	shapes[11].X_size = 3;
	shapes[11].Y_size = 3;

	shapes[12].processors = 9;
	shapes[12].X_size = 3;
	shapes[12].Y_size = 3;
}


