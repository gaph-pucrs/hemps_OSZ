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

// Ticket Status
#define BLANK 0
#define WAITING_DATA 1
#define WAITING_TICKET 2
#define WAITING 3
#define SUSPICIOUS 4

#define END_SESSION -1
#define START_SESSION -2

#define WAITING_MSG_QUEUE 10 

//#define session_puts(argument) puts(argument)
#define session_puts(argument) 
//#define SESSION_MANAGER

typedef struct 
{
	unsigned int producer;
	unsigned int consumer;
	unsigned int time;
    unsigned int avgLatency;
    Message* msg;
    // ServiceHeader header; 
    unsigned int status;
    int sent;
    int rcvd;
    int code;
} Ticket;

// typedef struct 
// {
// 	unsigned int producer;
// 	unsigned int consumer;
// 	unsigned int time;
//     int sent;
//     int recieved;
//     Message* msg;
//     // ServiceHeader header; 
//     unsigned int status;
//     int code;
// } Session;


Message waitingMessages[WAITING_MSG_QUEUE];
Ticket deliveryTicket[2*MAX_TASKS_APP];
int recptIndex;
int auxIndex;
int auxTime;
int tInit, tEnd;