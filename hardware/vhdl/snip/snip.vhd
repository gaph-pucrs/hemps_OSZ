library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.snip_pkg.all;

-----------------------------------------------
-- Secure Network Interface with Peripherals --
-----------------------------------------------

entity snip is
    generic
    (
        SNIP_ID : regflit
    );
    port
    (
        clock   : in    std_logic;
        reset   : in    std_logic;

        ----------------------
        -- Hermes Interface --
        ----------------------

        hermes_primary_tx           : out   std_logic;
        hermes_primary_tx_clk       : out   std_logic;
        hermes_primary_data_out     : out   regflit;
        hermes_primary_eop_out      : out   std_logic;
        hermes_primary_credit_in    : in    std_logic;

        hermes_primary_rx           : in    std_logic;
        hermes_primary_rx_clk       : in    std_logic;
        hermes_primary_data_in      : in    regflit;
        hermes_primary_eop_in       : in    std_logic;
        hermes_primary_credit_out   : out   std_logic;

        ---------------------
        -- BrNoC Interface --
        ---------------------

        brnoc_primary_source_in     : in    regNsource;
        brnoc_primary_target_in     : in    regNtarget;
        brnoc_primary_service_in    : in    seek_bitN_service;
        brnoc_primary_payload_in    : in    regNpayload;
        brnoc_primary_req_in        : in    std_logic;
        brnoc_primary_opmode_in     : in    std_logic;
        brnoc_primary_ack_out       : out   std_logic;
        
        brnoc_primary_source_out    : out   regNsource;
        brnoc_primary_target_out    : out   regNtarget;
        brnoc_primary_service_out   : out   seek_bitN_service;
        brnoc_primary_payload_out   : out   regNpayload;
        brnoc_primary_req_out       : out   std_logic;
        brnoc_primary_opmode_out    : out   std_logic;
        brnoc_primary_ack_in        : in    std_logic
    );
end entity;

architecture snip of snip is

    ----------------------------
    -- Port Selection Signasl --
    ----------------------------
    
    signal hermes_rx                : std_logic;
    signal hermes_rx_ck             : std_logic;
    signal hermes_data_in           : regflit;
    signal hermes_eop_in            : std_logic;
    signal hermes_credit_out        : std_logic;

    signal hermes_tx                : std_logic;
    signal hermes_tx_ck             : std_logic;
    signal hermes_data_out          : regflit;
    signal hermes_eop_out           : std_logic;
    signal hermes_credit_in         : std_logic;

    -------------------------------
    -- Application Table Signals --
    -------------------------------

    signal tableIn_handlerOut   : AppTablePrimaryInput;
    signal tableOut_handlerIn   : AppTablePrimaryOutput;

    signal tableIn_builderOut   : AppTableSecondaryInput;
    signal tableOut_builderIn   : AppTableSecondaryOutput;

    --------------------------------
    -- Response Request Interface --
    --------------------------------

    signal response_req     : std_logic;
    signal response_param   : ResponseParametersType;
    signal tx_status        : TransmissionStatusType;

    --------------------
    -- Buffer Signals --
    --------------------

    -- buffer out

    signal buffer_o_wen     : std_logic;
    signal buffer_o_datain  : regflit;

    signal buffer_o_ren     : std_logic;
    signal buffer_o_dataout : regflit;

    signal buffer_o_flush   : std_logic;
    signal buffer_o_enable  : std_logic;
    signal buffer_o_status  : BufferStatusType;

    -- buffer in

    signal buffer_i_wen     : std_logic;
    signal buffer_i_datain  : regflit;

    signal buffer_i_ren     : std_logic;
    signal buffer_i_dataout : regflit;

    signal buffer_i_flush   : std_logic;
    signal buffer_i_enable  : std_logic;
    signal buffer_i_status  : BufferStatusType;

    ---------------------
    -- Warning Signals --
    ---------------------

    signal mpe_routing_header       : regword;

    signal warning_req              : std_logic;
    signal warning_ack              : std_logic;
    signal warning_param            : WarningParametersType;

    signal warning_excessive_data   : std_logic;
    signal warning_unexpected_data  : std_logic;
    signal warning_abnormal_periph  : std_logic;
    signal warning_overwritten_line : std_logic;
    signal warning_full_table_write : std_logic;
    signal warning_failed_auth      : std_logic;

    signal unlock_warnings          : std_logic;
    
    -- in param
    signal incoming_source          : regflit;
    signal incoming_f1              : regflit;
    signal incoming_f2              : regflit;
    signal line_index               : integer range 0 to TABLE_SIZE-1;

    -- out param
    signal warning_f1               : regflit;
    signal warning_f2               : regflit;
    signal warning_pkt_source       : regflit;
    signal warning_slot_index       : integer range 0 to TABLE_SIZE-1;


