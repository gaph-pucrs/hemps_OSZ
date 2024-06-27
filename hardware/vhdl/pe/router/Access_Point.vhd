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
	bop_in					: in  std_logic; 
	--Output 
	tx                      : out std_logic; 
	data_out                : out regflit; 
	credit_i                : in std_logic; 
	eop_out					: out std_logic; 
	bop_out					: out std_logic; 
	-- Access 
	access_i                : in std_logic; 
	access_o                : out std_logic; 
 
	-- Router <-> AP 
	-- Output to Router 
	data_in_router          : out regflit; 
	credit_o_router         : in std_logic; 
	rx_router               : out std_logic; 
	eop_in_router			: out std_logic; 
	bop_in_router			: out std_logic; 
	-- Input from Router 
	data_out_router			: in  regflit; 
	credit_i_router			: out std_logic; 
	tx_router				: in  std_logic; 
	eop_out_router			: in  std_logic; 
	bop_out_router			: in  std_logic; 
 
	change_routing			: out std_logic;  
 
	-- PE -> AP 
	enable					: in  std_logic; 
	sz						: in  std_logic; 
	k1						: in  regflit; 
	k2						: in  regflit; 
	apThreshold				: in  std_logic_vector(7 downto 0);
	auth_status				: out std_logic_vector(2 downto 0);
	intAP					: out std_logic 
 
); 
end Access_Point; 
 
architecture Access_Point of Access_Point is 

	signal pass, ANDauth	:	std_logic;
	signal auth		: std_logic_vector(2 downto 0);

	signal mask		: 	std_logic; 
	signal Cin, Cout: std_logic_vector(8 downto 0); --Counters with 4 bits 
	signal reg_K1	:	std_logic_vector(11 downto 0); 
	signal reg_K2	:	std_logic_vector(11 downto 0);
	signal reg_auth	:	std_logic_vector(2 downto 0);
	signal renew_key:  	std_logic;

	-- alias
	alias data_in12:  std_logic_vector(11 downto 0) is data_in(11 downto 0);
	alias packetType:  std_logic_vector(3 downto 0) is data_in(15 downto 12);
 
begin 
 
	mask <= ((NOT sz) AND (not access_i)) OR enable; 
				    
	-- Wrapper filters (from neighbor) 
	tx 				<= tx_router AND mask; 
	credit_i_router <= credit_i OR (NOT mask);
	eop_out			<=	eop_out_router AND mask; 
	bop_out			<=	bop_out_router AND mask; 


	-- Wrapper filters (from local) 
	access_o <= sz AND (enable NAND pass);
 
	change_routing 	<=	enable; 

	--Output 
	data_out	<=	data_out_router; 
 
	-- Connecting the sides 
	-- Input 
	data_in_router		<=	data_in; 
	credit_o			<=	credit_o_router;
	eop_in_router		<=	eop_in; 
	bop_in_router		<=	bop_in; 
	rx_router			<=	rx;

	-- rx_router			<=	rx and pass;
	-- eop_in_router		<=	eop_in and pass;
	-- bop_in_router		<=	bop_in and pass;

	-- constant KEY_AUTH       : integer := 0;
	-- constant COUNT_AUTH     : integer := 1;
	-- constant TYPE_AUTH      : integer := 2;

	auth(KEY_AUTH) <= 	'1' when (data_in12 XOR reg_K1) = reg_K2 else 
						'0';
	
	auth(COUNT_AUTH) <= '1' when (Cin < Cout) else 
						'0';
	-- auth(COUNT_AUTH) <= '1' when (Cin <= Cout) else --breach to pass an attack packet
	-- 					'0';

	auth(TYPE_AUTH) <= 	'1' when (packetType = IO_PACKET) else 
						'0';
	
	ANDauth <= and auth;

	renew_key <= reg_auth(KEY_AUTH) AND (reg_auth(COUNT_AUTH) NAND reg_auth(TYPE_AUTH));
	
	intAP <= '1' when ((Cout(7 downto 0) > apThreshold)) OR (renew_key) = '1' else -- When the out counter is 0, reached the Threshold 
			 '0'; 

	auth_status <= reg_auth;

	process (clock, reset) -- Registradores Cin, Cout, K1 e K2
	begin 
		if reset = '1' then 
			Cin <= (others => '0'); 
			Cout <= (others => '0');
			reg_K1 <= (others => '0');
			reg_K2 <= (others => '0');
			reg_auth <= (others => '0');
			pass <= '0';
		elsif rising_edge(clock) then 
			if enable = '1' then
				reg_K1 <= k1(11 downto 0);
				reg_K2 <= k2(11 downto 0);
				
				-- REG_AUTH
				if (rx OR renew_key OR pass) then -- caso tenha renew_key, segurar o auth status pro kernel
					reg_auth <= reg_auth;		  -- pass também, pra não perder auth caso caia o crédito
				else
					reg_auth <= auth;
				end if;

				-- PASS
				if ANDauth then
					pass <= '1';
				elsif eop_in then
					pass <= '0';
				end if;
				
				-- Cin
				if (eop_in_router)then 
					Cin <= Cin+1;
				end if;
				
				-- Cout
				if (eop_out_router) then 
					Cout <= Cout+1; 
				end if;

			else
				Cin <= (others => '0'); 
				Cout <= (others => '0');
				reg_K1 <= (others => '1'); -- reg k1 e k2 diferentes
				reg_K2 <= (others => '0'); -- caso contrário, enable vai salvar valor 100, indicando ataque
				reg_auth <= (others => '0');
				pass <= '0';
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
