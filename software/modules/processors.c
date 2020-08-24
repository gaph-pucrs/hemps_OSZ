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

Processor processors[MAX_CLUSTER_PEs];	//!<Processor array
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

#ifdef WARD_MODULE
	processor_with_less_resources = processors[1].address;
#else
    processor_with_less_resources = -1;
#endif    
	processor_free_pages = processors[1].free_pages;
    //for(int i=1; i<MAX_CLUSTER_PEs; i++){
	for(int i = MAX_CLUSTER_PEs -1; i > 0; i--){
			
		if (processors[i].free_pages == MAX_LOCAL_TASKS){
			processors_with_task = processors[i].address;
            		PE_x = processors_with_task >> 8;
            		PE_y = processors_with_task && 0XFF;
            		puts("Conferindo1 Proc: \n");puts(itoh(processors_with_task));
            		if(PE_belong_SZ(PE_x, PE_y) != 1){
            			puts("Passou no 1\n");
			     	return processors_with_task;}
            		else
                		continue;
		}
		else{
			if (processors[i].free_pages > processor_free_pages){
                    		PE_x = processors[i].address >> 8;
                    		PE_y = processors[i].address && 0XFF; 
                    		puts("Conferindo2 Proc: \n");puts(itoh(processors[i].address));      
                    		if(PE_belong_SZ(PE_x, PE_y) != 1){
					processor_with_less_resources = processors[i].address;
					processor_free_pages = processors[i].free_pages;
                    		}
                    		else
                        		continue;                    
			}
		}		
	}
	puts("Passou no 2\n");
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
void print_shapes_found(int nb_shapes){
  int x;
       
        puts("Number of shapes: "); puts(itoa(nb_shapes)); puts("\n");
        for(x=0; x<nb_shapes; x++) {
           //printf("      (%2d  %2d) - excess: %d  processors: %d\n",  shapes[x].X_size, shapes[x].Y_size, 
           //                   shapes[x].excess, shapes[x].processors) ;
            puts("      ("); puts(itoa(shapes[x].X_size)); puts(" - "); puts(itoa(shapes[x].Y_size)); puts(") excess: ");  
            puts(itoa(shapes[x].excess)); puts("  processors: "); puts(itoa(shapes[x].processors));  puts("\n");
        }
}


