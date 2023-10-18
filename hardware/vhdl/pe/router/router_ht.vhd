library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
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
