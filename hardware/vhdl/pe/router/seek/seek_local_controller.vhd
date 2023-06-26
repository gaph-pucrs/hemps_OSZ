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
use work.seek_pkg.all;
use work.hemps_pkg.all; 

entity Seek_Local_Controller is 
port( 
	clock                   : in  std_logic; 
	reset                   : in  std_logic; 
 
	-- PE local 
	pe_target          		: in  regNtarget;
	pe_source          		: in  regNsource; 
	pe_service         		: in  seek_bitN_service; 
	pe_payload          	: in  regNpayload; 
	pe_opmode          		: in  std_logic; 
	pe_req          		: in  std_logic;

	pe_ack					: out  std_logic;
	pe_nack					: out  std_logic;

	-- Barriers
	unr_target				: in regflit;
	unr_source				: in regflit;
	unr_service				: in regNport;

	-- brNoC
	seek_target          	: out  regNtarget;
	seek_source          	: out  regNsource; 
	seek_payload          	: out  regNpayload;
	seek_service         	: out  seek_bitN_service;  
	seek_opmode          	: out  std_logic; 
	seek_req          		: out  std_logic;

	seek_ack				: in  std_logic;
	seek_nack				: in  std_logic

); 
end Seek_Local_Controller; 
 
architecture Seek_Local_Controller of Seek_Local_Controller is 

	signal reg_target		:regflit;
	signal reg_source		:regflit;
	signal ask_unr,sending	:std_logic;
	signal ORunr_service	:std_logic;
	signal prev_unreach		:regNport;

	alias packetType:  std_logic_vector(3 downto 0) is reg_source(15 downto 12);


begin
	ORunr_service <= OR unr_service;

	seek_source  <= reg_target & reg_target when sending else 
					pe_source;
	
	seek_target  <= reg_source 	when ((sending = '1') AND (packetType /= x"6")) else
					x"0004" 	when sending else 
					pe_target;

	seek_service <= TARGET_UNREACHABLE_SERVICE when ((sending = '1') AND (packetType /= x"6")) else
					LC_NOTIFICATION when (sending) else
					pe_service;

	seek_payload <= x"AA" when sending else
					pe_payload;

	seek_opmode  <= '0' when sending else
					pe_opmode;

	seek_req   	 <= pe_req or sending;

	-- Ack and Nack to PE
	pe_ack		<= '0' when sending else
					seek_ack;

	pe_nack		<= '0' when sending else
					seek_nack;

	process(clock,reset)
	begin
		if reset = '1' then 
			reg_target <= (others => '0'); 
			reg_source <= (others => '0');
			prev_unreach <= (others => '0');
			ask_unr <= '0';
		elsif rising_edge(clock) then 
			if ORunr_service = '1' and ask_unr = '0' and prev_unreach = x"0000" then
				reg_target <= unr_target;
				reg_source <= unr_source(15 downto 0);
				ask_unr <= '1';
				prev_unreach <= unr_service;
			elsif prev_unreach /= unr_service then
				prev_unreach <= (others => '0');
			end if;
			if sending and seek_ack then
				ask_unr <= '0';
			end if;
		end if;
	end process;	

	process (clock,reset)
	begin
		if reset = '1' then 
			sending <= '0';
		elsif rising_edge(clock) then
			if sending = '1' then
				if seek_ack or seek_nack then
					sending <= '0';
				end if;
			elsif pe_req = '0' and ask_unr = '1' then
				sending <= '1';
			end if;
		end if;

	end process;

end Seek_Local_Controller; 