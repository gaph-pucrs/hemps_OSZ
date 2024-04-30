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
    probe_path_size = 0;
    broken_path_size = 0;
    binary_search_state = BINARY_SEARCH_INIT;
    enable_binary_search = 0;
    //init trust scores cube matrix
    for(int x = 0; x < PLATFORM_DIMENSION_X; x++) {
        for(int y = 0; y < PLATFORM_DIMENSION_Y; y++) {
            for(int z = 0; z < NUM_LINKS_PER_ROUTER; z++) {
                link_trust_scores[x][y][z] = 0;
            }
        }
    }
}

void probe_protocol() {

    static int probes_counter = 0;

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

void continue_binary_search(int result) {

    while(1) {

        int left_size = searched_path_size / 2;
        int left_head = 0;
        int left_tail = left_size - 1;

        int right_size = searched_path_size - left_size;
        int right_head = left_size;
        int right_tail = searched_path_size - 1;

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

    unsigned int source_routing_path[10];
    int source_routing_length = path_to_sr_header(path, path_size, source_routing_path);

    probe_puts("[HT] PROBE REQUEST -- from ");
    probe_puts(itoh(source_addr));
    
    probe_puts(" to ");
    probe_puts(itoh(target_addr));
    
    probe_puts(" path: ");
    print_path(path, path_size);

    probe_puts(" -- header: ");
    print_sr_header(source_routing_path, source_routing_length);
    probe_puts("\n");

    ServiceHeader *p = get_service_header_slot();

    p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = source_addr;
    p->service = PROBE_REQUEST;
    p->probe_source = source_addr;
    p->probe_target = target_addr;
    p->probe_sr_length = source_routing_length;
    p->msg_lenght = source_routing_length;

    //if payload is too small then add padding
    if(source_routing_length == 1) {
        p->msg_lenght++;
        source_routing_path[1] = 0x00000000;
    }

    send_packet(p, (unsigned int) source_routing_path, p->msg_lenght);
}

void handle_probe_results(unsigned int source, unsigned int target, unsigned int payload) {

    unsigned int source_probe = source >> 16;
    unsigned int source_packet = source & 0xffff;
    
    probe_puts("[HT] PROBE RESULTS -- from ");
    probe_puts(itoh(source_probe));
    
    probe_puts(" to ");
    probe_puts(itoh(source_packet));

    probe_puts(" result: ");
    probe_puts(itoh(payload));
    probe_puts("\n");

    if(enable_binary_search)
        continue_binary_search(payload);

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
