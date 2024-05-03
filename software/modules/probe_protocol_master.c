#include "probe_protocol_master.h"

void print_trust_score_matrix() {

    for(int link = 0; link < NUM_LINKS_PER_ROUTER; link++) {

        switch(link) {
            case EAST:
                probe_puts("EAST:\n");
                break;
            case WEST:
                probe_puts("WEST:\n");
                break;
            case NORTH:
                probe_puts("NORTH:\n");
                break;
            case SOUTH:
                probe_puts("SOUTH:\n");
                break;
        }

        for(int y = PLATFORM_DIMENSION_Y-1; y >= 0; y--) {
            for(int x = 0; x < PLATFORM_DIMENSION_X; x++) {

                int score = link_trust_scores[x][y][link];

                //signal
                if(score >= 0) {
                    probe_puts("+");
                }
                else {
                    probe_puts("-");
                    score *= -1;
                }

                //limit to 2 digits
                if(score > 99)
                    score = 99;
                
                //leading 0
                if(score < 10)
                    probe_puts("0");
                
                //actual print
                probe_puts(itoa(score));

                //spacing
                probe_puts(" ");
            }
            probe_puts("\n");
        }
    }
}

void init_probe_master_structures() {
    //init binary search
    broken_path_size = 0;
    enable_binary_search = 0;
    binary_search_left_status = BINARY_SEARCH_SIDE_BLANK;
    binary_search_right_status = BINARY_SEARCH_SIDE_BLANK;
    //init probe entries
    next_probe_id = 0;
    for(int i = 0; i < MAX_PROBE_ENTRIES; i++) {
        probes[i].status = PROBE_STATUS_FREE;
    }
    //init trust scores cube matrix
    for(int x = 0; x < PLATFORM_DIMENSION_X; x++) {
        for(int y = 0; y < PLATFORM_DIMENSION_Y; y++) {
            for(int z = 0; z < NUM_LINKS_PER_ROUTER; z++) {
                link_trust_scores[x][y][z] = 0;
            }
        }
    }
    //init missing packets queue
    next_missing_packet_pending = 0;
    next_missing_packet_slot = 0;
    missing_packets_pending = 0;
    for(int i = 0; i < SIZE_MISSING_PACKETS_QUEUE; i ++) {
        missing_packets_queue[i].status = MISSING_PACKET_FREE;
    }
}

int get_new_probe_slot() {

    //skip next probe_ids if the respective position on the array is holding a pending probe -- (think about what to do when all slots are filled)
    while(probes[PROBE_INDEX(next_probe_id)].status == PROBE_STATUS_PENDING)
        next_probe_id++;
    
    int probe_index = PROBE_INDEX(next_probe_id);
    probes[probe_index].id = next_probe_id;
    probes[probe_index].status = PROBE_STATUS_ALLOCATED;

    next_probe_id++;
    return probe_index;
}

void probe_protocol(int last_result) {

    static int probes_counter = 0;

    int probe_path_size;
    char probe_path[MAX_PATH_SIZE];

    //straight route
    if(probes_counter == 0) {
        probe_puts("[HT] **** Starting Probe Protocol -- WIP Hardcoded Version ****\n");
        probe_path[0] = EAST;
        probe_path[1] = EAST;
        probe_path[2] = EAST;
        probe_path[3] = EAST;
        probe_path_size = 4;
        send_probe_request(0x0003, 0x0403, probe_path, probe_path_size);
        probes_counter++;
        return;
    }

    //north route
    if(probes_counter == 1) {
        probe_path[0] = NORTH;
        probe_path[1] = EAST;
        probe_path[2] = EAST;
        probe_path[3] = EAST;
        probe_path[4] = EAST;
        probe_path[5] = SOUTH;
        probe_path_size = 6;
        send_probe_request(0x0003, 0x0403, probe_path, probe_path_size);
        probes_counter++;
        return;
    }

    //south route
    if(probes_counter == 2) {
        probe_path[0] = SOUTH;
        probe_path[1] = EAST;
        probe_path[2] = EAST;
        probe_path[3] = EAST;
        probe_path[4] = EAST;
        probe_path[5] = NORTH;
        probe_path_size = 6;
        send_probe_request(0x0003, 0x0403, probe_path, probe_path_size);
        probes_counter++;
        return;
    }
}

