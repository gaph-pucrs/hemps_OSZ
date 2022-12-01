/*---------------------------------------------------------------------
TITLE: Program Scheduler
AUTHOR: Nicolas Saint-jean
EMAIL : saintjea@lirmm.fr
DATE CREATED: 04/04/06
FILENAME: task3.c
PROJECT: Network Process Unit
COPYRIGHT: Software placed into the public domain by the author.
           Software 'as is' without warranty.  Author liable for nothing.
DESCRIPTION: This file contains the task3
---------------------------------------------------------------------*/

#include <api.h>
#include <stdlib.h>
#include "mpeg_std.h"

typedef int type_DATA; //unsigned

Message msg1;
Message msgIO;

int main()
{
   unsigned int time_a, time_b, time_c;
   int i;
    
    msgIO.length = 64;

    Echo("MPEG Task PRINT start:");

    for(i=0;i<MPEG_FRAMES;i++)
    {
       Echo(" PRINT FOR");
       time_a = GetTick();
       Receive(&msg1,idct);
       time_c = GetTick();
       Echo(itoa(time_c-time_a));

       IOSend(&msgIO, IO_PERIPHERAL2);
       time_b = GetTick();
       Echo(itoa(time_b-time_c));
    }

    Echo("End Task E - MPEG");

    exit();
}
