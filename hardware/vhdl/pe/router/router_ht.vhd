library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all; 
use work.hemps_pkg.all; 

entity router_ht is
    port
    (
        clock           : in    std_logic;
        reset           : in    std_logic;

        router_tx       : in    std_logic;
        router_clock_tx : in    std_logic;
        router_data_out : in    regflit;
        router_eop_out  : in    std_logic;
        router_cred_in  : out   std_logic;

        ht_tx           : out   std_logic;
        ht_clock_tx     : out   std_logic;
        ht_data_out     : out   regflit;
        ht_eop_out      : out   std_logic;
        ht_cred_in      : in    std_logic
    );
end entity;

architecture router_ht_harmless of router_ht is
begin
    ht_tx           <= router_tx;
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    ht_eop_out      <= router_eop_out;
    router_cred_in  <= ht_cred_in;
end architecture;

architecture router_ht_blackhole of router_ht is
begin
    ht_tx           <= '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    ht_eop_out      <= router_eop_out;
    router_cred_in  <= ht_cred_in;
end architecture;

architecture router_ht_blackhole_300us of router_ht is
    constant trigger_time : integer := 30000; -- 300 us = 300 000 ns = 30 000 cc 

    signal activated    : std_logic;
    signal counter      : integer;
begin
    
    ht_tx           <= router_tx when activated='0' else '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    router_cred_in  <= ht_cred_in;
    ht_eop_out      <= router_eop_out;
    
    ClockCounter: process(clock, reset)
    begin
        if reset='1' then
            counter <= 0;
        elsif rising_edge(clock) then
            if counter/=trigger_time then
                counter <= counter + 1;
            end if;
        end if;
    end process;

    activated <= '1' when counter=trigger_time else '0';

end architecture;

architecture router_ht_blackhole_2ms of router_ht is
    constant trigger_time : integer := 200000; -- 2 000 us = 2 000 000 ns = 200 000 cc 

    signal activated    : std_logic;
    signal counter      : integer;
begin
    
    ht_tx           <= router_tx when activated='0' else '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    router_cred_in  <= ht_cred_in;
    ht_eop_out      <= router_eop_out;
    
    ClockCounter: process(clock, reset)
    begin
        if reset='1' then
            counter <= 0;
        elsif rising_edge(clock) then
            if counter/=trigger_time then
                counter <= counter + 1;
            end if;
        end if;
    end process;

    activated <= '1' when counter=trigger_time else '0';

end architecture;

architecture router_ht_blackhole_300us_to_1950us of router_ht is
    constant activate_time      : integer := 30000;     --   300 us =   300 000 ns =  30 000 cc
    constant deactivate_time    : integer := 195000;    -- 1 950 us = 1 950 000 ns = 195 000 cc 

    signal activated    : std_logic;
    signal counter      : integer;
begin
    
    ht_tx           <= router_tx when activated='0' else '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    router_cred_in  <= ht_cred_in;
    ht_eop_out      <= router_eop_out;
    
    ClockCounter: process(clock, reset)
    begin
        if reset='1' then
            counter <= 0;
        elsif rising_edge(clock) then
            if counter/=deactivate_time then
                counter <= counter + 1;
            end if;
        end if;
    end process;

    AvtivateRegister: process(clock, reset)
    begin
        if reset='1' then
            activated <= '0';
        elsif rising_edge(clock) then
            if counter=activate_time then
                activated <= '1';
            elsif counter=deactivate_time then
                activated <= '0';
            end if;
        end if;
    end process;

end architecture;

