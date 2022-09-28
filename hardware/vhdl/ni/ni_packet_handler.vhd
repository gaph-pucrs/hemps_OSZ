library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_pkg.all;

entity ni_packet_handler is
    port
    (
        clock               : in    std_logic;
        reset               : in    std_logic;

        hermes_rx           : in    std_logic;
        hermes_data_in      : in    regflit;
        hermes_eop_in       : in    std_logic;
        hermes_credit_out   : out   std_logic;

        tableIn             : in    TableOutput;
        tableOut            : out   TableInput;

        response_req        : out   std_logic;
        response_param      : out   ResponseParametersType;
        tx_status           : in    TransmissionStatusType;

        buffer_wdata        : out   regflit;
        buffer_wen          : out   std_logic;
        buffer_full         : in    std_logic
    );
end entity;

architecture ni_packet_handler of ni_packet_handler is

    -----------------
    -- FSM SIGNALS --
    -----------------

    -- master fsm

    type MainStateType              is (START_RECEPTION, ACCESS_TABLE, RECEIVE_DATA, FINISH_RECEPTION, RESPOND);
    signal stage                    : MainStateType;
    signal next_stage               : MainStateType;

    -- slave fsms

    type StartReceptionStateType    is (WAIT_REQUEST, PARSE_HERMES_HEADER, EXIT_STAGE);
    signal start_rx_state           : StartReceptionStateType;
    signal next_start_rx_state      : StartReceptionStateType;

    type AccessTableStateType       is (CHECK_TABLE_SLOT, WRITE_TABLE, SAVE_PATH, EXIT_STAGE);
    signal table_state              : AccessTableStateType;
    signal next_table_state         : AccessTableStateType;

    type ReceiveDataStateType       is (CONSUME_DATA_FLIT, EXIT_STAGE);
    signal data_state               : ReceiveDataStateType;
    signal next_data_state          : ReceiveDataStateType;

    type FinishReceptionStateType   is (DROP_FLIT, EXIT_STAGE);
    signal finish_rx_state          : FinishReceptionStateType;
    signal next_finish_rx_state     : FinishReceptionStateType;

    type RespondStateType           is (WAIT_TX_AVAILABLE, REQUEST_RESPONSE, EXIT_STAGE);
    signal respond_state            : RespondStateType;
    signal next_respond_state       : RespondStateType;

    -- exit flags

    type FsmExitFlagsType is record
        start_rx            : std_logic;
        table               : std_logic;
        data                : std_logic;
        finish_rx           : std_logic;
        respond             : std_logic;
    end record;

    signal exiting          : FsmExitFlagsType;

    signal changing_stage   : std_logic;

    ---------------------------
    -- PACKET INFO REGISTERS --
    ---------------------------

    -- flit counters:

    signal routing_header_flit  : integer range 0 to XY_HEADER_SIZE;
    signal header_flit          : integer range 0 to HEADER_SIZE;
    signal path_flit            : intN_pathIndex;

    -- registers:

    signal app_id               : regN_appID;
    signal app_id_valid         : std_logic;

    signal crypto_tag           : regN_appID;
    signal crypto_tag_valid     : std_logic;

    signal key_periph           : regN_keyPeriph;
    signal key_periph_valid     : std_logic;

    signal burst_size           : regN_burstSize;
    signal burst_size_valid     : std_logic;

    signal hermes_service       : regword;
    signal hermes_service_valid : std_logic;
    alias  hermes_service_hi    : regflit is hermes_service(TAM_WORD-1 downto TAM_FLIT);
    alias  hermes_service_lo    : regflit is hermes_service(TAM_FLIT-1 downto 0);

    signal packet_source        : regflit;
    signal packet_source_valid  : std_logic;

    signal packet_target        : regflit;
    signal packet_target_valid  : std_logic;

    ---------------------
    -- CONTROL SIGNALS --
    ---------------------

    -- hermes control signals

    type HermesControlSignals is record
        request                 : std_logic;
        acceptingFlit           : std_logic;
        payloadIsPath           : std_logic;
        payloadIsData           : std_logic;
        receivingRoutingHeader  : std_logic;
        receivingHeader         : std_logic;
        receivingPath           : std_logic;
        receivingData           : std_logic;
        droppingPackage         : std_logic;
        endOfHeader             : std_logic;
        endOfPacket             : std_logic;
        receivedEndOfPacket     : std_logic;
        sourceRoutingPacket     : std_logic;
        sourceRoutingFlit       : std_logic;
    end record;

    signal hermesControl    : HermesControlSignals;

    -- table control signals

    type TableControlSignals is record
        fetchNewSlot        : std_logic;
        fetchPlaintext      : std_logic;
        fetchCrypto         : std_logic;
        fetchExistingSlot   : std_logic;
        tagAvailable        : std_logic;
        slotAvailable       : std_logic;
        accessFailed        : std_logic;
        enableWriting       : std_logic;
        enablePathWriting   : std_logic;
        saveAppId           : std_logic;
        saveKeyPeriph       : std_logic;
        saveBurstSize       : std_logic;
    end record;

    signal tableControl : TableControlSignals;

    -- other control signals -- todo

    signal unknown_service          : std_logic;
    signal authenticated            : std_logic;
    signal response_necessary       : std_logic;
    signal data_to_write_on_table   : std_logic;
    signal end_of_handling          : std_logic;

