/*!\file cluster_scheduler.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief Selects where to execute a task and application
 * \detailed Cluster scheduler implements the cluster resources management,
 * task mapping, application mapping, and also can implement task migration heuristics.
 * Adittionally it have a function named: SearchCluster, which selects the cluster to send an application. This
 * function in only used in the global master mode
 */
#include "../include/plasma.h"

#include "cluster_scheduler.h"

#include "../../include/kernel_pkg.h"
#include "utils.h"
#include "processors.h"
#include "applications.h"
#include "define_pairs.h"
#include "seek.h" 
#include "osz_master.h"

extern unsigned int clusterID;
//extern unsigned int app_id_counter;

/** Allocate resources to a Cluster by decrementing the number of free resources. If the number of resources
 * is higher than free_resources, then free_resourcers receives zero, and the remaining of resources are allocated
 * by reclustering
 * \param cluster_index Index of cluster to allocate the resources
 * \param nro_resources Number of resource to allocated. Normally is the number of task of an application
 */
inline void allocate_cluster_resource(int cluster_index, int nro_resources){

	//puts(" Cluster address "); puts(itoh(cluster_info[cluster_index].master_x << 8 | cluster_info[cluster_index].master_y)); puts(" resources "); puts(itoa(cluster_info[cluster_index].free_resources));

	if (cluster_info[cluster_index].free_resources >= nro_resources){
		cluster_info[cluster_index].free_resources -= nro_resources;
	} else {
		cluster_info[cluster_index].free_resources = 0;
	}

	// putsv(" ALLOCATE - nro resources : ", cluster_info[cluster_index].free_resources);
}

/** Release resources of a Cluster by incrementing the number of free resources according to the nro of resources
 * by reclustering
 * \param cluster_index Index of cluster to allocate the resources
 * \param nro_resources Number of resource to release. Normally is the number of task of an application
 */
inline void release_cluster_resources(int cluster_index, int nro_resources){

	//puts(" Cluster address "); puts(itoh(cluster_info[cluster_index].master_x << 8 | cluster_info[cluster_index].master_y)); puts(" resources "); puts(itoa(cluster_info[cluster_index].free_resources));

	cluster_info[cluster_index].free_resources += nro_resources;

   // putsv(" RELEASE - nro resources : ", cluster_info[cluster_index].free_resources);
}

/** This function is called by kernel manager inside it own code and in the modules: reclustering and cluster_scheduler.
 * It is called even when a task is mapped into a processor, by normal task mapping or reclustering.
 * Automatically, this function update the Processors structure by calling the add_task function
 * \param cluster_id Index of cluster to allocate the page
 * \param proc_address Address of the processor that is receiving the task
 * \param task_ID ID of the allocated task
 */
void page_used(int cluster_id, int proc_address, int task_ID){

	//puts("Page used proc: "); puts(itoh(proc_address)); putsv(" task id ", task_ID);
	add_task(proc_address, task_ID);

	// allocate_cluster_resource(cluster_id, 1);
}

/** This function is called by manager inside it own code and in the modules: reclustering and cluster_scheduler.
 * It is called even when a task is removed from a processor.
 * Automatically, this function update the Processors structure by calling the remove_task function
 * \param cluster_id Index of cluster to remove the page
 * \param proc_address Address of the processor that is removing the task
 * \param task_ID ID of the removed task
 */