int PE_belong_SZ(int PE_x, int PE_y){

        int i,  xi_cut, xf_cut, yi_cut, yf_cut;
        int xi, yi, xf, yf;

        for(i = 0; i < MAX_SHAPES; i++){
            if(Secure_Zone[i].occuped == 1){

                xi =  (Secure_Zone[i].position >> 8) & 0XFF;
                yi =   Secure_Zone[i].position  & 0XFF;
                xf =  xi + Secure_Zone[i].X_size;
                yf =  yi + Secure_Zone[i].Y_size;

                if(Secure_Zone[i].cut != -1){
                    xi_cut =  (Secure_Zone[i].cut >> 8) & 0XFF;
                    yi_cut =   Secure_Zone[i].cut  & 0XFF;
        
                    xf_cut = (Secure_Zone[i].cut >> 24) & 0XFF;
                    yf_cut = (Secure_Zone[i].cut >> 16) & 0XFF;

                    if(((PE_x >= xi_cut) && (PE_x <= xf_cut)) && ((PE_y >= yi_cut) && (PE_y <= yf_cut))  )
                        continue;
                }
                //puts("\nBelong? X: ");  puts(itoa(PE_x));  puts(" Y: ");  puts(itoa(PE_y));
                if(((PE_x >= xi) && (PE_x < xf)) && ((PE_y >= yi) && (PE_y < yf))  )
                    return 1;
            }
        }
    return 0;
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


int set_SZ_migrations(int SZ_index) {
    int desl_Y, y, x, proc_address;
    int i, flag, init_cut_index, end_cut_index;
    int xi, yi, xf, yf;
    int taskID0, taskID1, index;
    xi =  (Secure_Zone[SZ_index].position >> 8) & 0XFF;
    yi =   Secure_Zone[SZ_index].position  & 0XFF;
    xf =  xi + Secure_Zone[SZ_index].X_size;
    yf =  yi + Secure_Zone[SZ_index].Y_size;
    if(Secure_Zone[SZ_index].cut != -1){
        init_cut_index = (Secure_Zone[SZ_index].cut & 0XFFFF);
        init_cut_index = ((init_cut_index & 0XFF) * XCLUSTER) + (init_cut_index >> 8);

        end_cut_index = (Secure_Zone[SZ_index].cut >> 16);
        end_cut_index = ((end_cut_index & 0XFF) * XCLUSTER) + (end_cut_index >> 8);
    }
    for(y = yi;  y < yf; y++){
        desl_Y = (y)*XCLUSTER ;
        for(x = xi; x < xf; x++){
            //----------- avoid the SZ excess ----------------
            if(Secure_Zone[SZ_index].cut != -1){
                flag = 0;
                for(i = init_cut_index; i <= end_cut_index; i += XCLUSTER){
                    if((x+desl_Y) == i)
                        flag = 1;
                }
                if(flag == 1){
                    continue;
                }
            }
            //-----------------------------------------------
            proc_address = get_proc_address(x+desl_Y);
            //puts("address: "); puts(itoh(proc_address)); puts("\n");
            if (get_proc_free_pages(proc_address) != MAX_LOCAL_TASKS){
                taskID0 = get_task_id_processor(proc_address);
                taskID1 = (taskID0 >> 16) &  0XFFFF;
                taskID0 = taskID0 &  0XFFFF;

                for(index = 0; index < MAX_MIGRATIONS; index++){
                    if(migration_list[index].status == OFF ){
                        migration_list[index].status = ACTIVE;
                        migration_list[index].actual_address = proc_address;
                        migration_list[index].actual_taskID = taskID0;
                        break;
                    }
                }
                if(taskID1 != 0XFFFF){
                    for(; index < MAX_MIGRATIONS; index++){
                        if(migration_list[index].status == OFF ){
                            migration_list[index].status = ACTIVE;
                            migration_list[index].actual_address = proc_address;
                            migration_list[index].actual_taskID = taskID1;
                            break;
                        }
                    }                    
                }
            }
        }
    }
    return 0;
}


void shapes_invert_order(Shapes shapes[], int nb_valid_shapes){
  int i;
  Shapes shape_aux;

  for(i = 0; i < nb_valid_shapes/2; i++){
    shape_aux.processors = shapes[i].processors;
    shapes[i].processors = shapes[nb_valid_shapes-i-1].processors;
    shapes[nb_valid_shapes-i-1].processors = shape_aux.processors;

    shape_aux.X_size = shapes[i].X_size;
    shapes[i].X_size = shapes[nb_valid_shapes-i-1].X_size;
    shapes[nb_valid_shapes-i-1].X_size = shape_aux.X_size;

    shape_aux.Y_size = shapes[i].Y_size;
    shapes[i].Y_size = shapes[nb_valid_shapes-i-1].Y_size;
    shapes[nb_valid_shapes-i-1].Y_size = shape_aux.Y_size;

    shape_aux.excess = shapes[i].excess;
    shapes[i].excess = shapes[nb_valid_shapes-i-1].excess;
    shapes[nb_valid_shapes-i-1].excess = shape_aux.excess;
  }
  print_shapes_found(nb_valid_shapes);
}



//-------------------------------------------------------------------------------
int create_valid_shapes(int PEs, int cont)
//-------------------------------------------------------------------------------
{
  int x, y, ix1, ix2, delta1, delta2, swap, contador;

  // create all possible the shapes
  //printf("\ncall:");
  for( x = 1 ; x<= PEs; x++)
    {   y = PEs/x;
        while (x*y < PEs)   y++;
        shapes[cont+x-1].X_size = x;
        shapes[cont+x-1].Y_size = y;
        shapes[cont+x-1].valid = 1;   // all shapes are valid
        //printf("\nShape: (%2d x %2d)", x, y);
    }

  // simple bubble sort according to the delta - we want a rectangular shape
   for (ix1 = 0 ; ix1 < PEs-1 ; ix1++)
    for (ix2 = 0 ; ix2 < PEs - ix1 - 1; ix2++)
       {
         if ( shapes[cont+ix2].X_size > shapes[cont+ix2].Y_size) 
              delta1 = shapes[cont+ix2].X_size - shapes[cont+ix2].Y_size;
         else delta1 = shapes[cont+ix2].Y_size - shapes[cont+ix2].X_size;

         if ( shapes[cont+ix2+1].X_size > shapes[cont+ix2+1].Y_size) 
              delta2 = shapes[cont+ix2+1].X_size - shapes[cont+ix2+1].Y_size;
         else delta2 = shapes[cont+ix2+1].Y_size - shapes[cont+ix2+1].X_size;

         if ( delta1 > delta2 )
         {
           swap            = shapes[cont+ix2].X_size;
           shapes[cont+ix2].X_size   = shapes[cont+ix2+1].X_size;
           shapes[cont+ix2+1].X_size = swap;

           swap            = shapes[cont+ix2].Y_size;
           shapes[cont+ix2].Y_size   = shapes[cont+ix2+1].Y_size;
           shapes[cont+ix2+1].Y_size = swap;
         }
      } 

  // suppress invalid shapes -  those that are enclosed in other shapes 
  for( ix1= 0; ix1<PEs-1; ix1++)
       if  (shapes[cont+ix1].Y_size == shapes[cont+ix1+1].Y_size)  shapes[cont+ix1+1].valid=0;

  // suppress invalid shapes -  that are larger than the cluster size
  for( ix1=0; ix1<PEs; ix1++)
       if( shapes[cont+ix1].X_size>XCLUSTER || shapes[cont+ix1].Y_size>YCLUSTER)
                    shapes[cont+ix1].valid=0; 
  
  // recreate the list and the correct number of shapes
  for( contador=x=0; x<PEs; x++)
      if (shapes[cont+x].valid)
        { shapes[cont+contador].X_size = shapes[cont+x].X_size;
          shapes[cont+contador].Y_size = shapes[cont+x].Y_size;
          shapes[cont+contador].valid = shapes[cont+x].valid;
          shapes[cont+contador].processors = shapes[cont+contador].X_size * shapes[cont+contador].Y_size;
          shapes[cont+contador].excess = ((shapes[cont+x].X_size) *  (shapes[cont+x].Y_size))-PEs;

          contador++;
        }

  return( cont+contador );
}


//*********************************************************************************************
/** Shape search and recognition
*/
int shape_recog(int X_size, int Y_size, int X_init, int Y_init){
  int  x, y, desl_Y, used;
  int XMASTER, YMASTER;

  XMASTER = (get_net_address() >> 8) && 0xFF;
  YMASTER = get_net_address() && 0xFF;

  used = 0;
  for(y = Y_init; y < Y_size + Y_init; y++){
    desl_Y = y * XCLUSTER;
    for(x = X_init; x < X_size + X_init; x++){
        used += MAX_LOCAL_TASKS - processors[x+desl_Y].free_pages;
        if((x == XMASTER) && (y == YMASTER))
            return  100;
        if(PE_belong_SZ(x,y) == 1)
            return 100;
    }
  }
  return used;
}


int search_shape_in_cluster(int X_size, int Y_size, Shapes shape[], int cont, int used_looking ){
    int x, y, used_in_SWS, result;

    //for(y = 0; y<=YCLUSTER-Y_size; y++){
    //  for(x = 0; x<=XCLUSTER-X_size; x++){

    for(y = YCLUSTER-Y_size; y >= 0; y--){
      for(x = XCLUSTER-X_size; x >= 0; x--){
        used_in_SWS = shape_recog(X_size, Y_size, x, y);
  
        //discart strip shapes using all column or all line at the middle of cluster
        if(used_in_SWS == used_looking){
            if(shape[cont].X_size == XCLUSTER && (y != YCLUSTER - shape[cont].Y_size))
                continue;
        }
        result = (x<<8) + y;
  
        shape[cont].position = (X_size << 24 | Y_size << 16) | result;
        shape[cont].used = used_in_SWS;
        shape[cont].cut = -1;
  
        if(used_in_SWS == used_looking){
            if(shape[cont].excess > 0){
                //shape[cont].cut = ((x + X_size-1)<<24) | ((y + Y_size-1) << 16) | ((x + X_size -1) << 8) | ((y + Y_size) - shape[cont].excess);
                shape[cont].cut = (x <<24) | ((y + shape[cont].excess -1) << 16) | (x  << 8) | y ;
            }
            return cont;
        }
      }
    }
    return -1;
}


int search_shape(int valid_shapes){
  int x, used_looking, indice;

  for(used_looking = 0; used_looking <= MAX_MIGRATIONS; used_looking++){
      if( used_looking == 1){
        puts("Inverting... \n"); 
        shapes_invert_order(shapes, valid_shapes);
      }

      for(x = 0; x < valid_shapes; x++){
          indice = search_shape_in_cluster(shapes[x].X_size, shapes[x].Y_size, shapes, x, used_looking);
          if(indice != -1){
                //return x;
                shape_index = x;
                return shapes[x].position;
          }          
      }
  }
  return -1;
}
  

int create_shapes(int task_pe, int tasks_app){
  int nb_shapes = 0, t, nb_pe;
  for(t=1; t <= task_pe; t++ )
     { 
        nb_pe = tasks_app/t ;

        if( nb_pe < tasks_app )  nb_pe++;   // ceil

        nb_shapes =  create_valid_shapes(nb_pe, nb_shapes);
     } 
     return nb_shapes;
}

int get_Secure_Zone_index(int RH_address){
    int i, aux;

    //puts("get_SZ RH: "); puts(itoh(RH_address)); puts("\n");

    RH_address = ((RH_address & 0XF0) << 4) + (RH_address & 0X0F);

    //puts("RH: "); puts(itoh(RH_address)); puts("\n");

    for(i = 0; i < MAX_SHAPES; i++){
        aux = (Secure_Zone[i].position & 0XFFFF) + (Secure_Zone[i].position >> 16) - 0x0101;

        //puts("aux RH: "); puts(itoh(aux)); puts("\n");
        if((Secure_Zone[i].occuped == 1) && (aux == RH_address)){
            return i;
        }
    }
    return -1;
}

void set_Secure_Zone(int shape_index){
    int i;

    for(i = 0; i < MAX_SHAPES; i++){
        if(Secure_Zone[i].occuped == 0){
            //puts("set_SZ index: "); puts(itoh(i)); puts("\n");
            Secure_Zone[i].processors = shapes[shape_index].processors;
            Secure_Zone[i].X_size = shapes[shape_index].X_size;
            Secure_Zone[i].Y_size = shapes[shape_index].Y_size;
            Secure_Zone[i].excess = shapes[shape_index].excess;
            Secure_Zone[i].used = shapes[shape_index].used;
            Secure_Zone[i].cut = shapes[shape_index].cut;
            Secure_Zone[i].position = shapes[shape_index].position;
            Secure_Zone[i].occuped = 1;

            set_SZ_migrations(i);
            freeze_application();
            return;
        }
    }    
}

void unset_Secure_Zone(int RH_address){ // falta implementar
    int i, RH_SZ;

    RH_address = ((RH_address << 4) & 0XF00) | (RH_address & 0x0F);
    puts("unset_SZ RH_address: "); puts(itoh(RH_address)); puts("\n");
    for(i = 0; i < MAX_SHAPES; i++){
        RH_SZ = (Secure_Zone[i].position & 0XFFFF) + (Secure_Zone[i].position >> 16) - 0x0101;
        puts("RH_SZ: "); puts(itoh(RH_SZ)); puts("\n");
        if((Secure_Zone[i].occuped == 1) && (RH_SZ == RH_address)){
             Secure_Zone[i].occuped = 0;
             return;
        }
    }    
}


void init_Secure_Zone(){
    int i;
    for(i = 0; i < MAX_SHAPES; i++){
        Secure_Zone[i].occuped = 0;
    }
}
