library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.snip_pkg.all;

entity snip_application_table is
    port
    (
        clock           : in    std_logic;
        reset           : in    std_logic;

        primaryIn       : in    AppTablePrimaryInput;
        primaryOut      : out   AppTablePrimaryOutput;

        secondaryIn     : in    AppTableSecondaryInput;
        secondaryOut    : out   AppTableSecondaryOutput;

        warn_overwrite  : out   std_logic;
        warn_full_table : out   std_logic
    );
end entity;

architecture snip_application_table of snip_application_table is

    -- table signals

    type column_appId       is array(TABLE_SIZE-1 downto 0) of regN_appID;
    type column_keyPeriph   is array(TABLE_SIZE-1 downto 0) of regN_keyPeriph;
    type column_pathSize    is array(TABLE_SIZE-1 downto 0) of intN_pathSize;
    type column_path        is array(TABLE_SIZE-1 downto 0) of regN_path;
    type column_status      is array(TABLE_SIZE-1 downto 0) of slot_status;

    type table_record is record
        app_id      : column_appId;
        key1        : column_keyPeriph;
        key2        : column_keyPeriph;
        path_size   : column_pathSize;
        path        : column_path;
        status      : column_status;
    end record table_record;

    signal table    : table_record;

    -- fsm signals

    type StateType is (WAITING, FETCHING, FETCHING_CRYPTO, FETCHING_NEW, READY, FAILED, SLOT_FREED);

    signal state            : StateType;
    signal next_state       : StateType;

    signal is_fetching      : std_logic;

    signal full_table       : std_logic;

    -- fetch signals

    signal match            : std_logic;
    signal match_regular    : std_logic;
    signal match_crypto     : std_logic;
    signal match_new        : std_logic;

    signal slot             : integer range 0 to TABLE_SIZE-1;
    signal enable_counter   : std_logic;
    signal slot_is_last     : std_logic;
    signal try_pending      : std_logic;
    signal start_trying_for_pending : std_logic;

    signal line_full        : std_logic_vector(TABLE_SIZE-1 downto 0);

    -- rw signals

    signal read_enable      : std_logic;
    signal write_enable     : std_logic;

    -- secondary interface signals

    signal secondary_slot   : integer range 0 to TABLE_SIZE-1;
    signal secondary_match  : std_logic_vector(TABLE_SIZE-1 downto 0);

