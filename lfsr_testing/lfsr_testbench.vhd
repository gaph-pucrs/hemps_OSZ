library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.snip_pkg.all;

entity testbench is
end entity;

architecture testbench of testbench is

    signal clock        : std_logic := '1';
    signal reset        : std_logic;

    -- inputs

    signal request      : std_logic;
    signal appID        : regN_appID;
    signal n, p         : regN_keyParam;

    -- outputs

    signal busy, ready  : std_logic;
    signal k1, k2       : regN_keyPeriph;

    -- key generation params

    type ArrayAppID     is array(0 to 15) of regN_appID;
    type ArrayKeyParam  is array(0 to 15) of regN_keyParam;

    signal appID_list : ArrayAppID :=
    (
        x"0001", x"0000", x"0000", x"0000",
        x"0000", x"0000", x"0000", x"0000",
        x"0000", x"0000", x"0000", x"0000",
        x"0000", x"0000", x"0000", x"0000"
    );

    signal n_list : ArrayKeyParam :=
    (
        x"10", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00"
    );

    signal p_list : ArrayKeyParam :=
    (
        x"10", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00",
        x"00", x"00", x"00", x"00"
    );

    signal param_index      : integer range 0 to 15;

    -- fsm

    type StateType is (IDLE, RAISE_REQUEST, PROCESSING, DROP_REQUEST);
    signal state, next_state : StateType;

begin

    clock <= not clock after 5 ns;
    reset <= '1', '0' after 50 ns;

    KeyGenerator: entity work.snip_key_generator
    port map
    (
        clock   => clock,
        reset   => reset,
    
        request => request,
        appID   => appID,
        n       => n,
        p       => p,

        busy    => busy,
        ready   => ready,
        k1      => k1,
        k2      => k2
    );

    ChangeState: process(reset, clock)
    begin
        if reset='1' then
            state <= IDLE;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    NextState: process(state, busy, ready)
    begin
        case state is
            
            when IDLE =>

                next_state <= RAISE_REQUEST;
            
            when RAISE_REQUEST =>

                if busy='1' then
                    next_state <= PROCESSING;
                else
                    next_state <= RAISE_REQUEST;
                end if;
            
            when PROCESSING =>

                if ready='1' then
                    next_state <= DROP_REQUEST;
                else
                    next_state <= PROCESSING;
                end if;
            
            when DROP_REQUEST =>

                if busy='0' then
                    next_state <= RAISE_REQUEST;
                else
                    next_state <= DROP_REQUEST;
                end if;

        end case;
    end process;

    request <= '1' when state=RAISE_REQUEST or state=PROCESSING else '0';

    ChangeParams: process(reset, clock)
    begin
        if reset='1' then
            param_index <= 0;
        elsif rising_edge(clock) and state=DROP_REQUEST and busy='0' then
            
            -- transition from DROP_REQUEST to RAISE_REQUEST - next params
            
            if param_index=15 then
                param_index <= 0;
            else    
                param_index <= param_index + 1;
            end if;

        end if;
    end process;
    
    appID   <= appID_list(param_index);
    n       <= n_list(param_index);
    p       <= p_list(param_index);

end architecture;
