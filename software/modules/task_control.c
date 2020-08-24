/*!\file task_control.c
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module implements function relative to task control block (TCB)
 * This module is used by the slave kernel
 */

#include "task_control.h"

#include "../../include/kernel_pkg.h"
#include "utils.h"


TCB tcbs[MAX_LOCAL_TASKS];			//!<Local task TCB array

/**Initializes TCB array
 */
void init_TCBs(){


	for(int i=0; i<MAX_LOCAL_TASKS; i++) {
		tcbs[i].id = -1;
		tcbs[i].pc = 0;
		tcbs[i].offset = PAGE_SIZE * (i + 1);
		tcbs[i].proc_to_migrate = -1;

        init_scheduling_ptr(&tcbs[i].scheduling_ptr, i);

        tcbs[i].scheduling_ptr->tcb_ptr = (unsigned int) &tcbs[i];

        clear_scheduling( tcbs[i].scheduling_ptr );
	}
}

/**Search from a tcb position with status equal to FREE
 * \return The TCB pointer or 0 in a ERROR situation
 */
TCB* search_free_TCB() {

    for(int i=0; i<MAX_LOCAL_TASKS; i++){
		if(tcbs[i].scheduling_ptr->status == FREE){
			return &tcbs[i];
		}
	}

    puts("ERROR - no FREE TCB\n");
    while(1);
    return 0;
}

/**Search by a TCB
 * \param task_id Task ID to be searched
 * \return TCB pointer
 */
TCB * searchTCB(unsigned int task_id) {

    int i;

    for(i=0; i<MAX_LOCAL_TASKS; i++)
    	if(tcbs[i].id == task_id)
    		return &tcbs[i];

    return 0;
}

/**Gets the TCB pointer from a index
 * \param i Index of TCB
 * \return The respective TCB pointer
 */
TCB * get_tcb_index_ptr(unsigned int i){
	return &(tcbs[i]);
}

/**Test if there is another task of the same application running in the same slave processor
 * \param app_id Appliation ID
 * \return 1 - if YES, 0 if NO
 */
int is_another_task_running(int app_id){

	for (int i = 0; i < MAX_LOCAL_TASKS; i++){
		if (tcbs[i].scheduling_ptr->status != FREE && (tcbs[i].id >> 8) == app_id){
			return 1;
		}
	}
	return 0;
}


int unblock_tasks_of_App(int app_id){
    int cont = 0;
    // puts("app id: "); puts(itoh(app_id)); puts("\n");
    for (int i = 0; i < MAX_LOCAL_TASKS; i++){
        if (tcbs[i].scheduling_ptr->status == BLOCKED && (tcbs[i].id >> 8) == app_id){
            tcbs[i].scheduling_ptr->status = READY;
            cont++;
        }
    }
    return cont;
}

void clear_all_memory_areas(int app_id){
    for (int i = 0; i < MAX_LOCAL_TASKS; i++){
        if (tcbs[i].scheduling_ptr->status == FREE && (tcbs[i].id >> 8) == app_id){
            unsigned int *offset;
            unsigned int stack_lenght;
        
            unsigned int stack_addr;

            stack_addr = tcbs[i].reg[25];    

            while((PAGE_SIZE - stack_addr) % 4) stack_addr--;
            stack_lenght = (PAGE_SIZE - stack_addr) / 4;
            

            // CLEAR BSS and DATA   
            offset = (unsigned int *)  (tcbs[i].offset + (tcbs[i].text_lenght*4));
            for(int aux=0; aux<tcbs[i].bss_lenght + tcbs[i].data_lenght; aux++, offset++){
                *offset = 0;
            }
            //CLEAR STACK
            offset =  (unsigned int *)  (tcbs[i].offset + tcbs[i].reg[25]);
            for(int aux=0; aux<stack_lenght; aux++, offset++){
                *offset = 0;
            }

            // CLEAR TEXT (object code)
            offset = (unsigned int *) tcbs[i].offset;
            for(int aux=0; aux<tcbs[i].text_lenght; aux++, offset++){
                *offset = 0;
            }
            // CLEAR REGISTERS
            for (int aux=0; aux<30; aux++){
                tcbs[i].reg[aux] = 0;
            } 


            // if want to print memory and registers uncomment the lines above           
            //tcbs[i].reg[25] =  stack_addr;   
            //printTaskInformations(&tcbs[i], 1, 1, 1);
        }
    }
}

