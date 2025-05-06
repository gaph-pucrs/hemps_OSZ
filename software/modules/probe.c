#include "probe.h"

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
    for(int i = 0; i < MAX_INCOMING_BATCHES; i++) {
        incoming_batches[i].status = INCOMING_BATCH_BLANK;
    }
    for(int i = 0; i < MAX_OUTGOING_BATCHES; i++) {
        outgoing_batches[i].status = OUTGOING_BATCH_BLANK;
    }
}

void report_suspicious_path_to_mpe(unsigned int target) {
    
    unsigned char compressed_path[3];

    int sr_path_index = SearchSourceRoutingDestination(target);
    if (sr_path_index != -1) { // is using source routing
        convert_sr_header_to_compressed_path(SR_Table[sr_path_index].path, SR_Table[sr_path_index].path_size, compressed_path);
    } else { // is using xy
        char path[MAX_PROBE_PATH_SIZE];
        int path_size = write_xy_path(path, get_net_address()&0xFFFF, target);
        convert_path_to_compressed_path(path, path_size, compressed_path);
    }
    
    unsigned char source_address = ((get_net_address() & 0xF00) >> 4) | (get_net_address() & 0xF);
    unsigned char target_address = ((target & 0xF00) >> 4) | (target & 0xF);
    unsigned int source_field = ((compressed_path[0] << 24) | (compressed_path[1] << 16) | (source_address << 8) | (target_address));
    
    Seek(REPORT_SUSPICIOUS_PATH, source_field, *probe_mpe_addr_ptr, compressed_path[2]);
}

/***************/
/**** PRINT ****/
/***************/

void print_probe_result(int status) {
    switch(status) {
        case PROBE_RESULT_SUCCESS:
            probe_puts("SUCCESS");
            break;
        case PROBE_RESULT_FAILURE:
            probe_puts("FAILURE");
            break;
        default:
            probe_puts("UNKNOWN RESULT");
    }
}

void print_probe_result_logs(int status) {
    switch(status) {
        case PROBE_RESULT_SUCCESS:
            probe_logs_puts("SUCCESS");
            break;
        case PROBE_RESULT_FAILURE:
            probe_logs_puts("FAILURE");
            break;
        default:
            probe_logs_puts("UNKNOWN RESULT");
    }
}

void print_turn(char turn) {
    switch(turn) {
        case EAST:
            probe_puts("E");
            return;
        case WEST:
            probe_puts("W");
            return;
        case NORTH:
            probe_puts("N");
            return;
        case SOUTH:
            probe_puts("S");
            return;
    }
}

void print_turn_logs(char turn) {
    switch(turn) {
        case EAST:
            probe_logs_puts("E");
            return;
        case WEST:
            probe_logs_puts("W");
            return;
        case NORTH:
            probe_logs_puts("N");
            return;
        case SOUTH:
            probe_logs_puts("S");
            return;
        default:
            probe_logs_puts(itoa(turn));
            return;
    }
}

void print_path(char *path, int path_size) {
    for(int i = 0; i < path_size; i++)
        print_turn(path[i]);
}

void print_path_logs(char *path, int path_size) {
    for(int i = 0; i < path_size; i++)
        print_turn_logs(path[i]);
}

void print_sr_header(unsigned int *header, int header_size) {
    for(int i = 0; i < header_size; i++) {
        probe_puts(itoh(header[i]));
        probe_puts(" ");
    }
}

void print_sr_header_logs(unsigned int *header, int header_size) {
    for(int i = 0; i < header_size; i++) {
        probe_logs_puts(itoh(header[i]));
        probe_logs_puts(" ");
    }
}

void print_compressed_path(unsigned char *compressed_path) {
    int byte = 0;
    int turn = 0;
    while(byte < 3) {
        int shift = 8 - ((turn + 1) * 2);
        int turn_val = (compressed_path[byte] >> shift) & 0x3;
        print_turn(turn_val);
        if(++turn == 4) {
            turn = 0;
            byte++;
        }
    }
}

/********************/
/**** PATH LOGIC ****/
/********************/

int get_turn_integer(char turn) {
    if (turn == 'E') return EAST;
    if (turn == 'W') return WEST;
    if (turn == 'N') return NORTH;
    if (turn == 'S') return SOUTH;
    return -1;
}

