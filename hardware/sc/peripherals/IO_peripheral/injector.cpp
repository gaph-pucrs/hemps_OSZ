//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Date: 	March 2018
//
//  Source name:  repository.cpp
//
//  Brief description: 
//
//---------------------------------------------------------------------------------------

#include "injector.h"


void injector::brnoc_in_proc_FSM(){
	if (reset.read() == 1)  {
		EA_in_brnoc.write(S_INIT);
		need_to_clear = 0;
	} else{

		switch(EA_in_brnoc.read()){
			case S_INIT:
				if(in_req_router_seek_primary.read() == 1){
					if(in_service_router_seek_primary.read() == GMV_READY_SERVICE){ 
						EA_in_brnoc.write(S_GMV_RECEIVE);
					}
					else if(in_service_router_seek_primary.read() == NEW_APP_ACK_SERVICE){ 
						EA_in_brnoc.write(S_ACK_NEW_APP_RECEIVE);
					}
					else{
						out_ack_router_seek_secondary.write(1); 
						out_ack_router_seek_primary.write(1);
					}
				}			
			break;

			case S_GMV_RECEIVE:	
 					address_to_clear = in_source_router_seek_primary.read();
 					global_master_location = in_source_router_seek_primary.read();
					cout << "GMV location: " << global_master_location << endl;
					EA_in_brnoc.write(S_ACK);
			break;

				
			case S_ACK_NEW_APP_RECEIVE:								
 					app_master_location[app_index] = in_target_router_seek_primary.read();
 					address_to_clear = in_source_router_seek_primary.read();
 					app_ID[app_index] = in_source_router_seek_primary.read() & 0x0000FFFF;//tirar depois
					cout << "CM address: " << app_master_location[app_index] << " to execute app_id :" << app_ID[app_index]  << endl;
					EA_in_brnoc.write(S_ACK);
				
			break;

	        case S_ACK:	   
	        		out_ack_router_seek_primary.write(1);
					out_ack_router_seek_secondary.write(1);
					EA_in_brnoc.write(S_WAIT_REQ_DOWN);
	        break;	

			case S_WAIT_REQ_DOWN: 
				if (in_req_router_seek_primary.read() == 0){
					EA_in_brnoc.write(S_INIT);
					out_ack_router_seek_primary.write(0);
					out_ack_router_seek_secondary.write(0);
					need_to_clear = 1;
				}
	        break;	
		}		
	}	

}


void injector::brnoc_out_proc_FSM(){
	if (reset.read() == 1){
		EA_out_brnoc.write(S_WAIT_INIT);
	} else{

		switch(EA_out_brnoc.read()){
			case S_WAIT_INIT:// 4 send the NEW_APP_REPO_SERVICE
				if (app_status[app_index] == INIT_ALLOCATION){		           
		            EA_out_brnoc.write(S_NEW_APP);
				}
				if (need_to_clear == 1){
					EA_out_brnoc.write(S_CLEAR);	
				}
			break;
			case S_WAIT_ACK:
				if(in_ack_router_seek_primary.read() == 1){
	            	out_req_router_seek_primary.write(0);
					app_status[app_index] = WAITING_ALLOCATION_ACK;
	            	EA_out_brnoc.write(S_ACK_DOWN);
	        	}
				if(in_ack_router_seek_primary.read() == 1){
	            	out_req_router_seek_primary.write(0);
	            	EA_out_brnoc.write(S_ACK_DOWN);
	        	}
	        break;	
	        case S_ACK_DOWN:
				if(in_ack_router_seek_primary.read() == 0){
					EA_out_brnoc.write(S_WAIT_INIT);
	        	}
	        break;	

	        case S_CLEAR:	      	
				out_service_router_seek_primary.write(CLEAR_SERVICE);
	    		out_source_router_seek_primary.write(address_to_clear);
	    		out_target_router_seek_primary.write(0);
	    		out_opmode_router_seek_primary.write(GLOBAL_MODE);
        		out_req_router_seek_primary.write(1);
        		out_req_router_seek_secondary.write(0);
				EA_out_brnoc.write(S_WAIT_ACK);  
				need_to_clear = 0;
			break;	

			case S_NEW_APP:	 
 	 	       	 out_payload_router_seek_primary.write(app_number_of_tasks[app_index]);
				 out_req_router_seek_primary.write(1);
		         out_service_router_seek_primary.write(NEW_APP_SERVICE);
	    		 out_source_router_seek_primary.write(io_id);
	    		 out_target_router_seek_primary.write(0);				
	    		 out_opmode_router_seek_primary.write(RESTRICT_MODE);
	    		 EA_out_brnoc.write(S_WAIT_ACK);
			break;	

		}		
	}
}


