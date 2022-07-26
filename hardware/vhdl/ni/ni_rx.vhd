library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_pkg.all;

entity ni_rx is
    port
    (
        clock               : in    std_logic;
        reset               : in    std_logic;

        hermes_rx           : in    std_logic;
        hermes_data_in      : in    regflit;
        hermes_eop_in       : in    std_logic;
        hermes_credit_out   : out   std_logic;

        tableIn             : in    TableOutput;
        tableOut            : out   TableInput
    );
end entity;

architecture ni_rx of ni_rx is

    -----------------
    -- FSM SIGNALS --
    -----------------

    type InputHandlerState is (WAIT_REQ, HERMES_HEADER, WAIT_SLOT, RECEIVE_PATH, WRITE_TABLE);

    signal state        : InputHandlerState;
    signal next_state   : InputHandlerState;
    
    ---------------------------
    -- PACKET INFO REGISTERS --
    ---------------------------

    signal header_flit          : integer range 0 to HEADER_SIZE;
    signal path_flit            : intN_pathIndex;

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

    ---------------------
    -- CONTROL SIGNALS --
    ---------------------

    signal end_of_handling  : std_logic;

    -- hermes control signals

    type HermesControlSignals is record
        request             : std_logic; -- Hermes is trying to send a flit
        acceptingFlit       : std_logic; -- the transmitted flit is being accepted into the NI
        receivingHeader     : std_logic; -- the transmitted flit is part of the packet header
        receivingPath       : std_logic; -- the transmitted flit is part of the source-routing path
        endOfHeader         : std_logic; -- the transmitted flit is the last flit of the header
        endOfPacket         : std_logic; -- the transmitted flit is the last flit of the packet
    end record;

    signal hermesControl    : HermesControlSignals;

    -- table control signals

    type TableControlSignals is record

        accessRequired      : std_logic;
        pathSavingRequired  : std_logic;

        requestNewSlot      : std_logic;
        requestExistingSlot : std_logic;
        cryptoFetch         : std_logic;
        tagAvailable        : std_logic;
        slotAvailable       : std_logic;
        accessFailed        : std_logic;
        
        enableWriting       : std_logic;
        enablePathWriting   : std_logic;
        saveAppId           : std_logic;
        saveKeyPeriph       : std_logic;
        saveBurstSize       : std_logic;
        savePathSize        : std_logic;

    end record;

    signal tableControl     : TableControlSignals;