void page_released(int cluster_id, int proc_address, int task_ID){

	//puts("Page released proc: "); puts(itoh(proc_address)); putsv(" task id ", task_ID);
	remove_task(proc_address, task_ID);

	release_cluster_resources(cluster_id, 1);
}
/*
int get_static_SZ(){
	int appID;
	int xi = 255, yi = 255, xf = 0, yf = 0;

	appID = app_id_counter-1;		// ver se é o atual ou o próximo

#if MAX_STATIC_TASKS
	for(int i=0; i<MAX_STATIC_TASKS; i++){
		if ((static_map[i][0] >> 8) ==  appID){
			if ((static_map[i][1] >> 8) < xi)  // menor X
				xi = (static_map[i][1] >> 8);

			if ((static_map[i][1] & 0XFF) < yi) // menor Y
				yi = (static_map[i][1] & 0XFF);

			if ((static_map[i][1] >> 8) > xf)  // maior X
				xf = (static_map[i][1] >> 8);

			if ((static_map[i][1] & 0XFF) > yf) // maior Y
				yf = (static_map[i][1] & 0XFF);
	
		}
	}
#endif
	if(xi != 255){
		shape_index = 0;
		shapes[0].excess = 0;
		shapes[0].X_size = xf - xi + 1;
		shapes[0].Y_size = yf - yi + 1;
		shapes[0].position = (shapes[0].X_size << 24)|(shapes[0].Y_size << 16) | (xi << 8) | yi;
		shapes[0].used = 1; //Bug --nome
		shapes[0].cut = -1;
		shapes[0].processors = shapes[0].X_size * shapes[0].Y_size;
//		puts(">>>> Appid "); puts(itoa(appID)); 
//		puts("\n    xi: "); puts(itoh(xi));
//		puts("\n    yi: "); puts(itoh(yi));
//		puts("\n    xf: "); puts(itoh(xf));
//		puts("\n    yf: "); puts(itoh(yf));
//		puts("\n    position: "); puts(itoh(shapes[0].position));
//		puts("\n");
		return shapes[0].position;
	}

	return 0;	
}
*/


/** Maps a task into a cluster processor. This function only selects the processor not modifying any management structure
 * The mapping heuristic is based on the processor's utilization (slack time) and the number of free_pages
 * \param task_id ID of the task to be mapped
 * \return Address of the selected processor
 */
