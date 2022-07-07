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
    constant BSIZE_SIZE         : integer := 6;
    constant MAX_PATH_FLITS     : integer := 6;    

    subtype regN_appID      is std_logic_vector(APPID_SIZE-1 downto 0);
    subtype regN_keyPeriph  is std_logic_vector(KEYPERIPH_SIZE-1 downto 0);
    subtype regN_burstSize  is std_logic_vector(BSIZE_SIZE-1 downto 0);
    type    regN_path       is array(MAX_PATH_FLITS-1 downto 0) of regflit;
    subtype intN_pathSize   is integer range 0 to MAX_PATH_FLITS;
    
    constant SERVICE_FLIT                       : integer := 6;
    constant END_OF_HEADER_FLIT                 : integer := 25;
    
    constant CONFIG_PERIPH_SERVICE              : regword := x"02000010";
    constant CONFIG_PERIPH_SERVICE_APPID_FLIT   : integer := 9;
    constant CONFIG_PERIPH_SERVICE_KEYP_FLIT    : integer := 11;

    constant SET_PATH_SERVICE                   : regword := x"FEDC1234";
    constant SET_PATH_SERVICE_APPID_FLIT        : integer := 9;

    constant REQUEST_PERIPH_SERVICE             : regword := x"45542323";
    constant REQUEST_PERIPH_SERVICE_APPID_FLIT  : integer := 9;
    constant REQUEST_PERIPH_SERVICE_BSIZE_FLIT  : integer := 19;
    
end package ni_pkg;
