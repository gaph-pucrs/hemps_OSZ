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
   unsigned int time_a, time_b;
   int i;
    
   /* IO_WRITE */
   msgIO.length = 13;     // Message size = 13 words (3 of IO Header + 10 of data)
   msgIO.msg[0] = 0x2020; // OpCode = 0x2020 (IO_WRITE)
   msgIO.msg[1] = 0xb3ff; // Address = 0xb3ff (doesn't matter, is unused)
   msgIO.msg[2] = 0x0014; // Request size = 20 flits (must be 20 flits)
   for(i=3; i<13; i++)
      msgIO.msg[i] = i-3; // Fill the 10 words of data

    Echo("MPEG Task PRINT start:");

    for(i=0;i<MPEG_FRAMES;i++)
    {
       Echo(" PRINT FOR");
       time_a = GetTick();
       Receive(&msg1,idct);
       IOSend(&msgIO, IO_PERIPHERAL2);
       time_b = GetTick();
       Echo(itoa(time_b-time_a));
    }

    Echo("End Task E - MPEG");

    exit();
}
