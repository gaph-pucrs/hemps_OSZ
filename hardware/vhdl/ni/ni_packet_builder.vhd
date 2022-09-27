library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_pkg.all;

entity ni_packet_builder is
    generic
    (
        NI_ID   : regflit
    );
    port
    (
        clock               : in    std_logic;
        reset               : in    std_logic;

        hermes_tx           : out   std_logic;
        hermes_data_out     : out   regflit;
        hermes_eop_out      : out   std_logic;
        hermes_credit_in    : in    std_logic;

        tableIn             : in    TableSecondaryOutput;
        tableOut            : out   TableSecondaryInput;

        response_req        : in    std_logic;
        response_param_in   : in    ResponseParametersType;
        status              : out   TransmissionStatusType;

        buffer_rdata        : in    regflit;
        buffer_ren          : out   std_logic;
        buffer_empty        : in    std_logic
    );
end entity;

architecture ni_packet_builder of ni_packet_builder is

    -----------------
    -- FSM SIGNALS --
    -----------------

    type PacketBuilderState is (WAIT_REQ, CHECK_TABLE, HERMES_FIXED_HEADER, HERMES_PATH, HERMES_HEADER, DATA_PAYLOAD, REJECT_REQUEST);

    signal state                : PacketBuilderState;
    signal next_state           : PacketBuilderState;

    ----------------------
    -- REQUEST REGISTER --
    ----------------------

    signal response_param_reg   : ResponseParametersType;

    ---------------------------
    -- HERMES HEADER SIGNALS --
    ---------------------------
    
    signal fixed_header_flit    : integer range 0 to FIXED_HEADER_SIZE;
    signal path_flit            : integer range 0 to MAX_PATH_FLITS;
    signal header_flit          : integer range 0 to DYNAMIC_HEADER_SIZE;

    signal fixed_header_end     : std_logic;
    signal path_end             : std_logic;
    signal header_end           : std_logic;

    signal header_tx            : std_logic;
    signal header_eop           : std_logic;

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

    NextState: process(state, response_req, response_param_reg, tableIn, fixed_header_end, path_end, header_end, data_eop, hermes_tx)
    begin
        case state is

            when WAIT_REQ =>

                if response_req='1' then
                    next_state <= CHECK_TABLE;
                else
                    next_state <= WAIT_REQ;
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
                    next_state <= WAIT_REQ;
                else
                    next_state <= DATA_PAYLOAD;
                end if;

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
    status.accepted <= '1' when state/=WAIT_REQ and state/=CHECK_TABLE and state/=REJECT_REQUEST else '0';

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
            elsif state=HERMES_HEADER and hermes_credit_in='1' then
                header_flit <= header_flit + 1;
            end if;
        end if;
    end process;

    header_end <= '1' when header_flit=DYNAMIC_HEADER_SIZE-1 else '0';

    FlitGenerator: process(state, fixed_header_flit, path_flit, header_flit, tableIn, data_flit_ready, response_param_reg, buffer_rdata)
    begin

        ---- FIXED HEADER ----

        if state=HERMES_FIXED_HEADER then

            if fixed_header_flit=0 then
                hermes_data_out <= x"6021";
            else
                hermes_data_out <= response_param_reg.target;
            end if;

        ---- PATH ----

        elsif state=HERMES_PATH then

            hermes_data_out <= tableIn.pathFlit;
        
        ---- HEADER ----

        elsif state=HERMES_HEADER then

            if response_param_reg.hermesService=IO_DELIVERY_SERVICE then

                if header_flit=PACKET_SIZE_FLIT then
                    hermes_data_out <= conv_std_logic_vector(DEFAULT_WORDS_PER_DELIVERY + 11, hermes_data_out'length);

                elsif header_flit=SERVICE_FLIT then
                    hermes_data_out <= IO_DELIVERY_SERVICE(TAM_WORD-1 downto TAM_FLIT);

                elsif header_flit=SERVICE_FLIT+1 then
                    hermes_data_out <= IO_DELIVERY_SERVICE(TAM_FLIT-1 downto 0);

                elsif header_flit=IO_DELIVERY_SERVICE_PERPH_ID_FLIT then
                    hermes_data_out <= NI_ID;

                elsif header_flit=IO_DELIVERY_SERVICE_TASK_ID_FLIT then
                    hermes_data_out <= response_param_reg.appId; -- using task granularity for now

                elsif header_flit=IO_DELIVERY_SERVICE_PE_SRC_FLIT then
                    hermes_data_out <= response_param_reg.source;

                elsif header_flit=IO_DELIVERY_SERVICE_PAYLD_SZ_FLIT then
                    hermes_data_out <= conv_std_logic_vector(DEFAULT_WORDS_PER_DELIVERY, hermes_data_out'length);

                else
                    hermes_data_out <= x"0000";
                end if;

            elsif response_param_reg.hermesService=IO_ACK_SERVICE then

                if header_flit=PACKET_SIZE_FLIT then
                    hermes_data_out <= conv_std_logic_vector(11, hermes_data_out'length);
                
                elsif header_flit=SERVICE_FLIT then
                    hermes_data_out <= IO_ACK_SERVICE(TAM_WORD-1 downto TAM_FLIT);
                
                elsif header_flit=SERVICE_FLIT+1 then
                    hermes_data_out <= IO_ACK_SERVICE(TAM_FLIT-1 downto 0);

                elsif header_flit=IO_ACK_SERVICE_TASK_ID_FLIT then
                    hermes_data_out <= response_param_reg.appId;

                elsif header_flit=IO_ACK_SERVICE_PERPH_ID_FLIT then
                    hermes_data_out <= NI_ID;

                elsif header_flit=IO_ACK_SERVICE_PE_SRC_FLIT then
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
        header_tx   when (state=HERMES_FIXED_HEADER or state=HERMES_PATH or state=HERMES_HEADER)    else
        data_tx     when (state=DATA_PAYLOAD)                                                       else
        '0';

    header_eop      <= '1' when state=HERMES_HEADER and header_end='1' and send_data='0' else '0';
    data_eop        <= data_flit_ready and last_data_flit;

    hermes_eop_out  <= header_eop when (state=HERMES_HEADER) else data_eop when (state=DATA_PAYLOAD) else '0';

end architecture;