char get_opposite_direction(char direction) {

    if(direction >= 4) //uses the second channel
        direction = direction -4;

    switch(direction) {
        case EAST:
            return WEST;
        case WEST:
            return EAST;
        case NORTH:
            return SOUTH;
        case SOUTH:
            return NORTH;
    }
    probe_puts("[HT] Function get_opposite_direction received invalid parameter\n");
    return -1;
}

int are_opposite_directions(char direction1, char direction2) {
    if(direction1 >= 4) //uses the second channel
        direction1 = direction1 -4;
    switch(direction1) {
        case EAST:
            return (direction2 == WEST);
        case WEST:
            return (direction2 == EAST);
        case NORTH:
            return (direction2 == SOUTH);
        case SOUTH:
            return (direction2 == NORTH);
    }
    //probe_puts("[HT] ERROR - are_opposite_directions received invalid input\n");
    //probe_puts("[HT] direction1= "); probe_puts(itoa(direction1)); probe_puts(" direction2= "); probe_puts(itoa(direction2)); probe_puts("\n");
    return 0;
}

unsigned int calculate_target(unsigned int source, char *path, int path_size) {

    int x = source >> 8;
    int y = source & 0xff;

    for(int i = 0; i < path_size; i++) {
        switch(path[i]) {
            case EAST:
                x++;
                break;
            case WEST:
                x--;
                break;
            case NORTH:
                y++;
                break;
            case SOUTH:
                y--;
                break;
        }
    }

    return (x << 8) | y;
}

int write_xy_path(char *path_buffer, unsigned int source, unsigned int target) {

    int i = 0;

    int current_x = source >> 8;
    int current_y = source & 0xff;

    int target_x = target >> 8;
    int target_y = target & 0xff;

    while(current_x < target_x) {
        path_buffer[i] = EAST;
        current_x++;
        i++;
    }

    while(current_x > target_x) {
        path_buffer[i] = WEST;
        current_x--;
        i++;
    }

    while(current_y < target_y) {
        path_buffer[i] = NORTH;
        current_y++;
        i++;
    }

    while(current_y > target_y) {
        path_buffer[i] = SOUTH;
        current_y--;
        i++;
    }

    return i; //path size
}

void convert_path_to_compressed_path(char *path, int path_size, unsigned char *compressed_path) {

    int cpath_hop = 0;
    int cpath_byte = 0;

    int path_hop, shift;
    for(path_hop = 0; path_hop < path_size; path_hop++) {
        
        shift = 8 - ((cpath_hop + 1) * 2);

        //if it's the first compressed path hop, initialize the byte
        if(cpath_hop == 0)
            compressed_path[cpath_byte] = 0;

        compressed_path[cpath_byte] = compressed_path[cpath_byte] | (path[path_hop] << shift);

        cpath_hop++;
        if(cpath_hop == 4) {
            cpath_byte++;
            cpath_hop = 0;
        }
    }

    //termination hop
    shift = 8 - ((cpath_hop + 1) * 2);
    compressed_path[cpath_byte] = compressed_path[cpath_byte] | (get_opposite_direction(path[path_hop-1]) << shift);
}

int convert_compressed_path_to_path(unsigned char *compressed_path, char *path) {

    int path_hop = 0;

    int cpath_hop = 0;
    int cpath_byte = 0;

    char current_port, next_port;

    do {
        int shift = 8 - ((cpath_hop + 1) * 2);
        current_port = (compressed_path[cpath_byte] >> shift) & 0x3;

        path[path_hop] = current_port;
        path_hop++;

        cpath_hop++;
        if(cpath_hop == 4) {
            cpath_byte++;
            cpath_hop = 0;
        }

        //special case: compressed case has no termination hop
        if(cpath_byte > 2)
            return path_hop;

        int next_shift = 8 - ((cpath_hop + 1) * 2);
        next_port = (compressed_path[cpath_byte] >> next_shift) & 0x3;

    } while(are_opposite_directions(current_port, next_port) == 0);

    return path_hop;
}