begin

    ----------------
    -- MASTER FSM --
    ----------------

    ChangeStage: process(clock, reset)
    begin
        if reset='1' then
            stage <= START_RECEPTION;
        elsif rising_edge(clock) and changing_stage='1' then
            stage <= next_stage;
        end if;
    end process;

    NextStage: process(stage, changing_stage, unknown_service, authenticated, hermesControl, response_necessary)
    begin
        case stage is

            when START_RECEPTION =>

                if unknown_service='1' then
                    next_stage <= FINISH_RECEPTION;
                else
                    next_stage <= ACCESS_TABLE;
                end if;

            when ACCESS_TABLE =>

                if authenticated='1' and hermesControl.payloadIsData='1' then
                    next_stage <= RECEIVE_DATA;
                else
                    next_stage <= FINISH_RECEPTION;
                end if;

            when RECEIVE_DATA =>

                next_stage <= FINISH_RECEPTION;

            when FINISH_RECEPTION =>

                if response_necessary='1' then
                    next_stage <= RESPOND;
                else
                    next_stage <= START_RECEPTION;
                end if;

            when RESPOND =>

                next_stage <= START_RECEPTION;

        end case;
    end process;

    changing_stage <= exiting.start_rx or exiting.table or exiting.data or exiting.finish_rx or exiting.respond;

    ----------------
    -- SLAVE FSMS --
    ----------------

    ChangeStates: process(clock, reset)
    begin
        if reset='1' then
            start_rx_state  <= WAIT_REQUEST;
            table_state     <= CHECK_TABLE_SLOT;
            data_state      <= CONSUME_DATA_FLIT;
            finish_rx_state <= DROP_FLIT;
            respond_state   <= WAIT_TX_AVAILABLE;
        
        elsif rising_edge(clock) then
        
            if stage=START_RECEPTION then

                if exiting.start_rx='1' then
                    start_rx_state <= WAIT_REQUEST;
                else
                    start_rx_state <= next_start_rx_state;
                end if;
            
            elsif stage=ACCESS_TABLE then

                if exiting.table='1' then
                    table_state <= CHECK_TABLE_SLOT;
                else
                    table_state <= next_table_state;
                end if;
            
            elsif stage=RECEIVE_DATA then

                if exiting.data='1' then
                    data_state <= CONSUME_DATA_FLIT;
                else
                    data_state <= next_data_state;
                end if;

            elsif stage=FINISH_RECEPTION then

                if exiting.finish_rx='1' then
                    finish_rx_state <= DROP_FLIT;
                else
                    finish_rx_state <= next_finish_rx_state;
                end if;
            
            elsif stage=RESPOND then

                if exiting.respond='1' then
                    respond_state <= WAIT_TX_AVAILABLE;
                else
                    respond_state <= next_respond_state;
                end if;

            end if;
        end if;
    end process;

    -- start reception

    NextState_StartRx: process(start_rx_state, hermesControl)
    begin
        case start_rx_state is

            when WAIT_REQUEST =>

                if hermesControl.request='1' then
                    next_start_rx_state <= PARSE_HERMES_HEADER;
                else
                    next_start_rx_state <= WAIT_REQUEST;
                end if;

            when PARSE_HERMES_HEADER =>

                if hermesControl.endOfHeader='1' and hermesControl.acceptingFlit='1' then
                    next_start_rx_state <= EXIT_STAGE;
                else
                    next_start_rx_state <= PARSE_HERMES_HEADER;
                end if;
            
            when EXIT_STAGE =>

                next_start_rx_state <= EXIT_STAGE;

        end case;
    end process;

    exiting.start_rx <= '1' when stage=START_RECEPTION and next_start_rx_state=EXIT_STAGE else '0';

    -- access table

    NextState_AccessTable: process(table_state, tableControl, hermesControl, data_to_write_on_table)
    begin
        case table_state is

            when CHECK_TABLE_SLOT =>

                if tableControl.slotAvailable='1' then

                    if data_to_write_on_table='1' then
                        next_table_state <= WRITE_TABLE;
                    elsif hermesControl.payloadIsPath then
                        next_table_state <= SAVE_PATH;
                    else
                        next_table_state <= EXIT_STAGE;
                    end if;
                    
                elsif tableControl.accessFailed='1' then
                    next_table_state <= EXIT_STAGE;
                else
                    next_table_state <= CHECK_TABLE_SLOT;
                end if;

            when WRITE_TABLE =>

                if hermesControl.payloadIsPath then
                    next_table_state <= SAVE_PATH;
                else
                    next_table_state <= EXIT_STAGE;
                end if;

            when SAVE_PATH =>

                if hermesControl.receivedEndOfPacket='1' or (hermesControl.endOfPacket='1' and hermesControl.acceptingFlit='1') then
                    next_table_state <= EXIT_STAGE;
                else
                    next_table_state <= SAVE_PATH;
                end if;
            
            when EXIT_STAGE =>
            
                next_table_state <= EXIT_STAGE;

        end case;
    end process;

    exiting.table <= '1' when stage=ACCESS_TABLE and next_table_state=EXIT_STAGE else '0';

    -- receive data

    NextState_ReceiveData: process(data_state, hermesControl)
    begin
        case data_state is

            when CONSUME_DATA_FLIT =>

                if hermesControl.receivedEndOfPacket='1' or (hermesControl.endOfPacket='1' and hermesControl.acceptingFlit='1') then
                    next_data_state <= EXIT_STAGE;
                else
                    next_data_state <= CONSUME_DATA_FLIT;
                end if;
            
            when EXIT_STAGE =>
            
                next_data_state <= EXIT_STAGE;

        end case;
    end process;

    exiting.data <= '1' when stage=RECEIVE_DATA and next_data_state=EXIT_STAGE else '0';

    -- finish reception

    NextState_FinishRx: process(finish_rx_state, hermesControl)
    begin
        case finish_rx_state is

            when DROP_FLIT =>

                if hermesControl.receivedEndOfPacket='1' or (hermesControl.endOfPacket='1' and hermesControl.acceptingFlit='1') then
                    next_finish_rx_state <= EXIT_STAGE;
                else
                    next_finish_rx_state <= DROP_FLIT;
                end if;

            when EXIT_STAGE =>
            
                next_finish_rx_state <= EXIT_STAGE;

        end case;
    end process;

    exiting.finish_rx <= '1' when stage=FINISH_RECEPTION and next_finish_rx_state=EXIT_STAGE else '0';

    -- respond

    NextState_Respond: process(respond_state, tx_status)
    begin
        case respond_state is

            when WAIT_TX_AVAILABLE =>

                if tx_status.busy='1' then
                    next_respond_state <= WAIT_TX_AVAILABLE;
                else
                    next_respond_state <= REQUEST_RESPONSE;
                end if;

            when REQUEST_RESPONSE =>

                if tx_status.accepted='1' or tx_status.rejected='1' then
                    next_respond_state <= EXIT_STAGE;
                else
                    next_respond_state <= REQUEST_RESPONSE;
                end if;

            when EXIT_STAGE =>
            
                next_respond_state <= EXIT_STAGE;

        end case;
    end process;

    exiting.respond <= '1' when stage=RESPOND and next_respond_state=EXIT_STAGE else '0';

    --------------------
    -- PACKET PARSING --
    --------------------

    CountRoutingHeaderFlits: process(clock, reset)
    begin
        if reset='1' then
            routing_header_flit <= 0;
        elsif rising_edge(clock) then
            if end_of_handling='1' then
                routing_header_flit <= 0;
            elsif hermesControl.receivingRoutingHeader='1' and hermesControl.acceptingFlit='1' and routing_header_flit/=XY_HEADER_SIZE then
                routing_header_flit <= routing_header_flit + 1;
            end if;
        end if;
    end process;

    CountHeaderFlits: process(clock, reset)
    begin
        if reset='1' then
            header_flit <= 0;
        elsif rising_edge(clock) then
            if end_of_handling='1' then
                header_flit <= 0;
            elsif hermesControl.receivingHeader='1' and hermesControl.acceptingFlit='1' and hermesControl.receivingRoutingHeader='0' then
                header_flit <= header_flit + 1;
            end if;
        end if;
    end process;

    GetPacketInfo: process(clock, reset)
    begin
        if reset='1' then
            
            app_id                  <= (others => '0');
            app_id_valid            <= '0';
            
            crypto_tag              <= (others => '0');
            crypto_tag_valid        <= '0';
            
            key_periph              <= (others => '0');
            key_periph_valid        <= '0';
            
            burst_size              <= (others => '0');
            burst_size_valid        <= '0';
            
            hermes_service          <= (others => '0');
            hermes_service_valid    <= '0';

            packet_source           <= (others => '0');
            packet_source_valid     <= '0';

            packet_target           <= (others => '0');
            packet_target_valid     <= '0';

        elsif rising_edge(clock) then

            if end_of_handling='1' then

                app_id                  <= (others => '0');
                app_id_valid            <= '0';
                
                crypto_tag              <= (others => '0');
                crypto_tag_valid        <= '0';
                
                key_periph              <= (others => '0');
                key_periph_valid        <= '0';
                
                burst_size              <= (others => '0');
                burst_size_valid        <= '0';
                
                hermes_service          <= (others => '0');
                hermes_service_valid    <= '0';
            
                packet_source           <= (others => '0');
                packet_source_valid     <= '0';

                packet_target           <= (others => '0');
                packet_target_valid     <= '0';
            
            ---- HERMES PACKET HEADER (FIXED AND ROUTING) ----

            elsif hermesControl.receivingHeader='1' and hermesControl.receivingRoutingHeader='1' and hermesControl.acceptingFlit='1' then

                if routing_header_flit=1 then
                    packet_target <= hermes_data_in;
                    packet_target_valid <= '1';
                end if;

            ---- HERMES PACKET HEADER (DYNAMIC) ----

            elsif hermesControl.receivingHeader='1' and hermesControl.receivingRoutingHeader='0' and hermesControl.acceptingFlit='1' then

                if header_flit = SERVICE_FLIT then
                    hermes_service_hi <= hermes_data_in;
                elsif header_flit = SERVICE_FLIT+1 then
                    hermes_service_lo <= hermes_data_in;
                    hermes_service_valid <= '1';
                else

                    -- Initialize NI -- 
                    -- receber k0

                    -- Key Evolve --
                    
                    ---- CONFIG_PERIPHERAL ----

                    if hermes_service = CONFIG_PERIPH_SERVICE then

                        if header_flit = CONFIG_PERIPH_SERVICE_APPID_FLIT then
                            app_id <= hermes_data_in(APPID_SIZE-1 downto 0);
                            app_id_valid <= '1';
                        elsif header_flit = CONFIG_PERIPH_SERVICE_KEYP_FLIT then
                            key_periph <= hermes_data_in(KEYPERIPH_SIZE-1 downto 0);
                            -- key_periph 2
                            key_periph_valid <= '1';
                        end if;

                    end if;

                    ---- SET_PATH ----

                    if hermes_service = SET_PATH_SERVICE then

                        if header_flit = SET_PATH_SERVICE_APPID_FLIT then
                            app_id <= hermes_data_in(APPID_SIZE-1 downto 0);
                            app_id_valid <= '1';
                        end if;

                    end if;

                    ---- REQUEST_PERIPHERAL ----

                    if hermes_service = REQUEST_PERIPH_SERVICE then

                        if header_flit = REQUEST_PERIPH_SERVICE_APPID_FLIT then
                            crypto_tag <= hermes_data_in(APPID_SIZE-1 downto 0);
                            crypto_tag_valid <= '1';
                        elsif header_flit = REQUEST_PERIPH_SERVICE_BSIZE_FLIT then
                            burst_size <= hermes_data_in(BSIZE_SIZE-1 downto 0);
                            burst_size_valid <= '1';
                        end if;

                    end if;

                    ---- IO_REQUEST ----

                    if hermes_service = IO_REQUEST_SERVICE then

                        if header_flit = IO_REQUEST_SERVICE_APPID_FLIT then
                            crypto_tag <= hermes_data_in(APPID_SIZE-1 downto 0);
                            crypto_tag_valid <= '1';
                        elsif header_flit = IO_REQUEST_SERVICE_PE_SRC_FLIT then
                            packet_source <= hermes_data_in;
                            packet_source_valid <= '1';
                        end if;

                    end if;

                    ---- IO_DELIVERY ----

                    if hermes_service = IO_DELIVERY_SERVICE then

                        if header_flit = IO_DELIVERY_SERVICE_PERPH_ID_FLIT then
                            crypto_tag <= hermes_data_in(APPID_SIZE-1 downto 0);
                            crypto_tag_valid <= '1';
                        elsif header_flit = IO_DELIVERY_SERVICE_PE_SRC_FLIT then
                            packet_source <= hermes_data_in;
                            packet_source_valid <= '1';
                        end if;

                    end if;

                end if;

            end if;

        end if;
    end process;

    CountPathFlits: process(clock, reset)
    begin
        if reset='1' then
            path_flit <= 0;
        elsif rising_edge(clock) then
            if end_of_handling='1' then
                path_flit <= 0;
            elsif hermesControl.receivingPath='1' and hermesControl.acceptingFlit='1' then
                path_flit <= path_flit + 1;
            end if;
        end if;
    end process;

    ---------------------
    -- TABLE INTERFACE --
    ---------------------

    -- slot request

    tableOut.request    <= tableControl.fetchNewSlot or (tableControl.fetchExistingSlot and tableControl.tagAvailable);
    
    tableOut.newLine    <= tableControl.fetchNewSlot;
    tableOut.crypto     <= tableControl.fetchCrypto;

    tableOut.tag        <= crypto_tag when tableControl.fetchCrypto='1' else app_id;

    tableOut.clearSlot  <= '0';
    
    -- write fields

    tableOut.appId_w        <= app_id;
    tableOut.appId_wen      <= tableControl.enableWriting and tableControl.saveAppId;

    tableOut.key1_w         <= key_periph;
    tableOut.key1_wen       <= tableControl.enableWriting and tableControl.saveKeyPeriph;

    tableOut.key2_w         <= key_periph;
    tableOut.key2_wen       <= tableControl.enableWriting and tableControl.saveKeyPeriph;

    tableOut.burstSize_w    <= burst_size;
    tableOut.burstSize_wen  <= tableControl.enableWriting and  tableControl.saveBurstSize;

    -- write path

    tableOut.pathSize_w     <= path_flit;
    tableOut.pathSize_wen   <= tableControl.enablePathWriting;

    tableOut.pathFlit_w     <= hermes_data_in;
    tableOut.pathFlit_wen   <= tableControl.enablePathWriting;
    tableOut.pathFlit_idx   <= path_flit;

    --------------------------------
    -- CONTROL SIGNALS GENERATION --
    --------------------------------

    -- hermes control signals

    hermes_credit_out <= not hermesControl.receivedEndOfPacket and
        (hermesControl.receivingHeader or hermesControl.receivingPath or (hermesControl.receivingData and not buffer_full) or hermesControl.droppingPackage);

    hermesControl.request       <= hermes_rx;
    hermesControl.acceptingFlit <= hermes_rx and hermes_credit_out;

    hermesControl.payloadIsPath <= '1' when hermes_service_valid='1'    and (hermes_service=CONFIG_PERIPH_SERVICE or hermes_service=SET_PATH_SERVICE)   else '0';
    hermesControl.payloadIsData <= '1' when hermes_service_valid='1'    and (hermes_service=IO_DELIVERY_SERVICE)                                        else '0';

    hermesControl.receivingHeader   <= '1' when stage=START_RECEPTION   and (start_rx_state=WAIT_REQUEST or start_rx_state=PARSE_HERMES_HEADER) else '0';
    hermesControl.receivingPath     <= '1' when stage=ACCESS_TABLE      and (table_state=SAVE_PATH)                                             else '0';
    hermesControl.receivingData     <= '1' when stage=RECEIVE_DATA      and (data_state=CONSUME_DATA_FLIT)                                      else '0';
    hermesControl.droppingPackage   <= '1' when stage=FINISH_RECEPTION  and (finish_rx_state=DROP_FLIT)                                         else '0';

    hermesControl.endOfHeader <= '1' when header_flit=END_OF_HEADER_FLIT else '0';
    hermesControl.endOfPacket <= hermes_eop_in;

    hermesControl.sourceRoutingFlit <= '1' when hermesControl.receivingRoutingHeader='1' and hermes_data_in(TAM_FLIT-1 downto TAM_FLIT-4)=x"7" else '0';

    hermesControl.receivingRoutingHeader <= '1' when hermesControl.receivingHeader='1' and (
        (hermesControl.sourceRoutingPacket='0' and routing_header_flit/=XY_HEADER_SIZE) or (hermesControl.sourceRoutingPacket='1' and hermesControl.sourceRoutingFlit='1')
    ) else '0';

    HermesControlRegisters: process(clock, reset)
    begin
        if reset='1' then
            hermesControl.receivedEndOfPacket   <= '0';
            hermesControl.sourceRoutingPacket   <= '0';
        elsif rising_edge(clock) then
            if end_of_handling='1' then
                hermesControl.receivedEndOfPacket   <= '0';
                hermesControl.sourceRoutingPacket   <= '0';
            else
            
                if hermesControl.endOfPacket='1' then
                    hermesControl.receivedEndOfPacket <= '1';
                end if;

                if hermesControl.sourceRoutingFlit='1' then
                    hermesControl.sourceRoutingPacket <= '1';
                end if;

            end if;
        end if;
    end process;

    -- table control signals

    tableControl.fetchNewSlot   <= '1' when hermes_service_valid='1'    and (hermes_service=CONFIG_PERIPH_SERVICE)  else '0';
    tableControl.fetchPlaintext <= '1' when hermes_service_valid='1'    and (hermes_service=SET_PATH_SERVICE)       else '0';
    tableControl.fetchCrypto    <= '1' when hermes_service_valid='1'    and (
        hermes_service=REQUEST_PERIPH_SERVICE or hermes_service=IO_REQUEST_SERVICE or hermes_service=IO_DELIVERY_SERVICE
    ) else '0';

    tableControl.fetchExistingSlot <= tableControl.fetchPlaintext or tableControl.fetchCrypto;
    
    tableControl.tagAvailable <= (tableControl.fetchPlaintext and app_id_valid) or (tableControl.fetchCrypto and crypto_tag_valid);

    tableControl.slotAvailable <= tableIn.ready;
    tableControl.accessFailed <= tableIn.fail;

    tableControl.enableWriting      <= '1' when stage=ACCESS_TABLE  and (table_state=WRITE_TABLE)   else '0';
    tableControl.enablePathWriting  <= '1' when stage=ACCESS_TABLE  and (table_state=SAVE_PATH)     else '0';

    tableControl.saveAppId      <= '1' when hermes_service_valid='1'    and (hermes_service=CONFIG_PERIPH_SERVICE)  else '0';
    tableControl.saveKeyPeriph  <= '1' when hermes_service_valid='1'    and (hermes_service=CONFIG_PERIPH_SERVICE)  else '0';
    tableControl.saveBurstSize  <= '1' when hermes_service_valid='1'    and (hermes_service=REQUEST_PERIPH_SERVICE) else '0';

    -- other control signals

    unknown_service <= '0' when hermes_service_valid='1' and
    (
        hermes_service=CONFIG_PERIPH_SERVICE or
        hermes_service=SET_PATH_SERVICE or
        hermes_service=REQUEST_PERIPH_SERVICE or
        hermes_service=IO_REQUEST_SERVICE or
        hermes_service=IO_DELIVERY_SERVICE
    ) else '1';

    authenticated <= tableControl.slotAvailable;

    response_necessary <= '1' when hermes_service_valid='1' and (hermes_service=IO_REQUEST_SERVICE or hermes_service=IO_DELIVERY_SERVICE) else '0';

    data_to_write_on_table <= tableControl.saveAppId or tableControl.saveKeyPeriph or tableControl.saveBurstSize;

    end_of_handling <= '1' when next_stage=START_RECEPTION and changing_stage='1' else '0';

    --------------------------------
    -- RESPONSE REQUEST INTERFACE --
    --------------------------------

    response_req <= '1' when stage=RESPOND and respond_state=REQUEST_RESPONSE else '0';

    response_param.txMode <= THROUGH_HERMES;
    response_param.appId <= tableIn.appId;
    response_param.hermesService <= IO_DELIVERY_SERVICE when hermes_service_valid='1' and hermes_service=IO_REQUEST_SERVICE else IO_ACK_SERVICE;
    response_param.brnocService <= (others => '0');

    response_param.source <= packet_target;
    response_param.target <= packet_source;

    ----------------
    -- WRITE DATA --
    ----------------

    buffer_wdata <= hermes_data_in;
    buffer_wen <= '1' when stage=RECEIVE_DATA and data_state=CONSUME_DATA_FLIT and hermesControl.acceptingFlit='1' else '0';
    
end architecture;