void injector::datanoc_in_proc_FSM(){
	if(reset.read() == true){
		EA_in_datanoc.write(S_INIT_IN);
		flit_in_counter = 0;
		
		for(int i=0;i<BUFFER_IN_PERIPHERAL;i++) {
			buffer_in_flit[i]		=	0;
		}		
		credit_o_primary.write(1);
		
	}
	else{	
		switch(EA_in_datanoc.read()){
			case S_INIT_IN:
					if(rx_primary.read() == true){
							buffer_in_flit[flit_in_counter] = data_in_primary.read();
							flit_in_counter = flit_in_counter + 1;	
							EA_in_datanoc.write(S_RECEIVE_HEADER);
					}
				
			break;

			case S_RECEIVE_HEADER:
				if(rx_primary.read() == true){
					buffer_in_flit[flit_in_counter] =  data_in_primary.read();
					flit_in_counter = flit_in_counter + 1;

					if(flit_in_counter == 20){
						reg_header	 		= buffer_in_flit[3];
						reg_msg_size 		= buffer_in_flit[5];
						reg_service 		= buffer_in_flit[7];
						reg_task_ID 		= buffer_in_flit[9];
						reg_peripheral_ID 	= buffer_in_flit[11];
						reg_source_PE 		= buffer_in_flit[13];
						reg_mapped_tasks    = buffer_in_flit[19];
					}
					if(flit_in_counter == 26 && reg_msg_size > 0X0B){
						EA_in_datanoc.write(S_PAYLOAD);
						flit_in_counter = 0;
					}
					if(eop_in_primary.read()== true){
						EA_in_datanoc.write(S_SERVICE);
						flit_in_counter = 0;
					}
					
				}
				else{
					EA_in_datanoc.write(S_WAIT);
				}
			break;			
			
			case S_WAIT:
				if(rx_primary.read() == true){
					buffer_in_flit[flit_in_counter] =  data_in_primary.read();
					flit_in_counter = flit_in_counter + 1;						
					EA_in_datanoc.write(S_RECEIVE_HEADER);
				}
			break;

			case S_SERVICE:	
				flag_map_received = 1;		
				flit_in_counter = 0;
				EA_in_datanoc.write(S_INIT_IN);
	    		cout << "Map received in injector " << endl;

			break;
			  
			case S_PAYLOAD:
				if(rx_primary.read() == true){
						buf_task_info[flit_in_counter] = data_in_primary.read();
				}
				flit_in_counter = (flit_in_counter + 1);//??
				if(eop_in_primary.read()== true){
					EA_in_datanoc.write(S_SERVICE);
					flit_in_counter = 0;
				}	
			break;
		}
	}
}

///////////////////////////////////////////////////

void injector::datanoc_out_comb_tx(){

	bool send_state = (
		EA_out_datanoc.read()==S_SEND_HEADER ||
		EA_out_datanoc.read()==S_SEND_PAYLOAD_HIGH ||
		EA_out_datanoc.read()==S_SEND_PAYLOAD_LOW ||
		EA_out_datanoc.read()==S_SEND_EOP
	);

	if(send_state && (credit_i_primary.read() == true))
		tx_primary.write(true);
	else
		tx_primary.write(false);
}

