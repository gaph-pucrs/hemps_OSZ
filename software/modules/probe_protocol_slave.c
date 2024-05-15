#include "probe_protocol_slave.h"

void init_probe_structures(unsigned int *mpe_addr_ptr) {
    probe_mpe_addr_ptr = mpe_addr_ptr;
    next_incoming_probe_slot = 0;
    for(int i = 0; i < MAX_INCOMING_PROBES; i++) {
        incoming_probes[i].status = INCOMING_PROBE_BLANK;
    }
    next_outgoing_probe_slot = 0;
    for(int i = 0; i < MAX_OUTGOING_PROBES; i++) {
        outgoing_probes[i].status = OUTGOING_PROBE_BLANK;
    }
    next_suspicious_path_slot = 0;
    for(int i = 0; i < MAX_SUSPICIOUS_PATHS; i++) {
        suspicious_paths[i].status = SUS_PATH_BLANK;
    }
}

int get_new_incoming_probe_slot() {

    int remaining_slots = MAX_INCOMING_PROBES;
    while(remaining_slots > 0) {

        int slot = next_incoming_probe_slot;
        int slot_status = incoming_probes[slot].status;

        next_incoming_probe_slot = (next_incoming_probe_slot + 1) % MAX_INCOMING_PROBES;

        if(slot_status == INCOMING_PROBE_BLANK || slot_status == INCOMING_PROBE_SUCCEEDED || slot_status == INCOMING_PROBE_FAILED) {
            incoming_probes[slot].status = INCOMING_PROBE_ALLOCATED;
            return slot;
        }

        remaining_slots--;
    }

    probe_puts("[HT] ERROR: incoming_probes array has no slot available\n");
    return -1;
}

int get_new_outgoing_probe_slot() {

    int remaining_slots = MAX_OUTGOING_PROBES;
    while(remaining_slots > 0) {

        int slot = next_outgoing_probe_slot;
        int slot_status = outgoing_probes[slot].status;

        next_outgoing_probe_slot = (next_outgoing_probe_slot + 1) % MAX_OUTGOING_PROBES;
        
        if(slot_status == OUTGOING_PROBE_BLANK || slot_status == OUTGOING_PROBE_SENT) {
            outgoing_probes[slot].status = OUTGOING_PROBE_ALLOCATED;
            return slot;
        }

        remaining_slots--;
    }

    probe_puts("[HT] ERROR: outgoing_probes array has no slot available\n");
    return -1;
}

int get_new_suspicious_path_slot() {

    int remaining_slots = MAX_SUSPICIOUS_PATHS;
    while(remaining_slots > 0) {

        int slot = next_suspicious_path_slot;
        enum suspicious_path_status slot_status = suspicious_paths[slot].status;

        next_suspicious_path_slot = (next_suspicious_path_slot + 1) % MAX_SUSPICIOUS_PATHS;
        
        if(slot_status == SUS_PATH_BLANK || slot_status == SUS_PATH_XY_SENT || slot_status == SUS_PATH_SR_SENT) {
            suspicious_paths[slot].status = SUS_PATH_ALLOCATED;
            return slot;
        }

        remaining_slots--;
    }

    probe_puts("[HT] ERROR: suspicious_paths array has no slot available\n");
    return -1;
}

int get_incoming_probe_by_id(unsigned int probe_id) {
    for(int i = 0; i < MAX_INCOMING_PROBES; i++)
        if(incoming_probes[i].id == probe_id && incoming_probes[i].status != INCOMING_PROBE_BLANK)
            return i;
    return -1;
}

int get_outgoing_probe_by_id(unsigned int probe_id) {
    for(int i = 0; i < MAX_OUTGOING_PROBES; i++)
        if(outgoing_probes[i].id == probe_id && outgoing_probes[i].status != OUTGOING_PROBE_BLANK)
            return i;
    return -1;
}

