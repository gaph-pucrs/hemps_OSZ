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
--  Brief description: Top module of the NoC with security features 
-- 
--------------------------------------------------------------------------------------- 
library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_unsigned.all; 
use work.standards.all; 
use work.hemps_pkg.all; 
 
entity RouterCC_AP is 
generic( address: regmetadeflit_32); 
port( 
	clock                   : in  std_logic; 
	reset                   : in  std_logic; 
	clock_rx                : in  regNport; 
	rx                      : in  regNport; 
	data_in                 : in  arrayNport_regflit; 
	credit_o                : out regNport; 
	eop_in					: in  regNport; 
	access_i				: in  regNport; 
	access_o				: out regNport; 
 
	clock_tx                : out regNport; 
	tx                      : out regNport; 
	data_out                : out arrayNport_regflit; 
	credit_i                :  in regNport; 
	eop_out					: out regNport; 
 
	k1						: in regflit; 
	k2						: in regflit; 
	sz						: in regNport; 
	ap						: in regNport; 
	apThreshold				: in  std_logic_vector(3 downto 0); 
	intAP					: out std_logic; 
 
 
	--Packet blocked by wrapper 
	unreachable				: out regNport; 
 
	target                  : out regflit; 
	source                  : out regflit; 
	w_source_target         : out std_logic; 
	rot_table				: out matrixNportNport_std_logic; 
	w_addr                  : out std_logic_vector(3 downto 0) 
); 
end RouterCC_AP; 
 
architecture RouterCC_AP of RouterCC_AP is 
 
	signal pass:	regNport; 
 
	signal rx_router           	: regNport;         
	signal data_in_router      	: arrayNport_regflit;         
	signal credit_o_router     	: regNport;         
	signal eop_in_router		: regNport; 
 
	signal tx_router           	: regNport;         
	signal data_out_router     	: arrayNport_regflit;         
	signal credit_i_router     	: regNport;         
	signal eop_out_router		: regNport; 
 
	signal ap_rout					:regNport; 
	signal szCH1					:regNport; 
	signal intAPs				: std_logic_vector(3 downto 0); 
 
begin 
 
	coreRouter : Entity work.RouterCC 
	generic map(address => address) 
	port map( 
		clock                   =>	clock, 
		reset                   =>	reset, 
 
		clock_rx				=>  clock_rx, 
		clock_tx				=>  clock_tx, 
 
		rx                      =>	rx_router, 
		data_in                 =>	data_in_router,  
		credit_o                =>	credit_o_router, 
		eop_in					=>	eop_in_router, 
 
		tx                      =>	tx_router, 
		data_out                =>	data_out_router, 
		credit_i                =>	credit_i_router, 
		eop_out					=>	eop_out_router, 
 
		ap						=>	ap_rout, 
 
		target                  =>	target, 
		source                  =>	source, 
		w_source_target         =>	w_source_target, 
		rot_table				=>	rot_table, 
		w_addr                  =>	w_addr 
	); 
 
	unreachable <= access_i OR (sz AND (NOT ap)); 
 
	--Directly connecting local port: 
	rx_router(LOCAL0) <= rx(LOCAL0); 
	data_in_router(LOCAL0) <= data_in(LOCAL0); 
	eop_in_router(LOCAL0) <= eop_in(LOCAL0); 
	credit_o(LOCAL0) <= credit_o_router(LOCAL0); 
 
	tx(LOCAL0) <= tx_router(LOCAL0); 
	data_out(LOCAL0) <= data_out_router(LOCAL0); 
	eop_out(LOCAL0) <= eop_out_router(LOCAL0); 
	credit_i_router(LOCAL0) <= credit_i(LOCAL0); 
 
	--Directly connecting local port: 
	rx_router(LOCAL1) <= rx(LOCAL1); 
	data_in_router(LOCAL1) <= data_in(LOCAL1); 
	eop_in_router(LOCAL1) <= eop_in(LOCAL1); 
	credit_o(LOCAL1) <= credit_o_router(LOCAL1); 
 
	tx(LOCAL1) <= tx_router(LOCAL1); 
	data_out(LOCAL1) <= data_out_router(LOCAL1); 
	eop_out(LOCAL1) <= eop_out_router(LOCAL1); 
	credit_i_router(LOCAL1) <= credit_i(LOCAL1); 
 
	access_o(LOCAL0) <= '0'; 
 	access_o(LOCAL1) <= '0'; 
 
	AP_gen : for i in 0 to 3 generate 
		-- (i*2) = Even 0,2,4,6 = CHANNEL 0 = with AP  
		AP_CH0:	Entity work.Access_Point 
		port map( 
			clock                   => clock, 
			reset                   => reset, 
 
			--Neighbor 
			data_in                 => data_in(i*2), 
			credit_o                => credit_o(i*2), 
			rx                      => rx(i*2), 
			eop_in					=> eop_in(i*2), 
			tx                      => tx(i*2), 
			data_out                => data_out(i*2), 
			credit_i                => credit_i(i*2), 
			eop_out					=> eop_out(i*2), 
			access_i                => access_i(i*2), 
			access_o                => access_o(i*2), 
 
			--Core Router 
			data_in_router          => data_in_router(i*2), 
			credit_o_router         => credit_o_router(i*2), 
			rx_router               => rx_router(i*2), 
			eop_in_router			=> eop_in_router(i*2), 
			data_out_router			=> data_out_router(i*2), 
			credit_i_router			=> credit_i_router(i*2), 
			tx_router				=> tx_router(i*2), 
			eop_out_router			=> eop_out_router(i*2), 
			ap 						=> ap_rout(i*2), 
 
			--Mem Mapped Regs from PE 
			enable					=> ap(i*2), 
			sz						=> sz(i*2), 
			k1						=> k1, 
			k2						=> k2, 
			apThreshold 			=> apThreshold, 
			intAP					=> intAPs(i) 
		); 
 
 
		-- -- (i*2+1) = Odd 1,3,5,7 = CHANNEL 1 = no AP trocar -- apenas wrapper 
		--Directly connecting local port: 
		szCH1 <= sz OR access_i; 
		 
		rx_router(i*2+1) <= rx(i*2+1); 
		data_in_router(i*2+1) <= data_in(i*2+1); 
		eop_in_router(i*2+1) <= eop_in(i*2+1); 
		credit_o(i*2+1) <= credit_o_router(i*2+1); 
 
		tx(i*2+1) <= tx_router(i*2+1) AND (NOT szCH1(i*2+1)); 
		data_out(i*2+1) <= data_out_router(i*2+1); 
		eop_out(i*2+1) <= eop_out_router(i*2+1); 
		credit_i_router(i*2+1) <= credit_i(i*2+1) OR (szCH1(i*2+1)); 
 
		access_o(i*2+1)	<= sz(i*2+1); 
		ap_rout(i*2+1) <= '0'; -- Indicates that there is no AP in this port 
 
		intAP <= or intAPs; 
 
	end generate ; -- identifier 
end RouterCC_AP; 
