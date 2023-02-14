library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.snip_pkg.all;

entity snip_key_generator is
    port
    (
        clock   : in    std_logic;
        reset   : in    std_logic;

        request : in    std_logic;
        appID   : in    regN_appID;
        n, p    : in    regN_keyParam;

        busy    : out   std_logic;
        ready   : out   std_logic;
        k1, k2  : out   regN_keyPeriph
    );
end entity;

architecture snip_key_generator of snip_key_generator is

    -----------------
    -- FSM Signals --
    -----------------

    type stateType is (IDLE, INIT_K1, GEN_K1, INIT_K2, GEN_K2, KEYS_READY);
    signal state, next_state : stateType;

    ------------------
    -- LFSR Signals --
    ------------------
    
    signal shift_lfsr       : std_logic;
    signal w_seed           : std_logic;
    signal lfsr_seed        : regN_lfsr;
    signal lfsr_output      : regN_lfsr;

    signal generated_key    : regN_keyPeriph;

    signal shift_counter    : regN_keyParam;
    signal key_is_ready     : std_logic;

    ----------------------------
    -- Registers and Counters --
    ----------------------------

begin

    ---------
    -- FSM --
    ---------

    changeState: process(reset, clock)
    begin
        if reset='1' then
            state <= IDLE;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    nextStateLogic: process(state, request, key_is_ready, n, p)
    begin
        case state is

            when IDLE =>

                if request='1' then
                    next_state <= INIT_K1;
                else
                    next_state <= IDLE;
                end if;
            
            when INIT_K1 =>

                if n=x"00" then
                    next_state <= INIT_K2; -- no shifts required
                else
                    next_state <= GEN_K1;
                end if;

            when GEN_K1 =>

                if key_is_ready='1' then
                    next_state <= INIT_K2;
                else
                    next_state <= GEN_K1;
                end if;
            
            when INIT_K2 =>

                if p=x"00" then
                    next_state <= KEYS_READY; -- no shifts required
                else
                    next_state <= GEN_K2;
                end if;

            when GEN_K2 =>
                
                if key_is_ready='1' then
                    next_state <= KEYS_READY;
                else
                    next_state <= GEN_K2;
                end if;

            when KEYS_READY =>

                if request='0'then
                    next_state <= IDLE;
                else
                    next_state <= KEYS_READY;
                end if;

        end case;
    end process;

    ----------------------
    -- LFSR and Counter --
    ----------------------

    SnipLFSR: entity work.snip_lfsr
    port map
    (
        clock       => clock,
        reset       => reset,

        shift_en    => shift_lfsr,

        w_en        => w_seed,
        w_value     => lfsr_seed,

        o_value     => lfsr_output
    );

    shift_lfsr <= '1' when state=GEN_K1 or state=GEN_K2 else '0';

    w_seed <= '1' when state=INIT_K1 else '0';

    setSeed: process(appID)
    begin
        lfsr_seed <= (others => '0');
        lfsr_seed(APPID_SIZE-1 downto 0) <= appID;
    end process;

    generated_key <= lfsr_output(KEYPERIPH_SIZE-1 downto 0);

    countShifts: process(reset, clock)
    begin
        if reset='1' then
            shift_counter <= (others => '0');
        elsif rising_edge(clock) then
            
            if state=INIT_K1 then
                shift_counter <= n;
            
            elsif state=INIT_K2 then
                shift_counter <= p;
            
            elsif state=GEN_K1 or state=GEN_K2 then
                shift_counter <= shift_counter - 1;
            end if;

        end if;
    end process;

    key_is_ready <= '1' when shift_counter=x"01" else '0';

    -----------------
    -- OUTPUT KEYS --
    -----------------

    -- k1 is registered while k2 is beign generated
    k1Register: process(reset, clock)
    begin
        if reset='1' then
            k1 <= (others => '0');
        elsif rising_edge(clock) and state=INIT_K2 then
            k1 <= generated_key;
        end if;
    end process;

    -- k2 is outputed directly from the LFSR to avoid extra register
    k2 <= generated_key when state=KEYS_READY else (others => '0');

    ready <= '1' when state=KEYS_READY else '0';

    busy <= '1' when state/=IDLE else '0';

end architecture;
