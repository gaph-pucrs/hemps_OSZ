library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.snip_pkg.all;

entity snip_packet_builder is
    generic
    (
        SNIP_ID : regflit
    );
    port
    (
        clock               : in    std_logic;
        reset               : in    std_logic;

        hermes_tx           : out   std_logic;
        hermes_data_out     : out   regflit;
        hermes_eop_out      : out   std_logic;
        hermes_bop_out      : out   std_logic;
        hermes_credit_in    : in    std_logic;

        tableIn             : in    AppTableSecondaryOutput;
        tableOut            : out   AppTableSecondaryInput;

        response_req        : in    std_logic;
        response_param_in   : in    ResponseParametersType;
        status              : out   TransmissionStatusType;

        warning_req         : in    std_logic;
        warning_ack         : out   std_logic;
        warning_param       : in    WarningParametersType;
        warning_f1          : in    regflit;
        warning_f2          : in    regflit;
        warning_pkt_source  : in    regflit;
        warning_slot_index  : in    integer range 0 to TABLE_SIZE-1;

        mpe_routing_header  : in    regword;

        buffer_rdata        : in    regflit;
        buffer_ren          : out   std_logic;
        buffer_empty        : in    std_logic;
        buffer_flush        : out   std_logic;
        buffer_enable       : out   std_logic;

        warn_excessive_data : out   std_logic
    );
end entity;