void injector::datanoc_out_proc_FSM(){
	
	if(reset.read()==true){
		flit_out_counter= 0 ;
		task_number = -1;
		EA_out_datanoc.write(S_INIT_DATANOC);
		for(int i=0;i<BUFFER_IN_PERIPHERAL;i++) {
			if(i<26)
				buffer_out_flit[i]		=	0;
		}
	}	
	else{
		switch(EA_out_datanoc.read()){
			case S_INIT_DATANOC:
			if (EA_manager.read() != S_WAITING_GM_READY){

				if(app_status[app_index] == INIT_ALLOCATION_ACK){ //7 manda O app descriptor para o LM
					buffer_out_flit[0] = 0; //header
					buffer_out_flit[1] = app_master_location[app_index]; 											//header
					buffer_out_flit[2] = 0;
					buffer_out_flit[3] = app_master_location[app_index]; 											//header
					buffer_out_flit[4] = 0;  					//payload_size
					//buffer_out_flit[5] = 26+(TASK_DESCRIPTOR_SIZE*app_number_of_tasks[app_index])+2;
					buffer_out_flit[5] = 11+((TASK_DESCRIPTOR_SIZE*(app_number_of_tasks[app_index] & 0xFF))+1);
					buffer_out_flit[6] = 0;  					//service
					buffer_out_flit[7] = 0x150;  				//service NEW_APP
					buffer_out_flit[8] = 0;  					//app ID
					buffer_out_flit[9] = app_ID[app_index];  	//app ID
					buffer_out_flit[10] = 0;
					buffer_out_flit[11] = 0;
					buffer_out_flit[12] = 0;
					buffer_out_flit[13] = 0;
					buffer_out_flit[14] = 0;
					buffer_out_flit[15] = 0;
					buffer_out_flit[16] = 0;
					buffer_out_flit[17] = 0;			  		
					buffer_out_flit[18] = 0;			  		//app_descriptor_size
					buffer_out_flit[19] = (TASK_DESCRIPTOR_SIZE*(app_number_of_tasks[app_index] & 0xFF))+1;  	//app_descriptor_size
					packet_size = buffer_out_flit[19];
					EA_out_datanoc.write(S_SEND_DESCRIPTOR);
				}	

				if(app_status[app_index] == SENDING_TASKS){
 
					for(task_number=0; task_number < tasks_map_received; task_number++){
						if(app_tasks[task_number].status == 0){
							buffer_out_flit[0] = 0; //header
							buffer_out_flit[1] = app_tasks[task_number].allocated_proc; 											//header
							buffer_out_flit[2] = 0;
							// buffer_out_flit[2] = 0x1000;
							buffer_out_flit[3] = app_tasks[task_number].allocated_proc; 											//header
							buffer_out_flit[4] = 0;  					//payload_size
							buffer_out_flit[5] = 11+app_tasks[task_number].code_size;
							buffer_out_flit[6] = 0;  					//service
							buffer_out_flit[7] = 0x40;  				//service TASK_ALLOCATION
							buffer_out_flit[8] = 0;  					//task ID
							buffer_out_flit[9] = app_tasks[task_number].id;  	//task ID
							buffer_out_flit[10] = 0;
							buffer_out_flit[11] = app_master_location[app_index];//master id
							buffer_out_flit[12] = 0;//1;
							buffer_out_flit[13] = 0;//2;
							buffer_out_flit[14] = 0;//3;
							buffer_out_flit[15] = 0;//4;
							buffer_out_flit[16] = 0;//5;
							buffer_out_flit[17] = 0;//6;			  		//app_descriptor_size
							buffer_out_flit[18] = 0;//7;			  		//app_descriptor_size
							buffer_out_flit[19] = 0;//8;  	//app_descriptor_size
							buffer_out_flit[20] = 0;//9;			  		
							buffer_out_flit[21] = 0;//10;			  		
							buffer_out_flit[22] = 0;			  		
							buffer_out_flit[23] = app_tasks[task_number].code_size;	
							packet_size = buffer_out_flit[23];		  		
							EA_out_datanoc.write(S_SEND_TASK);
							app_tasks[task_number].status = 1;	
							break;
						}	

					}	
					if(task_number == (app_number_of_tasks[app_index] & 0XFF)){
						EA_out_datanoc.write(S_END_SEND_TASK);
					}
				}	
			}	
			break;

			case S_END_SEND_TASK:				
			 	//if (app_status[app_index] == ALLOCATED){
					EA_out_datanoc.write(S_INIT_DATANOC);
				//	task_number = -1;	
				//}	
			break;

			case S_SEND_DESCRIPTOR:
					data_out_primary.write(buffer_out_flit[0]);
					if(credit_i_primary.read() == true){
						tasks_sent = -1;
						EA_out_datanoc.write(S_SEND_HEADER);
						flit_out_counter = flit_out_counter + 1; 
						repo_address = (app_initial_address[app_index]);
					}			
			break;

			case S_SEND_TASK:
					data_out_primary.write(buffer_out_flit[0]);
					if(credit_i_primary.read() == true){
						EA_out_datanoc.write(S_SEND_HEADER);
						flit_out_counter = flit_out_counter + 1; 
						repo_address = (app_tasks[task_number].initial_address);
					}			
			break;
			
			case S_SEND_HEADER:
					if(credit_i_primary.read() == true){
						data_out_primary.write(buffer_out_flit[flit_out_counter]);
						flit_out_counter = flit_out_counter + 1; 
						if(flit_out_counter == 26){
							EA_out_datanoc.write(S_SEND_PAYLOAD_HIGH);
							flit_out_counter = 0;	
						}						
					}
					else{
						EA_out_datanoc.write(S_WAIT_CREDIT_HEADER);
					}

			break;

			case S_SEND_PAYLOAD_HIGH:

				if(credit_i_primary.read() == 1){
					EA_out_datanoc.write(S_SEND_PAYLOAD_LOW);       
					data_out_primary.write((repository_txt[(repo_address+flit_out_counter)] >> 16));
					eop_out_primary.write(0);
				}
				else{
						EA_out_datanoc.write(S_WAIT_CREDIT_PAYLOAD_HIGH);
				}
			break;

			case S_SEND_PAYLOAD_LOW:
				if(credit_i_primary.read() == 1){
					data_out_primary.write(repository_txt[(repo_address+flit_out_counter)]);
					flit_out_counter = flit_out_counter + 1 ;
					if(flit_out_counter == packet_size){
						EA_out_datanoc.write(S_SEND_EOP);
						eop_out_primary.write(true);
					}
					else{
						EA_out_datanoc.write(S_SEND_PAYLOAD_HIGH);   
					}
				}
				else{
						EA_out_datanoc.write(S_WAIT_CREDIT_PAYLOAD_LOW);
				}
			break;


			case S_WAIT_CREDIT_HEADER: 
				if(credit_i_primary.read() == true){
					EA_out_datanoc.write(S_SEND_HEADER);
				}

			break;

			case S_WAIT_CREDIT_PAYLOAD_HIGH:
				if(credit_i_primary.read() == true){
					EA_out_datanoc.write(S_SEND_PAYLOAD_HIGH);
				}				

			break;

			case S_WAIT_CREDIT_PAYLOAD_LOW:  
				if(credit_i_primary.read() == true){
					EA_out_datanoc.write(S_SEND_PAYLOAD_LOW);
				}
			break;			

			case S_SEND_EOP: //FAZER O ESTADO WAIT EOP ACK DOWN
				eop_out_primary.write(false);
				flit_out_counter = 0;
				tasks_sent = tasks_sent + 1;
				EA_out_datanoc.write(S_INIT_DATANOC);
			break;			
			  
		}
	}
}