begin

    --------------------------
    -- FSM STATE MANAGEMENT --
    --------------------------

    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= WAIT_REQ;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    NextState: process(state, hermesControl, tableControl)
    begin
        case state is

            when WAIT_REQ =>

                if hermesControl.request='1' then
                    next_state <= HERMES_HEADER;
                else
                    next_state <= WAIT_REQ;
                end if;

            when HERMES_HEADER =>

                if hermesControl.acceptingFlit='1' and hermesControl.endOfHeader='1' then
                
                    if tableControl.accessRequired='1' then
                        next_state <= WAIT_SLOT;
                    else
                        next_state <= WAIT_REQ;
                    end if;

                else
                    next_state <= HERMES_HEADER;
                end if;

            when WAIT_SLOT =>

                if tableControl.slotAvailable='1' then

                    if tableControl.pathSavingRequired='1' then
                        next_state <= RECEIVE_PATH;
                    else
                        next_state <= WRITE_TABLE;
                    end if;

                elsif tableControl.accessFailed='1' then
                    next_state <= WAIT_REQ;
                else
                    next_state <= WAIT_SLOT;
                end if;

            when RECEIVE_PATH =>

                if hermesControl.acceptingFlit='1' and hermesControl.endOfPacket='1' then
                    next_state <= WRITE_TABLE;
                else
                    next_state <= RECEIVE_PATH;
                end if;

            when WRITE_TABLE =>

                next_state <= WAIT_REQ;

        end case;
    end process;

    ---------------------------
    -- PACKET INFO GATHERING --
    ---------------------------

    CountHeaderFlits: process(clock, reset)
    begin
        if reset='1' then
            header_flit <= 0;
        elsif rising_edge(clock) then
            if end_of_handling='1' then
                header_flit <= 0;
            elsif hermesControl.acceptingFlit='1' and hermesControl.receivingHeader='1' then
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
            
            ---- HERMES PACKET ----

            elsif hermesControl.acceptingFlit='1' and hermesControl.receivingHeader='1' then

                if header_flit = SERVICE_FLIT then
                    hermes_service_hi <= hermes_data_in;
                elsif header_flit = SERVICE_FLIT+1 then
                    hermes_service_lo <= hermes_data_in;
                    hermes_service_valid <= '1';
                else

                    ---- CONFIG_PERIPHERAL ----

                    if hermes_service = CONFIG_PERIPH_SERVICE then

                        if header_flit = CONFIG_PERIPH_SERVICE_APPID_FLIT then
                            app_id <= hermes_data_in(APPID_SIZE-1 downto 0);
                            app_id_valid <= '1';
                        elsif header_flit = CONFIG_PERIPH_SERVICE_KEYP_FLIT then
                            key_periph <= hermes_data_in(KEYPERIPH_SIZE-1 downto 0);
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
            elsif hermesControl.acceptingFlit='1' and hermesControl.receivingPath='1' then
                path_flit <= path_flit + 1;
            end if;
        end if;
    end process;

    -----------------------
    -- TABLE INTERFACING --
    -----------------------

    -- slot request

    tableOut.request    <= tableControl.requestNewSlot or (tableControl.requestExistingSlot and tableControl.tagAvailable);
    
    tableOut.newLine    <= tableControl.requestNewSlot;
    tableOut.crypto     <= tableControl.cryptoFetch;

    tableOut.tag        <= crypto_tag when tableControl.cryptoFetch='1' else app_id;
    
    -- write fields

    tableOut.appId_w        <= app_id;
    tableOut.appId_wen      <= tableControl.enableWriting and tableControl.saveAppId;

    tableOut.key1_w         <= key_periph;
    tableOut.key1_wen       <= tableControl.enableWriting and tableControl.saveKeyPeriph;

    tableOut.key2_w         <= key_periph;
    tableOut.key2_wen       <= tableControl.enableWriting and tableControl.saveKeyPeriph;

    tableOut.burstSize_w    <= burst_size;
    tableOut.burstSize_wen  <= tableControl.enableWriting and  tableControl.saveBurstSize;

    tableOut.pathSize_w     <= path_flit;
    tableOut.pathSize_wen   <= tableControl.enableWriting and tableControl.savePathSize;

    tableOut.pathFlit_w     <= hermes_data_in;
    tableOut.pathFlit_wen   <= tableControl.enablePathWriting;
    tableOut.pathFlit_idx   <= path_flit;

    --------------------------------
    -- CONTROL SIGNALS GENERATION --
    --------------------------------

    end_of_handling <= '1' when (next_state = WAIT_REQ) and (state /= WAIT_REQ) else '0';

    ---- hermes ----

    hermes_credit_out <= '1' when (state = WAIT_REQ) or (state = HERMES_HEADER) or (state = RECEIVE_PATH) else '0';

    hermesControl.request <= hermes_rx;

    hermesControl.acceptingFlit <= hermes_rx and hermes_credit_out;

    hermesControl.receivingHeader <= '1' when (state = WAIT_REQ) or (state = HERMES_HEADER) else '0';
    
    hermesControl.receivingPath <= '1' when state = RECEIVE_PATH else '0';
    
    hermesControl.endOfHeader <= '1' when header_flit = HEADER_SIZE-1 else '0';

    hermesControl.endOfPacket <= hermes_eop_in;

    ---- table ----

    -------------------------------
    ------------ TO DO ------------
    -------------------------------
    -- ORGANIZAR ESSES PROCESSOS --
    -------------------------------

    tableControl.accessRequired <=
        '1' when hermes_service_valid='1' and hermes_service=CONFIG_PERIPH_SERVICE  else
        '1' when hermes_service_valid='1' and hermes_service=SET_PATH_SERVICE       else
        '1' when hermes_service_valid='1' and hermes_service=REQUEST_PERIPH_SERVICE else
        '0';

    tableControl.pathSavingRequired <=
        '1' when hermes_service_valid='1' and hermes_service=SET_PATH_SERVICE       else
        '0';

    tableControl.requestNewSlot <=
        '1' when hermes_service_valid='1' and hermes_service=CONFIG_PERIPH_SERVICE  else
        '0';

    tableControl.requestExistingSlot <= tableControl.accessRequired and not tableControl.requestNewSlot;

    tableControl.cryptoFetch <=
        '1' when hermes_service_valid='1' and hermes_service=REQUEST_PERIPH_SERVICE else
        '0';

    tableControl.tagAvailable <= (app_id_valid and not tableControl.cryptoFetch) or (crypto_tag_valid and tableControl.cryptoFetch);
    
    tableControl.slotAvailable <= tableIn.ready;
    
    tableControl.accessFailed <= tableIn.fail;

    tableControl.enableWriting <= '1' when state=WRITE_TABLE else '0';
    
    tableControl.enablePathWriting <= '1' when state=RECEIVE_PATH and hermesControl.acceptingFlit='1' else '0';
    
    tableControl.saveAppId <=
        '1' when hermes_service_valid='1' and hermes_service=CONFIG_PERIPH_SERVICE  else
        '0';

    tableControl.saveKeyPeriph <=
        '1' when hermes_service_valid='1' and hermes_service=CONFIG_PERIPH_SERVICE  else
        '0';

    tableControl.saveBurstSize <=
        '1' when hermes_service_valid='1' and hermes_service=REQUEST_PERIPH_SERVICE else
        '0';
    
    tableControl.savePathSize <=
        '1' when hermes_service_valid='1' and hermes_service=SET_PATH_SERVICE else
        '0';

end architecture;
