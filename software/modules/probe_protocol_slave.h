#ifndef PROBE_PROTOCOL_SLAVE_H_
#define PROBE_PROTOCOL_SLAVE_H_

#include "probe_protocol.h"
#include "packet.h"

#define PROBE_MASTER_ADDR 0x0004

#define MAX_INCOMING_PROBES 10
#define MAX_OUTGOING_PROBES 10

#define INCOMING_PROBE_BLANK 0
#define INCOMING_PROBE_ALLOCATED 1
#define INCOMING_PROBE_WAITING_CONTROL 2
#define INCOMING_PROBE_WAITING_MESSAGE 3
#define INCOMING_PROBE_SUCCEEDED 4
#define INCOMING_PROBE_FAILED 5

#define STATIC_PROBE_THRESHOLD 15000 //150us

struct incoming_probe {
    short id;
    unsigned short source;
    unsigned int timestamp;
    char status;
};

int next_incoming_probe_slot;
struct incoming_probe incoming_probes[MAX_INCOMING_PROBES];

enum outgoing_probe_status {
    OUTGOING_PROBE_BLANK,
    OUTGOING_PROBE_ALLOCATED,
    OUTGOING_PROBE_WAITING_REQUEST,
    OUTGOING_PROBE_WAITING_PATH,
    OUTGOING_PROBE_SENT
};

struct outgoing_probe {
    short id;
    unsigned short target;
    unsigned char compressed_path[3];
    enum outgoing_probe_status status;
};

int next_outgoing_probe_slot;
struct outgoing_probe outgoing_probes[MAX_OUTGOING_PROBES];

int probe_sr_length;
unsigned int probe_sr_header[MAX_PROBE_SR_LENGTH];

int probe_status; // {IDLE, WAITING_CONTROL, WAITING_PROBE}
unsigned int probe_id_timeout;
unsigned int probe_source_address;
unsigned int probe_timestamp;

void init_probe_structures();

int get_new_incoming_probe_slot();

int get_new_outgoing_probe_slot();

int get_incoming_probe_by_id(unsigned int probe_id);

int get_outgoing_probe_by_id(unsigned int probe_id);

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length);

void handle_probe_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void handle_probe_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target);

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload);

void send_probe_result(unsigned int probe_id, unsigned int probe_source, int result);

void monitor_probe_timeout();

#endif