int convert_path_to_sr_header(char *path, int path_size, unsigned int *header) {

    //The dual channel path respects the turn model used in Hermes
    char dual_channel_path[MAX_PROBE_PATH_SIZE];
    int dual_channel_path_size = convert_single_channel_path_to_dual_channel_path(path, path_size, dual_channel_path);

    int word_index = 0;
    int turn_index = 0;
    int turn;

    int hop = 0;
    int total_hops = dual_channel_path_size + 1; //additional last hop is used to indicate end of path
 
    probe_puts("[HT] Total Hops = ");
    probe_puts(itoa(total_hops - 1));
    probe_puts("\n");

    while(hop < total_hops) {

        int is_last_hop = hop == (total_hops-1);
        int shift = 32 - ((turn_index + 1) * 4);


        //if it's the first turn, initialize the word
        if(turn_index == 0) {
            header[word_index] = 0;
        }

        //the start of each 16-bit flit stars with 0x7 turn to indicate it is a sr header
        if(turn_index == 0 || turn_index == 4) {
            header[word_index] = header[word_index] | (0x7 << shift);
        }

        //the other 4-bit slices contain the actual path hops
        else {
            turn = is_last_hop ? get_opposite_direction(dual_channel_path[hop-1]) : dual_channel_path[hop];
            header[word_index] = header[word_index] | (turn << shift);
            hop++;
        }

        probe_puts("[HT] turn_index = ");
        probe_puts(itoa(turn_index));
        probe_puts(";turn = ");
        probe_puts(itoa(turn));
        probe_puts("\n");
        print_sr_header(header, word_index);

        //increment turn_index
        turn_index++;
        if(turn_index == 8) {
            word_index++;
            turn_index = 0;
        }
    }

    //last word was filled completly, return as is:
    if(turn_index == 0)
        return word_index;

    //last word was not filled: complete the remaining turns with 0xe to indicate "empty"
    while(turn_index < 8) {
        int shift = 32 - ((turn_index + 1) * 4);
        int turn = (turn_index == 0 || turn_index == 4) ? 0x7 : 0xe;
        header[word_index] = header[word_index] | (turn << shift); 
        turn_index++;
    }

    return word_index + 1; //header size, in words
}

int convert_sr_header_to_path(unsigned int *header, int header_size, char *path) {

    int path_index = 0;

    int header_word = 0;
    int header_turn = 1; //skips position 0 (sr flit flag)

    unsigned volatile int current_hop;
    unsigned volatile int next_hop = 0;
    // puts("nxt1 = ");puts(itoa(next_hop));puts("\n");
    next_hop = (header[0]);
    // // puts("head0 = ");puts(itoa(next_hop));puts("\n");
    next_hop = (next_hop >> 24);
    // // puts("nxt_header = ");puts(itoa(next_hop));puts("\n");
    next_hop = (next_hop) & 0x0f;
    // // puts("nxt_and = ");puts(itoa(next_hop));puts("\n");
    next_hop = portToDirection(next_hop); //use only E W N S turns
    // puts("nxt_port = ");puts(itoa(next_hop));puts("\n");

    // next_hop = portToDirection((header[0] >> 24) & 0xf); //use only E W N S turns

    while(header_word < header_size) {

        /* Write current hop into path */
        current_hop = next_hop;

        path[path_index] = current_hop;

        /* Increment header turn */
        path_index++;

        header_turn++;

        if(header_turn == 4)
            header_turn = 5; //skips position 4 (sr flit flag)

        else if(header_turn == 8) {
            header_word++;
            header_turn = 1; //skips position 0 (sr flit flag)
        }

        /* Get next hop and check if path is finished */

        int shift = 32 - ((header_turn + 1) * 4);
        next_hop = portToDirection((header[header_word] >> shift) & 0xf); //use only E W N S turns

        if(are_opposite_directions(current_hop, next_hop))
            return path_index;
    }

    probe_puts("[HT] Error: convert_sr_header_to_path received wrong header_size_value\n");
    return path_index;
}

int convert_compressed_path_to_sr_header(unsigned char *compressed_path, unsigned int *header) {

    probe_puts("[HT] [DEBUG] input compressed path: ");
    print_compressed_path(compressed_path);
    probe_puts("\n");

    char path[MAX_PROBE_PATH_SIZE];
    int path_size = convert_compressed_path_to_path(compressed_path, path);

    probe_puts("[HT] [DEBUG] intermediate path: ");
    print_path(path, path_size);
    probe_puts("\n");

    int header_size = convert_path_to_sr_header(path, path_size, header);

    probe_puts("[HT] [DEBUG] output sr header: ");
    print_sr_header(header, header_size);
    probe_puts("\n");

    return header_size;
}

