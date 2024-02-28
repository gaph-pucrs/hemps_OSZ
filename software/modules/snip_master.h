#ifndef SNIP_MASTER_H_
#define SNIP_MASTER_H_

#include "applications.h"
#include "packet.h"
#include "seek.h"
#include "osz_master.h"

void init_snip_structures();

int is_peripheral_in_gray_line(int peripheral_id);

void config_snips(Application *app);

void clear_snips(Application *app);

void renew_snips(Application *app);

#endif
