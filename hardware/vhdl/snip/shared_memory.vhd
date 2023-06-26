library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity shared_memory is
    port
    (
        clock       : in    std_logic;
        reset       : in    std_logic;

        input_avail : in    std_logic;
        input_en    : out   std_logic;
        input_data  : in    std_logic_vector(15 downto 0);

        output_en   : out   std_logic;
        output_data : out   std_logic_vector(15 downto 0);
        output_full : in    std_logic;
    );
end entity;

architecture shared_memory of shared_memory is

    ----------------
    -- Parameters --
    ----------------

    constant start_delay        : integer   := 32;
    constant operation_latency  : integer   := 3;

    constant trans_size_length  : integer   := 8;   -- 0 to 255
    constant address_length     : integer   := 10;  -- 0 to 1023

    ---------------
    -- Constants --
    ---------------

    constant memory_size    : integer   := 2**address_length;

    constant read_op        : std_logic := '0';
    constant write_op       : std_logic := '1';

    -----------------
    -- FSM Signals --
    -----------------

    type state_type is (WAIT_INPUT, DELAY, SAVE_OP, SAVE_ADDR, SAVE_SIZE, GET_RFLIT, OUTPUT_RFLIT, GET_WFLIT, SAVE_WFLIT);
    signal state            : state_type;
    signal next_state       : state_type;

    -------------------
    -- Fetch Signals --
    -------------------

    signal reading_input        : std_logic;    
    
    signal fetch_header_flit    : std_logic;
    signal fetch_data_flit      : std_logic;

    --------------------
    -- Delay Counters --
    --------------------

    signal delay_counter    : integer range (0 to start_delay);
    signal latency_counter  : integer range (0 to operation_latency);

    -------------------------------
    -- Transaction Header Fields --
    -------------------------------

    signal transaction_type : std_logic;
    signal transaction_addr : std_logic_vector(address_length-1 downto 0);
    signal transaction_size : std_logic_vector(trans_size_length-1 downto 0);

    --------------------
    -- Memory Signals --
    --------------------

    signal trying_to_read   : std_logic;
    signal trying_to_write  : std_logic;

    type memory_type is array (0 to 1023) of std_logic_vector(15 downto 0);
    signal memory           : memory_type;
    signal data_read        : std_logic_vector(15 downto 0);

begin

    ---------
    -- FSM --
    ---------

    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= WAIT_INPUT;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    NextStateLogic: process(state, input_avail, reading_input, delay_counter, transaction_type, transaction_size, input_data)
    begin
        case state is
        
            when WAIT_INPUT =>

                if input_avail='1' then
                    next_state <= DELAY;
                else
                    next_state <= WAIT_INPUT;
                end if;
            
            when DELAY =>

                if delay_counter=start_delay and reading_input='1' then -- waited delay and is receiving op flit
                    next_state <= SAVE_OP;
                else
                    next_state <= DELAY;
                end if;
            
            when SAVE_OP =>
            
                if reading_input='1' then -- is receiving addr flit
                    next_state <= SAVE_ADDR;
                else
                    next_state <= SAVE_OP;
                end if;
            
            when SAVE_ADDR =>
            
                if reading_input='1' then -- is receiving size flit
                    next_state <= SAVE_SIZE;
                else
                    next_state <= SAVE_ADDR;
                end if;
             
            when SAVE_SIZE =>
            
                if input_data=0 then -- skips the transaction if size is zero
                    next_state <= WAIT_INPUT
                else
                    if transaction_type=write_op then
                        next_state <= GET_WFLIT;
                    else
                        next_state <= GET_RFLIT;
                    end if;
                end if;

            when GET_WFLIT =>

                if reading_input='1' then
                    next_state <= SAVE_WFLIT;
                else
                    next_state <= GET_WFLIT;
                end if;

            when SAVE_WFLIT =>
            
                if transaction_size=1 then
                    next_state <= WAIT_INPUT;
                else
                    next_state <= GET_WFLIT;
                end if;

            -- READ

        end case;
    end process;

    ----------------
    -- Fetch Data --
    ----------------

    reading_input <= (fetch_header_flit or fetch_data_flit) and input_avail;

    -- request header flit (op, addr, size) one cicle before it is processed
    fetch_header_flit <= '1' when (state=DELAY and delay_counter=start_delay) or state=SAVE_OP or state=SAVE_ADDR else '0';

    fetch_data_flit <= '1' when (state=GET_WFLIT and latency_counter=operation_latency) else '0';

    --------------------------------
    -- Delay and Latency Counters --
    --------------------------------

    CountStartDelay: process(clock, reset)
    begin
        if reset='1' then
            delay_counter <= 0;
        elsif rising_edge(clock) then

            if state=WAIT_INPUT then
                delay_counter <= 0;

            elsif state=DELAY then
                if delay_counter /= start_delay then
                    delay_counter <= delay_counter+1;
                end if;
            end if;

        end if;
    end process;

    CountOperationLatency: process(clock, reset)
    begin
        if reset='1' then
            latency_counter <= 0;
        elsif rising_edge(clock) then

            if state=WAIT_INPUT or state=OUTPUT_RFLIT or state=SAVE_WFLIT then
                latency_counter <= 0;

            elsif (state=GET_RFLIT and trying_to_read='1') or (state=GET_WFLIT and trying_to_write='1') then
                if latency_counter /= operation_latency then
                    latency_counter <= latency_counter+1;
                end if;
            end if;

        end if;
    end process;

    ----------------------------------------
    -- Transaction Registers and Counters --
    ----------------------------------------

    TransactioneRegisters: process(clock, reset)
    begin
        if reset='1' then
            transaction_type <= '0';
            transaction_addr <= (others => '0');
            transaction_size <= (others => '0');
        elsif rising_edge(clock) then

            if state=WAIT_INPUT then
                transaction_type <= '0';
                transaction_addr <= (others => '0');
                transaction_size <= (others => '0');

            elsif state=SAVE_OP then
                transaction_type <= input_data(0);
            
            elsif state=SAVE_ADDR then
                transaction_addr <= input_data(address_length-1 downto 0);
            
            elsif state=SAVE_SIZE then
                transaction_size <= input_data(trans_size_length-1 downto 0);
            
            elsif state=OUTPUT_RFLIT or state=SAVE_WFLIT then
                transaction_addr <= transaction_addr + 1;
                transaction_size <= transaction_size - 1;
            end if;

        end if;
    end process;

    -------------------
    -- Memory Access --
    -------------------

    trying_to_read  <= '1' when state=READING and output_full='0'   else '0';
    trying_to_write <= '1' when state=WRITING and input_avail='1'   else '0';
    
    MemoryWrite: process(clock, reset)
    begin
        if reset='1' then
            memory <= (others => x"0000");
        elsif rising_edge(clock) and state=SAVE_WFLIT then
            memory(to_integer(unsigned(transaction_addr))) <= input_data;
        end if;
    end process;

    ReadMemory: process(clock, reset)
    begin
        if reset='1' then
            data_read <= x"0000";
        elsif rising_edge(clock) then

            if state=WAIT_INPUT or state=OUTPUT_RFLIT then
                data_read <= x"0000";
            elsif state=GET_RFLIT then
                data_read <= memory(to_integer(unsigned(transaction_addr)));
            end if;
        end if;
    end process;
    
    ------------
    -- Output --
    ------------

    input_en <= reading_input;

    output_en   <= '1'          when state=OUTPUT_RFLIT else '0';
    output_data <= data_read    when state=OUTPUT_RFLIT else x"0000";

end architecture;