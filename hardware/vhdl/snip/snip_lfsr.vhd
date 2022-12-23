library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.snip_pkg.all;

-- https://surf-vhdl.com/how-to-implement-an-lfsr-in-vhdl/

entity snip_lfsr is
    port
    (
        clock   : std_logic,
        reset   : std_logic
    );
end entity;

architecture snip_lfsr of snip_lfsr is

    -- x^19 + x^18 + x^17 + x^14 +1
    constant GP         : integer := 19;
    constant polinomio  : std_logic_vector(GP-1 downto 0) := "1110010000000000000";
    constant seed       : std_logic_vector(GP-1 downto 0) := "1101101110110111011";

    signal lfsr         : std_logic_vector(GP-1 downto 0);
    signal w_mask       : std_logic_vector(GP-1 downto 0);

    signal bit_lfsr     : std_logic;
    signal en_lfsr      : std_logic;

begin

    -- aqui os ‘1s’ do polinomio são “entram” nos bits certos do registrador lfsr (ver figura do site)
    g_mask: for k in GP-1 downto 0 generate
        w_mask(k) <= polinomio(k) and lfsr(0);
    end generate;

    -- aqui o resgistrador eh deslocado e xored com o valor do polinomio mascarado anteriormente
    p_lfsr: process(clock, reset) begin
        if reset = '1' then
            lfsr <= seed;
        elsif rising_edge(clock) then
             if en_lfsr = '1' then
                lfsr <= ('0' & lfsr(GP-1 downto 1)) xor w_mask ;
            end if;
        end if;
    end process;
    
    bit_lfsr <= lfsr(0);
    en_lfsr <= '1';

end architecture;