int get_suspicious_path_by_target(unsigned int target) {
    int i = 0;
    while(i < MAX_SUSPICIOUS_PATHS) {
        if(suspicious_paths[i].target == target && suspicious_paths[i].status != SUS_PATH_BLANK)
            return i;
        i++;
    }
    return -1;
}

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length) {

    probe_puts("[HT] SEND PROBE MESSAGE -- probe #");
    probe_puts(itoa(probe_id));

    probe_puts(" src: ");
    probe_puts(itoh(source));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(target));
    
    probe_puts(" sr: ");
    print_sr_header(sr_header, sr_header_length);
    probe_puts("\n");

    /* PROBE CONTROL */

    Seek(PROBE_CONTROL, (probe_id << 16) | (get_net_address() & 0xffff), target, 0);

    /* PROBE MESSAGE */

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = target;
    
    p->service = PROBE_MESSAGE;
    p->probe_id = probe_id;
    p->probe_source = source;
    p->probe_target = target;

    send_packet_through_sr_path(p, 0, 0, sr_header, sr_header_length);
}

void handle_probe_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {

    unsigned int probe_id = pkt_source >> 16;
    unsigned int probe_target = pkt_source & 0xffff;

    probe_puts("[HT] Received PROBE_REQUEST -- probe #");
    probe_puts(itoa(probe_id));
    probe_puts(" tgt: ");
    probe_puts(itoh(probe_target));
    probe_puts("\n");

    int slot = get_outgoing_probe_by_id(probe_id);

    if(slot == -1) {
        slot = get_new_outgoing_probe_slot();
        outgoing_probes[slot].id = probe_id;
        outgoing_probes[slot].target = probe_target;
        outgoing_probes[slot].status = OUTGOING_PROBE_WAITING_PATH;
        probe_puts("[HT]    Waiting PROBE_PATH...\n");
        return;
    }

    if(outgoing_probes[slot].status != OUTGOING_PROBE_WAITING_REQUEST) {
        probe_puts("[HT] ERROR: handle_probe_request function expected slot to be WAITING_REQUEST, but was: ");
        probe_puts(itoa(outgoing_probes[slot].status));
        probe_puts("\n");
        return;
    }

    outgoing_probes[slot].target = probe_target;

    unsigned int sr_header[MAX_PROBE_SR_LENGTH];
    int sr_header_length = convert_compressed_path_to_sr_header(outgoing_probes[slot].compressed_path, sr_header);

    outgoing_probes[slot].status = OUTGOING_PROBE_SENT;
    send_probe(probe_id, get_net_address(), probe_target, sr_header, sr_header_length);
}

