---------------------------------------------------------------------------------------------------
--
-- Title       : Router
-- Design      : QoS
-- Company     : GAPH
--
---------------------------------------------------------------------------------------------------
--
-- File        : Router.vhd
-- Generated   : Thu Mar  6 17:08:38 2008
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--							   
-- Description : Implements a NoC router based on its mesh position. 
-- 	Connects the router components: Input Buffers, Crossbar and Switch Control.
--
---------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.standards.all;

entity mux_control is
    port(
        clock		        : in  std_logic;
        reset		        : in  std_logic;
        in_buffer           : in  arrayNport_regflit;
        out_buffer          : out arrayNport_regflit;
        credit_i            : in  regNport;
        enable_shift        : in  regNport
    );
end mux_control;

architecture mux_control of mux_control is

signal internal_enable_shift    : regNport;

begin

    mux_gen_source_routing:for i in 0 to NPORT-1 generate
    
        out_buffer(i)   <=  in_buffer(i)(TAM_FLIT-1 downto TAM_FLIT-4) & in_buffer(i)(TAM_FLIT-9 downto 0) & "1111" when internal_enable_shift(i) = '1' else
                            in_buffer(i);
    end generate;

        en_shift: for i in 0 to NPORT-1 generate
            process(clock,reset)
            begin
                if reset = '1' then
                    internal_enable_shift(i)                <= '0';
                elsif rising_edge(clock) then
                        if credit_i(i) = '0' then
                            if enable_shift(i) = '1' then
                                internal_enable_shift(i)   <= '1';
                            end if;
                        else 
                            internal_enable_shift(i)       <= enable_shift(i);
                        end if;
                end if ;
            end process;
        end generate;
end mux_control;
