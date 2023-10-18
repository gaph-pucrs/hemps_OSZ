library ieee; 
use ieee.std_logic_1164.all; 
use ieee.std_logic_unsigned.all; 
use work.standards.all; 
use work.hemps_pkg.all; 
 
entity router_ht_wrapper is
    generic
    (
        address                 : in    regmetadeflit_32
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

        clock_tx    => clock_tx,
        tx          => tx,
        data_out    => data_out,
        credit_i    => credit_i,
        eop_out     => eop_out,

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

end architecture;
