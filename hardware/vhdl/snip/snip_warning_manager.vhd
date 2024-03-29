library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.snip_pkg.all;

entity snip_warning_manager is
    port
    (
        clock                   : in    std_logic;
        reset                   : in    std_logic;

        abnormal_periph_input   : in    std_logic;
        line_overwritten_input  : in    std_logic;
        full_table_write_input  : in    std_logic;
        failed_auth_input       : in    std_logic;

        warning_req             : out   std_logic;
        warning_ack             : in    std_logic;
        warning_param           : out   WarningParametersType;

        unlock_warnings         : in    std_logic;

        -- in param
        incoming_source         : in    regflit;
        incoming_f1             : in    regflit;
        incoming_f2             : in    regflit;
        line_index              : in    integer range 0 to TABLE_SIZE-1;

        -- out param
        warning_f1              : out   regflit;
        warning_f2              : out   regflit;
        warning_pkt_source      : out   regflit;
        warning_slot_index      : out   integer range 0 to TABLE_SIZE-1
    );
end entity;

architecture snip_warning_manager of snip_warning_manager is

    constant MAX_FAILED_AUTH        : integer := 5;

    ------------------------------
    -- Warning register signals --
    ------------------------------

    signal abnormal_periph          : std_logic;
    signal abnormal_periph_reseted  : std_logic;
    signal abnormal_periph_ack      : std_logic;

    signal line_overwritten         : std_logic;
    signal line_overwritten_reseted : std_logic;
    signal line_overwritten_ack     : std_logic;

    signal full_table_write         : std_logic;
    signal full_table_write_reseted : std_logic;
    signal full_table_write_ack     : std_logic;

    signal failed_auth              : std_logic;
    signal failed_auth_reseted      : std_logic;
    signal failed_auth_ack          : std_logic;
    signal failed_auth_counter      : integer range 0 to MAX_FAILED_AUTH;

    -----------------
    -- FSM signals --
    -----------------

    type StateType is (WAITING, REQ_ABNORMAL_PERIPH, REQ_LINE_OVERWRITTEN, REQ_FULL_TABLE_WRITE, REQ_FAILED_AUTH);
    
    signal state        : StateType;
    signal next_state   : StateType;