void injector::current_time_inc(){
	if (reset.read() == 1)  {		
		current_time = 0;
	} else{
		current_time++;
	}
}

void injector::load_appstart_repository(){
	string line;
	int i = 0, aux;
	
	app_count = 0;

	ifstream appstart_file ("appstart.txt");

	if (appstart_file.is_open()) {

		while ( getline (appstart_file,line) ) {

			if (i == APPSTART_SIZE){
				cout << "ERROR: App Start file appstart.txt is greater than APPSTART_SIZE = " << APPSTART_SIZE << "\nPlease, recompile apps and hw" <<endl;
				sc_stop();
			} 
		
			//Converts a hex string to unsigned integer
			sscanf( line.substr(0, 8).c_str(), "%lx", &appstart[i] );

			if(appstart[i] != 0xdeadc0de){
				if((i & 1) == 0){				
					app_initial_address[app_count] = (appstart[i]/4);
				}
				else{
					app_start_time[app_count] = appstart[i]*100000;
					app_status[app_count]= INITIAL;
					app_count++;
				}				
			}	
			i++;

		}
		appstart_file.close();
	} 
	else {
		cout << "Unable to open file appstart.txt" << endl;
	}



	ifstream repo_file ("repository.txt");
	i = 0;


	if (repo_file.is_open()) {
		while ( getline (repo_file,line) ) {

			if (i == REPO_SIZE){
				cout << "ERROR: Repository file repository.txt is greater than REPOSIZE = " << REPO_SIZE << endl;
				sc_stop();
			}

			//Converts a hex string to unsigned integer

			sscanf( line.substr(0, 8).c_str(), "%lx", &repository_txt[i] );

			for(aux = 0; aux < app_count; aux++){
				if(i == app_initial_address[aux]){
					app_number_of_tasks[aux] = repository_txt[i];
				}
			}

			i++;

		}
		repo_file.close();
	} 
	else {
		cout << "Unable to open file repository.txt" << endl;
	}
}

