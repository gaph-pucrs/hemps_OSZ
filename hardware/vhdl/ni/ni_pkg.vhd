library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;

package ni_pkg is
    
    constant TAM_WORD   : integer := TAM_FLIT*2;
    subtype regword is std_logic_vector(TAM_WORD-1 downto 0);

    constant TABLE_SIZE         : integer := 8;
    constant MAX_FLITS_PER_PKT  : integer := 255;

    constant APPID_SIZE         : integer := 10;
    constant KEYPERIPH_SIZE     : integer := 8;

    subtype regN_appID      is std_logic_vector(APPID_SIZE-1 downto 0);
    subtype regN_keyPeriph  is std_logic_vector(KEYPERIPH_SIZE-1 downto 0);
    subtype regN_path       is std_logic_vector(2 downto 0);
    subtype regN_burstSize  is std_logic_vector(2 downto 0);
    
    constant CONFIG_PERIPH_SERVICE              : regword := x"02000010";
    
    constant SERVICE_FLIT                       : integer := 7;
    constant APPID_FLIT_CONFIG_PERIPH_SERVICE   : integer := 10;
    constant KEYP_FLIT_CONFIG_PERIPH_SERVICE    : integer := 12;
    
end package ni_pkg;
