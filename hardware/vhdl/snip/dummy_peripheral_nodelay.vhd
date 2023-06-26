library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;

entity dummy_peripheral is
    port
    (
        clock               : in    std_logic;
        reset               : in    std_logic;

        r_en                : out   std_logic;
        w_en                : out   std_logic;

        data_in             : in    regflit;
        data_out            : out   regflit;

        space_unavailable   : in    std_logic;
        data_unavailable    : in    std_logic
    );
end entity;

architecture dummy_peripheral of dummy_peripheral is

    constant BUFFER_SIZE : integer := 64;

    type FlitArray is array(0 to BUFFER_SIZE-1) of regflit;

    signal buffer_in    : FlitArray;
    signal buffer_out   : FlitArray;

    signal ptr_in       : integer range 0 to BUFFER_SIZE-1;
    signal ptr_out      : integer range 0 to BUFFER_SIZE-1;

begin

    ----------
    -- Read --
    ----------

    r_en <= not data_unavailable;

    ReceiveData: process(clock, reset)
    begin
        if reset='1' then
            buffer_in <= (others => (others => '0'));
        elsif rising_edge(clock) and r_en='1' then
            buffer_in(ptr_in) <= data_in;
        end if;
    end process;

    UpdatePointerIn: process(clock, reset)
    begin
        if reset='1' then
            ptr_in <= 0;
        elsif rising_edge(clock) and r_en='1' then
            if ptr_in=BUFFER_SIZE-1 then
                ptr_in <= 0;
            else
                ptr_in <= ptr_in + 1;
            end if;
        end if;
    end process;

    -----------
    -- Write --
    -----------

    w_en <= not space_unavailable;

    data_out <= buffer_out(ptr_out);

    SetBufferOut: process(reset)
        variable index  : integer   := 0;
        variable value  : regflit   := (others=>'1');
    begin
        if reset='1' then
            while index < BUFFER_SIZE loop
                buffer_out(index) <= value;
                index := index + 1;
                value := value - 1;
            end loop;
        end if;
    end process;

    UpdatePointerOut: process(clock, reset)
    begin
        if reset='1' then
            ptr_out <= 0;
        elsif rising_edge(clock) and w_en='1' then
            if ptr_out=BUFFER_SIZE-1 then
                ptr_out <= 0;
            else
                ptr_out <= ptr_out + 1;
            end if;
        end if;
    end process;

end architecture;
