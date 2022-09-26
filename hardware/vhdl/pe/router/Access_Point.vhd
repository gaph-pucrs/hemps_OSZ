------------------------------------------------------------------------------------------------
--
--  DISTRIBUTED HEMPS  - version 5.0
--
--  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
--
--  Distribution:  September 2013
--
--  Source name:  RouterCC_AP.vhd
--
--  Brief description: Top module of the NoC - the NoC is built using only this module
--
---------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.standards.all;
use work.hemps_pkg.all;

entity Access_Point is
port(
	clock                   : in  std_logic;
	reset                   : in  std_logic;

	-- AP <-> Out
	-- Input
	data_in                 : in  regflit;
	credit_o                : out std_logic;
	rx                      : in  std_logic;
	eop_in					: in  std_logic;
	--Output
	tx                      : out std_logic;
	data_out                : out regflit;
	credit_i                : in std_logic;
	eop_out					: out std_logic;
	-- Access
	access_i                : in std_logic;
	access_o                : out std_logic;

	-- Router <-> AP
	-- Output to Router
	data_in_router          : out regflit;
	credit_o_router         : in std_logic;
	rx_router               : out std_logic;
	eop_in_router			: out std_logic;
	-- Input from Router
	data_out_router			: in  regflit;
	credit_i_router			: out std_logic;
	tx_router				: in  std_logic;
	eop_out_router			: in  std_logic;

	ap						: out std_logic; 

	-- PE -> AP
	enable					: in  std_logic;
	sz						: in  std_logic;
	k1						: in  regflit;
	k2						: in  regflit
);
end Access_Point;

architecture Access_Point of Access_Point is

	signal pass:	std_logic;
	signal mask: 	std_logic;

	signal reg_F1	:	regflit;
	signal reg_F2	:	regflit;
	signal flit_counter: std_logic_vector(5 downto 0);
	signal invalid , eop_ap, terminate 	:std_logic;
	signal mask_rx: std_logic;

begin


	mask <= ((NOT sz) AND (not access_i)) OR enable;
				   
	-- Wrapper filters (from neighbor)
	tx <= tx_router AND mask;
	credit_i_router <= credit_i OR (NOT mask);

	-- Wrapper filters (from local)
	access_o <= sz AND (NOT enable);
	
	-- Connecting the sides
	-- Input
	data_in_router		<=	data_in;
	credit_o			<=	credit_o_router;
	rx_router			<=	rx AND mask_rx;
	-- eop_in_router		<=	eop_in;
	eop_in_router		<=	eop_ap when (terminate = '1') else
							eop_in;
	--Output
	data_out	<=	data_out_router;
	eop_out		<=	eop_out_router;

	ap 	<=	enable;

	pass <= '1' when (reg_F1 XOR k1) = k2 else
			'0';

	-- Authentication process
	packetAuth: process(clock, reset)
	variable counter : integer;
	begin		  	   
		if (reset = '1') then
			counter	:= 0;
			reg_F1	<= (others => '0');	
			reg_F2	<= (others => '0');	
			terminate <= '0';
			eop_ap <= '0';
			mask_rx <= '1';
		elsif rising_edge(clock) then
			if (rx = '1') and (enable = '1') then
				-- Save flits according to counter
				case counter is
					when SERVICE_F1 => -- Read Service HI
						reg_F1 <= data_in;
					when SERVICE_F2 => -- Read Service LO
						reg_F2 <= data_in;
						-- terminate <= '1';
					when SERVICE_F2 + 1 => -- After having the Service
						if (pass = '0') then -- Service /= IO_DELIVERY or _ACK
							terminate <= '1'; -- Cancel sending
							eop_ap <= '1';	  -- Force EOP						
						end if; -- ELSE, terminate is not set, following the eop_in
					when others =>
						eop_ap <= '0';	-- Lowers EOP from cancelling packet
				end case;
				mask_rx <= NOT terminate; -- Rx must recieve terminate delayed 1cycle, to properly send the EOP
				-- Counter increment and reset in case of eop
				if eop_in = '1' then
					counter := 0;
					terminate <= '0'; -- resets terminate in case of dropped packet
				else
					counter	:= counter + 1;
				end if;	
			end if;	
	
		end if;
	end process;
end Access_Point;


	-- Mapa de Karnaugh for masking signals
	--	   a_i  sz  en  | mask_tx
	-- 		A	B	C	|  Y
	-- 0	0	0	0	|  1   -- Normal = 1 (not masking tx)
	-- 1	0	0	1	|  x   -- sz0 en1 never happens
	-- 2	0	1	0	|  0   -- sz1 en0, mask tx
	-- 3	0	1	1	|  1   -- sz1 en1 = AP, dont mask tx
	-- 4	1	0	0	|  0   -- a_i1, from nbohr, mask tx
	-- 5	1	0	1	|  x   -- sz0 en1 never happens 
	-- 6	1	1	0	|  0   -- adjascent SZs, mask tx
	-- 7	1	1	1	|  x   -- ai1 sz1 never happens (AP on adjascent SZs?)

	-- maskTX | maskCI ~~> maskTX = NOT maskCI
	--  1     |  0   -- Normal = 0 (not masking credit)
	--  x     |  x   -- sz0 en1 never happens
	--  0     |  1   -- sz1 en0, mask credit
	--  1     |  0   -- sz1 en1 = AP, dont mask credit
	--  0     |  1   -- a_i1, from nbohr, mask credit
	--  x     |  x   -- sz0 en1 never happens 
	--  0     |  1   -- adjascent SZs, mask credit
	--  x     |  x   -- ai1 sz1 never happens (AP on adjascent SZs?)
