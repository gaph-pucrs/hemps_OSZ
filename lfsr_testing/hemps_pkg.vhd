library IEEE;
use IEEE.Std_Logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

package hemps_pkg is

    -- paging definitions
    constant PAGE_SIZE_BYTES             : integer := 131072;
    constant MEMORY_SIZE_BYTES           : integer := 262144;
    constant TOTAL_REPO_SIZE_BYTES       : integer := 1048576;
    constant APP_NUMBER                  : integer := 1;
    constant PAGE_SIZE_H_INDEX        : integer := 16;
    constant PAGE_NUMBER_H_INDEX      : integer := 17;
    -- Hemps top definitions
    constant NUMBER_PROCESSORS_X      : integer := 4;
    constant NUMBER_PROCESSORS_Y      : integer := 4;
    constant TAM_BUFFER               : integer := 8;
    constant NUMBER_PROCESSORS        : integer := 16;

    constant IO_NUMBER                : integer := 5;
    constant MAX_TASKS_APP                : integer := 6;
    subtype kernel_str is string(1 to 3);
    subtype manual_io_option is string(1 to 3);
    type manual_io_type is array(0 to NUMBER_PROCESSORS-1) of manual_io_option;
    constant OPEN_IO : manual_io_type := ("wes","sou","gnd","gnd","gnd","gnd","gnd","gnd","gnd","gnd","gnd","gnd","gnd","nor","nor","nor");

end hemps_pkg;
