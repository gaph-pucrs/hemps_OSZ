------------------------------------------------------------------------------------------------
--
--  DISTRIBUTED HEMPS  - version 5.0
--
--  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
--
--  Distribution:  November 2015
--
--  Source name:  seek_pkg.vhd
--
--  Brief description:  Functions and constants for seek module.
--
------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.standards.all;

package seek_pkg is

    constant    NPORT_SEEK                              : integer := 5;
    --WARNING : modify source target size to 8
    constant    TARGET_SIZE                             : integer := 16;
    constant    SOURCE_SIZE                             : integer := 32;
    constant    SEEK_PAYLOAD_SIZE                       : integer := 8;
    constant    TAM_SERVICE_SEEK                        : integer := 5;
    
    constant    EAST                                    : integer := 0;
    constant    WEST                                    : integer := 1;
    constant    NORTH                                   : integer := 2;
    constant    SOUTH                                   : integer := 3;
    constant    LOCAL                                   : integer := 4;
    
    constant    ROW0                                    : integer := 0;
    constant    ROW1                                    : integer := 1;
    constant    ROW2                                    : integer := 2;
    constant    ROW3                                    : integer := 3;
    constant    ROW4                                    : integer := 4;
    constant    ROW5                                    : integer := 5;
    constant    ROW6                                    : integer := 6;
    constant    ROW7                                    : integer := 7;

--table sizes
    constant    TABLE_HEIGHT                            : integer := 8;
    constant    TABLE_SEEK_LENGHT                       : integer := 8;

-- PDN services
    constant    START_APP_SERVICE                       : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00001";
    constant    TARGET_UNREACHABLE_SERVICE              : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00010";
    constant    CLEAR_SERVICE                           : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00011";
    constant    BACKTRACK_SERVICE                       : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00100";
    constant    SEARCHPATH_SERVICE                      : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00101";
    constant    END_TASK_SERVICE                        : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00110";
    constant    SET_SECURE_ZONE_SERVICE                 : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "00111";
    constant    PACKET_RESEND_SERVICE                   : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01000";
    constant    WARD_SERVICE                            : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01001";
    constant    OPEN_SECURE_ZONE_SERVICE                : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01010";
    constant    SECURE_ZONE_CLOSED_SERVICE              : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01011";
    constant    SECURE_ZONE_OPENED_SERVICE              : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01100";
    constant    FREEZE_TASK_SERVICE                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01101";
    constant    UNFREEZE_TASK_SERVICE                   : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01110";  
    constant    MASTER_CANDIDATE_SERVICE                : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "01111"; 
    constant    TASK_ALLOCATED_SERVICE                  : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10000";
    constant    INITIALIZE_SLAVE_SERVICE                : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10001";
    constant    INITIALIZE_CLUSTER_SERVICE              : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10010";
    --constant    LOAN_PROCESSOR_REQUEST_SERVICE          : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10011"; --
    --constant    LOAN_PROCESSOR_RELEASE_SERVICE          : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10100"; --
    constant    END_TASK_OTHER_CLUSTER_SERVICE          : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10101";
    constant    WAIT_KERNEL_SERVICE                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10110";
    constant    SEND_KERNEL_SERVICE                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10111";
    constant    WAIT_KERNEL_SERVICE_ACK                 : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11000";
    constant    FAIL_KERNEL_SERVICE                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11001";
    constant    NEW_APP_SERVICE                         : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11010";
    constant    NEW_APP_ACK_SERVICE                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11011";
    constant    GMV_READY_SERVICE                       : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11100";
    constant    SET_SZ_RECEIVED_SERVICE                 : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11101";
    constant    SET_EXCESS_SZ_SERVICE                   : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11110";
    constant    RCV_FREEZE_TASK_SERVICE                 : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "11111";
    constant    MSG_DELIVERY_RECEIPT                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10011";
    constant    MSG_REQUEST_RECEIPT                     : std_logic_vector(TAM_SERVICE_SEEK-1 downto 0) := "10100";

    subtype     regNtarget                              is std_logic_vector((TARGET_SIZE-1) downto 0);
    subtype     regNsource                              is std_logic_vector((SOURCE_SIZE-1) downto 0);
    subtype     regNpayload                             is std_logic_vector((SEEK_PAYLOAD_SIZE-1) downto 0);

    type        regNportNsource_neighbor                is array (0 to NPORT_SEEK-1) of regNsource;
    type        regNportNtarget_neighbor                is array (0 to NPORT_SEEK-1) of regNtarget;
    type        regNportNpayload_neighbor               is array (0 to NPORT_SEEK-1) of regNpayload;

    subtype     seek_bitN_service                       is std_logic_vector(TAM_SERVICE_SEEK-1 downto 0);
    type        regNport_seek_bitN_service              is array (NPORT_SEEK-1 downto 0) of seek_bitN_service;

end package seek_pkg;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Service                      type                        	Operation Mode      Payload     Target                          Source
-- START_APP_SERVICE            Broadcast to all local ports   	Global              AppID       RH_corner                       --
-- TARGET_UNREACHABLE_SERVICE   Broadcast With Target       	Global              --          TaskID Address                  --
-- CLEAR_SERVICE                Broadcast Without Target    	Global              --          --                              --
-- BACKTRACK_SERVICE            Unicast                     	Restrict            Hop number  --                              --
-- SEARCHPATH_SERVICE           Broadcast With Target          	Restrict            Hop number  Target Unreachable Address
-- END_TASK_SERVICE             Broadcast With Target       	Global              TaskID      CMP Address
-- PACKET_RESEND_SERVICE        Broadcast With Target       	Global              --          TaskID Address
-- WARD_SERVICE                 Broadcast With Target       	Global              --          CMP WARD Address
-- SET_SECURE_ZONE              Broadcast to all local ports    Global              RH_corner   LL_corner
-- OPEN_SECURE_ZONE             Broadcast to all local ports    Global              RH_corner   AppID
-- SECURE_ZONE_CLOSED           Broadcast With Target           Global              RH_corner   CMP Address
-- SECURE_ZONE_OPENED           Broadcast With Target           Global              AppID       CMP Address
-- FREEZE_TASK_SERVICE          Broadcast to all local ports    Global              0           CMP WARD Address
-- UNFREEZE_TASK_SERVICE        Broadcast to all local ports    Global              0           CMP WARD Address
-- MASTER_CANDIDATE_SERVICE     Broadcast With Target           Global              0           CMP WARD Address
-- TASK_ALLOCATED_SERVICE       Broadcast With Target           Global              TaskID      CMP Address
-- INITIALIZE_SLAVE_SERVICE     Broadcast to all local ports    Global              RH_corner   LL_corner
-- WAIT_KERNEL_SERVICE          Broadcast With Target           Global              ?           Next master of cluster
-- SEND_KERNEL_SERVICE          Broadcast With Target           Global              ?           Master fail of cluster
-- FAIL_KERNEL_SERVICE          Broadcast With Target           Global              ?           CMP WARD Address
-- NEW_APP_SERVICE              Broadcast to all local ports    Global              Nr,task     Global master virtual
-- NEW_APP_ACK_SERVICE          Broadcast With Target           Global              Nr,task     Address of the LMP
-- GMV_READY_SERVICE            Broadcast Without Target        Global              --          Injection Entity 
-- MSG_DELIVERY_RECEIPT             Broadcast With Target           Global              TgtAppID    TargetID                        SrcAppID
-- MSG_REQUEST_RECEIPT          Broadcast With Target           Global              TgtAppID    TargetID                        SrcAppID

--Seek(MSG_DELIVERY_RECEIPT, target, (AppID << 16), 0); 