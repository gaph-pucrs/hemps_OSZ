library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_defines.all;

entity network_interface is
    port
    (
        clock   : in    std_logic;
        reset   : in    std_logic;

        ----------------------
        -- Hermes Interface --
        ----------------------

        hermes_primary_tx           : out   std_logic;
        hermes_primary_tx_clk       : out   std_logic;
        hermes_primary_data_out     : out   regflit;
        hermes_primary_eop_out      : out   std_logic;
        hermes_primary_credit_in    : in    std_logic;

        hermes_primary_rx           : in    std_logic;
        hermes_primary_rx_clk       : in    std_logic;
        hermes_primary_data_in      : in    regflit;
        hermes_primary_eop_in       : in    std_logic;
        hermes_primary_credit_out   : out   std_logic;

        ---------------------
        -- BrNoC Interface --
        ---------------------

        brnoc_primary_source_in     : in    regNsource;
        brnoc_primary_target_in     : in    regNtarget;
        brnoc_primary_service_in    : in    seek_bitN_service;
        brnoc_primary_payload_in    : in    regNpayload;
        brnoc_primary_req_in        : in    std_logic;
        brnoc_primary_opmode_in     : in    std_logic;
        brnoc_primary_ack_out       : out   std_logic;
        
        brnoc_primary_source_out    : out   regNsource;
        brnoc_primary_target_out    : out   regNtarget;
        brnoc_primary_service_out   : out   seek_bitN_service;
        brnoc_primary_payload_out   : out   regNpayload;
        brnoc_primary_req_out       : out   std_logic;
        brnoc_primary_opmode_out    : out   std_logic;
        brnoc_primary_ack_in        : in    std_logic
    );
end network_interface;

architecture network_interface of network_interface is

    -------------------
    -- Table Signals --
    -------------------

    type column_appId       is array(TABLE_SIZE-1 downto 0) of regN_appID;
    type column_keyPerith   is array(TABLE_SIZE-1 downto 0) of regN_keyPerith;
    type column_burstSize   is array(TABLE_SIZE-1 downto 0) of regN_burstSize;
    type column_srcRouting  is array(TABLE_SIZE-1 downto 0) of std_logic;
    type column_path        is array(TABLE_SIZE-1 downto 0) of regN_path;
    type column_free        is array(TABLE_SIZE-1 downto 0) of std_logic;

    type table_record is record
        app_id      : column_appId;
        key_periph  : column_keyPeriph;
        burst_size  : column_burstSize;
        src_routing : column_srcRouting;
        path        : column_path;
        free        : column_free;
    end record table_record;

    signal table            : table_record;
    signal table_is_full    : std_logic;
    signal next_free_slot   : integer range 0 to TABLE_SIZE-1;

    -----------------------
    -- Hermes In Signals --
    -----------------------

    signal HermesIn_PS  : HermesInStateType;
    signal HermesIn_NS  : HermesInStateType;

    signal hermes_rx            : std_logic;
    signal hermes_rx_ck         : std_logic;
    signal hermes_data_in       : regflit;
    signal hermes_eop_in        : std_logic;
    signal hermes_credit_out    : std_logic;
    
    signal received_flits   : integer range 0 to MAX_FLITS_PER_PKG;
    
    signal hermes_is_receiving              : std_logic;
    signal hermes_is_finishing_reception    : std_logic;

begin

    -----------
    -- Table --
    -----------

    table_is_full <= nor table.free;

    ---- begin next_free_slot generates ----

    if TABLE_SIZE = 2 generate
        next_free_slot  <=  0   when table.free(0)='1'  else
                            1;
    end generate;

    if TABLE_SIZE = 4 generate
        next_free_slot  <=  0   when table.free(0)='1'  else
                            1   when table.free(1)='1'  else
                            2   when table.free(2)='1'  else
                            3;
    end generate;

    if TABLE_SIZE = 8 generate
        next_free_slot  <=  0   when table.free(0)='1'  else
                            1   when table.free(1)='1'  else
                            2   when table.free(2)='1'  else
                            3   when table.free(3)='1'  else
                            4   when table.free(4)='1'  else
                            5   when table.free(5)='1'  else
                            6   when table.free(6)='1'  else
                            7;
    end generate;

    ---- end next_free_slot generates ----

    ---------------
    -- Hermes In --
    ---------------

    hermes_rx                   <= hermes_primary_rx;
    hermes_rx_ck                <= hermes_primary_rx_clk;
    hermes_data_in              <= hermes_primary_data_in;
    hermes_eop_in               <= hermes_primary_eop_in;
    hermes_prymary_credit_out   <= hermes_credit_out;
    
    hermes_is_receiving             <= hermes_rx and hermes_credit_out;
    hermes_is_finishing_reception   <= hermes_is_receiving and hermes_eop_in;

    CountReceivedFlits: process(reset, clock)
    begin
        if reset='1' then
            received_flits <= 0;
        elsif clock'event and clock='1' then
            if hermes_is_finishing_reception='1' then
                received_flits <= 0;
            elsif hermes_is_receiving='1' then
                received_flits <= received_flits + 1;
            end if;
        end if;
    end process;

end network_interface;
