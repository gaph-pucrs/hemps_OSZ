#ifndef PROBE_PROTOCOL_SLAVE_H_
#define PROBE_PROTOCOL_SLAVE_H_

#include "probe_protocol.h"
#include "packet.h"

#define PROBE_MASTER_ADDR 0x0004

#define MAX_PROBE_SR_LENGTH 10

#define PROBE_STATUS_IDLE 1
#define PROBE_STATUS_WAITING_CONTROL 2
#define PROBE_STATUS_WAITING_MESSAGE 3

#define STATIC_PROBE_THRESHOLD 15000 //150us

int probe_sr_length;
unsigned int probe_sr_header[MAX_PROBE_SR_LENGTH];

int probe_status; // {IDLE, WAITING_CONTROL, WAITING_PROBE}
unsigned int probe_source_address;
unsigned int probe_timestamp;

void init_probe_structures();

void send_probe(unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length);

void receive_probe(unsigned int source, unsigned int target);

void receive_probe_control(unsigned int source, unsigned int target, unsigned int payload);

void send_probe_result(unsigned int probe_source, unsigned int result);

void monitor_probe_timeout();

#endif