begin

    -- Resetando as saídas inutilizadas até o momento para reduzir os warnings
    process (reset)
    begin
        if reset = '1' then
            brnoc_primary_source_out    <= (others => '0');
            brnoc_primary_target_out    <= (others => '0');
            brnoc_primary_service_out   <= (others => '0');
            brnoc_primary_payload_out   <= (others => '0');
            brnoc_primary_req_out       <= '0';
            brnoc_primary_opmode_out    <= '0';
            brnoc_primary_ack_out       <= '1';
        end if;
    end process;

    --------------------
    -- Port Selection --
    --------------------

    hermes_rx                   <= hermes_primary_rx;
    hermes_rx_ck                <= hermes_primary_rx_clk;
    hermes_data_in              <= hermes_primary_data_in;
    hermes_eop_in               <= hermes_primary_eop_in;
    hermes_primary_credit_out   <= hermes_credit_out;

    hermes_primary_tx           <= hermes_tx;
    hermes_primary_tx_clk       <= '1';
    hermes_primary_data_out     <= hermes_data_out;
    hermes_primary_eop_out      <= hermes_eop_out;
    hermes_credit_in            <= hermes_primary_credit_in;

    -------------------------------------
    -- Application Table Instantiation --
    -------------------------------------

    ApplicationTable: entity work.snip_application_table
    port map
    (
        clock           => clock,
        reset           => reset,

        primaryIn       => tableIn_handlerOut,
        primaryOut      => tableOut_handlerIn,

        secondaryIn     => tableIn_builderOut,
        secondaryOut    => tableOut_builderIn,

        warn_overwrite  => warning_overwritten_line,
        warn_full_table => warning_full_table_write,
        warn_fail_auth  => warning_failed_auth,
        line_index      => line_index
    );

    ----------------------------------
    -- Packet Handler Instantiation --
    ----------------------------------

    PacketHandler: entity work.snip_packet_handler
    port map
    (
        clock               => clock,
        reset               => reset,

        hermes_rx           => hermes_rx,
        hermes_data_in      => hermes_data_in,
        hermes_eop_in       => hermes_eop_in,
        hermes_credit_out   => hermes_credit_out,

        tableIn             => tableOut_handlerIn,
        tableOut            => tableIn_handlerOut,

        response_req        => response_req,
        response_param      => response_param,
        tx_status           => tx_status,

        mpe_routing_header  => mpe_routing_header,

        buffer_wdata        => buffer_o_datain,
        buffer_wen          => buffer_o_wen,
        buffer_full         => buffer_o_status.full,

        unlock_warnings     => unlock_warnings,
        incoming_source     => incoming_source,
        incoming_f1         => incoming_f1,
        incoming_f2         => incoming_f2
    );

    ----------------------------------
    -- Packet Builder Instantiation --
    ----------------------------------

    PacketBuilder: entity work.snip_packet_builder
    generic map
    (
        SNIP_ID             => SNIP_ID
    )
    port map
    (
        clock               => clock,
        reset               => reset,

        hermes_tx           => hermes_tx,
        hermes_data_out     => hermes_data_out,
        hermes_eop_out      => hermes_eop_out,
        hermes_credit_in    => hermes_credit_in,

        tableIn             => tableOut_builderIn,
        tableOut            => tableIn_builderOut,

        response_req        => response_req,
        response_param_in   => response_param,
        status              => tx_status,

        warning_req         => warning_req,
        warning_ack         => warning_ack,
        warning_param       => warning_param,
        warning_f1          => warning_f1,
        warning_f2          => warning_f2,
        warning_pkt_source  => warning_pkt_source,
        warning_slot_index  => warning_slot_index,

        mpe_routing_header  => mpe_routing_header,

        buffer_rdata        => buffer_i_dataout,
        buffer_ren          => buffer_i_ren,
        buffer_empty        => buffer_i_status.empty,
        buffer_flush        => buffer_i_flush,
        buffer_enable       => buffer_i_enable,

        warn_excessive_data => warning_excessive_data
    );

    ------------------------------
    -- IO Buffers Instantiation --
    ------------------------------

    OutputBuffer: entity work.snip_io_buffer
    port map
    (
        clock   => clock,
        reset   => reset,

        w_en    => buffer_o_wen,
        data_i  => buffer_o_datain,

        r_en    => buffer_o_ren,
        data_o  => buffer_o_dataout,

        flush   => buffer_o_flush,
        status  => buffer_o_status
    );

    buffer_o_flush <= '0';

    InputBuffer: entity work.snip_io_buffer
    port map
    (
        clock   => clock,
        reset   => reset,

        w_en    => buffer_i_wen,
        data_i  => buffer_i_datain,

        r_en    => buffer_i_ren,
        data_o  => buffer_i_dataout,

        flush   => buffer_i_flush,
        status  => buffer_i_status
    );

    -----------------------------------
    -- Warning Manager Instantiation --
    -----------------------------------

    WarningManager: entity work.snip_warning_manager
    port map
    (
        clock                   => clock,
        reset                   => reset,

        abnormal_periph_input   => warning_abnormal_periph,
        line_overwritten_input  => warning_overwritten_line,
        full_table_write_input  => warning_full_table_write,
        failed_auth_input       => warning_failed_auth,

        warning_req             => warning_req,
        warning_ack             => warning_ack,
        warning_param           => warning_param,

        unlock_warnings         => unlock_warnings,
        incoming_source         => incoming_source,
        incoming_f1             => incoming_f1,
        incoming_f2             => incoming_f2,
        line_index              => line_index,

        warning_f1              => warning_f1,
        warning_f2              => warning_f2,
        warning_pkt_source      => warning_pkt_source,
        warning_slot_index      => warning_slot_index
    );

    warning_unexpected_data <= buffer_i_wen and not buffer_i_enable;
    warning_abnormal_periph <= warning_unexpected_data or warning_excessive_data;

    --------------------------------------------------
    -- Peripheral Instantiation -- Testing Purposes --
    --------------------------------------------------

    Peripheral: entity work.peripheral(real_peripheral)
    port map
    (
        clock               =>  clock,
        reset               =>  reset,

        r_en                => buffer_o_ren,
        data_in             => buffer_o_dataout,
        r_buffer_empty      => buffer_o_status.empty,
        
        w_en                => buffer_i_wen,
        data_out            => buffer_i_datain,
        w_buffer_full       => buffer_i_status.full,
        w_buffer_empty      => buffer_i_status.empty,
        w_buffer_enable     => buffer_i_enable

    );

    buffer_o_enable <= '1';

end architecture;
