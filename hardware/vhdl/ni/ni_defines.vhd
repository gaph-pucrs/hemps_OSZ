library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

package ni_pkg is

    constant TABLE_SIZE : integer := 8;

    subtype regN_appID      is std_logic_vector(2 downto 0);
    subtype regN_keyPeriph  is std_logic_vector(2 downto 0);
    subtype regN_path       is std_logic_vector(2 downto 0);
    subtype regN_burstSize  is std_logic_vector(2 downto 0);

end package ni_pkg;