begin

    ---------------------------------------------------------
    -- Receives, filters and registers the warning signals --
    ---------------------------------------------------------

    AbnormalPeriphRegister: process(clock, reset)
    begin
        if reset='1' then
            abnormal_periph <= '0';
            abnormal_periph_reseted <= '1';
        elsif rising_edge(clock) then
            
            -- Abnormal Peripheral Register
            if abnormal_periph_input='1' and abnormal_periph_reseted='1' then
                abnormal_periph <= '1';
            elsif abnormal_periph_ack='1' then
                abnormal_periph <= '0';
            end if;

            -- Abnormal Peripheral Reseted --- Only accepts another warning after UNLOCK_WARNINGS
            if unlock_warnings='1' then
                abnormal_periph_reseted <= '1';
            elsif abnormal_periph_input='1' then
                abnormal_periph_reseted <= '0';
            end if;
        
        end if;
    end process;

    LineOverwrittenRegister: process(clock, reset)
    begin
        if reset='1' then
            line_overwritten <= '0';
            line_overwritten_reseted <= '1';
        elsif rising_edge(clock) then
            
            -- Line Overwritten Register
            if line_overwritten_input='1' and line_overwritten_reseted='1' then
                line_overwritten <= '1';
            elsif line_overwritten_ack='1' then
                line_overwritten <= '0';
            end if;

            -- Line Overwritten Reseted
            if line_overwritten_input='0' then
                line_overwritten_reseted <= '1';
            elsif line_overwritten_input='1' then
                line_overwritten_reseted <= '0';
            end if;
        
        end if;
    end process;

    FullTableWriteRegister: process(clock, reset)
    begin
        if reset='1' then
            full_table_write <= '0';
            full_table_write_reseted <= '1';
        elsif rising_edge(clock) then
            
            -- Full Table Write Register
            if full_table_write_input='1' and full_table_write_reseted='1' then
                full_table_write <= '1';
            elsif full_table_write_ack='1' then
                full_table_write <= '0';
            end if;

            -- Full Table Write Reseted
            if full_table_write_input='0' then
                full_table_write_reseted <= '1';
            elsif full_table_write_input='1' then
                full_table_write_reseted <= '0';
            end if;
        
        end if;
    end process;

    FailedAuthRegister: process(clock, reset)
    begin
        if reset='1' then
            failed_auth <= '0';
            failed_auth_reseted <= '1';
        elsif rising_edge(clock) then
            
            -- Failed Auth Register
            if failed_auth_input='1' and failed_auth_reseted='1' then
                failed_auth <= '1';
            elsif failed_auth_ack='1' then
                failed_auth <= '0';
            end if;

            -- Failed Auth Reseted
            if failed_auth_input='0' then
                failed_auth_reseted <= '1';
            elsif failed_auth_input='1' then
                failed_auth_reseted <= '0';
            end if;
        
        end if;
    end process;

    abnormal_periph_ack     <= '1' when state=REQ_ABNORMAL_PERIPH   and next_state=WAITING else '0';
    line_overwritten_ack    <= '1' when state=REQ_LINE_OVERWRITTEN  and next_state=WAITING else '0';
    full_table_write_ack    <= '1' when state=REQ_FULL_TABLE_WRITE  and next_state=WAITING else '0';
    failed_auth_ack         <= '1' when state=REQ_FAILED_AUTH       and next_state=WAITING else '0';

    ----------------------------------------
    -- Register params for table warnings --
    ----------------------------------------

    ParamRegister: process(clock, reset)
    begin
        if reset='1' then
            warning_f1 <= (others => '0');
            warning_f2 <= (others => '0');
            warning_pkt_source <= (others => '0');
            warning_slot_index <= 0;
        elsif rising_edge(clock) then
            if (line_overwritten_input='1' and line_overwritten_reseted='1') or (full_table_write_input='1' and full_table_write_reseted='1') or (failed_auth_input='1' and failed_auth_reseted='1') then
                warning_f1 <= incoming_f1;
                warning_f2 <= incoming_f2;
                warning_pkt_source <= incoming_source;
                warning_slot_index <= line_index;
            end if;
        end if;
    end process;

    ---------
    -- FSM --
    ---------

    ChangeState: process(clock, reset)
    begin
        if reset='1' then
            state <= WAITING;
        elsif rising_edge(clock) then
            state <= next_state;
        end if;
    end process;
    
    NextStateLogic: process(full_table_write, line_overwritten, abnormal_periph, failed_auth, failed_auth_counter, warning_ack)
    begin
        case state is
        
            when WAITING =>

                if full_table_write='1' then
                    next_state <= REQ_FULL_TABLE_WRITE;
                elsif line_overwritten='1' then
                    next_state <= REQ_LINE_OVERWRITTEN;
                elsif abnormal_periph='1' then
                    next_state <= REQ_ABNORMAL_PERIPH;
                elsif failed_auth='1' and failed_auth_counter/=MAX_FAILED_AUTH then
                    next_state <= REQ_FAILED_AUTH;
                else
                    next_state <= WAITING;
                end if;

            when REQ_FULL_TABLE_WRITE =>

                if warning_ack='1' then
                    next_state <= WAITING;
                else
                    next_state <= REQ_FULL_TABLE_WRITE;
                end if;

            when REQ_LINE_OVERWRITTEN =>

                if warning_ack='1' then
                    next_state <= WAITING;
                else
                    next_state <= REQ_LINE_OVERWRITTEN;
                end if;

            when REQ_ABNORMAL_PERIPH =>

                if warning_ack='1' then
                    next_state <= WAITING;
                    else
                    next_state <= REQ_ABNORMAL_PERIPH;
                end if;
            
            when REQ_FAILED_AUTH =>

                if warning_ack='1' then
                    next_state <= WAITING;
                    else
                    next_state <= REQ_FAILED_AUTH;
                end if;
        
        end case;
    end process;

    -----------------------------------
    -- Interface with packet handler --
    -----------------------------------

    warning_req <= '1' when state=REQ_FULL_TABLE_WRITE or state=REQ_LINE_OVERWRITTEN or state=REQ_ABNORMAL_PERIPH or state=REQ_FAILED_AUTH else '0';

    GenerateRequestParams: process(state)
    begin
        case state is

            when REQ_ABNORMAL_PERIPH =>
                warning_param.warning_type <= ABNORMAL_PERIPHERAL;

            when REQ_LINE_OVERWRITTEN =>
                warning_param.warning_type <= OVERWRITTEN_ROW;

            when REQ_FULL_TABLE_WRITE =>
                warning_param.warning_type <= WRITE_ON_FULL_TABLE;
            
            when REQ_FAILED_AUTH =>
                warning_param.warning_type <= FAILED_AUTHENTICATION;
            
            when others =>
                warning_param.warning_type <= ABNORMAL_PERIPHERAL;

        end case;
    end process;

    -------------------------------------------
    -- Block counter for Failed Auth warning --
    -------------------------------------------

    CountFailedAuthWarnings: process(clock, reset)
    begin
        if reset='1' then
            failed_auth_counter <= 0;
        elsif rising_edge(clock) then

            if unlock_warnings='1' then
                failed_auth_counter <= 0;
            elsif failed_auth_ack='1' then
                failed_auth_counter <= failed_auth_counter + 1;
            end if;
        
        end if;
    end process;
            
end architecture;
