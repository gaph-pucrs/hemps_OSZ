library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;

package ni_pkg is

    constant TABLE_SIZE         : integer := 8;
    constant MAX_FLITS_PER_PKG  : integer := 255;
    constant TAM_WORD           : integer := TAM_FLIT*2;

    subtype regword         is std_logic_vector(TAM_WORD-1 downto 0);

    subtype regN_appID      is std_logic_vector(2 downto 0);
    subtype regN_keyPeriph  is std_logic_vector(2 downto 0);
    subtype regN_path       is std_logic_vector(2 downto 0);
    subtype regN_burstSize  is std_logic_vector(2 downto 0);

    constant FLIT_SERVICE_HI    : integer := 7;
    constant FLIT_SERVICE_LO    : integer := 8;

end package ni_pkg;
