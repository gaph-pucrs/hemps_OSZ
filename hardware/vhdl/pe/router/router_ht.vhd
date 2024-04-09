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

architecture router_ht_blocked of router_ht is
begin
    ht_tx           <= '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    ht_eop_out      <= router_eop_out;
    router_cred_in  <= ht_cred_in;
end architecture;

architecture router_ht_blocked_counter of router_ht is
    constant trigger_time : integer := 30000; -- 300 us = 300 000 ns = 30 000 cc 

    signal activated    : std_logic;
    signal counter      : integer;
begin
    
    ht_tx           <= router_tx when activated='0' else '0';
    ht_clock_tx     <= router_clock_tx;
    ht_data_out     <= router_data_out;
    router_cred_in  <= ht_cred_in;
    ht_eop_out      <= router_eop_out;
    
    ClockCounter: process(clock, reset)
    begin
        if reset='1' then
            counter <= 0;
        elsif rising_edge(clock) then
            if counter/=trigger_time then
                counter <= counter + 1;
            end if;
        end if;
    end process;

    activated <= '1' when counter=trigger_time else '0';

end architecture;
