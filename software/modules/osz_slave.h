/*!\file osz.h
 * HEMPS VERSION - 8.5 - support for OSZ
 *
 * Distribution:  August 2020
 *
 * Created by: Luciano Caimi - contact: lcaimi@gmail.com
 *             Rafael Faccenda - contact: faccendarafael@gmail.com
 *
 * Research group: GAPH-PUCRS   -  contact:  fernando.moraes@pucrs.br
 *
 * \brief This module implements functions to open and close Opaque Secure Zones
 *
 */

#ifndef _OSZ_SLAVE_H_
#define _OSZ_SLAVE_H_

#include "../../include/kernel_pkg.h"
#include "../include/api.h"

/** \brief This structure store variables useful to the kernel master manage the Access Point
 */
typedef struct 
{
    unsigned int address;
    unsigned int port;
} AccessPoint;

void Set_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE);
/*  Origem: seek.c
    Instância: SeekInterruptHandler > kernel_slave.c
    Variáveis Globais:
        wrapper_value > seek.c
*/

void Unset_Secure_Zone(unsigned int left_low_corner, unsigned int right_high_corner, unsigned int master_PE);
/*  Origem: seek.c
    Instância: SeekInterruptHandler > kernel_slave.c
    Variáveis Globais:
        wrapper_value > seek.c
*/


// Session Status
#define BLANK 0
#define WAITING_DATA 1
#define WAITING_CONTROL 2
#define WAITING_ANY 3
#define SUSPICIOUS 4
#define IO_WAITING 5
#define IO_IDLE 6
#define RECOVERING 7


#define END_SESSION -1
#define START_SESSION -2

#define LAT_THRESHOLD 1000
#define TIMEOUT_SLEEP 2000
#define KE_OSZ 0x021

#define LAT_THRESHOLD_CONV 0.2
#define ONE_HOP_STD_LATENCY 500

#define LAT_THRESHOLD_MOD 1.2
#define LAT_THRESHOLD_WARMUP 1 // 5
#define LAT_THRESHOLD_TOLERANCE 1 //5 // 1/5 = 20%

// Array Sizes
#define WAITING_MSG_QUEUE 10 
#define MAX_SESSIONS (2*MAX_TASKS_APP) + IO_NUMBER

// #define session_time_puts(argument) puts(argument)
#define session_time_puts(argument) 

// #define session_puts(argument) puts(argument)
#define session_puts(argument) 

typedef struct 
{
	unsigned int producer;  // Producer task ID
	unsigned int consumer;  // Consumer task ID
	unsigned int time;      // Time accumulator
    unsigned int avgLatency;    // Average Latency of this Session
    Message* msg;           // Pointer to a message received via DATA NoC waiting for the CONTROL
    ServiceHeader* header;  // Pointer to a message received via CONTROL NoC waiting for the DATA
    unsigned int status;    // Session Status
    int sent;               // Number of sent packets
    int requested;          // Number of requested packets
    int code;               // Session code
    int pairIndex;          // The session Index on the pair side, so when the message arrives, it is directly indexed
    unsigned int auxTimestamp;
    unsigned int countedLatencies;
    unsigned int timeoutThreshold;
} Session;


Message waitingMessages[WAITING_MSG_QUEUE];
ServiceHeader waitingServices[WAITING_MSG_QUEUE];
Session Sessions[MAX_SESSIONS];
int recptIndex;
int auxIndex;
int auxTime;
int tInit, tEnd;
int auxCode;
int auxSlot;
Session* auxSession;

void config_AP_SZ();
//ServiceHeader* auxService;

// int findBlankSession(Session* sessions);
// int checkSession(Session* sessions, unsigned int prod, unsigned int cons);
// int checkSessionCode(Session* sessions, unsigned int code);
// int clearSession(Session* sessions, int index);
// void initSessions();
// Message* getMessageSlot();
// void clearMessageSlot(Message* m);
// ServiceHeader* getServiceSlot();
// void clearServiceSlot(ServiceHeader* slot);
// int createSession(Session* sessions, unsigned int prod, unsigned int cons, int code);
// void printSessions(Session* sessions);
// void printSessionStatus(Session* sessions, unsigned int index);
// int checkRunningSession(Session* sessions, unsigned int task);
// void copyService(ServiceHeader* SHsource, ServiceHeader* SHtarget);
// ServiceHeader* checkWaitingServices(ServiceHeader* serviceQueue, int sProd, int sCons, int serv);
// void send_message_delivery_control(Session * sessions,unsigned int prod, unsigned int cons, unsigned int target);
// void send_message_request_control(Session* sessions, unsigned int prod, unsigned int cons, unsigned int target);
// void timeoutMonitor(Session* sessions, int time);
// int find_SZ_position_and_direction_to_IO(int peripheral_id);
// void open_wrapper_IO_SZ(int peripheral_id, int io_service); // io_service: 0 - request; 1 - delivery
// void send_wrapper_close_back__open_forward(int CM_index);
// void send_wrapper_close_forward(int CM_index);

#endif