int map_task(int last_proc_address, int task_id, int AppSec){

	int proc_address;
	int canditate_proc = -1;
	int max_slack_time = -1;
	int slack_time;

	//putsv("Mapping call for task id ", task_id);


#if MAX_STATIC_TASKS
	//Test if the task is statically mapped
	for(int i=0; i<MAX_STATIC_TASKS; i++){

		//Test if task_id is statically mapped
		if (static_map[i][0] == task_id){
			puts("Task id "); puts(itoa(static_map[i][0])); puts(" statically mapped at processor"); puts(itoh(static_map[i][1])); puts("\n");

			proc_address = static_map[i][1];

			if (get_proc_free_pages(proc_address) <= 0){
				puts("ERROR: Processor not have free resources\n");
				while(1);
			}

			return proc_address;
		}
	}
#endif

#ifdef GRAY_AREA
	if(AppSec == 1){ 
		int desl_Y, y, x;
		int i, flag, init_cut_index, end_cut_index;
		int xi, yi, xf, yf;


		xi =  (shapes[shape_index].position >> 8) & 0XFF;
		yi =   shapes[shape_index].position  & 0XFF;
		xf =  xi + shapes[shape_index].X_size;
		yf =  yi + shapes[shape_index].Y_size;


		if(last_proc_address == 0){
			y = yi;
			x = xf-1;
		}
		else{
			y = last_proc_address & 0xFF;
			x = (last_proc_address >> 8) - 1;
		}

		init_cut_index = (shapes[shape_index].cut & 0XFFFF);
		init_cut_index = ((init_cut_index & 0XFF) * XCLUSTER) + (init_cut_index >> 8);

		end_cut_index = (shapes[shape_index].cut >> 16);
		end_cut_index = ((end_cut_index & 0XFF) * XCLUSTER) + (end_cut_index >> 8);

		for( ; y < yf; y++){
			desl_Y = (y)*XCLUSTER ;
			for( ;x >= xi; x--){

				//----------- avoid the SZ excess ----------------
				flag = 0;
				for(i = init_cut_index; i <= end_cut_index; i += XCLUSTER){
					if((x+desl_Y) == i)
						flag = 1;
				}
				if(flag == 1){
					continue;
				}
				//-----------------------------------------------
				proc_address = get_proc_address(x+desl_Y);

				//puts("Task mapping for task "), puts(itoa(task_id)); puts(" maped at proc "); puts(itoh(proc_address)); puts("\n");
		
				if (get_proc_free_pages(proc_address) > 0)
					return proc_address;
				else
					continue;
			}
			x = xf;
		}
	}
	
	else if(AppSec >= 2){ // Mapear perto do AccessPoint
		int desl_Y, y, x;
		int i, flag, init_cut_index, end_cut_index;
		int xi, yi, xf, yf;


		xi =  (shapes[shape_index].position >> 8) & 0XFF;
		yi =   shapes[shape_index].position  & 0XFF;
		xf =  xi + shapes[shape_index].X_size;
		yf =  yi + shapes[shape_index].Y_size;


		if(last_proc_address == 0){
			y = yf-1;
			x = xi;
		}
		else{
			y = last_proc_address & 0xFF;
			x = (last_proc_address >> 8) + 1;
		}

		init_cut_index = (shapes[shape_index].cut & 0XFFFF);
		init_cut_index = ((init_cut_index & 0XFF) * XCLUSTER) + (init_cut_index >> 8);

		end_cut_index = (shapes[shape_index].cut >> 16);
		end_cut_index = ((end_cut_index & 0XFF) * XCLUSTER) + (end_cut_index >> 8);

		for( ; y >= yi; y--){
			desl_Y = (y)*XCLUSTER ;
			for( ;x < xf; x++){

				//----------- avoid the SZ excess ----------------
				flag = 0;
				for(i = init_cut_index; i <= end_cut_index; i += XCLUSTER){
					if((x+desl_Y) == i)
						flag = 1;
				}
				if(flag == 1){
					continue;
				}
				//-----------------------------------------------
				proc_address = get_proc_address(x+desl_Y);

				//puts("Task mapping for task "), puts(itoa(task_id)); puts(" maped at proc "); puts(itoh(proc_address)); puts("\n");
				if (get_proc_free_pages(proc_address) > 0)
					return proc_address;
				else
					continue;
			}
			x = xi;
		}
	}
	#else
		if(AppSec == 1){ 
		int desl_Y, y, x;
		int i, flag, init_cut_index, end_cut_index;
		int xi, yi, xf, yf;


		xi =  (shapes[shape_index].position >> 8) & 0XFF;
		yi =   shapes[shape_index].position  & 0XFF;
		xf =  xi + shapes[shape_index].X_size;
		yf =  yi + shapes[shape_index].Y_size;


		if(last_proc_address == 0){
			y = yi;
			x = xi;
		}
		else{
			y = last_proc_address & 0xFF;
			x = (last_proc_address >> 8) + 1;
		}

		init_cut_index = (shapes[shape_index].cut & 0XFFFF);
		init_cut_index = ((init_cut_index & 0XFF) * XCLUSTER) + (init_cut_index >> 8);

		end_cut_index = (shapes[shape_index].cut >> 16);
		end_cut_index = ((end_cut_index & 0XFF) * XCLUSTER) + (end_cut_index >> 8);

		for( ; y < yf; y++){
			desl_Y = (y)*XCLUSTER ;
			for( ;x < xf; x++){

				//----------- avoid the SZ excess ----------------
				flag = 0;
				for(i = init_cut_index; i <= end_cut_index; i += XCLUSTER){
					if((x+desl_Y) == i)
						flag = 1;
				}
				if(flag == 1){
					continue;
				}
				//-----------------------------------------------
				proc_address = get_proc_address(x+desl_Y);

				//puts("Task mapping for task "), puts(itoa(task_id)); puts(" maped at proc "); puts(itoh(proc_address)); puts("\n");
		
				return proc_address;
			}
			x = xi;
		}
	}
	
	#endif
	//Else (not secure), map the task following a CPU utilization based algorithm
	else{ 
		for(int i=0; i<MAX_CLUSTER_PEs; i++){
	
			proc_address = get_proc_address(i);
	
		#ifdef GRAY_AREA
			if ((get_proc_free_pages(proc_address) > 0) && (PE_belong_SZ(proc_address>>8, proc_address&0XFF) != 1) && (PE_belong_GA(proc_address>>8, proc_address&0XFF) == 1)){
		#else
			if ((get_proc_free_pages(proc_address) > 0) & (PE_belong_SZ(proc_address>>8, proc_address&0XFF) != 1)){
		#endif
			{
				slack_time = get_proc_slack_time(proc_address);
	
				if (max_slack_time < slack_time){
					canditate_proc = proc_address;
					max_slack_time = slack_time;
				}
			}
		}
	
		if (canditate_proc != -1){
	
			puts("Task mapping for task "); puts(itoa(task_id)); puts(" maped at proc "); puts(itoh(canditate_proc)); puts("\n");
	
				return canditate_proc;
			}
		}
	}
	puts("WARNING: no resources available in cluster to map task ");
	return -1;
}

/**This heuristic maps all task of an application
 * Note that some task can not be mapped due the cluster is full or the processors not satisfies the
 * task requiriments. In this case, the reclustering will be used after the application_mapping funcion calling
 * into the kernel_master.c source file
 * Clearly the tasks that need reclustering are those one that have he allocated_processor equal to -1
 * \param cluster_id ID of the cluster where the application will be mapped
 * \param app_id ID of the application to be mapped
 * \return 1 if mapping OK, 0 if there are no available resources
*/
int application_mapping(int cluster_id, int app_id){

	Application * app;
	Task *t;
	int prev_proc_io, prev_proc, proc_address;

	proc_address = prev_proc_io = prev_proc =  0;
	app = get_application_ptr(app_id);

	//puts("\napplication_mapping\n");

	for(int i=0; i<app->tasks_number; i++){

		t = &app->tasks[i];

		//putsv("Vai mapear task id: ", t->id);

		/*Map task*/
		if(i == (shapes[shape_index].processors - shapes[shape_index].excess ))
			proc_address = prev_proc_io = prev_proc =  0;

		#ifdef GRAY_AREA
		if(t->dependences_number > 0 && app->secure == 1){
			prev_proc_io = map_task(prev_proc_io, t->id, 2);
			proc_address = prev_proc_io;
			puts("Proc mapeado IO ");puts(itoh(proc_address));puts("\n");
		}else{
			prev_proc = map_task(prev_proc, t->id, app->secure);
			proc_address = prev_proc;
			puts("Proc mapeado ");puts(itoh(proc_address));puts("\n");
		}
		#else
		proc_address = map_task(proc_address, t->id, app->secure);
		#endif

		// puts("Proc mapeado para ");puts(itoh(proc_address));puts("\n");
		if (proc_address == -1){

			return 0;

		} else {

			t->allocated_proc = proc_address;

			if(proc_is_migrating(proc_address)){
				change_task(proc_address, t->id);
			}
			else
				page_used(cluster_id, proc_address, t->id);

		}
	}

	puts("App have all its task mapped\n");

	return 1;
}


/** Receive a address and return the cluster index of array cluster_info[]
 *  \param x Address x of the manager processor
 *  \param y Address y of the manager processor
 *  \return Index of array cluster_info[]
 */
int get_cluster_ID(int x, int y){

	for (int i=0; i<CLUSTER_NUMBER; i++){
		if (cluster_info[i].master_x == x && cluster_info[i].master_y == y){
			return i;
		}
	}
	puts("ERROR - cluster nao encontrado\n");
	return -1;
}


/** Receives a slave address and tells which is its master address
 *  \param slave_address The XY slave address
 *  \return The master address of the slave. Return -1 if there is no master (ERROR situation)
 */
int get_master_address(int slave_address){

	ClusterInfo *cf;
	int proc_x, proc_y;

	proc_x = slave_address >> 8;
	proc_y = slave_address & 0xFF;

	for(int i=0; i<CLUSTER_NUMBER; i++){
		cf = &cluster_info[i];
		if (cf->xi <= proc_x && cf->xf >= proc_x && cf->yi <= proc_y && cf->yf >= proc_y){
			return get_cluster_proc(i);
		}
	}

	puts("ERROR: no master address found\n");
	while(1);
	return -1;
}

int get_cluster_index(int X_Add, int Y_Add){
	int i;
	for (i=0; i<CLUSTER_NUMBER; i++){
		if(X_Add <= cluster_info[i].xf &&  X_Add >= cluster_info[i].xi)
		  if(Y_Add <= cluster_info[i].yf &&  Y_Add >= cluster_info[i].yi)
		  	return i;
	}
	return -1;
}


/**Selects a cluster to insert an application
 * \param GM_cluster_id cluster ID of the global manager processor
 * \param app_task_number Number of task of requered application
 * \return > 0 if mapping OK, -1 if there is not resources available
*/
int SearchCluster(int GM_cluster_id, int app_ID) {

	int selected_cluster = -1;
	int freest_cluster = 0;

	// seach a static map task of the current app_ID, 
	// if found return the cluster index
#if MAX_STATIC_TASKS
		for(int i = 0; i < MAX_STATIC_TASKS; i++){
			int aux, cluster_master;;

			aux = static_map[i][0] >> 8;
			if( aux == app_ID){
				aux = static_map[i][1];
				cluster_master = get_master_address(aux);
				return get_cluster_ID((cluster_master>>8), (cluster_master & 0xff));
		 	}
		}
#endif

	for (int i=0; i<CLUSTER_NUMBER; i++){

		if (i == GM_cluster_id) continue;

		if (cluster_info[i].free_resources >= freest_cluster){
			selected_cluster = i;
			freest_cluster = cluster_info[i].free_resources;
		}
	}

	if (cluster_info[GM_cluster_id].free_resources > freest_cluster){
		selected_cluster = GM_cluster_id;
	}
	if (selected_cluster == -1) {
			puts("ERROR: no resources available in MPSoC\n");
			while(1);
	}
	return selected_cluster;
}

/** Find the processor with no task or the processor with less number of task
 * \send to ward CM to register the slave candidate in case of fail the master
 */

void new_master_candidate(){

	struct_pairs my_pair; 
	int processors_with_task=0;
	int processor_number_task=0; 
	int task_id_processor_chousen; 
	unsigned int	net_address_to_send;

	net_address_to_send = get_master_other_cluster();

	processors_with_task = get_free_processor();

	processor_number_task = get_proc_free_pages(processors_with_task);
	
	task_id_processor_chousen = get_task_id_processor(processors_with_task); // pega o ID da tarefa caso precise de migração da tarefa.

	task_id_processor_chousen = ((task_id_processor_chousen >> 8) & 0XFF00) | (task_id_processor_chousen & 0xFF);
	//colocar um for para casos onde tiver mais de uma tarefa alocada
	//if (processor_number_task == MAX_LOCAL_TASKS){
	//	get_task_id_processor(processors_with_task);
	//	puts("\n");puts("A Processor free is: "); puts(itoh(processors_with_task)); puts("\n");
	//	puts("Resources to add task: "); puts(itoh(processor_number_task)); puts("\n");puts("\n");
	//	Seek(MASTER_CANDIDATE_SERVICE, processors_with_task, net_address_to_send, processor_number_task);
	//	set_slave_candidate_my_cluster(processors_with_task);
	//}
	//else{
	

	//	puts("\nA Processor choused is & 0xF: "); puts(itoh(processors_with_task & 0xF)); puts("\n");
	//	puts("\nA Processor choused is >> 4: "); puts(itoh(processors_with_task>>4)); puts("\n");
	//	puts("The Processor task number: "); puts(itoh(processor_number_task)); puts("\n");
	//	puts("task_id_processor_chousen: "); puts(itoh(task_id_processor_chousen)); puts("\n");
		Seek(MASTER_CANDIDATE_SERVICE, task_id_processor_chousen, net_address_to_send, (processors_with_task>>4) | (processors_with_task & 0xF));
		set_slave_candidate_my_cluster(processors_with_task);
	//}

}
