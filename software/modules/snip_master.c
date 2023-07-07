#include "snip_master.h"

char nonsecure_io_dependents[IO_NUMBER];

void init_snip_structures() {
	for(int i = 0; i < IO_NUMBER; i++)
		nonsecure_io_dependents[i] = 0;
}

int get_io_number(int peripheral_id) {
	int io_num = 0;
	while(io_num < IO_NUMBER) {
		if(io_info[io_num].peripheral_id == peripheral_id)
			return io_num;
		io_num++;
	}
	return -1;
}

int is_peripheral_in_gray_line(int peripheral_id) {

	int io_idx = get_io_number(peripheral_id);
	int peripheral_y = io_info[io_idx].default_address_y;

	for(int row = 0; row < MAX_GRAY_ROWS; row++)
		if(ga.rows[row] == peripheral_y)
			return 1;
	
	return 0;
} 

void config_snips_secure(Application *app) {

	// puts("[DEBUG SNIP] Entrando em config_snips_secure\n");
    
    SourceRoutingTableSlot sr[IO_NUMBER];

    for(int i = 0; i < app->io_dependencies_number; i++) {

        int peripheralID = app->io_dependencies[i].peripheralID;

		/* calculates path to application */

        int ioInGrayLine = is_peripheral_in_gray_line(peripheralID);
        long unsigned int pathSR = IOtoAPmaster(peripheralID, app->ap.address_go, app->ap.port_go, ioInGrayLine);
		ProcessTurnsPointer((pathSR & 0xffffffff), (pathSR >> 32 & 0xffffffff), (pathSR >> 64 & 0xffffffff), &sr[i]);

        /* assembles io_config packet */

		int k0 = get_NI_k0(peripheralID);
		int appID = app->appID_random;
		int turns = app->nTurns;

		// puts("[DEBUG SNIP] Sending secure IO_CONFIG to peripheral "); puts(itoa(peripheralID)); puts("\n");

        ServiceHeader *p = get_service_header_slot();
        //p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;
        p->service = ((appID ^ k0) << 16) | (turns ^ k0);
        p->io_service = IO_SR_PATH;

        send_packet_io(p, (unsigned int) &sr[i].path[0], sr[i].path_size, peripheralID);
    }
}

void config_snips_nonsecure(Application *app) {

	// puts("[DEBUG SNIP] Entrando em config_snips_nonsecure\n");

    for(int i = 0; i < app->io_dependencies_number; i++) {

        int peripheralID = app->io_dependencies[i].peripheralID;
		int io_idx = get_io_number(peripheralID);

		/* updates number of nonsecure dependents */

		nonsecure_io_dependents[io_idx]++;

		if(nonsecure_io_dependents[io_idx] != 1)
			break;

		/* configures the snip to use xy or yx routing */

        int useXY = is_peripheral_in_gray_line(peripheralID);
        unsigned int routing_cfg = useXY ? 0x60007eee : 0x10007eee;

		// puts("[DEBUG SNIP] Sending non-secure IO_CONFIG to peripheral "); puts(itoa(peripheralID)); puts("\n");

		/* assembles io_config packet */

        ServiceHeader *p = get_service_header_slot();
        //p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;
        p->service = 0;
        p->io_service = IO_SR_PATH;				
        send_packet_io(p, (unsigned int) &routing_cfg, 1, peripheralID);
    }
}

void config_snips(Application *app) {
	if(app->secure) {
		config_snips_secure(app);
	} else {
		config_snips_nonsecure(app);
	}
}

void clear_snips_secure(Application *app) {

	// puts("[DEBUG SNIP] Entrando em clear_snips_secure\n");

	for(int i = 0; i < app->io_dependencies_number; i++) {

		int peripheralID = app->io_dependencies[i].peripheralID;
		int k0 = get_NI_k0(peripheralID);

		// puts("[DEBUG SNIP] Sending secure IO_CLEAR to peripheral "); puts(itoa(peripheralID)); puts("\n");

		ServiceHeader *p = get_service_header_slot();
		//p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;
		p->service = ((app->appID_random ^ k0) << 16);
		p->io_service = IO_CLEAR;
		send_packet_io(p, 0, 0, peripheralID);
	}
}

void clear_snips_nonsecure(Application *app) {

	// puts("[DEBUG SNIP] Entrando em clear_snips_nonsecure\n");

	for(int i = 0; i < app->io_dependencies_number; i++) {

		int peripheralID = app->io_dependencies[i].peripheralID;
		int io_idx = get_io_number(peripheralID);

		/* updates number of nonsecure dependents */

		nonsecure_io_dependents[io_idx]--;

		if(nonsecure_io_dependents[io_idx] != 0)
			break;

		// puts("[DEBUG SNIP] Sending non-secure IO_CLEAR to peripheral "); puts(itoa(peripheralID)); puts("\n");

		ServiceHeader *p = get_service_header_slot();
		//p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;
		p->service = 0;
		p->io_service = IO_CLEAR;
		send_packet_io(p, 0, 0, peripheralID);
	}
}

void clear_snips(Application *app) {
	if(app->secure) {
		clear_snips_secure(app);
	} else {
		clear_snips_nonsecure(app);
	}
}

void renew_snips(Application *app) {

	// puts("[DEBUG SNIP] Entrando em renew_snips\n");

	for(int i = 0; i < app->io_dependencies_number; i++) {
	
		int peripheralID = app->io_dependencies[i].peripheralID;
		int k0 = get_NI_k0(peripheralID);

		// puts("[DEBUG SNIP] Sending IO_RENEW to peripheral "); puts(itoa(peripheralID)); puts("\n");

		ServiceHeader *p = get_service_header_slot();
		//p->header[MAX_SOURCE_ROUTING_PATH_SIZE-1] = app->tasks[i].allocated_proc;
		p->service = ((app->appID_random ^ k0) << 16) | (app->nTurns ^ k0);
		p->io_service = IO_RENEW_KEYS;
		send_packet_io(p, 0, 0, peripheralID);

	}
}
