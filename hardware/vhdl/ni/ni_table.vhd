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
        tableIn         : in    TableInput;
        tableOut        : out   TableOutput
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

    signal state            : StateType;
    signal next_state       : StateType;

    signal is_fetching      : std_logic;

    -- fetch signals

    signal match            : std_logic;
    signal match_regular    : std_logic;
    signal match_crypto     : std_logic;
    signal match_new        : std_logic;

    signal slot             : integer range 0 to TABLE_SIZE-1;
    signal reset_slot       : std_logic;
    signal enable_counter   : std_logic;
    signal slot_is_last     : std_logic;

    -- rw signals

    signal read_enable      : std_logic;
    signal write_enable     : std_logic;

begin

    tableOut.full <= and table.used;

    ---------------
    -- TABLE FSM --
    ---------------

    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= WAITING; 
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;

    NextState: process(state, tableIn.request, tableIn.crypto, tableIn.newLine, tableIn.clearSlot, match, slot_is_last)
    begin
        case state is

            when WAITING =>

                if tableIn.request='1' then
                    if tableIn.newLine='1' then
                        next_state <= FETCHING_NEW;
                    elsif tableIn.crypto='1' then
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

                if tableIn.request='0' then
                    next_state <= WAITING;
                elsif tableIn.clearSlot='0' then
                    next_state <= SLOT_FREED;
                else
                    next_state <= READY;
                end if;
            
            when FAILED =>
                
                if tableIn.request='0' then
                    next_state <= WAITING;
                else
                    next_state <= FAILED;
                end if;
            
            when SLOT_FREED =>

                if tableIn.request='0'then
                    next_state <= WAITING;
                else
                    next_state <= SLOT_FREED;
                end if;

        end case;
    end process;

    tableOut.ready <= '1' when state = READY else '0';
    tableOut.fail <= '1' when state = FAILED else '0';

    is_fetching <= '1' when state=FETCHING or state=FETCHING_CRYPTO or state=FETCHING_NEW else '0';

    ----------------
    -- FETCH SLOT --
    ----------------

    match_regular   <= nor (tableIn.tag xor table.app_id(slot));
    match_crypto    <= nor (tableIn.tag xor table.app_id(slot) xor table.key2(slot));
    match_new       <= not (table.used(slot));
    
    match <=    match_regular   when state = FETCHING else
                match_crypto    when state = FETCHING_CRYPTO else
                match_new       when state = FETCHING_NEW else
                '0';
    
    SlotCounter: process(clock, reset_slot, enable_counter)
    begin
        if reset_slot='1' then
            slot <= 0;
        elsif rising_edge(clock) and enable_counter='1' then
            slot <= slot + 1;
        end if;
    end process;

    reset_slot <= '1' when reset='1' or state=WAITING else '0';
    enable_counter <= '1' when is_fetching='1' and match='0' and slot_is_last='0' else '0';
    slot_is_last <= '1' when slot = TABLE_SIZE-1 else '0';

    ----------
    -- READ --
    ----------

    read_enable <= '1' when state = READY else '0';
    
    tableOut.appId      <= table.app_id(slot)       when read_enable='1' else (others => '0');
    tableOut.key1       <= table.key1(slot)         when read_enable='1' else (others => '0');
    tableOut.key2       <= table.key2(slot)         when read_enable='1' else (others => '0');
    tableOut.burstSize  <= table.burst_size(slot)   when read_enable='1' else (others => '0');
    tableOut.pathSize   <= table.path_size(slot)    when read_enable='1' else 0;

    tableOut.pathFlit   <= table.path(slot)(tableIn.pathFlit_idx) when read_enable='1' else (others => '0');

    -----------
    -- WRITE --
    -----------

    write_enable <= '1' when state = READY else '0';

    TableWrite: process(clock, reset)
    begin
        if reset='1' then
            
            table.app_id        <= (others => (others => '0'));
            table.key1          <= (others => (others => '0'));
            table.key2          <= (others => (others => '0'));
            table.burst_size    <= (others => (others => '0'));
            table.path_size     <= (others => 0);
            table.path          <= (others => (others => (others => '0')));

        elsif rising_edge(clock) and write_enable='1' then

            if tableIn.clearSlot='1' then
                table.app_id(slot)      <= (others => '0');
                table.key1(slot)        <= (others => '0');
                table.key2(slot)        <= (others => '0');
                table.burst_size(slot)  <= (others => '0');
                table.path_size(slot)   <= 0;
                table.path(slot)        <= (others => (others => '0'));
            else
                if tableIn.appId_wen='1' then
                    table.app_id(slot) <= tableIn.appId_w;
                end if;

                if tableIn.key1_wen='1' then
                    table.key1(slot) <= tableIn.key1_w;
                end if;

                if tableIn.key2_wen='1' then
                    table.key2(slot) <= tableIn.key2_w;
                end if;

                if tableIn.burstSize_wen='1' then
                    table.burst_size(slot) <= tableIn.burstSize_w;
                end if;

                if tableIn.pathSize_wen='1' then
                    table.path_size(slot) <= tableIn.pathSize_w;
                end if;

                if tableIn.pathFlit_wen='1' then
                    table.path(slot)(tableIn.pathFlit_idx) <= tableIn.pathFlit_w;
                end if;
            end if;

        end if; 
    end process;

    ManageUsedSlots: process(clock, reset)
    begin
        if reset='1' then
            table.used <= (others => '0');
        elsif rising_edge(clock) then
            
            if state = FETCHING_NEW and match='1' then
                table.used(slot) <= '1';
            end if;

            if state = READY and tableIn.clearSlot='1' then
                table.used(slot) <= '0';
            end if;

        end if;
    end process;
    
end architecture;