void convert_sr_header_to_compressed_path(unsigned int *header, int header_size, unsigned char *compressed_path) {

    probe_puts("[HT] [DEBUG] input sr header: ");
    print_sr_header(header, header_size);
    probe_puts("\n");

    char path[MAX_PROBE_PATH_SIZE];
    int path_size = convert_sr_header_to_path(header, header_size, path);

    probe_puts("[HT] [DEBUG] intermediate path: ");
    print_path(path, path_size);
    probe_puts("\n");

    convert_path_to_compressed_path(path, path_size, compressed_path);

    probe_puts("[HT] [DEBUG] output compressed path: ");
    print_compressed_path(compressed_path);
    probe_puts("\n");
}

int convert_single_channel_path_to_dual_channel_path(char *path, int path_size, char *dual_channel_path) {

    const int west_first = 0;
    const int east_first = 1;

    int i;
    int algorithm = west_first;
	
    for(i = 0; i < path_size-1; i++) {
		if(algorithm == west_first) {
            //turns prohibited by WEST FIRST: SW and NW
			if((path[i] == SOUTH || path[i] == NORTH) && path[i+1] == WEST) {
				algorithm = east_first;
			}
            dual_channel_path[i] = path[i]; //channel 0
		}
		else {
            //turns prohibited by EAST FIRST: SE and NE
			if((path[i] == SOUTH || path[i] == NORTH) && path[i+1] == EAST) {
				algorithm = west_first;
			}
            dual_channel_path[i] = path[i] + 4; //channel 1
		}
	}

    //last hop is assigned separately as it does not have to calculate the algorithm for the next hop
    dual_channel_path[i] = (algorithm == west_first) ? path[i] : path[i] + 4;

    return path_size;
}

/************************/
/**** FAULTY PACKETS ****/
/************************/

void clear_residual_switching_from_current_path(unsigned int faulty_packet_source, unsigned int faulty_packet_target) {

    // probe_puts("[ROUTER RST] ** DATA MESSAGE RESET **\n");

    char faulty_path[MAX_PROBE_PATH_SIZE];
    int faulty_path_size;

    int sr_slot = SearchSourceRoutingDestination(faulty_packet_target);
    
    if(sr_slot < 0)
        faulty_path_size = write_xy_path(faulty_path, faulty_packet_source, faulty_packet_target); // Path is XY
    else
        faulty_path_size = convert_sr_header_to_path(SR_Table[sr_slot].path, SR_Table[sr_slot].path_size, faulty_path); // Path is SR
    
    send_reset_packets_to_routers_in_path(faulty_packet_source, faulty_path, faulty_path_size);
}

void send_reset_packets_to_routers_in_path(unsigned int source, char *path, int path_size) {

    // probe_puts("[ROUTER RST] Clearing path from "); probe_puts(itoh(source)); probe_puts("\n");
    // probe_puts("[ROUTER RST] Faulty path: "); print_path(path, path_size); probe_puts("\n");

    // RESET SOURCE LOCAL PORT
    
    unsigned int reset_mask = (1 << PORT_LOCAL0) | (1 << PORT_LOCAL1);
    // probe_puts("[ROUTER RST]   Resetting "); probe_puts(itoh(source)); probe_puts(" L\n");
    Seek(RESET_HERMES_PORT_SERVICE, (MemoryRead(TICK_COUNTER) << 16) | reset_mask, source, 0);

    // RESET INTERMEDIATE HOPS

    int current_x = source >> 8;
    int current_y = source & 0xff;

    for(int i = 0; i < path_size; i++) {

        // Obs: the hops denoted in "faulty_path[]" indicates the OUTPUT direction used to transmit the packet to the next router
        // As the Router Reset needs to clear the INPUT BUFFERS of the routers, we clear the hops OPPOSITE to those in "faulty_path[]"

        switch(path[i]) {
            case EAST:
                current_x += 1;
                reset_mask = (1 << PORT_WEST0) | (1 << PORT_WEST1);
                break;

            case WEST:
                current_x -= 1;
                reset_mask = (1 << PORT_EAST0) | (1 << PORT_EAST1);
                
                break;

            case NORTH:
                current_y +=1;
                reset_mask = (1 << PORT_SOUTH0) | (1 << PORT_SOUTH1);
                break;

            case SOUTH:
                current_y -= 1;
                reset_mask = (1 << PORT_NORTH0) | (1 << PORT_NORTH1);
                break;
            
            default:
                probe_puts("[ROUTER RST] UNRECOGNIZEBLE TURN: "); probe_puts(itoh(path[i])); probe_puts("\n");
        }

        int current_router = (current_x << 8) | current_y;

        // probe_puts("[ROUTER RST]   Resetting "); probe_puts(itoh(current_router)); probe_puts(" "); print_turn(get_opposite_direction(path[i])); probe_puts("\n");
        Seek(RESET_HERMES_PORT_SERVICE, (MemoryRead(TICK_COUNTER) << 16) | reset_mask, current_router, 0);
    }
}