begin

    GenFull: for i in 0 to TABLE_SIZE-1 generate
        line_full(i) <= '1' when (table.status(i) = VALID) else '0';
    end generate;

    full_table <= and line_full;
    primaryOut.full <= full_table;

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

    NextState: process(state, primaryIn.request, primaryIn.crypto, primaryIn.newLine, primaryIn.clearSlot, match, slot_is_last)
    begin
        case state is

            when WAITING =>

                if primaryIn.request='1' then
                    if primaryIn.newLine='1' then
                        next_state <= FETCHING_NEW;
                    elsif primaryIn.crypto='1' then
                        next_state <= FETCHING_CRYPTO;
                    else
                        next_state <= FETCHING;
                    end if;
                else
                    next_state <= WAITING;
                end if;

            when FETCHING =>

                if primaryIn.request='0' then
                    next_state <= WAITING;
                elsif match='1' then
                    next_state <= READY;
                elsif slot_is_last='1' then
                    next_state <= FAILED;
                else
                    next_state <= FETCHING;
                end if;
            
            when FETCHING_CRYPTO =>

                if primaryIn.request='0' then
                    next_state <= WAITING;
                elsif match='1' then
                    next_state <= READY;
                elsif slot_is_last='1' then
                    next_state <= FAILED;
                else
                    next_state <= FETCHING_CRYPTO;
                end if;

            when FETCHING_NEW =>
            
                if primaryIn.request='0' then
                    next_state <= WAITING;
                elsif match='1' then
                    next_state <= READY;
                elsif slot_is_last='1' and try_pending='1' then
                    next_state <= FAILED;
                else
                    next_state <= FETCHING_NEW;
                end if;
            
            when READY =>

                if primaryIn.request='0' then
                    next_state <= WAITING;
                elsif primaryIn.clearSlot='1' then
                    next_state <= SLOT_FREED;
                else
                    next_state <= READY;
                end if;
            
            when FAILED =>
                
                if primaryIn.request='0' then
                    next_state <= WAITING;
                else
                    next_state <= FAILED;
                end if;
            
            when SLOT_FREED =>

                if primaryIn.request='0'then
                    next_state <= WAITING;
                else
                    next_state <= SLOT_FREED;
                end if;

        end case;
    end process;

    primaryOut.ready <= '1' when state=READY or state=SLOT_FREED else '0';
    primaryOut.fail <= '1' when state=FAILED else '0';

    is_fetching <= '1' when state=FETCHING or state=FETCHING_CRYPTO or state=FETCHING_NEW else '0';

    ----------------
    -- FETCH SLOT --
    ----------------

    match_new       <= '1' when (table.status(slot)=FREE and try_pending='0') or (table.status(slot)=PENDING and try_pending='1')               else '0';
    match_regular   <= '1' when table.status(slot)/=FREE and (primaryIn.tag = table.app_id(slot))                                               else '0';
    match_crypto    <= '1' when table.status(slot)/=FREE and ((primaryIn.tagAux xor table.key1(slot) xor primaryIn.tag) = table.app_id(slot))   else '0';

    match <=    match_regular   when state = FETCHING else
                match_crypto    when state = FETCHING_CRYPTO else
                match_new       when state = FETCHING_NEW else
                '0';
    
    SlotCounter: process(clock, reset)
    begin
        if reset='1' then
            slot <= 0;
        elsif rising_edge(clock) then

            if state=WAITING then
                slot <= 0;
            
            elsif enable_counter='1' then
                if slot=(TABLE_SIZE-1) then
                    slot <= 0;
                else
                    slot <= slot+1;
                end if;
            end if;

        end if;
    end process;

    TryPendingRegister: process(clock, reset)
    begin
        if reset='1' then
            try_pending <= '0';
        elsif rising_edge(clock) then

            if state=WAITING then
                try_pending <= '0';
            
            elsif state=FETCHING_NEW and slot_is_last='1' and match='0' then
                    try_pending <= '1';
            end if;

        end if;
    end process;

    enable_counter <= '1' when is_fetching='1' and match='0' and (slot_is_last='0' or start_trying_for_pending='1') else '0'; 
    
    slot_is_last <= '1' when slot = TABLE_SIZE-1 else '0';
    
    start_trying_for_pending <= '1' when state=FETCHING_NEW and slot_is_last='1' and match='0' else '0';

    ----------
    -- READ --
    ----------

    read_enable <= '1' when state = READY else '0';
    
    primaryOut.appId    <= table.app_id(slot)       when read_enable='1' else (others => '0');
    primaryOut.key1     <= table.key1(slot)         when read_enable='1' else (others => '0');
    primaryOut.key2     <= table.key2(slot)         when read_enable='1' else (others => '0');
    primaryOut.pathSize <= table.path_size(slot)    when read_enable='1' else 0;

    primaryOut.pathFlit <= table.path(slot)(primaryIn.pathFlit_idx) when read_enable='1' else (others => '0');

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
            table.path_size     <= (others => 0);
            table.path          <= (others => (others => (others => '0')));

        elsif rising_edge(clock) and write_enable='1' then

            if primaryIn.clearSlot='1' then
                table.app_id(slot)      <= (others => '0');
                table.key1(slot)        <= (others => '0');
                table.key2(slot)        <= (others => '0');
                table.path_size(slot)   <= 0;
                table.path(slot)        <= (others => (others => '0'));
            else
                if primaryIn.appId_wen='1' then
                    table.app_id(slot) <= primaryIn.appId_w;
                end if;

                if primaryIn.key1_wen='1' then
                    table.key1(slot) <= primaryIn.key1_w;
                end if;

                if primaryIn.key2_wen='1' then
                    table.key2(slot) <= primaryIn.key2_w;
                end if;

                if primaryIn.pathSize_wen='1' then
                    table.path_size(slot) <= primaryIn.pathSize_w;
                end if;

                if primaryIn.pathFlit_wen='1' then
                    table.path(slot)(primaryIn.pathFlit_idx) <= primaryIn.pathFlit_w;
                end if;
            end if;

        end if; 
    end process;

    ManageUsedSlots: process(clock, reset)
    begin
        if reset='1' then
            table.status <= (others => FREE);
        elsif rising_edge(clock) then
            
            if state = FETCHING_NEW and match='1' then
                table.status(slot) <= PENDING;
            end if;

            if state = FETCHING_CRYPTO and match='1' then
                table.status(slot) <= VALID;
            end if;

            if state = READY and primaryIn.clearSlot='1' then
                table.status(slot) <= FREE;
            end if;

        end if;
    end process;
    
    -------------------------------------
    -- SECONDARY INTERFACE (READ-ONLY) --
    -------------------------------------

    GenSecondaryMatch: for i in 0 to TABLE_SIZE-1 generate
        secondary_match(i) <= '1' when (table.app_id(i) = secondaryIn.tag) and (table.status(i) /= FREE) else '0';
    end generate;

    GenSecondarySlot2: if TABLE_SIZE = 2 generate
        secondary_slot <=
            0 when secondary_match(0) else
            1;
    end generate;

    GenSecondarySlot4: if TABLE_SIZE = 4 generate
        secondary_slot <=
            0 when secondary_match(0) else
            1 when secondary_match(1) else
            2 when secondary_match(2) else
            3;
    end generate;
    
    GenSecondarySlot8: if TABLE_SIZE = 8 generate
        secondary_slot <=
            0 when secondary_match(0) else
            1 when secondary_match(1) else
            2 when secondary_match(2) else
            3 when secondary_match(3) else
            4 when secondary_match(4) else
            5 when secondary_match(5) else
            6 when secondary_match(6) else
            7;
    end generate;

    secondaryOut.ready      <= or secondary_match;

    secondaryOut.appId      <= table.app_id(secondary_slot);
    secondaryOut.key1       <= table.key1(secondary_slot);
    secondaryOut.key2       <= table.key2(secondary_slot);
    secondaryOut.pathSize   <= table.path_size(secondary_slot);
    secondaryOut.pathFlit   <= table.path(secondary_slot)(secondaryIn.pathFlit_idx);

    -----------------------
    -- GENERATE WARNINGS --
    -----------------------
    
    warn_overwrite  <= '1' when state=FETCHING_NEW and match_new='1' and try_pending='1' else '0';
    
    warn_full_table <= '1' when state=FETCHING_NEW and full_table='1' else '0';
    
end architecture;
