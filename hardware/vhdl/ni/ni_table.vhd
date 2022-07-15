library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.ni_pkg.all;

entity ni_table is
    port
    (
        clock           : in    std_logic;
        reset           : in    std_logic;

        -- control --

        request         : in    std_logic;
        crypto          : in    std_logic;
        new_line        : in    std_logic;
        tag             : in    regN_appID;

        ready           : out   std_logic;
        fail            : out   std_logic;
        
        full            : out   std_logic;
        
        -- rw interface --

        app_id          : out   regN_appID;
        app_id_w        : in    regN_appID;
        app_id_w_en     : in    std_logic;

        key1            : out   regN_keyPeriph;
        key1_w          : in    regN_keyPeriph;
        key1_w_en       : in    std_logic;

        key2            : out   regN_keyPeriph;
        key2_w          : in    regN_keyPeriph;
        key2_w_en       : in    std_logic;

        burst_size      : out   regN_burstSize;
        burst_size_w    : in    regN_burstSize;
        burst_size_w_en : in    std_logic;

        path_size       : out   intN_pathSize;
        path_size_w     : in    intN_pathSize;
        path_size_w_en  : in    std_logic;

        path_flit       : out   regflit;
        path_flit_w     : in    regflit;
        path_flit_w_en  : in    std_logic;
        path_flit_index : in    intN_pathIndex;

        free_slot       : in    std_logic
    );
end entity;

architecture ni_table of ni_table is

    -- table signals

    type column_appId       is array(TABLE_SIZE-1 downto 0) of regN_appID;
    type column_keyPeriph   is array(TABLE_SIZE-1 downto 0) of regN_keyPeriph;
    type column_burstSize   is array(TABLE_SIZE-1 downto 0) of regN_burstSize;
    type column_pathSize    is array(TABLE_SIZE-1 downto 0) of intN_pathSize;
    type column_path        is array(TABLE_SIZE-1 downto 0) of regN_path;

    type table_record is record
        app_id      : column_appId;
        key1        : column_keyPeriph;
        key2        : column_keyPeriph;
        burst_size  : column_burstSize;
        path_size   : column_pathSize;
        path        : column_path;
        used        : std_logic_vector(TABLE_SIZE-1 downto 0);
    end record table_record;

    signal table    : table_record;

    -- fsm signals

    type StateType is (WAITING, FETCHING, FETCHING_CRYPTO, FETCHING_NEW, READY, FAILED, SLOT_FREED);

    signal present_state    : StateType;
    signal next_state       : StateType;

    signal is_fetching      : std_logic;

    -- fetch signals

    signal match_regular    : std_logic;
    signal match_crypto     : std_logic;
    signal match_new        : std_logic;

    signal slot             : integer range 0 to TABLE_SIZE-1;
    signal reset_slot       : std_logic;
    signal enable_counter   : std_logic;
    signal slot_is_last     : std_logic;

    -- rw signals

    signal read_en          : std_logic;
    signal write_en         : std_logic;

