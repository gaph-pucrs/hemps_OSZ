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
	k2						: in  regflit; 
	apThreshold				: in  std_logic_vector(7 downto 0); 
	intAP					: out std_logic 
 
); 
end Access_Point; 
 
architecture Access_Point of Access_Point is 

	signal pass, auth:	std_logic; 
	signal mask: 	std_logic; 
	signal Cin, Cout: std_logic_vector(8 downto 0); --Counters with 4 bits 
	signal reg_K1	:	std_logic_vector(11 downto 0); 
	signal reg_K2	:	std_logic_vector(11 downto 0); 
	alias data_in12:  std_logic_vector(11 downto 0) is data_in(11 downto 0);
	alias packetType:  std_logic_vector(3 downto 0) is data_in(15 downto 12);

	-- signal invalid , eop_ap, terminate 	:std_logic; 
	-- signal mask_rx: std_logic; 
 
begin 
 
	mask <= ((NOT sz) AND (not access_i)) OR enable; 
				    
	-- Wrapper filters (from neighbor) 
	tx <= tx_router AND mask; 
	credit_i_router <= credit_i OR (NOT mask); 
 
	-- Wrapper filters (from local) 
	access_o <= sz AND (NOT enable); 
 
	ap 	<=	enable; 
	--Output 
	data_out	<=	data_out_router; 
	eop_out		<=	eop_out_router; 
 
	-- Connecting the sides 
	-- Input 
	data_in_router		<=	data_in; 
	credit_o			<=	credit_o_router;
	rx_router			<=	rx and pass;
	eop_in_router	<=	eop_in;

	auth <= '1' when ((data_in12 XOR reg_K1) = reg_K2) AND (Cin < Cout) AND (packetType = IO_PACKET) else 
			'0'; 

	intAP <= '1' when (Cout(7 downto 0) > apThreshold and enable = '1') else -- When the out counter is 0, reached the Threshold 
			 '0'; 
 
	process (clock, reset) -- Controle do pass 
	begin
		if reset = '1' then 
			pass <= '0'; 
		elsif rising_edge(clock) then 		
			if enable = '0' then
				pass <= '1';
			elsif auth = '1' and enable = '1' then -- Se autenticar o 1 flit, aciona pass
				pass <= '1';
			elsif pass = '1' then -- Mantem pass até o eop
				if eop_in = '1' then
					pass <= '0';
				end if;
			else				-- Mantém pass em 0 até outro auth
				pass <= '0';
			end if;
		end if;
	end process;
 
	process (clock, reset) -- Registradores Cin, Cout, K1 e K2
	begin 
		if reset = '1' then 
			Cin <= (others => '0'); 
			Cout <= (others => '0');
			reg_K1 <= (others => '0');
			reg_K2 <= (others => '0');
		elsif rising_edge(clock) then 
			if (auth  and enable and rx)then 
				Cin <= Cin+1; 
			elsif (apThreshold = 0) then 
				Cin <= (others => '0'); 
			else 
				Cin <= Cin; 
			end if; 
 
			if (eop_out_router = '1' and (enable = '1') ) then 
				Cout <= Cout+1; 
			elsif (apThreshold = 0) then 
				Cout <= (others => '0'); 
			else 
				Cout<=Cout; 
			end if;
			
			if enable = '1' then
				reg_K1 <= k1(11 downto 0);
				reg_K2 <= k2(11 downto 0);
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