void request_to_clear_residual_switching(unsigned int faulty_packet_source) {

    /* PACKET IS PROBE DEFINED BY THE MPE */

    int probe_id = -1;
    for(int slot = 0; slot < MAX_INCOMING_PROBES; slot++) {
        if(incoming_probes[slot].status == INCOMING_PROBE_WAITING_MESSAGE && incoming_probes[slot].source == faulty_packet_source) {
            probe_id = incoming_probes[slot].id;
            break;
        }
    }

    if(probe_id > 0) {
        // Seek(INIT_ROUTER_RESET, probe_id, *probe_mpe_addr_ptr, 1); // payload '1' indicates that it is a faulty probe, src field contains probe_id
        return;
    }

    /* PACKET IS REGULAR AND SENT BY THE SOURCE */

    probe_puts("[DMNI TIMEOUT] Sending reset router REQUEST to "); probe_puts(itoh(faulty_packet_source)); probe_puts("\n");
    // Seek(INIT_ROUTER_RESET, get_net_address(), faulty_packet_source, 0); // payload '0' indicates that it is a regular faulty packet, src field contais src addr
}

/*******************/
/**** PROBE API ****/
/*******************/

int get_new_incoming_probe_slot() {

    int remaining_slots = MAX_INCOMING_PROBES;
    while(remaining_slots > 0) {

        int slot = next_incoming_probe_slot;
        enum incoming_probe_status slot_status = incoming_probes[slot].status;

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
        enum outgoing_probe_status slot_status = outgoing_probes[slot].status;

        next_outgoing_probe_slot = (next_outgoing_probe_slot + 1) % MAX_OUTGOING_PROBES;
        
        if(slot_status == OUTGOING_PROBE_BLANK || slot_status == OUTGOING_PROBE_SENT || slot_status == OUTGOING_PROBE_BATCH_CONFIGURED) {
            outgoing_probes[slot].status = OUTGOING_PROBE_ALLOCATED;
            return slot;
        }

        remaining_slots--;
    }

    probe_puts("[HT] ERROR: outgoing_probes array has no slot available\n");
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

void send_probe(unsigned int probe_id, unsigned int source, unsigned int target, unsigned int *sr_header, int sr_header_length, unsigned int batch_config) {

    /* PROBE CONTROL */

    unsigned char compact_net_address = ((get_net_address() & 0xf00) >> 4) | (get_net_address() & 0xf);
    Seek(PROBE_CONTROL, (batch_config << 16) | (probe_id & 0xffff), target, compact_net_address);

    /* PROBE MESSAGE */

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = target;
    
    p->service = PROBE_MESSAGE;
    p->probe_id = probe_id;
    p->probe_source = source;
    p->probe_target = target;
    p->data_size = PROBE_PACKET_SIZE;

    if(batch_config==0){
        probe_logs_puts("[HT] SEND PROBE MESSAGE -- probe #"); probe_logs_puts(itoa(probe_id & 0xffff)); probe_logs_puts(" from batch #"); probe_logs_puts(itoa(probe_id & 0xffff));
    }
    probe_logs_puts(" src: ");
    probe_logs_puts(itoh(source));
    
    probe_logs_puts(" tgt: ");
    probe_logs_puts(itoh(target));

    probe_logs_puts(" path: ");

    char path_to_print[MAX_PROBE_PATH_SIZE];
    int path_size = convert_sr_header_to_path(sr_header, sr_header_length, path_to_print);

    print_path_logs(path_to_print, path_size);

	probe_logs_puts(" payload_size: "); probe_logs_puts(itoa(PROBE_PACKET_SIZE));

    probe_logs_puts(" config_period: ");
    probe_logs_puts(itoa((batch_config & 0x3F)));

    probe_logs_puts(" probe_type: ");
    probe_logs_puts(batch_config == 0 ? "bsa" : "batch");

    probe_logs_puts(" release_time: @");
    probe_logs_puts(itoa(MemoryRead(TICK_COUNTER)));

    probe_logs_puts("\n");

    send_packet_through_sr_path(p, 0, PROBE_PACKET_SIZE, sr_header, sr_header_length);
    // send_packet_through_sr_path(p, 0, 0, sr_header, sr_header_length);
}

void handle_probe_request(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {
    
    unsigned short batch_config = pkt_source >> 16;

    unsigned int id_lo = (pkt_source >> 8) & 0xff;
    unsigned int id_hi = pkt_payload;
    unsigned int probe_id = (id_hi << 8) | id_lo;
    
    unsigned char compressed_probe_target = pkt_source & 0xff;
    unsigned int probe_target = ((compressed_probe_target & 0xf0) << 4) | (compressed_probe_target & 0xf);

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
        outgoing_probes[slot].batch_config = batch_config;
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
    outgoing_probes[slot].batch_config = batch_config;

    if(batch_config) {
        probe_puts("[HT] Configuring batch: "); probe_puts(itoh(batch_config)); probe_puts("\n");
        configure_new_outgoing_batch(&outgoing_probes[slot]);
        outgoing_probes[slot].status = OUTGOING_PROBE_BATCH_CONFIGURED;
        return;
    }

    unsigned int sr_header[MAX_PROBE_SR_LENGTH];
    int sr_header_length = convert_compressed_path_to_sr_header(outgoing_probes[slot].compressed_path, sr_header);

    outgoing_probes[slot].status = OUTGOING_PROBE_SENT;
    send_probe(probe_id, get_net_address(), probe_target, sr_header, sr_header_length, 0);
}

void handle_probe_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {
    
    unsigned int probe_id = pkt_source & 0xffff;
    
    unsigned char probe_path[3];
    probe_path[0] = (pkt_source & 0xff000000) >> 24;
    probe_path[1] = (pkt_source & 0xff0000) >> 16;
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

    if(outgoing_probes[slot].batch_config) {
        probe_puts("[HT] Configuring batch: "); probe_puts(itoh(outgoing_probes[slot].batch_config)); probe_puts("\n");
        configure_new_outgoing_batch(&outgoing_probes[slot]);
        outgoing_probes[slot].status = OUTGOING_PROBE_BATCH_CONFIGURED;
        return;
    }

    unsigned int sr_header[MAX_PROBE_SR_LENGTH];
    int sr_header_length = convert_compressed_path_to_sr_header(probe_path, sr_header);

    outgoing_probes[slot].status = OUTGOING_PROBE_SENT;
    send_probe(probe_id, get_net_address(), outgoing_probes[slot].target, sr_header, sr_header_length, 0);
}

void receive_probe(unsigned int probe_id, unsigned int source, unsigned int target) {

    probe_logs_puts("[HT] RECV PROBE MESSAGE -- probe #");
    probe_logs_puts(itoa(probe_id));

    probe_logs_puts(" src: ");
    probe_logs_puts(itoh(source));
    
    probe_logs_puts(" tgt: ");
    probe_logs_puts(itoh(target));

    probe_logs_puts(" arrive_time: @");
    probe_logs_puts(itoa(MemoryRead(TICK_COUNTER)));

    probe_logs_puts("\n");

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

    finalize_incoming_probe(&incoming_probes[slot], PROBE_RESULT_SUCCESS);
}

void receive_probe_control(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {

    unsigned short batch_config = pkt_source >> 16;
    unsigned short probe_id = pkt_source & 0xff;

    unsigned char compact_source = pkt_payload;
    unsigned int source = ((compact_source & 0xf0) << 4) | (compact_source & 0xf);

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
        incoming_probes[slot].batch_config = batch_config;
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

    incoming_probes[slot].batch_config = batch_config;
    finalize_incoming_probe(&incoming_probes[slot], PROBE_RESULT_SUCCESS);
}

void finalize_incoming_probe(struct incoming_probe *in_probe, int probe_result) {
    
    if(in_probe->batch_config == 0) {
        send_probe_result(in_probe->id, in_probe->source, probe_result);
    } else {
        register_result_to_incoming_batch(in_probe, probe_result);
    }

    in_probe->status = (probe_result == PROBE_RESULT_SUCCESS) ? INCOMING_PROBE_SUCCEEDED : INCOMING_PROBE_FAILED;
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
                finalize_incoming_probe(&incoming_probes[i], PROBE_RESULT_FAILURE);
            }
            else {
                probe_puts("[HT] Probe is within threshold\n");
            }
        }
    }
}

