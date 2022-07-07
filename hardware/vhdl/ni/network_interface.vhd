library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_pkg.all;

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
    type column_keyPeriph   is array(TABLE_SIZE-1 downto 0) of regN_keyPeriph;
    type column_burstSize   is array(TABLE_SIZE-1 downto 0) of regN_burstSize;
    type column_path        is array(TABLE_SIZE-1 downto 0) of regN_path;
    type column_pathSize    is array(TABLE_SIZE-1 downto 0) of intN_pathSize;

    type table_record is record
        app_id      : column_appId;
        key_periph  : column_keyPeriph;
        burst_size  : column_burstSize;
        path        : column_path;
        path_size   : column_pathSize;
        free        : std_logic_vector(TABLE_SIZE-1 downto 0);
        match       : std_logic_vector(TABLE_SIZE-1 downto 0);
    end record table_record;

    signal table            : table_record;
    
    signal table_is_full    : std_logic;
    signal table_has_match  : std_logic;

    signal fetch_appid      : regN_appID;
    
    signal free_slot        : integer range 0 to TABLE_SIZE-1;
    signal match_slot       : integer range 0 to TABLE_SIZE-1;
    signal write_slot       : integer range 0 to TABLE_SIZE-1;

    ---------------------------
    -- Input Control Signals --
    ---------------------------

    type InFSM_StateType is (IN_WAIT, IN_HERMES, IN_BRNOC);

    signal InFSM_PS             : InFSM_StateType;
    signal InFSM_NS             : InFSM_StateType;

    ---- hermes ----
    
    signal hermes_rx                : std_logic;
    signal hermes_rx_ck             : std_logic;
    signal hermes_data_in           : regflit;
    signal hermes_eop_in            : std_logic;
    signal hermes_credit_out        : std_logic;
    
    signal flit_counter             : integer range 0 to MAX_FLITS_PER_PKT;
    signal path_flit_counter        : intN_pathSize;
    
    signal hermes_in_service        : regword;
    signal hermes_in_app_id         : regN_appID;
    signal hermes_in_key_periph     : regN_keyPeriph;
    signal hermes_in_burst_size     : regN_burstSize;
    signal hermes_in_path_flit      : regflit;
    signal hermes_in_path_size      : intN_pathSize;

    signal hermes_in_save_app_id    : std_logic;
    signal hermes_in_save_keyp      : std_logic;
    signal hermes_in_save_bsize     : std_logic;
    signal hermes_in_save_path      : std_logic;
    signal hermes_in_save_path_size : std_logic;
    
    alias hermes_in_service_hi      : regflit   is hermes_in_service(TAM_WORD-1 downto TAM_FLIT);
    alias hermes_in_service_lo      : regflit   is hermes_in_service(TAM_FLIT-1 downto 0);

    signal hermes_input_request     : std_logic;
    signal hermes_is_receiving      : std_logic;
    signal hermes_end_of_reception  : std_logic;

    ---- brnoc ----

    signal brnoc_input_request      : std_logic;
    signal brnoc_end_of_reception   : std_logic;

