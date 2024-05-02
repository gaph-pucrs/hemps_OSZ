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
    binary_search_state = BINARY_SEARCH_INIT;
    enable_binary_search = 0;
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

    if(probes_counter == 3) {
        broken_path[0] = SOUTH;
        broken_path[1] = EAST;
        broken_path[2] = EAST;
        broken_path[3] = EAST;
        broken_path[4] = EAST;
        broken_path[5] = NORTH;
        broken_path_size = 6;
        
        search_source = 0x0003;
        search_target = 0x0403;
        searched_path = broken_path;
        searched_path_size = broken_path_size;

        binary_search_state = BINARY_SEARCH_INIT;
        enable_binary_search = 1;
        continue_binary_search(0);
        return;
    }

    if(enable_binary_search) {        
        continue_binary_search(last_result);
        return;
    }
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

    search_source = source;
    search_target = target;
    broken_path_size = write_xy_path(broken_path, source, target);

    searched_path = broken_path;
    searched_path_size = broken_path_size;

    probe_puts("[HT] **** Starting new binary search - Source:");
    probe_puts(itoh(source));
    probe_puts(" Target:");
    probe_puts(itoh(target));
    probe_puts(" Path:");
    print_path(broken_path, broken_path_size);
    probe_puts("\n");
    
    binary_search_state = BINARY_SEARCH_INIT;
    enable_binary_search = 1;
    continue_binary_search(0);
}

void continue_binary_search(int result) {

    while(1) {

        int left_size = searched_path_size / 2;
        int left_head = 0;

        int right_size = searched_path_size - left_size;
        int right_head = left_size;

        unsigned int middle_router = calculate_target(search_source, searched_path, left_size);

        /* PROBE NEW SUSPICIOUS PATH -- START WITH LEFT */
        if(binary_search_state == BINARY_SEARCH_INIT) {
            
            send_probe_request(search_source, middle_router, searched_path, left_size);
            binary_search_state = BINARY_SEARCH_LEFT;
            
            return;
        }

        /* RECEIVE RESULT FROM LEFT PROBE -- THEN PROBE RIGHT */
        else if(binary_search_state == BINARY_SEARCH_LEFT) {
            
            result_left = result;
            
            send_probe_request(middle_router, search_target, searched_path + left_size, right_size);
            binary_search_state = BINARY_SEARCH_RIGHT;
            
            return;
        }

        /* RECEIVE RESULT FROM RIGHT PROBE -- THEN UPDATE SEARCH SCOPE */
        else if(binary_search_state == BINARY_SEARCH_RIGHT) {
            
            result_right = result;

            /* Update binary search scope */

            if(result_left==PROBE_RESULT_SUCCESS && result_right==PROBE_RESULT_SUCCESS) {
                probe_puts("[HT] BINARY SEARCH ERROR - Both right and left probes were SUCCESSFUL\n");
                while(1);
            }
            
            if(result_left==PROBE_RESULT_FAILURE && result_right==PROBE_RESULT_FAILURE) {
                probe_puts("[HT] BINARY SEARCH ERROR - Both right and left probes FAILED\n");
                while(1);
            }

            // Zoom on left
            if(result_left==PROBE_RESULT_FAILURE) {

                if(left_size == 1) {
                    //FINALIZE SEARCH
                    broken_router = search_source;
                    broken_port = searched_path[left_head];
                    print_search_result();
                    binary_search_state = BINARY_SEARCH_INIT;
                    enable_binary_search = 0;
                    return;
                }

                search_target = middle_router;
                searched_path_size = left_size;
            }

            // Zoom on right
            else {

                if(right_size == 1) {
                    //FINALIZE SEARCH
                    broken_router = middle_router;
                    broken_port = searched_path[right_head];
                    print_search_result();
                    binary_search_state = BINARY_SEARCH_INIT;
                    enable_binary_search = 0;
                    return;
                }

                search_source = middle_router;
                searched_path_size = right_size;
                searched_path = searched_path + left_size;
            }

            binary_search_state = BINARY_SEARCH_INIT;
        }
    }

}

void send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size) {

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

    if(enable_binary_search)
        continue_binary_search(result);

    // else {
    //     update_trust_scores(source_probe, source_packet, probe_path, probe_path_size, payload);
    //     probe_protocol(); //call probe_protocol back to continue with the hardcoded algorithm
    // }
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

    print_trust_score_matrix();
}
