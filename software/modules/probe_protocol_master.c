#include "probe_protocol_master.h"

void init_probe_master_structures() {
    //init binary search
    bs_data.status = BS_IDLE;
    bs_data.ht_counter = 0;
    for(int i = 0; i < MAX_BINARY_SEARCH_PROBES; i++) {
        bs_data.bs_probes[i].status = BS_PROBE_UNUSED;
    }
    //init probe entries
    next_probe_id = 0;
    for(int i = 0; i < MAX_PROBE_ENTRIES; i++) {
        probes[i].status = PROBE_STATUS_FREE;
    }
    //init noc health matrix
    for(int x = 0; x < XDIMENSION; x++) {
        for(int y = 0; y < YDIMENSION; y++) {
            for(int z = 0; z < NUM_LINKS_PER_ROUTER; z++) {
                noc_health[x][y].links[z].status = HEALTHY;
                noc_health[x][y].links[z].total_probes = 0;
                noc_health[x][y].links[z].failed_probes = 0;
            }
        }
    }
    //init suspicious path table
    for (int i = 0; i < SUSPICOUS_PATH_TABLE_SIZE; i++) {
        suspicious_path_table[i].used = 0;
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

int get_new_binary_search_probe_slot() {
    for(int i = 0; i < MAX_BINARY_SEARCH_PROBES; i++) {
        if(bs_data.bs_probes[i].status == BS_PROBE_UNUSED) {
            bs_data.bs_probes[i].status = BS_PROBE_USED;
            return i;
        }
    }
    probe_puts("[HT] ERROR: binary_search_probes array has no slot available\n");
    return -1;
}

int get_binary_search_probe_by_id(int id) {
    for(int i = 0; i < MAX_BINARY_SEARCH_PROBES; i++) {
        if(bs_data.bs_probes[i].id == id) {
            return i;
        }
    }
    return -1;
}

int is_binary_search_probes_empty() {
    for(int i = 0; i < MAX_BINARY_SEARCH_PROBES; i++)
        if(bs_data.bs_probes[i].status == BS_PROBE_USED)
            return 0;
    return 1;
}

int get_new_suspicious_path_slot() {
    for (int i = 0; i < SUSPICIOUS_PATH_TABLE_SIZE; i++) {
        if (suspicious_path_table[i].used == 0) {
            return i;
        }
    }
    return -1;
}

void handle_report_suspicious_path(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload) {
    unsigned int source = (((pkt_source & 0xF000) >> 4) | ((pkt_source & 0xF00) >> 8));
    unsigned int target = (((pkt_source & 0xF0) << 4) | (pkt_source & 0xF));
    unsigned char compressed_path[3];
    compressed_path[0] = ((pkt_source & 0xFF000000) >> 24);
    compressed_path[1] = ((pkt_source & 0xFF0000) >> 16);
    compressed_path[2] = (pkt_payload);

    int slot = get_new_suspicious_path_slot();
    if (slot == -1) {
        probe_puts("[HT] The suspicious path table is full, discarding this path.\n");
        return;
    }
    suspicious_path_table[slot].used = 1;
    suspicious_path_table[slot].source = source;
    suspicious_path_table[slot].target = target;
    suspicious_path_table[slot].path_size = convert_compressed_path_to_path(compressed_path, suspicious_path_table[slot].path);
    probe_puts("[HT] Registered new path in the suspicious path table.\n");
    probe_puts("[HT] Source: "); probe_puts(itoh(source));
    probe_puts(" Target: "); probe_puts(itoh(target));
    probe_puts(" Path: "); print_path(suspicious_path_table[slot].path, suspicious_path_table[slot].size); probe_puts("\n");
    set_suspicious_health(source, suspicious_path_table[slot].path, suspicious_path_table[slot].size);    
}

void start_binary_search(unsigned int source, unsigned int target) {
    
    if(bs_data.status == BS_BUSY) {
        probe_puts("[HT] MPE already has ongoing binary search. Discarding...\n");        
        return;
    }
    
    bs_data.status = BS_BUSY;
    bs_data.suspicious_source = source;
    bs_data.suspicious_target = target;

    probe_puts("[HT] New binary search from ");
    probe_puts(itoh(source));
    probe_puts(" to ");
    probe_puts(itoh(target));
    probe_puts(" requires asking path to SourcePE, requesting...\n");

    //request path taken by the missing_packet
    Seek(PROBE_REQUEST_PATH, (target << 16) | get_net_address(), source, 0);

    /* wait receiving the PROBE_PATH packet from source pe... */
}

void receive_binary_search_path(unsigned int pkt_source, unsigned int pkt_payload, unsigned int pkt_service) {

    if(bs_data.status == BS_IDLE) {
        probe_puts("[HT] Warning: MPE received binary search path while binary search is disabled. Ignoring...\n");
        return;
    }

    unsigned int packet_source_address = pkt_source >> 16;
    unsigned char compressed_path[3];
    compressed_path[0] = (pkt_source & 0xff00) >> 8;
    compressed_path[1] = pkt_source & 0xff;
    compressed_path[2] = pkt_payload;

    if(packet_source_address != bs_data.suspicious_source) {
        probe_puts("[HT] Error: MPE was expecting binary search path from ");
        probe_puts(itoh(bs_data.suspicious_source));
        probe_puts(" but received from ");
        probe_puts(itoh(packet_source_address));
        probe_puts("\n");
        return;
    }

    /* PATH IS XY */
    if(pkt_service == PROBE_PATH_XY) {
        bs_data.suspicious_path_size = write_xy_path(bs_data.suspicious_path, bs_data.suspicious_source, bs_data.suspicious_target);
    }

    /* PATH IS SOURCE ROUTING */
    else {
        bs_data.suspicious_path_size = convert_compressed_path_to_path(compressed_path, bs_data.suspicious_path);
    }

    //mark suspicous path
    set_suspicious_health(bs_data.suspicious_source, bs_data.suspicious_path, bs_data.suspicious_path_size);
    print_noc_health();

    probe_puts("[HT] **** Starting new Binary Search - Source:");
    probe_puts(itoh(bs_data.suspicious_source));
    probe_puts(" Target:");
    probe_puts(itoh(bs_data.suspicious_target));
    probe_puts(" Path:");
    print_path(bs_data.suspicious_path, bs_data.suspicious_path_size);
    probe_puts("\n");

    binary_search_divide(bs_data.suspicious_source, bs_data.suspicious_target, bs_data.suspicious_path, bs_data.suspicious_path_size);
}

void binary_search_divide(unsigned int source, unsigned int target, char *path, int path_size) {

    unsigned int middle_router = calculate_target(source, path, path_size/2);

    /* SEND LEFT PROBE */

    unsigned int left_source = source;
    unsigned int left_target = middle_router;
    char *left_path = path;
    int left_path_size = path_size / 2;

    int left_slot = get_new_binary_search_probe_slot();
    bs_data.bs_probes[left_slot].id = send_probe_request(left_source, left_target, left_path, left_path_size);

    /* SEND RIGHT PROBE */

    unsigned int right_source = middle_router;
    unsigned int right_target = target;
    char *right_path = path + left_path_size;
    int right_path_size = path_size - left_path_size;

    int right_slot = get_new_binary_search_probe_slot();
    bs_data.bs_probes[right_slot].id = send_probe_request(right_source, right_target, right_path, right_path_size);
}

void receive_binary_search_probe(int bs_probe_slot, int result) {

    int probe_id = bs_data.bs_probes[bs_probe_slot].id;
    int probe_index = PROBE_INDEX(probe_id);

    if(result == PROBE_RESULT_FAILURE) {
        
        if(probes[probe_index].path_size == 1) {
            register_binary_search_ht(probes[probe_index].source, probes[probe_index].path[0]);
        }

        else {
            binary_search_divide(probes[probe_index].source, probes[probe_index].target, probes[probe_index].path, probes[probe_index].path_size);
        }
            
    }

    bs_data.bs_probes[bs_probe_slot].status = BS_PROBE_UNUSED;
    if(is_binary_search_probes_empty())
        finalize_binary_search();
}

void register_binary_search_ht(unsigned int router, char port) {

    if(bs_data.ht_counter == MAX_BINARY_SEARCH_HTS) {
        return;
    }

    bs_data.hts[bs_data.ht_counter].router = router;
    bs_data.hts[bs_data.ht_counter].port = port;
    bs_data.ht_counter++;
}

void print_binary_search_result() {
    probe_puts("[HT] **** BINARY SEARCH FINALIZED ****\n");

    if(bs_data.ht_counter == 0) {
        probe_puts("[HT]          No HT found.\n");
        return;
    }

    for(int i = 0; i < bs_data.ht_counter; i++) {
        probe_puts("[HT]          HT #");
        probe_puts(itoa(i+1));
        probe_puts(": ");
        probe_puts(itoh(bs_data.hts[i].router));
        probe_puts(" ");
        print_turn(bs_data.hts[i].port);
        probe_puts("\n");
    }
}

void finalize_binary_search() {
    print_binary_search_result();
    bs_data.ht_counter = 0;
    bs_data.status = BS_IDLE;
}

int send_probe_request(unsigned int source_addr, unsigned int target_addr, char *path, int path_size) {

    int probe_index = get_new_probe_slot();
    probes[probe_index].source = source_addr;
    probes[probe_index].target = target_addr;
    probes[probe_index].path_size = path_size;
    for(int i = 0; i < path_size; i++)
        probes[probe_index].path[i] = path[i];
    
    unsigned char compressed_path[3];
    convert_path_to_compressed_path(path, path_size, compressed_path);

    probe_puts("[HT] PROBE REQUEST -- probe #");
    probe_puts(itoa(probes[probe_index].id));

    probe_puts(" src: ");
    probe_puts(itoh(source_addr));
    
    probe_puts(" tgt: ");
    probe_puts(itoh(target_addr));

    probe_puts(" path: ");
    print_path(path, path_size);

    probe_puts(" compressed_path: ");
    print_compressed_path(compressed_path);
    probe_puts("\n");

    Seek(PROBE_REQUEST, (probes[probe_index].id << 16) | (target_addr & 0xffff), source_addr, 0);
    Seek(PROBE_PATH, (probes[probe_index].id << 16) | (compressed_path[0] << 8) | compressed_path[1], source_addr, compressed_path[2]);
    probes[probe_index].status = PROBE_STATUS_PENDING;

    return probes[probe_index].id;
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

    if(result == PROBE_RESULT_FAILURE)
        clear_residual_switching_from_probe_id(probe_id);

    if(packet_src != probes[i].target)
        probe_puts("[HT]    ERROR: PROBE_RESULTS was sent by someone other than original probe_target\n");

    update_trust_scores(probes[i].source, probes[i].target, probes[i].path, probes[i].path_size, result);

    if(bs_data.status == BS_BUSY) {
        int bs_probe_slot = get_binary_search_probe_by_id(probe_id);
        if(bs_probe_slot >= 0) {
            receive_binary_search_probe(bs_probe_slot, result);
        }
    }
}

void update_trust_scores(unsigned int source, unsigned int target, char *path, int path_size, int probe_result) {
    
    int x = source >> 8;
    int y = source & 0xff;

    for(int i = 0; i < path_size; i++) {

        if(x < 0 || x >= XDIMENSION || y < 0 || y >= YDIMENSION) {
            probe_puts("[HT] Update scores error: router address is not within platform dimensions\n");
        }
        
        int port = path[i];

        noc_health[x][y].links[port].total_probes++;
        if(probe_result == PROBE_RESULT_FAILURE)
            noc_health[x][y].links[port].failed_probes++;
        
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

void clear_residual_switching(unsigned int pkt_source, unsigned int pkt_target, unsigned int pkt_payload, unsigned int pkt_service) {
    if(pkt_payload == 1)
        clear_residual_switching_from_probe_id(pkt_source);
    else
        clear_residual_switching_from_current_path(pkt_target, pkt_source);
}

void clear_residual_switching_from_probe_id(int probe_id) {

    // probe_puts("[ROUTER RST] ** PROBE PACKET RESET **\n");

    int probe_index = PROBE_INDEX(probe_id);
    send_reset_packets_to_routers_in_path(probes[probe_index].source, probes[probe_index].path, probes[probe_index].path_size);
}

void set_suspicious_health(unsigned int source_address, char *path, int path_size) {
    
    int current_x = source_address >> 8;
    int current_y = source_address && 0xff;
    
    for(int i = 0; i < path_size; i++) {
        noc_health[current_x][current_y].links[path[i]].status = SUSPICIOUS;
        
        switch(path[i]) {
            case EAST:
                current_x++;
                break;
            case WEST:
                current_x--;
                break;
            case NORTH:
                current_y++;
                break;
            case SOUTH:
                current_y--;
                break;
        }
    }
}

void print_noc_health() {

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

        // PRINT NUMERICAL SCORE FOR EACH ROUTER
        // for(int y = YDIMENSION-1; y >= 0; y--) {
        //     for(int x = 0; x < XDIMENSION; x++) {
        //         int score = link_trust_scores[x][y][link];
        //         if(score >= 0) { //signal
        //             probe_puts("+");
        //         }
        //         else {
        //             probe_puts("-");
        //             score *= -1;
        //         }
        //         if(score > 99) //limit to 2 digits
        //             score = 99;
        //         if(score < 10) //leading 0
        //             probe_puts("0");
        //         probe_puts(itoa(score)); //actual print
        //         probe_puts(" "); //spacing
        //     }
        //     probe_puts("\n");
        // }

        for(int y = YDIMENSION-1; y >= 0; y--) {
            for(int x = 0; x < XDIMENSION; x++) {
                switch(noc_health[x][y].links[link].status) {
                    case HEALTHY:
                        probe_puts("H ");
                        break;
                    case SUSPICIOUS:
                        probe_puts("S ");
                        break;
                    case INFECTED:
                        probe_puts("I ");
                        break;
                    default:
                        probe_puts("? ");
                }
            }
            probe_puts("\n");
        }
    }
}
