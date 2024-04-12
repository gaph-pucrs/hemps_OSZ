/*!\file packet.h
 * HEMPS VERSION - 8.0 - support for RT applications
 *
 * Distribution:  June 2016
 *
 * Created by: Marcelo Ruaro - contact: marcelo.ruaro@acad.pucrs.br
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief
 * This module defines the ServiceHeader structure. This structure is used by all software components to
 * send and receive packets. It defines the service header of each packets.
 */

#ifndef SOFTWARE_INCLUDE_PACKET_PACKET_H_
#define SOFTWARE_INCLUDE_PACKET_PACKET_H_

#include "../../include/kernel_pkg.h"
#include "seek.h"

//packet size 14 in mazembe
 //#define CONSTANT_PKT_SIZE	14	//!<Constant Service Header size, based on the structure ServiceHeader.
#define CONSTANT_PKT_SIZE	13	//!<Constant Service Header size, based on the structure ServiceHeader.

#define 	OUT_NORTH		5
#define 	OUT_EAST		4
#define 	OUT_WEST		3
#define 	OUT_SOUTH		2

#define INPUT_DIRECTION      0
#define OUTPUT_DIRECTION     1
#define CLEAR_INPUT_DIRECTION      2

/**
 * \brief This structure is in charge to defines the ServiceHeader field that can be filled by the software part
 * when need to send a packet, or that will be read when the packet is received
 */
typedef struct {
	unsigned int header[MAX_SOURCE_ROUTING_PATH_SIZE];				//!<Is the first flit of packet, keeps the target NoC router
	unsigned int payload_size;			//!<Stores the number of flits that forms the remaining of packet
	unsigned int service;				//!<Store the packet service code (see services.h file)
	union {								//!<Generic union
		unsigned int producer_task;
		unsigned int task_ID;
		unsigned int app_ID;
		unsigned int io_service;
		unsigned int SR_target;
		unsigned int probe_source;
	};

	union {								//!<Generic union
	   	unsigned int consumer_task;
	   	unsigned int peripheral_ID;
	   	unsigned int cluster_ID;
	   	unsigned int master_ID;
	   	unsigned int hops;
	   	unsigned int period;
		unsigned int io_port;
		unsigned int k0; 
		unsigned int io_task_ID;
		unsigned int probe_target;
	};

	unsigned int source_PE;				//!<Store the packet source PE address
	unsigned int timestamp;				//!<Store the packet timestamp, filled automatically by send_packet function

	union {
		unsigned int transaction;			//!<Unused field for while
		unsigned int arrival_time;
	};

	union {								//!<Generic union
		unsigned int msg_lenght;
		unsigned int resolution;
		unsigned int priority;
		unsigned int latency_deadline;
		unsigned int pkt_latency;
		unsigned int stack_size;
		unsigned int requesting_task;
		unsigned int released_proc;
		unsigned int app_task_number;
		unsigned int app_descriptor_size;
		unsigned int allocated_processor;
		unsigned int requesting_processor;
	   	unsigned int io_direction;
		unsigned int burst_size;
	};

	union {								//!<Generic union
		unsigned int probe_sr_length;
		unsigned int pkt_size;
		unsigned int data_size;
	};

	union {								//!<Generic union
		unsigned int code_size;
		unsigned int max_free_procs;
		unsigned int execution_time;
		unsigned int secure;
		unsigned int program_counter; //aux fochi
	};

	union {								//!<Generic union
		unsigned int bss_size;
		unsigned int cpu_slack_time;
		unsigned int request_size;
	};

	union {								//!<Generic union
		unsigned int initial_address;
		//unsigned int program_counter;
		unsigned int utilization;
	};

	//Add new variables here ...

} ServiceHeader;

/**
 * \brief This structure is in charge to store a ServiceHeader slot memory space
 */
typedef struct {

	ServiceHeader service_header;
	unsigned int status;

}ServiceHeaderSlot;


volatile ServiceHeader* get_service_header_slot();

void init_service_header_slots();

int DMNI_read_data(unsigned int, unsigned int);

void DMNI_send_data(unsigned int, unsigned int);

void send_packet(volatile ServiceHeader *, unsigned int, unsigned int);
void send_packet_through_sr_path(volatile ServiceHeader *p, unsigned int initial_address, unsigned int dmni_msg_size, unsigned int *path, int path_size);
void send_packet_io(volatile ServiceHeader *, unsigned int, unsigned int, int);

int find_io_peripheral(unsigned int );

int get_last_hop(unsigned int, unsigned int );

int find_SZ_position_and_direction_to_IO(int );

void send_wrapper_close_back__open_forward(int );

void send_wrapper_close_forward(int );

int read_packet(ServiceHeader *);

int pathToIO(int, int*);

int oppositePort(unsigned int p);

int pathFromIO(long unsigned int);

int IOtoAPmaster(int peripheral_id, int ap_addr, int ap_port, int ioInGrayLine);


#endif /* SOFTWARE_INCLUDE_PACKET_PACKET_H_ */