/***********************/
/**** PROBE BATCHES ****/
/***********************/

int get_new_incoming_batch_slot() {
    for(int i = 0; i < MAX_INCOMING_BATCHES; i++) {
        if(incoming_batches[i].status == INCOMING_BATCH_BLANK || incoming_batches[i].status == INCOMING_BATCH_RECEIVED) {
            incoming_batches[i].status = INCOMING_BATCH_ALLOCATED;
            return i;
        }
    }
    return -1;
}

int get_new_outgoing_batch_slot() {
    for(int i = 0; i < MAX_OUTGOING_BATCHES; i++) {
        if(outgoing_batches[i].status == OUTGOING_BATCH_BLANK || outgoing_batches[i].status == OUTGOING_BATCH_SENT) {
            outgoing_batches[i].status = OUTGOING_BATCH_ALLOCATED;
            return i;
        }
    }
    return -1;
}

int find_incoming_batch_by_probe_id(int probe_id) {
    for(int i = 0; i < MAX_INCOMING_BATCHES; i++) {
        int initial_id = incoming_batches[i].initial_id;
        int final_id = incoming_batches[i].initial_id + incoming_batches[i].batch_size - 1;
        if((incoming_batches[i].status == INCOMING_BATCH_RECEIVING) && (initial_id <= probe_id) && (probe_id <= final_id)) {
            return i;
        }
    }
    return -1;
}

