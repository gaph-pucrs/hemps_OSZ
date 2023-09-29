library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use work.standards.all;
use work.seek_pkg.all;
use work.snip_pkg.all;

entity snip_io_buffer is
    port
    (
        clock   : in    std_logic;
        reset   : in    std_logic;

        w_en    : in    std_logic;
        data_i  : in    regflit;

        r_en    : in    std_logic;
        data_o  : out   regflit;

        flush   : in    std_logic;
        status  : out   BufferStatusType
    );
end entity;

architecture snip_io_buffer of snip_io_buffer is

    type BufferType is array(0 to FIFO_SIZE-1) of regflit;

    signal fifo_buffer  : BufferType;

    signal counter      : integer range 0 to FIFO_SIZE;

    signal r_ptr        : integer range 0 to FIFO_SIZE-1;
    signal w_ptr        : integer range 0 to FIFO_SIZE-1;

    signal underflow    : std_logic;
    signal overflow     : std_logic;

begin

    ReadWrite: process(clock, reset)
    begin
        if reset='1' then

            data_o      <= (others => '0');
            fifo_buffer <= (others => (others => '0'));

            r_ptr       <= 0;
            w_ptr       <= 0;

        elsif rising_edge(clock) then

            if flush='1' then

                data_o      <= (others => '0');
                fifo_buffer <= (others => (others => '0'));

                r_ptr       <= 0;
                w_ptr       <= 0;
            
            else

                -- read

                if r_en='1' then

                    data_o <= fifo_buffer(r_ptr);

                    if r_ptr = FIFO_SIZE-1 then
                        r_ptr <= 0;
                    else
                        r_ptr <= r_ptr + 1;
                    end if;

                end if;

                -- write
                    
                if w_en='1' then

                    fifo_buffer(w_ptr) <= data_i;

                    if w_ptr = FIFO_SIZE-1 then
                        w_ptr <= 0;
                    else
                        w_ptr <= w_ptr + 1;
                    end if;

                end if;
                
            end if;
        end if;
    end process;

    CountElements: process(clock, reset)
    begin
        if reset='1' then
            counter     <= 0;
            underflow   <= '0';
            overflow    <= '0';
        elsif rising_edge(clock) then

            if flush='1' then

                counter     <= 0;
                underflow   <= '0';
                overflow    <= '0';

            -- decrement

            elsif r_en='1' and w_en='0' then

                if counter = 0 then
                    underflow <= '1';
                else
                    counter <= counter - 1;
                end if;

            -- increment

            elsif r_en='0' and w_en='1' then

                if counter = FIFO_SIZE then
                    overflow <= '1';
                else
                    counter <= counter + 1;
                end if;

            end if;

        end if;
    end process;

    status.empty    <= '1' when counter = 0         else '0';
    status.full     <= '1' when counter = FIFO_SIZE else '0';

    status.err      <= underflow or overflow;

end architecture;