architecture router_ht_intermittent of router_ht is

    constant COUNTER_LENGTH     : integer := 16;
    constant LFSR_FIXED_TURNS   : integer := 8;
    constant LFSR_POLYNOMIAL    : std_logic_vector(COUNTER_LENGTH-1 downto 0) := x"D008";
    constant LFSR_SEED          : std_logic_vector(COUNTER_LENGTH-1 downto 0) := x"ABBA";

    type StateType is (GEN_DISABLED_TIME, DISABLED, GEN_ENABLED_TIME, ENABLED);
    signal state        : StateType;
    signal next_state   : StateType;

    signal counter      : std_logic_vector(COUNTER_LENGTH-1 downto 0);
    signal lfsr         : std_logic_vector(COUNTER_LENGTH-1 downto 0);
    signal lfsr_mask    : std_logic_vector(COUNTER_LENGTH-1 downto 0);

    signal credit_mask : std_logic;

begin

    ht_tx           <= router_tx;
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    ht_eop_out      <= router_eop_out;
    router_cred_in  <= ht_cred_in and credit_mask;

    credit_mask <= '0' when (state=ENABLED or state=GEN_DISABLED_TIME) else '1';

    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= GEN_DISABLED_TIME;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    NextStateLogic: process(state, counter)
    begin
        case state is

            when GEN_DISABLED_TIME =>

                if counter=0 then
                    next_state <= DISABLED;
                else
                    next_state <= GEN_DISABLED_TIME;
                end if;
            
            when DISABLED =>

                if counter=0 then
                    next_state <= GEN_ENABLED_TIME;
                else
                    next_state <= DISABLED;
                end if;
            
            when GEN_ENABLED_TIME =>

                if counter=0 then
                    next_state <= ENABLED;
                else
                    next_state <= GEN_ENABLED_TIME;
                end if;

            when ENABLED =>

                if counter=0 then
                    next_state <= GEN_DISABLED_TIME;
                else
                    next_state <= ENABLED;
                end if;
        
        end case;
    end process;

    Countdown: process(clock, reset)
    begin
        if reset='1' then
            counter <= conv_std_logic_vector(LFSR_FIXED_TURNS, counter'length);
        elsif rising_edge(clock) then 

            -- set counter for next state
            if counter=0 then
                if state=GEN_DISABLED_TIME or state=GEN_ENABLED_TIME then
                    counter <= lfsr;
                elsif state=DISABLED or state=ENABLED then
                    counter <= conv_std_logic_vector(LFSR_FIXED_TURNS, counter'length);
                end if;
            
            -- decrement counter
            else
                counter <= counter - 1;
            end if;

        end if;
    end process;

    GenMaskLFSR: for k in COUNTER_LENGTH-1 downto 0 generate
        lfsr_mask(k) <= lfsr_polynomial(k) and lfsr(0);
    end generate;

    ShiftLFSR: process(clock, reset)
    begin
        if reset ='1' then
            lfsr <= LFSR_SEED;
        elsif rising_edge(clock) then
            if state=GEN_DISABLED_TIME or state=GEN_ENABLED_TIME then
                lfsr <= ('0' & lfsr(COUNTER_LENGTH-1 downto 1)) xor lfsr_mask;
            end if;
        end if;
    end process;
            
end architecture;

architecture router_ht_credit_block of router_ht is
begin
    ht_tx           <= router_tx;
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    ht_eop_out      <= router_eop_out;
    router_cred_in  <= '0';
end architecture;

architecture router_ht_credit_block_counter of router_ht is
    constant trigger_time : integer := 62873; -- 628.725 us = 628 725 ns = 62 873 cc 

    signal activated    : std_logic;
    signal counter      : integer;
begin
    
    ht_tx           <= router_tx when activated='0' else '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    router_cred_in  <= ht_cred_in;
    ht_eop_out      <= router_eop_out;
    
    ClockCounter: process(clock, reset)
    begin
        if reset='1' then
            counter <= 0;
        elsif rising_edge(clock) then
            if counter/=trigger_time then
                counter <= counter + 1;
            end if;
        end if;
    end process;

    activated <= '1' when counter=trigger_time else '0';

end architecture;


architecture router_ht_packet_injector of router_ht is
    
    constant packet_size    : integer := 10;
    constant trigger_time   : integer := 59040; -- 590.400 us = 590 400 ns = 59 040 cc 

    type StateType is (SLEEPING, SENDING, FINISHED);
    signal state            : StateType;
    signal next_state       : StateType;

    signal trigger_counter  : integer;
    signal flit_counter     : integer;

    type PacketType is array(0 to packet_size-1) of regflit;
    signal packet_flits     : PacketType;
    signal current_flit     : regflit;

    signal mal_tx           : std_logic;
    signal mal_data         : regflit;
    signal mal_eop          : std_logic;
    signal mal_cred         : std_logic;

begin
    
    ht_clock_tx     <= router_clock_tx;
    ht_tx           <= mal_tx   when state=SENDING else router_tx;
    ht_data_out     <= mal_data when state=SENDING else router_data_out;
    ht_eop_out      <= mal_eop  when state=SENDING else router_eop_out;
    router_cred_in  <= mal_cred when state=SENDING else ht_cred_in;

    mal_tx <= '1' when state=SENDING and ht_cred_in='1' else '0';
    mal_data <= current_flit;
    mal_eop <= '0';
    mal_cred <= '0';
    
    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= SLEEPING;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    NextStateLogic: process(state, trigger_counter, flit_counter, mal_tx)
    begin
        case state is

            when SLEEPING =>

                if trigger_counter = trigger_time then
                    next_state <= SENDING;
                else
                    next_state <= SLEEPING;
                end if;

            when SENDING =>

                if flit_counter=(packet_size-1) and mal_tx='1' then
                    next_state <= FINISHED;
                else
                    next_state <= SENDING;
                end if;
            
            when FINISHED =>

                next_state <= FINISHED;
        
        end case;
    end process;

    TriggerCounter: process(clock, reset)
    begin
        if reset='1' then
            trigger_counter <= 0;
        elsif rising_edge(clock) and state=SLEEPING then
            if trigger_counter/=trigger_time then
                trigger_counter <= trigger_counter + 1;
            end if;
        end if;
    end process;

    FlitCounter: process(clock, reset)
    begin
        if reset='1' then
            flit_counter <= 0;
        elsif rising_edge(clock) and state=SENDING and mal_tx='1' then
            if flit_counter/=packet_size then
                flit_counter <= flit_counter + 1;
            end if;
        end if;
    end process;

    SelectCurrentFlit: process(flit_counter)
    begin
        if flit_counter<0 or flit_counter>=packet_size then
            current_flit <= x"0000";
        else
            current_flit <= packet_flits(flit_counter);
        end if;
    end process; 

    -- header 1
    packet_flits(0) <= x"0000";
    packet_flits(1) <= x"0202";

    -- header 2
    packet_flits(2) <= x"0000";
    packet_flits(3) <= x"0202";

    -- packet size
    packet_flits(4) <= x"0000";
    packet_flits(5) <= x"0015";

    -- service
    packet_flits(6) <= x"0000";
    packet_flits(7) <= x"0020";

    packet_flits(8) <= x"0000";
    packet_flits(9) <= x"0000";

end architecture;

architecture router_ht_credit_block_563us_to_590us of router_ht is
    constant activate_time      : integer := 56397; -- 563.970 us = 563 970 ns = 56 397 cc 
    constant deactivate_time    : integer := 59000;

    signal activated    : std_logic;
    signal counter      : integer;
begin
    
    ht_tx           <= router_tx;
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    router_cred_in  <= ht_cred_in when activated='0' else '0';
    ht_eop_out      <= router_eop_out;
    
    ClockCounter: process(clock, reset)
    begin
        if reset='1' then
            counter <= 0;
        elsif rising_edge(clock) then
            if counter/=deactivate_time then
                counter <= counter + 1;
            end if;
        end if;
    end process;

    AvtivateRegister: process(clock, reset)
    begin
        if reset='1' then
            activated <= '0';
        elsif rising_edge(clock) then
            if counter=activate_time then
                activated <= '1';
            elsif counter=deactivate_time then
                activated <= '0';
            end if;
        end if;
    end process;

end architecture;