void report_missing_packet(unsigned int source, unsigned int target) {

    //mpe already busy with a binary search, queue for later
    if(enable_binary_search == 1) {

        //if queue is full, ignore missing packet
        if(missing_packets_pending == SIZE_MISSING_PACKETS_QUEUE) {
            probe_puts("[HT] Missing Packets Queue is completely full, ignoring Missing Packet Report. Source=");
            probe_puts(itoh(source));
            probe_puts(" Target=");
            probe_puts(itoh(target));
            probe_puts("\n");
            return;
        }

        missing_packets_queue[next_missing_packet_slot].source = source; 
        missing_packets_queue[next_missing_packet_slot].target = target;
        missing_packets_queue[next_missing_packet_slot].status = MISSING_PACKET_PENDING;
        next_missing_packet_slot = (next_missing_packet_slot + 1) % SIZE_MISSING_PACKETS_QUEUE;
        missing_packets_pending++;
        return;
    }

    //binary search is not busy, perform binary search on the missing packet
    start_binary_search_xy(source, target);
}

void check_missing_packets_queue() {
    
    //no missing packets to handle
    if(missing_packets_pending == 0)
        return;
    
    //consume missing packet from queue
    unsigned int source = missing_packets_queue[next_missing_packet_pending].source;
    unsigned int target = missing_packets_queue[next_missing_packet_pending].target;
    missing_packets_queue[next_missing_packet_pending].status = MISSING_PACKET_HANDLED;
    next_missing_packet_pending = (next_missing_packet_pending + 1) % SIZE_MISSING_PACKETS_QUEUE;
    missing_packets_pending--;

    start_binary_search_xy(source, target);
}

void print_search_result() {
    probe_puts("[HT] **** BINARY SEARCH FINALIZED -- HT LOCATION: ");
    probe_puts(itoh(broken_router));
    probe_puts(" ");
    switch(broken_port) {
        case EAST:
            probe_puts("E");
            break;
        case WEST:
            probe_puts("W");
            break;
        case NORTH:
            probe_puts("N");
            break;
        case SOUTH:
            probe_puts("S");
            break;
    }
    probe_puts(" ****\n");
}

void start_binary_search_xy(unsigned int source, unsigned int target) {

    broken_path_source = source;
    broken_path_target = target;
    broken_path_size = write_xy_path(broken_path, source, target);

    probe_puts("[HT] **** Starting new binary search - Source:");
    probe_puts(itoh(source));
    probe_puts(" Target:");
    probe_puts(itoh(target));
    probe_puts(" Path:");
    print_path(broken_path, broken_path_size);
    probe_puts("\n");

    if(enable_binary_search == 1) {
        probe_puts("[HT] MPE already has ongoing binary search. Discarding...\n");        
        return;
    }

    binary_search_path = broken_path;
    binary_search_path_size = broken_path_size;
    binary_search_source = broken_path_source;
    binary_search_target = broken_path_target;
    
    enable_binary_search = 1;
    send_binary_search_probes();
}

void send_binary_search_probes() {

    /* Divide path into two halves */

    binary_search_left_path = binary_search_path;
    binary_search_left_size = binary_search_path_size / 2;

    binary_search_right_path = binary_search_path + binary_search_left_size;
    binary_search_right_size = binary_search_path_size - binary_search_left_size;

    binary_search_middle = calculate_target(binary_search_source, binary_search_path, binary_search_left_size);

    /* Send probes to both sides in parallel */

    binary_search_left_status = BINARY_SEARCH_SIDE_PENDING;
    binary_search_left_probe_id = send_probe_request(binary_search_source, binary_search_middle, binary_search_left_path, binary_search_left_size);
    
    binary_search_right_status = BINARY_SEARCH_SIDE_PENDING;
    binary_search_right_probe_id = send_probe_request(binary_search_middle, binary_search_target, binary_search_right_path, binary_search_right_size);
}