begin

    full <= and table.used;

    ---------------
    -- TABLE FSM --
    ---------------

    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            present_state <= WAITING; 
        elsif rising_edge(clock) then
            present_state <= next_state;
        end if;
    end process;

    NextState: process(present_state, request, crypto, new_line, match, slot_is_last, free_slot)
    begin
        case present_state is

            when WAITING =>

                if request='1' then
                    if new_line='1' then
                        next_state <= FETCHING_NEW;
                    elsif crypto='1' then
                        next_state <= FETCHING_CRYPTO;
                    else
                        next_state <= FETCHING;
                    end if;
                else
                    next_state <= WAITING;
                end if;

            when FETCHING =>

                if match='1' then
                    next_state <= READY;
                elsif slot_is_last='1' then
                    next_state <= FAILED;
                else
                    next_state <= FETCHING;
                end if;
            
            when FETCHING_CRYPTO =>

                if match='1' then
                    next_state <= READY;
                elsif slot_is_last='1' then
                    next_state <= FAILED;
                else
                    next_state <= FETCHING_CRYPTO;
                end if;

            when FETCHING_NEW =>
            
                if match='1' then
                    next_state <= READY;
                elsif slot_is_last='1' then
                    next_state <= FAILED;
                else
                    next_state <= FETCHING_NEW;
                end if;
            
            when READY =>

                if request='0' then
                    next_state <= WAITING;
                elsif free_slot='0' then
                    next_state <= SLOT_FREED;
                else
                    next_state <= READY;
                end if;
            
            when FAILED =>
                
                if request='0' then
                    next_state <= WAITING;
                else
                    next_state <= FAILED;
                end if;
            
            when SLOT_FREED =>

                if request='0'then
                    next_state <= WAITING;
                else
                    next_state <= SLOT_FREED;
                end if;

        end case;
    end process;

    ready <= '1' when present_state = READY else '0';
    fail <= '1' when present_state = FAILED else '0';

    is_fetching <= '1' when present_state=FETCHING or present_state=FETCHING_CRYPTO or present_state=FETCHING_NEW else '0';

    ----------------
    -- FETCH SLOT --
    ----------------

    match_regular   <= nor (tag xor table.app_id(slot));
    match_crypto    <= nor (tag xor table.app_id(slot) xor table.key2(slot));
    match_new       <= not (table.used(slot));
    
    match <=    match_regular   when present_state = FETCHING else
                match_crypto    when present_state = FETCHING_CRYPTO else
                match_new       when present_state = FETCHING_NEW else
                '0';
    
    SlotCounter: process(clock, reset_slot, enable_counter)
    begin
        if reset_slot='1' then
            slot <= 0;
        elsif rising_edge(clock) and enable_counter='1' then
            slot <= slot + 1;
        end if;
    end process;

    reset_slot <= '1' when reset='1' or current_state=WAITING else '0';
    enable_counter <= '1' when is_fetching='1' and match='0' else '0';
    slot_is_last <= '1' when slot = TABLE_SIZE-1 else '0';

    ----------
    -- READ --
    ----------

    read_enable <= '1' when present_state = READY else '0';
    
    app_id      <= table.app_id(slot)       when read_enable='1' else (others => '0');
    key1        <= table.key1(slot)         when read_enable='1' else (others => '0');
    key2        <= table.key2(slot)         when read_enable='1' else (others => '0');
    burst_size  <= table.burst_size(slot)   when read_enable='1' else (others => '0');
    path_size   <= table.path_size(slot)    when read_enable='1' else (others => '0');

    path_flit   <= table.path(slot)(path_flit_index) when read_enable='1' else (others => '0');

    -----------
    -- WRITE --
    -----------

    write_enable <= '1' when present_state = READY else '0';

    TableWrite: process(clock, reset)
    begin
        if reset='1' then
            
            table.app_id        <= (others => (others => '0'));
            table.key1          <= (others => (others => '0'));
            table.key2          <= (others => (others => '0'));
            table.burst_size    <= (others => (others => '0'));
            table.path_size     <= (others => (others => '0'));
            table.path          <= (others => (others => (others => '0')));

        elsif rising_edge(clock) and write_enable='1' then

            if free_slot='1' then
                table.app_id(slot)      <= (others => '0');
                table.key1(slot)        <= (others => '0');
                table.key2(slot)        <= (others => '0');
                table.burst_size(slot)  <= (others => '0');
                table.path_size(slot)   <= (others => '0');
                table.path(slot)        <= (others => (others => '0'));
            else
                if app_id_w_en='1' then
                    table.app_id(slot) <= app_id_w;
                end if;d

                if key1_w_en='1' then
                    table.key1(slot) <= key1_w;
                end if;

                if key2_w_en='1' then
                    table.key2(slot) <= key2_w;
                end if;

                if burst_size_w_en='1' then
                    table.burst_size(slot) <= burst_size_w;
                end if;

                if path_size_w_en='1' then
                    table.path_size(slot) <= path_size_w;
                end if;

                if path_flit_w_en='1' then
                    table.path(slot)(path_flit_index) <= path_flit_w;
                end if;
            end if;

        end if; 
    end process;

    ManageUsedSlots: process(clock, reset)
    begin
        if reset='1' then
            table.used <= (others <= '0');
        elsif rising_edge(clock) then
            
            if present_state = FETCHING_NEW and match='1' then
                table.used(slot) <= '1';
            end if;

            if present_state = READY and free_slot='1' then
                table.used(slot) <= '0';
            end if;

        end if;
    end process;
    
end architecture;