/*--------------------------------------------------------------------------------------------------------
* printTaskInformations
*
* DESCRIPTION:
*    Prints (in hexadecimal) the code and data of task memory page
*--------------------------------------------------------------------------------------------------------*/
// void printTaskInformations(TCB *task_tcb, int text, int bss_data, int stack){
//     int i;
//     unsigned int *offset;
//     unsigned int stack_lenght;
//     unsigned int stack_addr = task_tcb->reg[25];
//     while((PAGE_SIZE - stack_addr) % 4) stack_addr--;
//     stack_lenght = (PAGE_SIZE - stack_addr) / 4;
//     puts("\n------------------------TASK INFORMATION----------------------------\n");
//     puts("\nID: "); puts(itoa(task_tcb->id));
//     puts("\nOffset: "); puts("\t"); puts(itoh(task_tcb->offset));
//     puts("\nStack pointer: "); puts(itoh(task_tcb->reg[25]));
//     puts("\nPC: "); puts(itoa(task_tcb->pc));
//     puts("\n\nPAGESIZE: "); puts(itoa(PAGE_SIZE));
//     puts("\nREGISTERS\n");
//     for (i=0; i<30; i++){
//         puts ("R"); puts(itoa(i)); puts(":\t"); puts(itoa(task_tcb->reg[i]));  puts("\n");
//     }
//     if (bss_data){
//         puts("\nBSS E DATA\n");
//         offset = (unsigned int *) (task_tcb->offset + (task_tcb->text_lenght*4));
//         puts("Offset: "); puts("\t"); puts(itoh(offset));        
//         for(i=0; i<task_tcb->bss_lenght + task_tcb->data_lenght; i++){
//             puts(itoh(&offset[i])); puts("\t"); puts(itoh(offset[i])); puts("\n");
//         }
//     }
//     if (stack) {
//         puts("\nSTACK\n");
//         offset = (unsigned int *) (task_tcb->offset + task_tcb->reg[25]);
//         puts("Offset: "); puts("\t"); puts(itoh(offset));        
//         for(i=0; i<stack_lenght; i++){
//             puts(itoh(&offset[i])); puts("\t"); puts(itoh(offset[i])); puts("\n");
//         }
//     }
//     if (text){
//         puts("\nTEXT\n");
//         offset = (unsigned int *) task_tcb->offset;
//         puts("Offset: "); puts("\t"); puts(itoh(offset));        
//         for(i=0; i<task_tcb->text_lenght; i++){
//             puts(itoh(&offset[i])); puts("\t"); puts(itoh(offset[i])); puts("\n");
//         }
//     }
//     puts("\n---------------------------------------------------------------------\n");
// }


void print_task(){
    for (int i = 0; i < MAX_LOCAL_TASKS; ++i)
    {
       putsv("----\nTask id: ", tcbs[i].id);
       putsv("Status: ",tcbs[i].scheduling_ptr->status);
    }
}

//WARD_MODULE
int freeze_tasks_of_cluster(int master){ 
    int cont = 0;
    
        for (int i = 0; i < MAX_LOCAL_TASKS; i++){
            if (tcbs[i].master_address == master){    
                tcbs[i].scheduling_ptr->last_status = tcbs[i].scheduling_ptr->status;
                tcbs[i].scheduling_ptr->status = BLOCKED;
                cont++;
            }
        }
    
    return cont;
}

int unfreeze_tasks_of_cluster(int master, int new_master){
    int cont = 0;

        for (int i = 0; i < MAX_LOCAL_TASKS; i++){
            if (tcbs[i].id != -1 || tcbs[i].scheduling_ptr->status == BLOCKED || tcbs[i].master_address == master ){
                tcbs[i].scheduling_ptr->status = tcbs[i].scheduling_ptr->last_status;
                tcbs[i].master_address = new_master;
                cont++;
            }
        }
    
    return cont;
}

int freeze_tasks_of_App(int appId){ 
    int cont = 0;
        for (int i = 0; i < MAX_LOCAL_TASKS; i++){
            if ((tcbs[i].id  >> 8)== appId){    
                tcbs[i].scheduling_ptr->last_status = tcbs[i].scheduling_ptr->status;
                tcbs[i].scheduling_ptr->status = BLOCKED;
                
                puts("app id: "); puts(itoh(appId)); puts("\n");
                puts("status: "); puts(itoh(tcbs[i].scheduling_ptr->status)); puts("\n");
                puts("last status: "); puts(itoh(tcbs[i].scheduling_ptr->last_status)); puts("\n");

                cont++;
            }
        }
    return cont;
}

int unfreeze_tasks_of_App(int appId){
    int cont = 0;

        //puts("app id: "); puts(itoh(appId)); puts("\n");
        for (int i = 0; i < MAX_LOCAL_TASKS; i++){
        //puts("    Id: "); puts(itoh(tcbs[i].id  >> 8)); puts("\n");
            if (((tcbs[i].id  >> 8) == appId)  ){
                //tcbs[i].scheduling_ptr->status = tcbs[i].scheduling_ptr->last_status;
                tcbs[i].scheduling_ptr->status = RUNNING;
                cont++;
            }
        }
    return cont;
}