void receive_binary_search_probe(int probe_id, int result) {

    /* Receive probes from each side and update status */

    if(probe_id == binary_search_left_probe_id) {

        if(binary_search_left_status != BINARY_SEARCH_SIDE_PENDING) {
            probe_puts("[HT] ERROR: Binary Search received multiple PROBE_RESULTS for the left side.\n");
            return;
        }

        binary_search_left_status = (result == PROBE_RESULT_SUCCESS) ? BINARY_SEARCH_SIDE_SUCCESS : BINARY_SEARCH_SIDE_FAILED;
    }
    else if(probe_id == binary_search_right_probe_id) {

        if(binary_search_right_status != BINARY_SEARCH_SIDE_PENDING) {
            probe_puts("[HT] ERROR: Binary Search received multiple PROBE_RESULTS for the right side.\n");
            return;
        }

        binary_search_right_status = (result == PROBE_RESULT_SUCCESS) ? BINARY_SEARCH_SIDE_SUCCESS : BINARY_SEARCH_SIDE_FAILED;
    }

    /* If both sides finished: read results and decide how to continue the search */

    // didn't finish both sides
    if(binary_search_left_status == BINARY_SEARCH_SIDE_PENDING || binary_search_right_status == BINARY_SEARCH_SIDE_PENDING) {
        return;
    }

    // fail/success - zoom on left
    if(binary_search_left_status == BINARY_SEARCH_SIDE_FAILED && binary_search_right_status == BINARY_SEARCH_SIDE_SUCCESS) {

        if(binary_search_left_size == 1) {
            broken_router = binary_search_source;
            broken_port = binary_search_left_path[0];
            print_search_result();
            finalize_binary_search();
            return;
        }

        binary_search_path = binary_search_left_path;
        binary_search_path_size = binary_search_left_size;
        binary_search_source = binary_search_source;
        binary_search_target = binary_search_middle;

        send_binary_search_probes();
        return;
    }

    // success/fail - zoom on right
    if(binary_search_left_status == BINARY_SEARCH_SIDE_SUCCESS && binary_search_right_status == BINARY_SEARCH_SIDE_FAILED) {

        if(binary_search_right_size == 1) {
            broken_router = binary_search_middle;
            broken_port = binary_search_right_path[0];
            print_search_result();
            finalize_binary_search();
            return;
        }
        
        binary_search_path = binary_search_right_path;
        binary_search_path_size = binary_search_right_size;
        binary_search_source = binary_search_middle;
        binary_search_target = binary_search_target;

        send_binary_search_probes();
        return;
    }

    // fail/fail - zoom on left & queue right for later
    if(binary_search_left_status == BINARY_SEARCH_SIDE_FAILED && binary_search_right_status == BINARY_SEARCH_SIDE_FAILED) {
        probe_puts("[HT] ERROR: Binary Search does not yet support paths with multiple HTs -- Abandoning search\n");

        finalize_binary_search();
        return;
    }

    // success/success - abandon search
    if(binary_search_left_status == BINARY_SEARCH_SIDE_SUCCESS && binary_search_right_status == BINARY_SEARCH_SIDE_SUCCESS) {

        probe_puts("[HT] Binary Search abandoned searching branches #");
        probe_puts(itoa(binary_search_left_probe_id));
        probe_puts(" and #");
        probe_puts(itoa(binary_search_right_probe_id));
        probe_puts("\n");

        finalize_binary_search();
        return;
    }

    probe_puts("[HT] ERROR: Binary Search is handling an unpredicted combination of results.\n");
}

