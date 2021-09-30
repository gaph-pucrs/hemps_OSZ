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
#include "../../include/kernel_pkg.h"
#include "../include/api.h"
#include "packet.h"



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

#define END_SESSION -1
#define START_SESSION -2

#define LAT_THRESHOLD 1000
#define TIMEOUT_SLEEP 2000

// Array Sizes
#define WAITING_MSG_QUEUE 10 
#define MAX_SESSIONS 2*MAX_TASKS_APP

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
//ServiceHeader* auxService;