void handle_probe_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {
    
    unsigned int probe_id = pkt_source >> 16;
    
    unsigned char probe_path[3];
    probe_path[0] = (pkt_source & 0xff00) >> 8;
    probe_path[1] = pkt_source & 0xff;
    probe_path[2] = pkt_payload;

    probe_puts("[HT] Received PROBE_PATH -- probe #");
    probe_puts(itoa(probe_id));
    probe_puts(" compressed path: ");
    print_compressed_path(probe_path);
    probe_puts("\n");

    int slot = get_outgoing_probe_by_id(probe_id);

    if(slot == -1) {
        slot = get_new_outgoing_probe_slot();
        outgoing_probes[slot].id = probe_id;
        outgoing_probes[slot].compressed_path[0] = probe_path[0];
        outgoing_probes[slot].compressed_path[1] = probe_path[1];
        outgoing_probes[slot].compressed_path[2] = probe_path[2];
        outgoing_probes[slot].status = OUTGOING_PROBE_WAITING_REQUEST;
        probe_puts("[HT]    Waiting PROBE_REQUEST...\n");
        return;
    }

    if(outgoing_probes[slot].status != OUTGOING_PROBE_WAITING_PATH) {
        probe_puts("[HT] ERROR: handle_probe_request function expected slot to be WAITING_PATH, but was: ");
        probe_puts(itoa(outgoing_probes[slot].status));
        probe_puts("\n");
        return;
    }

    outgoing_probes[slot].compressed_path[0] = probe_path[0];
    outgoing_probes[slot].compressed_path[1] = probe_path[1];
    outgoing_probes[slot].compressed_path[2] = probe_path[2];

    unsigned int sr_header[MAX_PROBE_SR_LENGTH];
    int sr_header_length = convert_compressed_path_to_sr_header(probe_path, sr_header);

    outgoing_probes[slot].status = OUTGOING_PROBE_SENT;
    send_probe(probe_id, get_net_address(), outgoing_probes[slot].target, sr_header, sr_header_length);
}

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target) {

    probe_puts("[HT] RECV PROBE MESSAGE -- probe #");
    probe_puts(itoa(probe_id));

    probe_puts(" src: ");
    probe_puts(itoh(source));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(target));
    probe_puts("\n");

    int slot = get_incoming_probe_by_id(probe_id);

    if(slot == -1) {
        slot = get_new_incoming_probe_slot();
        incoming_probes[slot].id = probe_id;
        incoming_probes[slot].source = source;
        incoming_probes[slot].timestamp = MemoryRead(TICK_COUNTER);
        incoming_probes[slot].status = INCOMING_PROBE_WAITING_CONTROL;
        return;
    }

    if(incoming_probes[slot].status != INCOMING_PROBE_WAITING_MESSAGE) {
        probe_puts("[HT] ERROR: receive_probe function expected slot to be WAITING_MESSAGE, but was: ");
        probe_puts(itoa(incoming_probes[slot].status));
        probe_puts("\n");
        return;
    }

    if(incoming_probes[slot].source != source) {
        probe_puts("[HT] ERROR: PROBE_MESSAGE and PROBE_CONTROL had different sources\n");
        return;
    }

    incoming_probes[slot].status = INCOMING_PROBE_SUCCEEDED;
    send_probe_result(probe_id, source, PROBE_RESULT_SUCCESS);
}

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {

    unsigned int probe_id = pkt_source >> 16;
    unsigned int source = pkt_source & 0xffff;

    probe_puts("[HT] RECV PROBE CONTROL -- probe #");
    probe_puts(itoa(probe_id));
    
    probe_puts(" src: ");
    probe_puts(itoh(source));

    probe_puts(" tgt: ");
    probe_puts(itoh(pkt_target));
    probe_puts("\n");

    int slot = get_incoming_probe_by_id(probe_id);

    if(slot == -1) {
        slot = get_new_incoming_probe_slot();
        incoming_probes[slot].id = probe_id;
        incoming_probes[slot].source = source;
        incoming_probes[slot].timestamp = MemoryRead(TICK_COUNTER);
        incoming_probes[slot].status = INCOMING_PROBE_WAITING_MESSAGE;
        probe_puts("[HT] Debug: allocating new incoming_probe slot:");
        probe_puts(itoa(slot));
        probe_puts("\n");
        return;
    }

    if(incoming_probes[slot].status != INCOMING_PROBE_WAITING_CONTROL) {
        probe_puts("[HT] ERROR: receive_probe function expected slot to be WAITING_CONTROL, but was: ");
        probe_puts(itoa(incoming_probes[slot].status));
        probe_puts("\n");
        return;
    }

    if(incoming_probes[slot].source != source) {
        probe_puts("[HT] ERROR: PROBE_MESSAGE and PROBE_CONTROL had different sources\n");
        return;
    }

    incoming_probes[slot].status = INCOMING_PROBE_SUCCEEDED;
    send_probe_result(probe_id, source, PROBE_RESULT_SUCCESS);
}

void send_probe_result(unsigned int probe_id, unsigned int probe_source, int result) {

    probe_puts("[HT] SEND PROBE RESULTS -- probe #");
    probe_puts(itoa(probe_id));
    
    probe_puts(" src: ");
    probe_puts(itoh(probe_source));

    probe_puts(" tgt: ");
    probe_puts(itoh(get_net_address()));

    probe_puts(" result: ");
    probe_puts(itoh(result));
    probe_puts("\n");

    unsigned int packet_source_field = (probe_id << 16) | (get_net_address() & 0xffff);
    
    Seek(PROBE_RESULT, packet_source_field, *probe_mpe_addr_ptr, result);
}

