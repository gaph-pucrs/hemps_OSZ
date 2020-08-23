#include "define_pairs.h"


void initialize_struct_pairs(){
    int i;
    //flag alone == -1 error
    //flag alone == 0 normal
    //flag alone == 1 ele não monitora ninguem
    for(i=0;i<MAX_PAIRS;i++){
        ward_pairs[i].pe_number = -1;
        ward_pairs[i].X_Address = -1;
        ward_pairs[i].Y_Address = -1;
        ward_pairs[i].alone = 0; 

        ward_pairs[i].pe_warded_1 = -1;
        ward_pairs[i].X_warded_1 = -1;
        ward_pairs[i].Y_warded_1 = -1;

        ward_pairs[i].pe_warded_2 = -1;
        ward_pairs[i].X_warded_2 = -1;
        ward_pairs[i].Y_warded_2 = -1;
    }

        slave_candidate_other_cluster.Address = -1;
        slave_candidate_other_cluster.tasks_number = -1;
        slave_candidate_my_cluster.Address = -1;
        
        ward_master.tasks_number = -1;
        ward_master.Address = -1;


}

void define_pairs(int PE, struct_pairs *ward_pairs_local){ 
    int nro_mast_X, nro_mast_Y;
    int cont_x, cont_y, position;
    int aux;
    nro_mast_X = XDIMENSION / XCLUSTER;
    nro_mast_Y = YDIMENSION / YCLUSTER;
    initialize_struct_pairs();
    for(cont_y = 0; cont_y < nro_mast_Y; cont_y++){ // encontra os mestres
        for(cont_x = 0; cont_x < nro_mast_X; cont_x++){
            unsigned int  x_loc, y_loc, pe_number;

            position = (cont_y*nro_mast_X)+cont_x;
            x_loc = cont_x*XCLUSTER;
            y_loc = cont_y*YCLUSTER;
            pe_number = x_loc + (y_loc * XDIMENSION);
            ward_pairs[position].pe_number = pe_number;
            ward_pairs[position].X_Address = x_loc;
            ward_pairs[position].Y_Address = y_loc;
        }
    }
    for(cont_x = 0; cont_x < position; cont_x+=2){  // conecta os pares
        ward_pairs[cont_x].X_warded_1 = ward_pairs[cont_x+1].X_Address;
        ward_pairs[cont_x].Y_warded_1 = ward_pairs[cont_x+1].Y_Address;
        ward_pairs[cont_x].pe_warded_1 = ward_pairs[cont_x+1].pe_number;

        ward_pairs[cont_x+1].X_warded_1 = ward_pairs[cont_x].X_Address;
        ward_pairs[cont_x+1].Y_warded_1 = ward_pairs[cont_x].Y_Address;
        ward_pairs[cont_x+1].pe_warded_1 = ward_pairs[cont_x].pe_number;
        if((cont_x+4)%nro_mast_X == 1) // pula a coluna impar final
            cont_x++;
    }
    if((nro_mast_X%2)==1){  // manipula coluna impar
        for(cont_x = position; cont_x > 0; cont_x = cont_x - (nro_mast_X * 2)){
            if((cont_x - nro_mast_X) > 1){  //pareando coluna
                ward_pairs[cont_x].X_warded_1 = ward_pairs[cont_x-nro_mast_X].X_Address;
                ward_pairs[cont_x].Y_warded_1 = ward_pairs[cont_x-nro_mast_X].Y_Address;
                ward_pairs[cont_x].pe_warded_1 = ward_pairs[cont_x-nro_mast_X].pe_number;

                ward_pairs[cont_x-nro_mast_X].X_warded_1 = ward_pairs[cont_x].X_Address;
                ward_pairs[cont_x-nro_mast_X].Y_warded_1 = ward_pairs[cont_x].Y_Address;
                ward_pairs[cont_x-nro_mast_X].pe_warded_1 = ward_pairs[cont_x].pe_number;
            }
            else{  // ultimo elemento da coluna. deve mapear com o elemento acima dele
                ward_pairs[cont_x].X_warded_1 = ward_pairs[cont_x+nro_mast_X].X_Address;
                ward_pairs[cont_x].Y_warded_1 = ward_pairs[cont_x+nro_mast_X].Y_Address;
                ward_pairs[cont_x].pe_warded_1 = ward_pairs[cont_x+nro_mast_X].pe_number;
                ward_pairs[cont_x].alone = 1;
        
                ward_pairs[cont_x+nro_mast_X].X_warded_2 = ward_pairs[cont_x].X_Address;
                ward_pairs[cont_x+nro_mast_X].Y_warded_2 = ward_pairs[cont_x].Y_Address;
                ward_pairs[cont_x+nro_mast_X].pe_warded_2 = ward_pairs[cont_x].pe_number;
            }
        }
    }
    for(cont_x = 0; cont_x <= position; cont_x++){
        aux = (ward_pairs[cont_x].X_Address<<8) + ward_pairs[cont_x].Y_Address;
        if (aux == PE){                   
           ward_pairs_local->X_warded_1 = ward_pairs[cont_x].X_warded_1; 
           ward_pairs_local->Y_warded_1 = ward_pairs[cont_x].Y_warded_1; 
           ward_pairs_local->pe_warded_1 = ward_pairs[cont_x].pe_warded_1; 
           ward_pairs_local->alone = ward_pairs[cont_x].alone;

           ward_pairs_local->X_warded_2 = ward_pairs[cont_x].X_warded_2; 
           ward_pairs_local->Y_warded_2 = ward_pairs[cont_x].Y_warded_2; 
           ward_pairs_local->pe_warded_2 = ward_pairs[cont_x].pe_warded_2; 

           ward_master.Address = ( ((ward_pairs[cont_x].X_Address+1) << 8)+ ward_pairs[cont_x].Y_Address); //Guarda o endereço do slave candidado a mestre por padrao do outro cluster.
           slave_candidate_other_cluster.Address = ( ((ward_pairs[cont_x].X_Address+1) << 8)+ ward_pairs[cont_x].Y_Address); //Guarda o endereço do slave candidado a mestre por padrao do outro cluster.
           slave_candidate_other_cluster.tasks_number = 0 ;
           //slave_candidate_other_cluster = ( ((ward_pairs[cont_x].X_Address+1) << 8)+ ward_pairs[cont_x].Y_Address);

           master_other_cluster.Address = ( (ward_pairs_local->X_warded_1 << 8)+ ward_pairs_local->Y_warded_1); //Guarda o endereço do mestre que ele está cuidando para enviar as informações de seu cluster          
           return;
        }
    } 
}

