library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
use work.standards.all; 
use work.hemps_pkg.all; 
 
entity router_ht_wrapper is
    generic
    (
        address                 : regmetadeflit_32;
        hts_setup               : string(1 to NPORT) := "xxxxxxxxxx"
    );
    port
    (
        clock                   : in    std_logic;
        reset                   : in    std_logic;
        clock_rx                : in    regNport;
        rx                      : in    regNport;
        data_in                 : in    arrayNport_regflit;
        credit_o                : out   regNport;
        eop_in                  : in    regNport;
        access_i                : in    regNport;
        access_o                : out   regNport;

        clock_tx                : out   regNport;
        tx                      : out   regNport;
        data_out                : out   arrayNport_regflit;
        credit_i                : in    regNport;
        eop_out                 : out   regNport;

        k1                      : in    regflit;
        k2                      : in    regflit;
        sz                      : in    regNport;
        ap                      : in    regNport;
        apThreshold             : in    std_logic_vector(7 downto 0);
        intAP                   : out   std_logic;
        AP_status               : out   std_logic_vector(2 downto 0);

        -- packet blocked by wrapper

        link_control_message    : out   regNport;
        
        target                  : out   regflit;
        source                  : out   regflit
    );
end entity;

architecture router_ht_wrapper of router_ht_wrapper is

    signal router_tx        : regNport;
    signal router_clock_tx  : regNport;
    signal router_data_out  : arrayNport_regflit;
    signal router_eop_out   : regNport;
    signal router_cred_in   : regNport;

    signal ht_tx            : regNport;
    signal ht_clock_tx      : regNport;
    signal ht_data_out      : arrayNport_regflit;
    signal ht_eop_out       : regNport;
    signal ht_cred_in       : regNport;

begin

    Router: entity work.RouterCC_AP
    generic map
    (
        address     => address
    )
    port map
    (
        clock       => clock,
        reset       => reset,
        clock_rx    => clock_rx,
        rx          => rx,
        data_in     => data_in,
        credit_o    => credit_o,
        eop_in      => eop_in,
        access_i    => access_i,
        access_o    => access_o,

        clock_tx    => router_clock_tx,
        tx          => router_tx,
        data_out    => router_data_out,
        credit_i    => router_cred_in,
        eop_out     => router_eop_out,

        k1          => k1,
        k2          => k2,
        sz          => sz,
        ap          => ap,
        apThreshold => apThreshold,
        intAP       => intAP,
        AP_status   => AP_status,

        link_control_message => link_control_message,
        target      => target,
        source      => source
    );

    GenHTs: for i in 0 to NPORT-1 generate

        HarmlessHT: if hts_setup(i+1)='x' generate
            HT: entity work.router_ht(router_ht_harmless)
            port map
            (
                clock           => clock,
                reset           => reset,

                router_tx       => router_tx(i),
                router_clock_tx => router_clock_tx(i),
                router_data_out => router_data_out(i),
                router_eop_out  => router_eop_out(i),
                router_cred_in  => router_cred_in(i),

                ht_tx           => ht_tx(i),
                ht_clock_tx     => ht_clock_tx(i),
                ht_data_out     => ht_data_out(i),
                ht_eop_out      => ht_eop_out(i),
                ht_cred_in      => ht_cred_in(i)
            );
        end generate;

        BlockedHT: if hts_setup(i+1)='b' generate
            HT: entity work.router_ht(router_ht_blocked)
            port map
            (
                clock           => clock,
                reset           => reset,

                router_tx       => router_tx(i),
                router_clock_tx => router_clock_tx(i),
                router_data_out => router_data_out(i),
                router_eop_out  => router_eop_out(i),
                router_cred_in  => router_cred_in(i),

                ht_tx           => ht_tx(i),
                ht_clock_tx     => ht_clock_tx(i),
                ht_data_out     => ht_data_out(i),
                ht_eop_out      => ht_eop_out(i),
                ht_cred_in      => ht_cred_in(i)
            );
        end generate;
        
    end generate;

    tx          <= ht_tx;
    clock_tx    <= ht_clock_tx;
    data_out    <= ht_data_out;
    eop_out     <= ht_eop_out;
    ht_cred_in  <= credit_i;

end architecture;
