
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

#define START_APP_SERVICE				1	//0x01
#define	TARGET_UNREACHABLE_SERVICE		2	//0x02
#define	CLEAR_SERVICE					3	//0x03
#define	BACKTRACK_SERVICE				4	//0x04
#define	SEARCHPATH_SERVICE				5	//0x05
#define END_TASK_SERVICE				6	//0x06
#define SET_SECURE_ZONE_SERVICE 		7	//0x07
#define	PACKET_RESEND_SERVICE			8	//0x08
#define WARD_SERVICE                    9	//0x09
#define OPEN_SECURE_ZONE_SERVICE        10	//0x0A
#define SECURE_ZONE_CLOSED_SERVICE      11	//0x0B
#define	SECURE_ZONE_OPENED_SERVICE		12	//0x0C
#define	FREEZE_TASK_SERVICE				13	//0x0D
#define	UNFREEZE_TASK_SERVICE			14	//0x0E
#define MASTER_CANDIDATE_SERVICE        15	//0x0F
#define TASK_ALLOCATED_SERVICE          16	//0x10
#define INITIALIZE_SLAVE_SERVICE        17	//0x11
#define	INITIALIZE_CLUSTER_SERVICE	    18	//0x12
#define LOAN_PROCESSOR_REQUEST_SERVICE  19	//0x13
#define LOAN_PROCESSOR_RELEASE_SERVICE  20	//0x14
#define END_TASK_OTHER_CLUSTER_SERVICE  21	//0x15
#define	WAIT_KERNEL_SERVICE				22	//0x16
#define	SEND_KERNEL_SERVICE				23	//0x17
#define	WAIT_KERNEL_SERVICE_ACK			24	//0x18
#define	FAIL_KERNEL_SERVICE				25	//0x19
#define NEW_APP_SERVICE   		        26	//0x1A
#define NEW_APP_ACK_SERVICE        		27	//0x1B
#define GMV_READY_SERVICE		        28	//0x1C
#define SET_SZ_RECEIVED_SERVICE         29	//0x1D
#define SET_EXCESS_SZ_SERVICE           30	//0x1E
#define	RCV_FREEZE_TASK_SERVICE			31	//0x1F
#define	BR_TO_APPID_SERVICE				32	//0x20
#define	SET_AP_SERVICE					33	//0x21
#define	MSG_DELIVERY_CONTROL		    34	//0x22
#define	MSG_REQUEST_CONTROL				35	//0x23
#define	RENEW_KEY						36	//0x24
#define	KEY_ACK							37	//0x25
#define REQUEST_SNIP_RENEWAL			38	//0x26
#define LC_NOTIFICATION					39	//0x27
#define AP_NOTIFICATION					40	//0x28
#define UNEXPECTED_DATA					41	//0x29
#define MISSING_PACKET					42	//0x2A
#define PROBE_REQUEST					43  //0x2B
#define PROBE_PATH						44  //0x2C
#define PROBE_CONTROL					45  //0x2D
#define PROBE_RESULT					46  //0x2E
#define PROBE_REQUEST_PATH				47  //0x2F
#define PROBE_PATH_XY					48  //0x30
#define RESET_HERMES_PORT_SERVICE		49  //0x31
#define INIT_ROUTER_RESET				50  //0x32


#define	IRQ_SEEK						0x80

//  #define seek_puts(argument) puts(argument)
#define seek_puts(argument) 
#define MAX_TRIES 5

#define portToDirection(port) ( (port) < 4 ? (port) : (port) - 4 )

//used for seek purposes
// int slot_seek;

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

int ProcessTurnsPointer(unsigned int backtrack, unsigned int backtrack1, unsigned int backtrack2, SourceRoutingTableSlot* ptrSR);

//void Set_Secure_Zone(unsigned int right_high_corner, unsigned int left_low_corner, unsigned int master_PE);

//void Unset_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE);

void Start_App_Secure_Zone(unsigned int appID);

void fireRecoverySearchpath(int target);

void requestRecoverySearchpath(int sessionCode, int target);

#endif