void finalize_binary_search() {
    enable_binary_search = 0;
    binary_search_left_status = BINARY_SEARCH_SIDE_BLANK;
    binary_search_right_status = BINARY_SEARCH_SIDE_BLANK;
    check_missing_packets_queue();
}

int send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size) {

    int probe_index = get_new_probe_slot();
    probes[probe_index].source = source_addr;
    probes[probe_index].target = target_addr;
    probes[probe_index].path_size = path_size;
    for(int i = 0; i < path_size; i++)
        probes[probe_index].path[i] = path[i];
    
    unsigned int source_routing_header[10];
    int source_routing_header_length = path_to_sr_header(path, path_size, source_routing_header);

    probe_puts("[HT] PROBE REQUEST -- probe #");
    probe_puts(itoa(probes[probe_index].id));

    probe_puts(" src: ");
    probe_puts(itoh(source_addr));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(target_addr));

    probe_puts(" path: ");
    print_path(path, path_size);

    probe_puts(" header: ");
    print_sr_header(source_routing_header, source_routing_header_length);
    probe_puts("\n");

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = source_addr;
    p->service = PROBE_REQUEST;
    p->probe_id = probes[probe_index].id;
    p->probe_source = source_addr;
    p->probe_target = target_addr;
    p->probe_sr_length = source_routing_header_length;
    p->msg_lenght = source_routing_header_length;

    //if payload is too small then add padding
    if(source_routing_header_length == 1) {
        p->msg_lenght++;
        source_routing_header[1] = 0x00000000;
    }

    send_packet(p, (unsigned int) source_routing_header, p->msg_lenght);
    probes[probe_index].status = PROBE_STATUS_PENDING;

    return probe_index;
}

void handle_probe_results(unsigned int packet_source_field, unsigned int payload) {

    unsigned int probe_id = packet_source_field >> 16;
    unsigned int packet_src = packet_source_field & 0xffff;

    int result = payload;

    int i = PROBE_INDEX(probe_id);
    probes[i].status = (result == PROBE_RESULT_SUCCESS) ? PROBE_STATUS_SUCCEEDED : PROBE_STATUS_FAILED;
    
    probe_puts("[HT] PROBE RESULTS -- probe #");
    probe_puts(itoa(probe_id));

    probe_puts(" src: ");
    probe_puts(itoh(probes[i].source));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(probes[i].target));

    probe_puts(" result: ");
    print_probe_result(result);
    probe_puts("\n");

    if(packet_src != probes[i].target)
        probe_puts("[HT]    ERROR: PROBE_RESULTS was sent by someone other than original probe_target\n");

    update_trust_scores(probes[i].source, probes[i].target, probes[i].path, probes[i].path_size, result);

    if(enable_binary_search) {
        if(probe_id == binary_search_left_probe_id || probe_id == binary_search_right_probe_id) {    
            receive_binary_search_probe(probe_id, result);
        }
    }
}

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result) {
    
    int x = source >> 8;
    int y = source & 0xff;

    for(int i = 0; i < path_size; i++) {

        if(x < 0 || x >= PLATFORM_DIMENSION_X || y < 0 || y >= PLATFORM_DIMENSION_Y) {
            probe_puts("[HT] Update scores error: router address is not within platform dimensions\n");
        }
        
        int port = path[i];

        if(probe_result == PROBE_RESULT_SUCCESS)
            link_trust_scores[x][y][port]++;
        else
            link_trust_scores[x][y][port]--;
        
        //jump to next router in the path
        switch(port) {
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
            default:
                probe_puts("[HT] Update scores error: path contains unknown hop\n");
        }
    }

    //Debug prints
    unsigned int calculated_target = (x << 8) | y;
    if(target != calculated_target) {
        probe_puts("[HT] Update scores error: path does not lead to specified target\n");
        probe_puts("[HT]     Expected target:  "); probe_puts(itoh(target)); probe_puts("\n");
        probe_puts("[HT]     Calculated target:"); probe_puts(itoh(calculated_target)); probe_puts("\n");
    }

    //print_trust_score_matrix();
}
