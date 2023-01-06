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
        clock       : in    std_logic;
        reset       : in    std_logic;

        shift_en    : in    std_logic;

        w_en        : in    std_logic;
        w_value     : in    regN_lfsr;

        o_value     : out   regN_lfsr
    );
end entity;

architecture snip_lfsr of snip_lfsr is

    signal lfsr     : regN_lfsr;
    signal w_mask   : regN_lfsr;

begin

    -- aqui os ‘1s’ do polinomio “entram” nos bits certos do registrador lfsr (ver figura do site)
    g_mask: for k in lfsr_degree-1 downto 0 generate
        w_mask(k) <= lfsr_polynomial(k) and lfsr(0);
    end generate;

    -- aqui o resgistrador eh deslocado e xored com o valor do polinomio mascarado anteriormente
    p_lfsr: process(clock, reset) begin
        if reset = '1' then
            lfsr <= (others => '0');
        elsif rising_edge(clock) then

            -- init with some seed
            if w_en='1' then
                lfsr <= w_value;

            -- perform one shift
            elsif shift_en='1' then
                lfsr <= ('0' & lfsr(lfsr_degree-1 downto 1)) xor w_mask;
            end if;

        end if;
    end process;
    
    o_value <= lfsr;

end architecture;