void configure_new_outgoing_batch(struct outgoing_probe *out_probe) {
    
    int slot = get_new_outgoing_batch_slot();
    if(slot < 0) {
        probe_puts("[HT] No space left for new Outgoing Batch, ignoring request.\n");
        return;
    }

    outgoing_batches[slot].initial_id = out_probe->id;
    outgoing_batches[slot].target = out_probe->target;
    outgoing_batches[slot].sr_header_size = convert_compressed_path_to_sr_header(out_probe->compressed_path, outgoing_batches[slot].sr_header);
    outgoing_batches[slot].batch_config = out_probe->batch_config;

    probe_puts("[HT] Configuring new Outgoing Batch\n");
    probe_puts("        Init ID: #"); probe_puts(itoa(out_probe->id)); probe_puts("\n");
    probe_puts("        Target: "); probe_puts(itoh(out_probe->target)); probe_puts("\n");

    unsigned char distribution = (out_probe->batch_config & 0xC000) >> 14;
    switch(distribution) {
        case UNIFORM_BATCH_CODE:
            outgoing_batches[slot].distribution = UNIFORM_DISTRIBUTION;
            outgoing_batches[slot].uniform_distribution_delay = (out_probe->batch_config & 0x3F00) >> 8;
            outgoing_batches[slot].batch_size = out_probe->batch_config & 0xFF;
            outgoing_batches[slot].next_probe_timestamp = MemoryRead(TICK_COUNTER); //send asap
            probe_puts("        Distribution: uniform\n");
            probe_puts("        Batch size: "); probe_puts(itoa(outgoing_batches[slot].batch_size)); probe_puts("\n");
            probe_puts("        Delay: "); probe_puts(itoa(outgoing_batches[slot].uniform_distribution_delay)); probe_puts("\n");
            break;
        default:
            probe_puts("[HT] Outgoing batch error: unknown distibution type: "); probe_puts(itoa(distribution)); probe_puts("\n");
            return;
    }

    outgoing_batches[slot].sent_probes = 0;
    outgoing_batches[slot].status = OUTGOING_BATCH_SENDING;
}

void monitor_outgoing_batches() {
    unsigned int time_now = MemoryRead(TICK_COUNTER);
    for(int i = 0; i < MAX_OUTGOING_BATCHES; i++) {
        if(outgoing_batches[i].status == OUTGOING_BATCH_SENDING && time_now >= outgoing_batches[i].next_probe_timestamp) {
            probe_logs_puts("[HT] SEND PROBE MESSAGE -- probe #"); probe_logs_puts(itoa(outgoing_batches[i].initial_id + (outgoing_batches[i].sent_probes))); probe_logs_puts(" from batch #"); probe_logs_puts(itoa(outgoing_batches[i].initial_id));
            send_probe_from_outgoing_batch(&outgoing_batches[i]);
        }
    }
}