architecture snip_packet_builder of snip_packet_builder is

    -----------------
    -- FSM SIGNALS --
    -----------------

    type PacketBuilderState is (WAIT_REQ, CHECK_TABLE, HERMES_FIXED_HEADER, HERMES_PATH, HERMES_HEADER, DATA_PAYLOAD, CHECK_BUFFER, BUILD_WARNING, REJECT_REQUEST);

    signal state                : PacketBuilderState;
    signal next_state           : PacketBuilderState;

    signal nonsecure            : std_logic;

    ----------------------
    -- REQUEST REGISTER --
    ----------------------

    signal response_param_reg   : ResponseParametersType;
    signal warning_param_reg    : WarningParametersType;

    ---------------------------
    -- HERMES HEADER SIGNALS --
    ---------------------------
    
    signal fixed_header_flit    : integer range 0 to FIXED_HEADER_SIZE;
    signal path_flit            : integer range 0 to MAX_PATH_FLITS;
    signal header_flit          : integer range 0 to FULL_HEADER_SIZE;

    signal fixed_header_end     : std_logic;
    signal path_end             : std_logic;
    signal header_end           : std_logic;

    signal header_tx            : std_logic;
    signal header_eop           : std_logic;

    signal warning_end          : std_logic;

    --------------------------
    -- DATA PAYLOAD SIGNALS --
    --------------------------

    signal send_data            : std_logic;

    signal data_words_to_read   : integer range 0 to MAX_WORDS_PER_DELIVERY;
    signal data_flit_low        : std_logic;
    signal data_flit_ready      : std_logic;
    signal last_data_flit       : std_logic;
    signal data_flit_blocked    : std_logic;
    
    signal data_tx              : std_logic;
    signal data_eop             : std_logic;
    signal warning_eop          : std_logic;

    signal buffer_enable_sig    : std_logic;

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

    NextState: process(state, response_req, warning_req, response_param_reg, tableIn, fixed_header_end, path_end, header_end, data_eop, hermes_tx, warning_end)
    begin
        case state is

            when WAIT_REQ =>

                if warning_req='1' then
                    next_state <= BUILD_WARNING;
                elsif response_req='1' then
                    next_state <= CHECK_TABLE;
                else
                    next_state <= WAIT_REQ;
                end if;
            
            when BUILD_WARNING =>
                
                if warning_end='1' and hermes_tx='1' then
                    next_state <= WAIT_REQ;
                else
                    next_state <= BUILD_WARNING;
                end if;

            when CHECK_TABLE =>

                if tableIn.ready='0' then
                    next_state <= REJECT_REQUEST;
                elsif response_param_in.txMode=THROUGH_HERMES then
                    next_state <= HERMES_FIXED_HEADER;
                else
                    next_state <= REJECT_REQUEST;
                end if;

            when HERMES_FIXED_HEADER =>

                if fixed_header_end='1' and hermes_tx='1' then
                    next_state <= HERMES_PATH;
                else
                    next_state <= HERMES_FIXED_HEADER;
                end if;

            when HERMES_PATH =>

                if path_end='1' and hermes_tx='1' then
                    next_state <= HERMES_HEADER;
                else
                    next_state <= HERMES_PATH;
                end if;

            when HERMES_HEADER =>

                if header_end='1' and hermes_tx='1' then
                    if send_data='1' then
                        next_state <= DATA_PAYLOAD;
                    else
                        next_state <= WAIT_REQ;
                    end if;
                else
                    next_state <= HERMES_HEADER;
                end if;

            when DATA_PAYLOAD =>

                if data_eop='1' and hermes_tx='1' then
                    next_state <= CHECK_BUFFER;
                else
                    next_state <= DATA_PAYLOAD;
                end if;
            
            when CHECK_BUFFER =>

                next_state <= WAIT_REQ;

            when REJECT_REQUEST =>

                if response_req='0' then
                    next_state <= WAIT_REQ;
                else
                    next_state <= REJECT_REQUEST;
                end if;

        end case;
    end process;

    status.busy <= '1' when state/=WAIT_REQ else '0';
    status.rejected <= '1' when state=REJECT_REQUEST else '0';
    status.accepted <= '1' when state=HERMES_FIXED_HEADER or state=HERMES_PATH or state=HERMES_HEADER or state=DATA_PAYLOAD else '0';

    nonsecure <= '1' when tableIn.appID=x"0000" and tableIn.key1=x"0000" and tableIn.key2=x"0000" else '0';

    -------------------------
    -- SAVE RESPONSE PARAM --
    -------------------------

    ResponseParamRegisterManagement: process(clock, reset)
    begin
        if rising_edge(clock) then
            if state=WAIT_REQ and response_req='1' then
                response_param_reg <= response_param_in;
            end if;
        end if;
    end process;

    tableOut.tag <= response_param_reg.appId;

    send_data <= '1' when response_param_reg.txMode=THROUGH_HERMES and response_param_reg.hermesService=IO_DELIVERY_SERVICE else '0';

    --------------------------------------------
    -- WARNING PARAM REGISTER AND ACKNOWLEDGE --
    --------------------------------------------

    WarningParamRegister: process(clock)
    begin
        if rising_edge(clock) then
            if state=WAIT_REQ and warning_req='1' then
                warning_param_reg <= warning_param;
            end if;
        end if;
    end process;

    AknowledgeWarningRequest: process(clock, reset)
    begin
        if reset='1' then
            warning_ack <= '0';
        elsif rising_edge(clock) then
            if state=WAIT_REQ and warning_req='1' then
                warning_ack <= '1';
            elsif state=BUILD_WARNING and warning_req='0' then
                warning_ack <= '0';
            end if;
        end if;
    end process;

    ----------------------------
    -- OUTPUT FLIT GENERATION --
    ----------------------------

    FixedHeaderCounter: process(clock, reset)
    begin
        if reset='1' then
            fixed_header_flit <= 0;
        elsif rising_edge(clock) then
            if state=WAIT_REQ then
                fixed_header_flit <= 0;
            elsif state=HERMES_FIXED_HEADER and hermes_credit_in='1' then
                fixed_header_flit <= fixed_header_flit + 1;
            end if;
        end if;
    end process;

    fixed_header_end <= '1' when fixed_header_flit=FIXED_HEADER_SIZE-1 else '0';

    PathCounter: process(clock, reset)
    begin
        if reset='1' then
            path_flit <= 0;
        elsif rising_edge(clock) then
            if state=WAIT_REQ then
                path_flit <= 0;
            elsif state=HERMES_PATH and hermes_credit_in='1' then
                path_flit <= path_flit + 1;
            end if;
        end if;
    end process;

    tableOut.pathFlit_idx <= path_flit;

    path_end <= '1' when path_flit=tableIn.pathSize else '0';

    HeaderCounter: process(clock, reset)
    begin
        if reset='1' then
            header_flit <= 0;
        elsif rising_edge(clock) then
            if state=WAIT_REQ then
                header_flit <= 0;
            elsif (state=HERMES_HEADER or state=BUILD_WARNING) and hermes_credit_in='1' then
                header_flit <= header_flit + 1;
            end if;
        end if;
    end process;

    header_end <= '1' when header_flit=DYNAMIC_HEADER_SIZE-1 else '0';
    warning_end <= '1' when header_flit=FULL_HEADER_SIZE-1 else '0';

    FlitGenerator: process(state, fixed_header_flit, path_flit, header_flit, tableIn, data_flit_ready, response_param_reg, buffer_rdata)
    begin

        ---- FIXED HEADER ----

        if state=HERMES_FIXED_HEADER then

            if fixed_header_flit=0 then
                -- hermes_data_out <= x"6021";
                hermes_data_out <= x"6" & (tableIn.key1(11 downto 0) xor tableIn.key2(11 downto 0)); -- src
            else
                hermes_data_out <= response_param_reg.target;
            end if;

        ---- PATH ----

        elsif state=HERMES_PATH then

            -- for NONSECURE applications:
            -- path(0) contains XY/YX header used as the first routing flit
            -- the second routing flit should be the target address

            if path_flit=1 and nonsecure='1' then
                hermes_data_out <= response_param_reg.target;
            else
                hermes_data_out <= tableIn.pathFlit;
            end if;
        
        ---- HEADER ----

        elsif state=HERMES_HEADER then

            if response_param_reg.hermesService=IO_DELIVERY_SERVICE then

                if header_flit=PACKET_SIZE_FLIT_HI+1 then
                    hermes_data_out <= conv_std_logic_vector(DEFAULT_WORDS_PER_DELIVERY + 11, hermes_data_out'length);
                
                elsif header_flit=F1_FLIT then
                    hermes_data_out <= tableIn.key1 xor tableIn.key2;
                
                elsif header_flit=F2_FLIT then
                    hermes_data_out <= response_param_reg.appId xor tableIn.key2;

                elsif header_flit=SERVICE_FLIT_HI then
                    hermes_data_out <= IO_DELIVERY_SERVICE(TAM_WORD-1 downto TAM_FLIT);

                elsif header_flit=SERVICE_FLIT_HI+1 then
                    hermes_data_out <= IO_DELIVERY_SERVICE(TAM_FLIT-1 downto 0);

                -- elsif header_flit=SERVICE_FLIT_HI_TX then
                --     hermes_data_out <= IO_DELIVERY_SERVICE(TAM_WORD-1 downto TAM_FLIT);

                -- elsif header_flit=SERVICE_FLIT_HI_TX+1 then
                --     hermes_data_out <= IO_DELIVERY_SERVICE(TAM_FLIT-1 downto 0);
                  
                elsif header_flit=TASK_ID_FLIT_HI then
                    hermes_data_out <= response_param_reg.taskId(TAM_WORD-1 downto TAM_FLIT);
                
                elsif header_flit=TASK_ID_FLIT_HI+1 then
                    hermes_data_out <= response_param_reg.taskId(TAM_FLIT-1 downto 0);

                elsif header_flit=PACKET_SOURCE_FLIT then
                    hermes_data_out <= response_param_reg.source;

                elsif header_flit=DELIVERY_SIZE_FLIT then
                    hermes_data_out <= conv_std_logic_vector(DEFAULT_WORDS_PER_DELIVERY, hermes_data_out'length);
    
                else
                    hermes_data_out <= x"0000";
                end if;

            elsif response_param_reg.hermesService=IO_ACK_SERVICE then

                if header_flit=PACKET_SIZE_FLIT_HI+1 then
                    hermes_data_out <= conv_std_logic_vector(11, hermes_data_out'length);

                elsif header_flit=F1_FLIT then
                    hermes_data_out <= tableIn.key1 xor tableIn.key2;
                
                elsif header_flit=F2_FLIT then
                    hermes_data_out <= response_param_reg.appId xor tableIn.key2;
                
                elsif header_flit=SERVICE_FLIT_HI then
                    hermes_data_out <= IO_ACK_SERVICE(TAM_WORD-1 downto TAM_FLIT);
                
                elsif header_flit=SERVICE_FLIT_HI+1 then
                    hermes_data_out <= IO_ACK_SERVICE(TAM_FLIT-1 downto 0);
                
                elsif header_flit=TASK_ID_FLIT_HI then
                    hermes_data_out <= response_param_reg.taskId(TAM_WORD-1 downto TAM_FLIT);
                
                elsif header_flit=TASK_ID_FLIT_HI+1 then
                    hermes_data_out <= response_param_reg.taskId(TAM_FLIT-1 downto 0);

                elsif header_flit=PACKET_SOURCE_FLIT then
                    hermes_data_out <= response_param_reg.source;

                else
                    hermes_data_out <= x"0000";
                end if;

            else
                hermes_data_out <= x"0000";
            end if;

        ---- DATA PAYLOAD ----

        elsif state=DATA_PAYLOAD then

            if data_flit_ready='1' then
                hermes_data_out <= buffer_rdata;
            else
                hermes_data_out <= x"0000";
            end if;
        
        elsif state=BUILD_WARNING then

            -- flit positions are offsetted from HERMES_HEADER because packet headers are also considered here
        
            -- fixed header

            if header_flit=0 then
                hermes_data_out <= x"0" & mpe_routing_header(TAM_WORD-5 downto TAM_FLIT); -- Hardcode begining of flit to XY (not actually used for routing)
            elsif header_flit=1 then
                hermes_data_out <= mpe_routing_header(TAM_FLIT-1 downto 0);
            
            -- routing header

            elsif header_flit=2 then
                hermes_data_out <= mpe_routing_header(TAM_WORD-1 downto TAM_FLIT);
            elsif header_flit=3 then
                hermes_data_out <= mpe_routing_header(TAM_FLIT-1 downto 0);

            -- packet size

            elsif header_flit=5 then
                hermes_data_out <= x"000B"; -- no payload: 11 words

            -- service

            elsif header_flit=6 then
                hermes_data_out <= IO_WARNING_SERVICE(TAM_WORD-1 downto TAM_FLIT);
            elsif header_flit=7 then
                hermes_data_out <= IO_WARNING_SERVICE(TAM_FLIT-1 downto 0);

            -- warning code

            elsif header_flit=9 then

                if warning_param_reg.warning_type=ABNORMAL_PERIPHERAL then
                    hermes_data_out <= ABNORMAL_PERIPH_CODE;

                elsif warning_param_reg.warning_type=OVERWRITTEN_ROW then
                    hermes_data_out <= OVERWRITTEN_ROW_CODE;

                elsif warning_param_reg.warning_type=WRITE_ON_FULL_TABLE then
                    hermes_data_out <= WRITE_ON_FULL_TABLE_CODE;
                
                elsif warning_param_reg.warning_type=FAILED_AUTHENTICATION then
                    hermes_data_out <= FAILED_AUTH_CODE;
                
                end if;
            
            -- snip id

            elsif header_flit=11 then
                hermes_data_out <= SNIP_ID;
            
            -- packet source

            elsif header_flit=13 and (warning_param_reg.warning_type=OVERWRITTEN_ROW or warning_param_reg.warning_type=WRITE_ON_FULL_TABLE or warning_param_reg.warning_type=FAILED_AUTHENTICATION) then
                hermes_data_out <= warning_pkt_source;
            
            -- f1/f2

            elsif header_flit=14 and (warning_param_reg.warning_type=OVERWRITTEN_ROW or warning_param_reg.warning_type=WRITE_ON_FULL_TABLE or warning_param_reg.warning_type=FAILED_AUTHENTICATION) then
                hermes_data_out <= warning_f1;
            elsif header_flit=15 and (warning_param_reg.warning_type=OVERWRITTEN_ROW or warning_param_reg.warning_type=WRITE_ON_FULL_TABLE or warning_param_reg.warning_type=FAILED_AUTHENTICATION) then
                hermes_data_out <= warning_f2; 
            
            -- overwritten line index

            elsif header_flit=17 and (warning_param_reg.warning_type=OVERWRITTEN_ROW) then
                hermes_data_out <= conv_std_logic_vector(warning_slot_index, hermes_data_out'length);

            else
                hermes_data_out <= x"0000";
            end if;

        ---- DEFAULT OUTPUT ----

        else

            hermes_data_out <= x"0000";

        end if;

    end process;

    ---------------
    -- READ DATA --
    ---------------

    NewDataFlitRegister: process(clock, reset)
    begin
        if reset='1' then
            data_flit_ready <= '0';
        elsif rising_edge(clock) and data_flit_blocked='0' then
            data_flit_ready <= buffer_ren;
        end if;
    end process;

    DecrementWordsToRead: process(clock, reset)
    begin
        if reset='1' then
            data_flit_low <= '0';
            data_words_to_read <= DEFAULT_WORDS_PER_DELIVERY;
        elsif rising_edge(clock) then
            if state=WAIT_REQ then
                data_flit_low <= '0';
                data_words_to_read <= DEFAULT_WORDS_PER_DELIVERY;
            elsif state=DATA_PAYLOAD and buffer_ren='1' then
                data_flit_low <= not data_flit_low;
                if data_flit_low='1' then
                    data_words_to_read <= data_words_to_read - 1;
                end if;
            end if;
        end if;
    end process;

    last_data_flit <= '1' when data_words_to_read=0 else '0';

    data_flit_blocked <= data_flit_ready and not data_tx;

    buffer_ren <= '1' when state=DATA_PAYLOAD and buffer_empty='0' and data_flit_blocked='0' and last_data_flit='0' else '0';

    ---------------------------------
    -- HERMES TRANSMISSION CONTROL --
    ---------------------------------

    header_tx   <= hermes_credit_in;
    data_tx     <= data_flit_ready and hermes_credit_in;

    hermes_tx <=
        header_tx   when (state=HERMES_FIXED_HEADER or state=HERMES_PATH or state=HERMES_HEADER or state=BUILD_WARNING) else
        data_tx     when (state=DATA_PAYLOAD)                                                                           else
        '0';

    header_eop      <= '1' when state=HERMES_HEADER and header_end='1' and send_data='0' else '0';
    data_eop        <= data_flit_ready and last_data_flit;
    warning_eop     <= '1' when state=BUILD_WARNING and warning_end='1' else '0';

    hermes_eop_out <=
        header_eop  when (state=HERMES_HEADER)  else
        data_eop    when (state=DATA_PAYLOAD)   else
        warning_eop when (state=BUILD_WARNING)  else
        '0';

    hermes_bop_out <= '1' when (state=HERMES_FIXED_HEADER and fixed_header_flit=0) or(state=BUILD_WARNING and header_flit=0) else '0';

    -----------------------
    -- GENERATE WARNINGS --
    -----------------------

    warn_excessive_data <= '1' when state=CHECK_BUFFER and buffer_empty='0' else '0';
    
    buffer_flush <= '1' when state=CHECK_BUFFER else '0';

    buffer_enable_sig <= '1' when state=DATA_PAYLOAD else '0';
    buffer_enable <= buffer_enable_sig;

end architecture;
