
#ifndef SEEK_H_
#define SEEK_H_

#include "utils.h"
#include "../include/plasma.h"
#include "../include/services.h"
// #include "applications.h"
#define MAX_TASK_COMMUNICATION 10 //TODO: include this define from application.h

#define EAST 		0
#define WEST 		1
#define NORTH		2
#define SOUTH		3

#define WEST_FIRST      0
#define EAST_FIRST      1

#define GLOBAL_MODE		0
#define RESTRICT_MODE	1

#define MAX_SOURCE_ROUTING_PATH_SIZE		0x20
#define MAX_SOURCE_ROUTING_DESTINATIONS		20

//seek service types

#define START_APP_SERVICE				1
#define	TARGET_UNREACHABLE_SERVICE		2
#define	CLEAR_SERVICE					3
#define	BACKTRACK_SERVICE				4
#define	SEARCHPATH_SERVICE				5
#define END_TASK_SERVICE				6
#define SET_SECURE_ZONE_SERVICE 		7
// #define	PACKET_RESEND_SERVICE			8
#define	SET_AP_SERVICE					8
#define WARD_SERVICE                    9
#define OPEN_SECURE_ZONE_SERVICE        10
#define SECURE_ZONE_CLOSED_SERVICE      11
#define	SECURE_ZONE_OPENED_SERVICE		12
#define	FREEZE_TASK_SERVICE				13
#define	UNFREEZE_TASK_SERVICE			14
#define MASTER_CANDIDATE_SERVICE        15
#define TASK_ALLOCATED_SERVICE          16
#define INITIALIZE_SLAVE_SERVICE        17
#define	INITIALIZE_CLUSTER_SERVICE	    18
// #define LOAN_PROCESSOR_REQUEST_SERVICE  19
// #define LOAN_PROCESSOR_RELEASE_SERVICE  20
#define END_TASK_OTHER_CLUSTER_SERVICE  21
#define	WAIT_KERNEL_SERVICE				22
#define	SEND_KERNEL_SERVICE				23
#define	WAIT_KERNEL_SERVICE_ACK			24
#define	FAIL_KERNEL_SERVICE				25
#define NEW_APP_SERVICE   		        26
#define NEW_APP_ACK_SERVICE        		27
#define GMV_READY_SERVICE		        28
#define SET_SZ_RECEIVED_SERVICE         29
#define SET_EXCESS_SZ_SERVICE           30
#define	RCV_FREEZE_TASK_SERVICE			31
#define	BR_TO_APPID_SERVICE				31

#define	MSG_DELIVERY_CONTROL		    19
#define	MSG_REQUEST_CONTROL				20


#define	IRQ_SEEK						0x80

 //#define seek_puts(argument) puts(argument)
#define seek_puts(argument) 
#define MAX_TRIES 5

//used for seek purposes
int slot_seek;

typedef struct {
	unsigned int path[MAX_SOURCE_ROUTING_PATH_SIZE];
	// unsigned int tableSlotStatus;
	enum {SR_LIVRE, SR_USADO} tableSlotStatus;
	unsigned int target;
	unsigned int path_size;
	unsigned int prevPath[MAX_TRIES][MAX_SOURCE_ROUTING_PATH_SIZE];
	//unsigned char port[64];
} SourceRoutingTableSlot;

struct{
	enum {FIFO_F, FIFO_U} status;
	unsigned int target;
} fifo_seek[MAX_TASK_COMMUNICATION];

extern SourceRoutingTableSlot SR_Table[MAX_SOURCE_ROUTING_DESTINATIONS];

int initSRstructs();

int GetFreeSlotSourceRouting();

int ClearSlotSourceRouting(int );

int SearchSourceRoutingDestination(int);

int GetSRpointer(int target);

void Seek(unsigned int, unsigned int, unsigned int, unsigned int);

int SeekInterruptHandler();

void print_port(unsigned int);

int ProcessTurns(unsigned int backtrack, unsigned int backtrack1, unsigned int backtrack2);

//void Set_Secure_Zone(unsigned int right_high_corner, unsigned int left_low_corner, unsigned int master_PE);

//void Unset_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE);

void Start_App_Secure_Zone(unsigned int appID);


#endif
