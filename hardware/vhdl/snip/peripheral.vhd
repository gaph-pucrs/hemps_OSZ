library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;

entity peripheral is
    port
    (
        clock               : in    std_logic;
        reset               : in    std_logic;

        r_en                : out   std_logic;
        data_in             : in    regflit;
        r_buffer_empty      : in    std_logic; -- snip's output buffer is empty
        
        w_en                : out   std_logic;
        data_out            : out   regflit;
        w_buffer_full       : in    std_logic; -- snip's input buffer is full
        w_buffer_empty      : in    std_logic; -- snip's input buffer is empty
        w_buffer_enable     : in    std_logic  -- snip's input buffer is accepting data
    );
end entity;

architecture real_peripheral of peripheral is

    constant MAX_REQ_SIZE : integer := 256;


    signal flits_available : std_logic;
    signal req_size_int : integer range 0 to MAX_REQ_SIZE;

    type StateType is (WAIT_REQ, SIMULATE_DELAY, RECEIVE_HEADER, REGISTER_LAST_HEADER_FLIT, RECEIVE_DATA, WAIT_W_BUFFER_EMPTY, SEND_DATA);
    signal state, next_state: StateType;

    constant DELAY_TO_PROCESS_REQUEST : integer := 15;
    signal delay_counter : integer range 0 to DELAY_TO_PROCESS_REQUEST;

    constant IO_HEADER_SIZE : integer := 6;
    constant WRITE_OPERATION : std_logic_vector := x"2020";
    constant READ_OPERATION : std_logic_vector := x"1010";

    signal header_flits_counter : integer range 0 to IO_HEADER_SIZE;
    signal req_operation, req_addr, req_size : std_logic_vector(15 downto 0);
    signal reading_last_header_flit : std_logic;

    signal received_flits_counter : integer range 0 to MAX_REQ_SIZE;
    signal receiving_last_flit : std_logic;
    signal sent_flits_counter : integer range 0 to MAX_REQ_SIZE;
    signal sending_last_flit : std_logic;
    
