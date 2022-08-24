library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_pkg.all;

entity ni_packet_builder is
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

    type PacketBuilderState is (WAIT_REQ, CHECK_TABLE, HERMES_FIXED_HEADER, HERMES_PATH, HERMES_HEADER, REJECT_REQUEST);

    signal state                : PacketBuilderState;
    signal next_state           : PacketBuilderState;

    ----------------------
    -- REQUEST REGISTER --
    ----------------------

    signal response_param_reg   : ResponseParametersType;

    --------------------------------------------
    -- HERMES FLIT COUNTERS (AND AUX) SIGNALS --
    --------------------------------------------
    
    signal fixed_header_flit    : integer range 0 to FIXED_HEADER_SIZE;
    signal path_flit            : integer range 0 to MAX_PATH_FLITS;
    signal header_flit          : integer range 0 to DYNAMIC_HEADER_SIZE;

    signal fixed_header_end     : std_logic;
    signal path_end             : std_logic;
    signal header_end           : std_logic;

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

    NextState: process(state, response_req, response_param_reg, tableIn, fixed_header_end, path_end, header_end)
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

                if fixed_header_end='1' then
                    next_state <= HERMES_PATH;
                else
                    next_state <= HERMES_FIXED_HEADER;
                end if;

            when HERMES_PATH =>

                if path_end='1' then
                    next_state <= HERMES_HEADER;
                else
                    next_state <= HERMES_PATH;
                end if;

            when HERMES_HEADER =>

                if header_end='1' then
                    next_state <= WAIT_REQ;
                else
                    next_state <= HERMES_HEADER;
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

    FlitGenerator: process(state, fixed_header_flit, path_flit, header_flit, tableIn)
    begin

        ---- FIXED HEADER ----

        if state=HERMES_FIXED_HEADER then

            if fixed_header_flit=0 then
                hermes_data_out <= x"0000";
            else
                hermes_data_out <= x"0000";
            end if;

        ---- PATH ----

        elsif state=HERMES_PATH then

            hermes_data_out <= tableIn.pathFlit;
        
        ---- HEADER ----

        elsif state=HERMES_HEADER then

            if header_flit=0 then
                hermes_data_out <= x"0000";
            else
                hermes_data_out <= x"0000";
            end if;

        ---- DEFAULT OUTPUT ----

        else

            hermes_data_out <= x"0000";

        end if;

    end process;

    ---------------------------------
    -- HERMES TRANSMISSION CONTROL --
    ---------------------------------

    hermes_tx <= '1' when (state=HERMES_FIXED_HEADER or state=HERMES_PATH or state=HERMES_HEADER) and hermes_credit_in='1' else '0';

    hermes_eop_out <= '1' when state=HERMES_HEADER and header_end='1' else '0';

end architecture;