void send_probe_from_outgoing_batch(struct outgoing_batch *out_batch) {

    unsigned int next_probe_id = out_batch->initial_id + out_batch->sent_probes;

    //Generating second batch_config that contains relative position
    
    unsigned int new_batch_config = 0xC000 | ((out_batch->sent_probes & 0x2F) << 6) | (out_batch->batch_size & 0x2F);
    send_probe(next_probe_id, get_net_address(), out_batch->target, out_batch->sr_header, out_batch->sr_header_size, new_batch_config);
    out_batch->sent_probes++;
    
    if(out_batch->sent_probes == out_batch->batch_size) {
        probe_puts("[HT] Outgoing Batch #"); probe_puts(itoa(out_batch->initial_id)); probe_puts(" finalized.\n");
        out_batch->status = OUTGOING_BATCH_SENT;
    } else {
        update_outgoing_batch_timestamp(out_batch);
    }
}

void update_outgoing_batch_timestamp(struct outgoing_batch *out_batch) {

    int probe_spacing_in_us, probe_spacing_in_cc;

    probe_puts("[HT] Batch next timestamp upload. Batch #") probe_puts(itoa(out_batch->initial_id)); 
    probe_puts(". Previous value: "); probe_puts(itoa(out_batch->next_probe_timestamp));

    switch(out_batch->distribution) {
        case UNIFORM_DISTRIBUTION:
            probe_spacing_in_us = out_batch->uniform_distribution_delay; // 1us granularity
            probe_spacing_in_cc = probe_spacing_in_us * 100;
            out_batch->next_probe_timestamp = out_batch->next_probe_timestamp + probe_spacing_in_cc;
            break;
        
        default:
            probe_puts("[HT] Warning: trying to update out_batch timestamp with UNKNOWN DISTRIBUTION.\n");
            return;
    }

    probe_puts(". Next value: "); probe_puts(itoa(out_batch->next_probe_timestamp)); probe_puts("\n");
}

void register_result_to_incoming_batch(struct incoming_probe *in_probe, int probe_result) {

    int slot = find_incoming_batch_by_probe_id(in_probe->id);
    if(slot < 0)
        slot = configure_new_incoming_batch(in_probe);

    incoming_batches[slot].finished_probes++;
    if(probe_result == PROBE_RESULT_FAILURE)
        incoming_batches[slot].failed_probes++;
    
    probe_puts("[HT DEBUG] Finished probes: "); probe_puts(itoa(incoming_batches[slot].finished_probes)); probe_puts("\n");
    
    if(incoming_batches[slot].finished_probes == incoming_batches[slot].batch_size) {
        send_probe_result(incoming_batches[slot].initial_id, incoming_batches[slot].source, (incoming_batches->failed_probes > 0) ? PROBE_RESULT_FAILURE : PROBE_RESULT_SUCCESS);
        incoming_batches[slot].status = INCOMING_BATCH_RECEIVED;
    }

}

int configure_new_incoming_batch(struct incoming_probe *in_probe) {
    
    int slot = get_new_incoming_batch_slot();

    //unsigned int distribution = (in_probe->batch_config & 0xC0) >> 14;
    unsigned int relative_position = (in_probe->batch_config & 0xFC) >> 6;
    unsigned int batch_size = (in_probe->batch_config & 0x3F);

    incoming_batches[slot].initial_id = in_probe->id - relative_position;
    incoming_batches[slot].source = in_probe->source;
    incoming_batches[slot].batch_size = batch_size;
    incoming_batches[slot].failed_probes = 0;
    incoming_batches[slot].finished_probes = 0;
    incoming_batches[slot].status = INCOMING_BATCH_RECEIVING;

    probe_puts("[HT] Configuring new Incoming Batch\n");
    probe_puts("        Init ID: #"); probe_puts(itoa(in_probe->id - relative_position)); probe_puts("\n");
    probe_puts("        Source: "); probe_puts(itoh(in_probe->source)); probe_puts("\n");
    probe_puts("        Distribution: uniform\n");
    probe_puts("        Batch size: "); probe_puts(itoa(incoming_batches[slot].batch_size)); probe_puts("\n");
    
    return slot;
}