int get_slave_candidate_my_cluster(){
    return slave_candidate_my_cluster.Address;
}

void set_slave_candidate_my_cluster(int net_address_to_send){
    slave_candidate_my_cluster.Address = net_address_to_send;
}

int get_slave_candidate_other_cluster(){
    return slave_candidate_other_cluster.Address;
}

int get_task_candidate_other_cluster(){
    return slave_candidate_other_cluster.tasks_number;
}

int get_task0_candidate_other_cluster(){
    return slave_candidate_other_cluster.task_id0;
}

int get_task1_candidate_other_cluster(){
    return slave_candidate_other_cluster.task_id1;
}

void set_slave_candidate_other_cluster(int net_address_to_send, int task){
    char task_id0, task_id1;
    slave_candidate_other_cluster.tasks_number = 0;
    slave_candidate_other_cluster.Address = net_address_to_send;
    task_id0 = task & 0XFF;
    task_id1 = (task >> 8) & 0xFF;
    slave_candidate_other_cluster.task_id0 = task_id0;
    slave_candidate_other_cluster.task_id1 = task_id1;

    if (MAX_LOCAL_TASKS == 1){
        if(task_id0 != -1)
        slave_candidate_other_cluster.tasks_number++;
       // return (p->task[0]);
    }
    else{
        if(task_id0 != -1)
        slave_candidate_other_cluster.tasks_number++;
        if(task_id1 != -1)
        slave_candidate_other_cluster.tasks_number++;

        //puts("\n"); puts("p->task[0] ");puts(itoh(p->task[0]));
        //puts("\n"); puts("p->task[1] ");puts(itoh(p->task[1])); puts("\n");   
        //return (p->task[0]<<8)|p->task[1];
    }

    /*if(task_id0 != -1)
        slave_candidate_other_cluster.tasks_number++;
    if(task_id1 != -1)
        slave_candidate_other_cluster.tasks_number++;*/

    //puts("slave_candidate_other_cluster.Address "); puts(itoh(slave_candidate_other_cluster.Address)); puts("\n");
    //puts("slave_candidate_other_cluster.tasks_number "); puts(itoh(slave_candidate_other_cluster.tasks_number)); puts("\n");
   // puts("slave_candidate_other_cluster.task_id0 "); puts(itoh(slave_candidate_other_cluster.task_id0)); puts("\n");
    //puts("slave_candidate_other_cluster.task_id1 "); puts(itoh(slave_candidate_other_cluster.task_id1)); puts("\n");   
    
}

void set_master_other_cluster(int net_address_to_send){
        master_other_cluster.Address = net_address_to_send ;
}

int get_master_other_cluster(){
        return master_other_cluster.Address;
}