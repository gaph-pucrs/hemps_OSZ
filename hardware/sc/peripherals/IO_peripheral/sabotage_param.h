/* hardware/sc/peripherals/IO_peripheral/sabotage_param.h */

#define T_START         90000   //100000
#define T_END           95000   //120000
#define PERIOD          1000    //500

#define HEADER_FIX_HI   0x5083  //header  Source: 0203 (usando 12 bits)
#define HEADER_FIX_LO   0x0103  //header 

#define HEADER_ROUT_HI  0x5083  //header  Source: 0203 (usando 12 bits)
#define HEADER_ROUT_LO  0x0103  //header

#define F1_FLIT         0x6e6b  //f1
#define F2_FLIT         0xf8ed  //f2

#define SERVICE_FLIT    0x0025  //service

#define SOURCE_FLIT     0x0202  //source