void monitor_probe_timeout() {
    for(int i = 0; i < MAX_INCOMING_PROBES; i++) {
        if(incoming_probes[i].status == INCOMING_PROBE_WAITING_CONTROL || incoming_probes[i].status == INCOMING_PROBE_WAITING_MESSAGE) {
            if((MemoryRead(TICK_COUNTER) - incoming_probes[i].timestamp) >= STATIC_PROBE_THRESHOLD) {
                probe_puts("[HT] PROBE TIMEOUT VIOLATION -- Probe #");
                probe_puts(itoa(incoming_probes[i].id));
                probe_puts("\n");
                incoming_probes[i].status = INCOMING_PROBE_FAILED;
                send_probe_result(incoming_probes[i].id, incoming_probes[i].source, PROBE_RESULT_FAILURE);    
            }
            else {
                probe_puts("[HT] Probe is within threshold\n");
            }
        }
    }
}

void register_suspicious_path(unsigned int target) {

    probe_puts("[HT] Registering suspicious path to address "); probe_puts(itoh(target)); probe_puts("\n");

    int sus_path_slot = get_suspicious_path_by_target(target);
    
    if(sus_path_slot < 0) {
        probe_puts("[HT] [DEBUG] New suspicious target\n");
        sus_path_slot = get_new_suspicious_path_slot();
    }
    
    if(sus_path_slot < 0) {
        probe_puts("[HT] Error: could not save suspicious path.\n");
        return;
    }

    suspicious_paths[sus_path_slot].target = target;

    int sr_slot = SearchSourceRoutingDestination(target);
    
    if(sr_slot < 0) {
        probe_puts("[HT] [DEBUG] Suspicious path is XY\n");
        suspicious_paths[sus_path_slot].status = SUS_PATH_XY_PENDING;
        return;
    }

    probe_puts("[HT] [DEBUG] Suspicious path is SR\n");
    suspicious_paths[sus_path_slot].status = SUS_PATH_SR_PENDING;
    convert_sr_header_to_compressed_path(SR_Table[sr_slot].path, SR_Table[sr_slot].path_size, suspicious_paths[sus_path_slot].compressed_sr_path);
}

void handle_broken_path_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {

    unsigned int target = pkt_source >> 16;

    probe_puts("[HT] Received PROBE_PATH_REQUEST\n");
    probe_puts("[HT]        Target: "); probe_puts(itoh(target)); probe_puts("\n");

    int sus_path_slot = get_suspicious_path_by_target(target);
    if(sus_path_slot < 0) {
        probe_puts("[HT] Error: Suspicious path requested by the MPE was not registered in suspicious_paths array\n");
        return;
    }

    if(suspicious_paths[sus_path_slot].status == SUS_PATH_XY_PENDING) {
        probe_puts("[HT]        Path is XY\n");
        Seek(PROBE_PATH_XY, get_net_address() << 16, *probe_mpe_addr_ptr, 0);
        suspicious_paths[sus_path_slot].status = SUS_PATH_XY_SENT;
        return;
    }

    if(suspicious_paths[sus_path_slot].status == SUS_PATH_SR_PENDING) {
        unsigned char *compressed_sr_path = suspicious_paths[sus_path_slot].compressed_sr_path;
        probe_puts("[HT]        Compressed path (SR): "); print_compressed_path(compressed_sr_path); probe_puts("\n");
        Seek(PROBE_PATH, (get_net_address() << 16) | (compressed_sr_path[0] << 8) | compressed_sr_path[1], *probe_mpe_addr_ptr, compressed_sr_path[2]);
        suspicious_paths[sus_path_slot].status = SUS_PATH_SR_SENT;
        return;
    }

    probe_puts("[HT] ERROR: handle_broken_path function expected slot to be XY_PENDING or SR_PENDING, but was: ");
    probe_puts(itoa(suspicious_paths[sus_path_slot].status));
    probe_puts("\n");
}
