//---------------------------------------------------------------------------------------
//
//  DISTRIBUTED HEMPS  - version 5.0
//
//  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
//
//  Distribution:  Novembeer 2017
//
//  Source name:  fail_wrapper_module.h
//
//  Brief description: Control process queue occupancy
//
//---------------------------------------------------------------------------------------

#include "fail_wrapper_module.h"

//-- PDN services
//#define	SET_SECURE_ZONE_SERVICE		0b00111
//#define	OPEN_SECURE_ZONE_SERVICE	0b01010
//#define	SECURE_ZONE_CLOSED_SERVICE	0b01011
//#define	SECURE_ZONE_OPENED_SERVICE	0b01100
//#define	SET_SZ_RECEIVED_SERVICE		0b11101
//#define	SET_EXCESS_SZ_SERVICE		0b11110
//

//PROCESSO DE CONTROLE PARA PDN
void fail_WRAPPER_module::in_proc_FSM(){
	#ifdef BRLOG
	char aux[255]; 
	FILE *fp;
	reg_seek_service auxService;
	#endif


	if(reset.read() == true){
		out_ack_wrapper_local.write(false);
		out_nack_wrapper_local.write(false);
		EA_in.write(S_INIT_IN);
		in_target_router.write(0);
	}	
	else{

		if (in_fail_cpu_config.read() == 1){
			in_target_router.write(mem_address_service_fail_cpu.read());
			//puts("SAVE DMA_FAIL_KERNEL to "); puts(itoh(in_target_router.read())); puts("\n");
			cout<<"DMA_FAIL_KERNEL "<< hex << mem_address_service_fail_cpu.read() <<endl;
		}

		if (in_fail_cpu_local.read() == false){ //if fail is false to nothing
			//cpu to wrapper
			in_source_router.write(in_source_wrapper_local.read());
			out_source_wrapper_local.write(in_source_wrapper_local.read());
			out_target_wrapper_local.write(in_target_wrapper_local.read());
			out_payload_wrapper_local.write(in_payload_wrapper_local.read());
			out_service_wrapper_local.write(in_service_wrapper_local.read());         
			out_req_wrapper_local.write(in_req_wrapper_local.read());
			out_opmode_wrapper_local.write(in_opmode_wrapper_local.read());
			out_fail_wrapper_local.write(in_fail_wrapper_local.read());
			out_ack_wrapper_local.write(in_ack_wrapper_local.read());
			out_nack_wrapper_local.write(in_nack_wrapper_local.read());
		}
		else{

			switch(EA_in.read()){
			
				case S_INIT_IN:

					out_req_wrapper_local.write(1);
					out_source_wrapper_local.write(in_source_router.read());
					out_target_wrapper_local.write(in_target_router.read());
					out_payload_wrapper_local.write(0);
					out_service_wrapper_local.write(FAIL_KERNEL_SERVICE);
					out_opmode_wrapper_local.write(1);
					if (in_ack_wrapper_local.read() == true){				 
					 	EA_in.write(S_END);
					 	cout<<"SEND_FAIL_SERVICE " << endl;
					}
	
					break;	
	
				case S_END:
						out_req_wrapper_local.write(0);		
				break;		
			}
		}
	}	
}

//PROCESSO DE CONTROLE PARA PDN
void fail_WRAPPER_module::brNoC_monitor(){
	char aux[255]; 
	FILE *fp;
	reg_seek_service auxService;
	//Store in aux the C's string way
	sprintf(aux, "debug/traffic_brnoc.txt");
	char jsonf[255];
	sprintf(jsonf, "debug/router_seek/wrapper_%x%xx%x%x.json",(address&0xf<<12)>>12,(address&0xf<<8)>>8,(address&0xf<<4)>>4,address&0xf);
	bool first=true;
	if(reset.read() == true){
		//prevService = 0;
		fp = fopen (jsonf, "w");
		fprintf(fp,"{\"entradas\":[\n");
		fclose(fp);
	}else{
		// Open a file called "aux" deferred on append mode
		fp = fopen (aux, "a");
		auxService = in_service_wrapper_local.read();

		//if (auxService != prevService && (auxService == SET_SECURE_ZONE_SERVICE || auxService == OPEN_SECURE_ZONE_SERVICE || auxService == SECURE_ZONE_CLOSED_SERVICE || auxService == SECURE_ZONE_OPENED_SERVICE || auxService == SET_SZ_RECEIVED_SERVICE || auxService == SET_EXCESS_SZ_SERVICE)){
		if (auxService == SET_SECURE_ZONE_SERVICE || auxService == OPEN_SECURE_ZONE_SERVICE || auxService == SECURE_ZONE_CLOSED_SERVICE || auxService == SECURE_ZONE_OPENED_SERVICE || auxService == SET_SZ_RECEIVED_SERVICE || auxService == SET_EXCESS_SZ_SERVICE || auxService == END_TASK_SERVICE){
			sprintf(aux, "%d\t%X\t%X\t%X\t%d\n", (unsigned int)tick_counter.read(), (unsigned int) (in_source_wrapper_local.read()), (unsigned int)in_target_wrapper_local.read(), (unsigned int) in_payload_wrapper_local.read(), (unsigned int) auxService);
			fprintf(fp,"%s",aux);
			//prevService = auxService;
		} 
		/*else {			

		}*/
		fclose (fp);

		fp = fopen (jsonf, "a");
		if(!first){
			fprintf(fp,",\n");
		}else
			first=false;
		fprintf(fp,"{\n");
		fprintf(fp," \"tick\":%d\n",(unsigned int)tick_counter.read());
// sc_in< bool >					in_fail_cpu_local;
// sc_in<bool>						in_fail_cpu_config;
// sc_in 	<sc_uint<32> >	  	 	mem_address_service_fail_cpu;
// sc_in   <bool >					in_req_wrapper_local;
// sc_in   <bool >					in_opmode_wrapper_local;
		fprintf(fp," \"in_fail_wrapper_local\":%d\n",(unsigned int)in_fail_wrapper_local.read());// sc_in <bool > in_fail_wrapper_local;
// sc_out   <bool > 				out_ack_wrapper_local;
// sc_out   <bool > 				out_nack_wrapper_local;
// sc_out   <bool >				out_req_wrapper_local;
// sc_out   <bool >				out_opmode_wrapper_local;
// sc_out   <bool >				out_fail_wrapper_local;
// sc_in   <bool > 				in_ack_wrapper_local;
// sc_in   <bool > 				in_nack_wrapper_local;
		fprintf(fp," \"in_source_router\":%d\n",(unsigned int)(in_source_router.read()&0xffff<<16)>>16);// sc_signal <reg_seek_source > in_source_router;
// sc_signal 	<reg_seek_target > 				in_target_router;
		fprintf(fp,"}");
		fclose(fp);
	}
}
/*-- PDN services
    #define    SET_SECURE_ZONE_SERVICE                 0b00111
    #define    OPEN_SECURE_ZONE_SERVICE                0b01010
    #define    SECURE_ZONE_CLOSED_SERVICE              0b01011
    #define    SECURE_ZONE_OPENED_SERVICE              0b01100
    #define    SET_SZ_RECEIVED_SERVICE                 0b11101
    #define    SET_EXCESS_SZ_SERVICE                   0b11110
---*/