begin

    -----------
    -- Table --
    -----------

    table_is_full <= nor table.free;
    table_has_match <= or table.match;
    
    GEN_TABLE_MATCH: for i in 0 to TABLE_SIZE-1 generate
        table.match(i) <= '1' when table.app_id(i) = fetch_appid and table.free(i)='0' else '0';
    end generate;
    
    IF_GEN_SLOTS_2: if TABLE_SIZE = 2 generate
        free_slot   <=  0   when table.free(0)='1'  else
                        1;
        match_slot  <=  0   when table.match(0)='1' else
                        1;
    end generate;

    IF_GEN_SLOTS_4: if TABLE_SIZE = 4 generate
        free_slot   <=  0   when table.free(0)='1'  else
                        1   when table.free(1)='1'  else
                        2   when table.free(2)='1'  else
                        3;
        match_slot  <=  0   when table.match(0)='1' else
                        1   when table.match(1)='1' else
                        2   when table.match(2)='1' else
                        3;
    end generate;

    IF_GEN_SLOTS_8: if TABLE_SIZE = 8 generate
        free_slot   <=  0   when table.free(0)='1'  else
                        1   when table.free(1)='1'  else
                        2   when table.free(2)='1'  else
                        3   when table.free(3)='1'  else
                        4   when table.free(4)='1'  else
                        5   when table.free(5)='1'  else
                        6   when table.free(6)='1'  else
                        7;
        match_slot  <=  0   when table.match(0)='1' else
                        1   when table.match(1)='1' else
                        2   when table.match(2)='1' else
                        3   when table.match(3)='1' else
                        4   when table.match(4)='1' else
                        5   when table.match(5)='1' else
                        6   when table.match(6)='1' else
                        7;
    end generate;

    write_slot <= match_slot when table_has_match='1' else free_slot;

    fetch_appid <= hermes_in_app_id;
    
    -------------------
    -- Input Control --
    -------------------

    hermes_rx                   <= hermes_primary_rx;
    hermes_rx_ck                <= hermes_primary_rx_clk;
    hermes_data_in              <= hermes_primary_data_in;
    hermes_eop_in               <= hermes_primary_eop_in;
    hermes_primary_credit_out   <= hermes_credit_out;

    hermes_credit_out           <= '1' when InFSM_PS = IN_WAIT or InFSM_PS = IN_HERMES else '0';

    hermes_input_request        <= hermes_rx;
    hermes_is_receiving         <= hermes_rx and hermes_credit_out;
    hermes_end_of_reception     <= hermes_is_receiving and hermes_eop_in;

    brnoc_input_request         <= '0';
    brnoc_end_of_reception      <= '0';

    InputFSM_ChangeState: process(reset, clock)
    begin
        if reset='1' then
            InFSM_PS <= IN_WAIT;
        elsif rising_edge(clock) then
            InFSM_PS <= InFSM_NS;
        end if;
    end process;

    InputFSM_NextState: process(InFSM_PS, brnoc_input_request, hermes_input_request, brnoc_end_of_reception, hermes_end_of_reception)
    begin
        case InFSM_PS is
        
            when IN_WAIT =>

                if hermes_input_request='1' then
                    InFSM_NS <= IN_HERMES;
                elsif brnoc_input_request='1' then
                    InFSM_NS <= IN_BRNOC;
                else
                    InFSM_NS <= IN_WAIT;
                end if;

            when IN_BRNOC =>

                if brnoc_end_of_reception='1' then
                    InFSM_NS <= IN_WAIT;
                else
                    InFSM_NS <= IN_BRNOC;
                end if;
            
            when IN_HERMES =>
            
                if hermes_end_of_reception='1' then
                    InFSM_NS <= IN_WAIT;
                else
                    InFSM_NS <= IN_HERMES;
                end if;
            
        end case;
    end process;

    CountReceivedFlits: process(reset, clock)
    begin
        if reset='1' then
            flit_counter <= 0;
        elsif rising_edge(clock) then
            if hermes_end_of_reception='1' then
                flit_counter <= 0;
            elsif hermes_is_receiving='1' then
                flit_counter <= flit_counter + 1;
            end if;
        end if;
    end process;

    WriteOnTable: process(reset, clock)
    begin
        if reset='1' then
            table.free <= (others => '1');
        elsif rising_edge(clock) then

            if InFSM_PS = IN_HERMES and hermes_end_of_reception='1' then

                if hermes_in_save_app_id='1' then
                    table.app_id(write_slot) <= hermes_in_app_id;
                end if;

                if hermes_in_save_keyp='1' then
                    table.key_periph(write_slot) <= hermes_in_key_periph;
                end if;

                if hermes_in_save_bsize='1' then
                    table.burst_size(write_slot) <= hermes_in_burst_size;
                end if;

                if hermes_in_save_path_size='1' then
                    table.path_size(write_slot) <= hermes_in_path_size;
                end if;

                if hermes_in_save_app_id='1' or hermes_in_save_keyp='1' or hermes_in_save_bsize='1' or hermes_in_save_path_size='1' then
                    table.free(write_slot) <= '0';
                end if;
                
            end if;

            if InFSM_PS = IN_HERMES and hermes_is_receiving='1' then
                
                if hermes_in_save_path='1' then
                    table.path(write_slot)(path_flit_counter) <= hermes_in_path_flit;
                end if;

            end if;
        
        end if;
    end process;

    HermesInControl: process(reset, clock)
    begin

        if reset='1' then
            hermes_in_service       <= (others => '0');
            hermes_in_app_id        <= (others => '0');
            hermes_in_key_periph    <= (others => '0');
            hermes_in_save_app_id   <= '0';
            hermes_in_save_keyp     <= '0';
            hermes_in_save_bsize    <= '0';
            hermes_in_save_path     <= '0';

        elsif rising_edge(clock) and InFSM_PS = IN_HERMES then

            if hermes_end_of_reception='1' then
                hermes_in_service       <= (others => '0');
                hermes_in_app_id        <= (others => '0');
                hermes_in_key_periph    <= (others => '0');
                hermes_in_save_app_id   <= '0';
                hermes_in_save_keyp     <= '0';
                hermes_in_save_bsize    <= '0';
                hermes_in_save_path     <= '0';
            
            elsif flit_counter = SERVICE_FLIT then
                hermes_in_service_hi <= hermes_data_in;
            elsif flit_counter = SERVICE_FLIT+1 then
                hermes_in_service_lo <= hermes_data_in;
            else

                ---- CONFIG_PERIPHERAL ----

                if hermes_in_service = CONFIG_PERIPH_SERVICE then

                    if flit_counter = CONFIG_PERIPH_SERVICE_APPID_FLIT then
                        hermes_in_app_id <= hermes_data_in(APPID_SIZE-1 downto 0);
                        hermes_in_save_app_id <= '1';
                    
                    elsif flit_counter = CONFIG_PERIPH_SERVICE_KEYP_FLIT then
                        hermes_in_key_periph <= hermes_data_in(KEYPERIPH_SIZE-1 downto 0);
                        hermes_in_save_keyp <= '1';
                    
                    end if;

                end if;

                ---- SET_PATH ----

                if hermes_in_service = SET_PATH_SERVICE then

                    if flit_counter = SET_PATH_SERVICE_APPID_FLIT then
                        hermes_in_app_id <= hermes_data_in(APPID_SIZE-1 downto 0);
                        
                    elsif flit_counter = END_OF_HEADER_FLIT then
                        hermes_in_save_path <= '1';
                    
                    end if;

                end if;

                ---- REQUEST_PERIPHERAL ----

                if hermes_in_service = REQUEST_PERIPH_SERVICE then

                    if flit_counter = REQUEST_PERIPH_SERVICE_APPID_FLIT then
                        hermes_in_app_id <= hermes_data_in(APPID_SIZE-1 downto 0);
                    
                    elsif flit_counter = REQUEST_PERIPH_SERVICE_BSIZE_FLIT then
                        hermes_in_burst_size <= hermes_data_in(BSIZE_SIZE-1 downto 0);
                        hermes_in_save_bsize <= '1';
                    
                    end if;

                end if;

            end if;
        end if;
    end process;

    CountPathFlits: process(reset, clock)
    begin
        if reset='1' then
            path_flit_counter <= 0;
        elsif rising_edge(clock) then
            if hermes_end_of_reception='1' then
                path_flit_counter <= 0;
            elsif hermes_is_receiving='1' and hermes_in_save_path='1' then
                path_flit_counter <= path_flit_counter + 1;
            end if;
        end if;
    end process;

    hermes_in_path_flit <= hermes_data_in when hermes_in_save_path='1' else (others => '0');
    hermes_in_path_size <= path_flit_counter when hermes_in_save_path='1' else 0;
    hermes_in_save_path_size <= '1' when hermes_in_save_path='1' and hermes_end_of_reception='1' else '0';

end network_interface;