void injector::new_app(){
	
	unsigned int app_repo_address = 0;
	unsigned int app_start_time_ms = 0;
	int i,y;
	

	if (reset.read() == 1)  {
		EA_manager.write(S_WAITING_GM_READY);
		app_index = 0;
		flag_map_received = 0;
	} else{

		switch(EA_manager.read()){
				
			case S_WAITING_GM_READY:
					if (EA_in_brnoc.read() == S_GMV_RECEIVE){
						EA_manager.write(S_INIT_MANAGER);
					}
			break;		

			case S_INIT_MANAGER:
				tasks_map_received = 0;
				for(i = 0; i< app_count; i++ ){
					if((current_time >= app_start_time[i]) && (app_status[i] == INITIAL)){
						app_status[i] = INIT_ALLOCATION;
						app_index = i;
						EA_manager.write(S_WAIT_LMP_LOCATION);
						break;
					}
				}
			break;

			case S_WAIT_LMP_LOCATION: 
					// app_status[app_index] = WAITING_ALLOCATION_ACK;

					if (EA_in_brnoc.read() == S_ACK_NEW_APP_RECEIVE){					
						app_status[app_index] = INIT_ALLOCATION_ACK;	
						EA_manager.write(S_WAIT_SEND_DESCRIPTOR);					
					}		
			break;

			case S_WAIT_SEND_DESCRIPTOR: 
					if (EA_out_datanoc.read() == S_SEND_DESCRIPTOR){					
						app_status[app_index] = WAITING_MAP;	
						EA_manager.write(S_WAITING_MAP);					
					}		
			break;


			case S_WAITING_MAP:					
					//if (EA_in_datanoc.read() == S_SERVICE){
					if (flag_map_received == 1){
						flag_map_received = 0;	
						int aux_tasks_mapped;
						EA_manager.write(S_SENDING_TASKS);
						app_status[app_index] = SENDING_TASKS;
						aux_tasks_mapped = tasks_map_received;
						for(i=tasks_map_received, y=0; i< aux_tasks_mapped + reg_mapped_tasks; i++, y=y+8){
							app_tasks[i].id = (buf_task_info[y] << 16) | buf_task_info[y+1];                    
  							app_tasks[i].allocated_proc = (buf_task_info[y+2] << 16) | buf_task_info[y+3]; 
							// app_tasks[i].allocated_proc = ((0x10 + buf_task_info[y+2]) << 16) | buf_task_info[y+3];// pra ir YX
  							app_tasks[i].initial_address= ((buf_task_info[y+4] << 16) | buf_task_info[y+5])/4;        
  							app_tasks[i].code_size = (buf_task_info[y+6] << 16) | buf_task_info[y+7];
  							app_tasks[i].status = 0;	
  							tasks_map_received = i+1;
						}

					}

					if (EA_out_datanoc.read() ==  S_END_SEND_TASK && (app_number_of_tasks[app_index] & 0XFF) == tasks_sent){
						EA_manager.write(S_INIT_MANAGER);
						app_status[app_index] = ALLOCATED;
					}	
		
			break;


			case S_SENDING_TASKS:
					if (EA_out_datanoc.read() ==  S_END_SEND_TASK && (app_number_of_tasks[app_index] & 0XFF) == tasks_sent){
					//if (EA_out_datanoc.read() ==  S_END_SEND_TASK){
						EA_manager.write(S_INIT_MANAGER);
						app_status[app_index] = ALLOCATED;
					}
					else{
						EA_manager.write(S_WAITING_MAP);		
					}
		
			break;
			
			default:

			break;
	  	 } 
	 }
}