begin

    flits_available <= not r_buffer_empty;
    req_size_int <= conv_integer(unsigned(req_size));

    w_en <= '1' when (state=SEND_DATA and w_buffer_full='0' and w_buffer_enable='1') else '0';
    r_en <= '1' when ((state=RECEIVE_HEADER or state=RECEIVE_DATA) and flits_available='1') else '0';

    FSM_ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= WAIT_REQ;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    FSM_NextStateLogic: process(state, flits_available, delay_counter, reading_last_header_flit, req_operation, receiving_last_flit, sending_last_flit, w_buffer_empty)
    begin
        case state is

            when WAIT_REQ =>

                if flits_available='1' then
                    next_state <= SIMULATE_DELAY;
                else
                    next_state <= WAIT_REQ;
                end if;

            when SIMULATE_DELAY =>

                if delay_counter=(DELAY_TO_PROCESS_REQUEST-1) then
                    next_state <= RECEIVE_HEADER;
                else
                    next_state <= SIMULATE_DELAY;
                end if;

            when RECEIVE_HEADER =>

                if reading_last_header_flit='1' then
                    next_state <= REGISTER_LAST_HEADER_FLIT;
                else
                    next_state <= RECEIVE_HEADER;
                end if;
            
            when REGISTER_LAST_HEADER_FLIT =>
            
                if req_operation=READ_OPERATION then
                    next_state <= WAIT_W_BUFFER_EMPTY;
                else
                    next_state <= RECEIVE_DATA;
                end if;

            when RECEIVE_DATA =>

                if receiving_last_flit='1' then
                    next_state <= WAIT_REQ;
                else
                    next_state <= RECEIVE_DATA;
                end if;
            
            when WAIT_W_BUFFER_EMPTY =>

                if w_buffer_empty='1' then
                    next_state <= SEND_DATA;
                else
                    next_state <= WAIT_W_BUFFER_EMPTY;
                end if;

            when SEND_DATA =>

                if sending_last_flit='1' then
                    next_state <= WAIT_REQ;
                else
                    next_state <= SEND_DATA;
                end if;
            
        end case;
    end process;

    ------------------------------------------------
    -- SIMULATE DELAY TO RECEIVE INCOMING REQUEST --
    ------------------------------------------------

    CountDelay: process(clock, reset)
    begin
        if reset='1' then
            delay_counter <= 0;
        elsif rising_edge(clock) then
            
            if state=WAIT_REQ then
                delay_counter <= 0;
            elsif state=SIMULATE_DELAY then
                delay_counter <= delay_counter + 1;
            end if;
        
        end if;
    end process;

    --------------------
    -- RECEIVE HEADER --
    --------------------

    reading_last_header_flit <= '1' when (r_en='1' and header_flits_counter=IO_HEADER_SIZE-1) else '0';

    CountHeaderFlits: process(clock, reset)
    begin
        if reset='1' then
            header_flits_counter <= 0;
        elsif rising_edge(clock) then

            if state=WAIT_REQ then
                header_flits_counter <= 0;
            elsif state=RECEIVE_HEADER and r_en='1' then
                header_flits_counter <= header_flits_counter + 1;
            end if;
        
        end if;
    end process;

    RegisterRequestParameters: process(clock, reset)
    begin
        if reset='1' then
            req_operation <= x"0000";
            req_addr <= x"0000";
            req_size <= x"0000";
        elsif rising_edge(clock) then

            if state=WAIT_REQ then
                req_operation <= x"0000";
                req_addr <= x"0000";
                req_size <= x"0000";
            elsif state=RECEIVE_HEADER and r_en='1' then
            
                if header_flits_counter=2 then --requesting flit 2 (data_in is flit 1)
                    req_operation <= data_in;
                
                elsif header_flits_counter=4 then --requesting flit 4 (data_in is flit 3)
                    req_addr <= data_in;
                end if;
            
            elsif state=REGISTER_LAST_HEADER_FLIT then    
                req_size <= data_in; --(data_in is flit 5)
            end if;

        end if;
    end process;

    -------------------------------------
    -- WRITE OPERATION (RECEIVE FLITS) --
    -------------------------------------

    receiving_last_flit <= '1' when (r_en='1' and (received_flits_counter+1)=req_size_int) else '0';

    CountReceivedFlits: process(clock, reset)
    begin
        if reset='1' then
            received_flits_counter <= 0;
        elsif rising_edge(clock) then
            
            if state=WAIT_REQ then
                received_flits_counter <= 0;
            elsif state=RECEIVE_DATA and r_en='1' then
                received_flits_counter <= received_flits_counter + 1;
            end if;
        
        end if;
    end process;

    ---------------------------------
    -- READ OPERATION (SEND FLITS) --
    ---------------------------------

    sending_last_flit <= '1' when (w_en='1' and (sent_flits_counter+1)=req_size_int) else '0';

    CountSentFlits: process(clock, reset)
    begin
        if reset='1' then
            sent_flits_counter <= 0;
        elsif rising_edge(clock) then

            if state=WAIT_REQ then
                sent_flits_counter <= 0;
            elsif state=SEND_DATA and w_en='1' then
                sent_flits_counter <= sent_flits_counter + 1;
            end if;
        
        end if;
    end process;

    GenerateOutputData: process(state, sent_flits_counter)
    begin
        if state=SEND_DATA then
            data_out <= conv_std_logic_vector(sent_flits_counter, data_out'length);
        else
            data_out <= x"0000";
        end if;
    end process;
    
end architecture;

---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------

architecture dummy_peripheral of peripheral is

    constant RW_LATENCY         : integer := 2;     -- latency for the reception of each flit
    constant SEND_DELAY         : integer := 16;    -- delay to wait after sending a burst of flits
    constant OUTPUT_BURST_SIZE  : integer := 20;    -- number of flits sent in each output interaction
    constant BUFFER_SIZE        : integer := 64;

    type FlitArray is array(0 to BUFFER_SIZE-1) of regflit;

    signal buffer_in    : FlitArray;
    signal buffer_out   : FlitArray;

    signal ptr_in       : integer range 0 to BUFFER_SIZE-1;
    signal ptr_out      : integer range 0 to BUFFER_SIZE-1;

    type ReceiveState is (WAIT_REQ, WAIT_LAT, WRITE_FLIT);
    signal r_state      : ReceiveState;
    signal r_next_state : ReceiveState;
    signal lat_count_r  : integer range 0 to RW_LATENCY; 

    type SendState is (WAIT_CREDIT, SEND_FLITS, WAIT_DELAY);
    signal s_state      : SendState;
    signal s_next_state : SendState;
    signal cnt_flits_s  : integer range 0 to OUTPUT_BURST_SIZE;
    signal cnt_delay_s  : integer range 0 to SEND_DELAY;

begin

    --------------------
    -- Read from SNIP --
    --------------------

    ChangeReceiveState: process(clock, reset)
    begin
        if reset='1' then
            r_state <= WAIT_REQ;
        elsif rising_edge(clock) then
            r_state <= r_next_state;
        end if;
    end process;

    ReceiveStateLogic: process(r_state, r_buffer_empty, lat_count_r)
    begin
        case r_state is

            when WAIT_REQ =>

                if r_buffer_empty='0' then
                    r_next_state <= WAIT_LAT;
                else
                    r_next_state <= WAIT_REQ;
                end if;
            
            when WAIT_LAT =>

                if lat_count_r=RW_LATENCY then
                    r_next_state <= WRITE_FLIT;
                else
                    r_next_state <= WAIT_LAT;
                end if;
            
            when WRITE_FLIT =>

                r_next_state <= WAIT_REQ;
            
        end case;
    end process;

    CountReceiveLatency: process(clock, reset)
    begin
        if reset='1' then
            lat_count_r <= 0;
        elsif rising_edge(clock) then

            if r_state=WAIT_REQ then
                lat_count_r <= 0;

            elsif r_state=WAIT_LAT and lat_count_r/=RW_LATENCY then
                lat_count_r <= lat_count_r + 1;
            end if;

        end if;
    end process;

    r_en <= '1' when r_state=WAIT_LAT and lat_count_r=RW_LATENCY else '0';

    WriteData: process(clock, reset)
    begin
        if reset='1' then
            buffer_in <= (others => (others => '0'));
        elsif rising_edge(clock) and r_state=WRITE_FLIT then
            buffer_in(ptr_in) <= data_in;
        end if;
    end process;

    UpdatePointerIn: process(clock, reset)
    begin
        if reset='1' then
            ptr_in <= 0;
        elsif rising_edge(clock) and r_state=WRITE_FLIT then
            if ptr_in=BUFFER_SIZE-1 then
                ptr_in <= 0;
            else
                ptr_in <= ptr_in + 1;
            end if;
        end if;
    end process;

    -----------
    -- Write --
    -----------

    w_en <= '1' when s_state=SEND_FLITS and w_buffer_full='0' and w_buffer_enable='1' else '0';

    data_out <= buffer_out(ptr_out);

    SetBufferOut: process(reset)
        variable index  : integer   := 0;
        variable value  : regflit   := (others=>'1');
    begin
        if reset='1' then
            while index < BUFFER_SIZE loop
                buffer_out(index) <= value;
                index := index + 1;
                value := value - 1;
            end loop;
        end if;
    end process;

    UpdatePointerOut: process(clock, reset)
    begin
        if reset='1' then
            ptr_out <= 0;
        elsif rising_edge(clock) and w_en='1' then
            if ptr_out=BUFFER_SIZE-1 then
                ptr_out <= 0;
            else
                ptr_out <= ptr_out + 1;
            end if;
        end if;
    end process;

    ChangeSendState: process(clock, reset)
    begin
        if reset='1' then
            s_state <= WAIT_CREDIT;
        elsif rising_edge(clock) then
            s_state <= s_next_state;
        end if;
    end process;

    NextSendStateLogic: process(s_state, w_buffer_enable, cnt_flits_s, cnt_delay_s)
    begin
        case s_state is

            when WAIT_CREDIT =>

                if w_buffer_enable='1' then
                    s_next_state <= SEND_FLITS;
                else
                    s_next_state <= WAIT_CREDIT;
                end if;

            when SEND_FLITS =>

                if cnt_flits_s=OUTPUT_BURST_SIZE-1 then
                    s_next_state <= WAIT_DELAY;
                else
                    s_next_state <= SEND_FLITS;
                end if;
            
            when WAIT_DELAY =>

                if cnt_delay_s=SEND_DELAY-1 then
                    s_next_state <= WAIT_CREDIT;
                else
                    s_next_state <= WAIT_DELAY;
                end if;
            
        end case;
    end process;

    SendCounters: process(clock, reset)
    begin
        if reset='1' then
            cnt_flits_s <= 0;
            cnt_delay_s <= 0;

        elsif rising_edge(clock) then

            if s_state=WAIT_CREDIT then
                cnt_flits_s <= 0;
                cnt_delay_s <= 0;
            
            elsif s_state=SEND_FLITS and w_en='1' then
                cnt_flits_s <= cnt_flits_s + 1;
            
            elsif s_state=WAIT_DELAY then
                cnt_delay_s <= cnt_delay_s + 1;
            end if;
        
        end if;
    end process;
    
end architecture;
