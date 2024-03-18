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
generic (
	router_address        			: regflit
);
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
	unr_link_controls		: in regNport;
	unr_internal			: in std_logic;

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

	signal reg_target		:regNtarget; -- 16
	signal reg_source		:regNsource; -- 32
	signal ask_unr,sending	:std_logic;
	signal LCflag			:std_logic;
	signal prev_lcs			:regNport;
	signal lc_counter		:regNpayload; --(8 bits) tamanho para enviar pelo payload
	signal lc_timer			:std_logic_vector(9 downto 0); -- 10 bits contador de 1024 (10 us)
	-- Buffer subtypes
    constant    SLC_BUFFER_SIZE		: integer := 4;
	type	buff_source_type	is array (SLC_BUFFER_SIZE-1 downto 0) of regNsource;
	type	buff_target_type	is array (SLC_BUFFER_SIZE-1 downto 0) of regNtarget;
	type	buff_service_type	is array (SLC_BUFFER_SIZE-1 downto 0) of seek_bitN_service;
	type	buff_payload_type	is array (SLC_BUFFER_SIZE-1 downto 0) of regNpayload;
	-- type	buff_payload_type	is array (SLC_BUFFER_SIZE-1 downto 0) of regNpayload;

	-- Signals Buffer
	signal  buffer_source : buff_source_type;
	signal	buffer_target : buff_target_type;
	signal	buffer_payload: buff_payload_type;
	signal	buffer_service: buff_service_type;
	signal	buffer_opmode : std_logic_vector(SLC_BUFFER_SIZE-1 downto 0);
	-- signal	buffer_used   : std_logic_vector(SLC_BUFFER_SIZE-1 downto 0);
	signal 	first,last: std_logic_vector(1 downto 0);
	signal no_space: std_logic;

	type state_in is (S0, INPE, INLC, CONTLC, WAITREQ, SNACK, SACK);
	signal EA_IN, PE_IN : state_in;

	type state_out is (SInit, SSend, SWaitAck);
	signal EA_OUT, PE_OUT : state_out;

	alias packetType:  std_logic_vector(3 downto 0) is reg_target(15 downto 12);


begin
	LCflag <= OR unr_link_controls;

	process(clock,reset)
	begin
		if reset = '1' then 
			reg_target <= (others => '0'); 
			reg_source <= (others => '0');
			prev_lcs <= (others => '0');
			lc_counter <= (others => '0');
			ask_unr <= '0';
		elsif rising_edge(clock) then
			if LCflag = '1' and ask_unr = '0' and prev_lcs = x"0000" then
				-- if (lc_counter >= x"10") OR (unr_internal = '1') then
				-- 	lc_counter <= (others => '0');
				-- 	reg_source <= router_address & unr_target; -- brNoC source targeting the source of blocked packet
				-- 	reg_target <= unr_source; -- Message targeting the source of blocked packet
				-- 	ask_unr <= '1';
				-- else
				-- 	lc_counter <= lc_counter+1;
				-- end if;
				lc_counter <= (others => '0');
				reg_source <= unr_target & router_address; -- brNoC source targeting the source of blocked packet
				reg_target <= unr_source; -- Message targeting the source of blocked packet
				ask_unr <= '1';
				prev_lcs <= unr_link_controls;

			elsif prev_lcs /= unr_link_controls then -- One message per blocked packet
				prev_lcs <= (others => '0');
			end if;
			if (EA_IN = INLC) and (no_space = '0') then -- Waits the message to be sent
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
				if (EA_IN = INLC) and (no_space = '0') then
					sending <= '0';
				end if;
			elsif pe_req = '0' and ask_unr = '1' then
				sending <= '1';
			end if;
		end if;
	end process;

	process (clock,reset)
	begin
		if reset = '1' then 
			EA_IN <= S0;
		elsif rising_edge(clock) then
			EA_IN <= PE_IN;
		end if;
	end process;

	-- process (clock,reset)
	-- begin
	-- 	if reset = '1' then 
	-- 		lc_timer <= "0111111111"; -- 512 pra testar
	-- 	elsif rising_edge(clock) then
	-- 		if lc_counter = 0 then -- Assim que contar o primeiro pacote, solta a contagem regressiva até zero
	-- 			lc_timer <= "0111111111";
	-- 		elsif lc_timer > 0 then -- Segura o valor em 0 até o próximo pacote chegar e resetar o contador
	-- 			lc_timer <= lc_timer - 1;
	-- 		end if;
	-- 	end if;
	-- end process;

	process(pe_req, EA_IN, sending)
	begin
		case EA_IN is
			when S0 =>
				if no_space = '1' then
					PE_IN <= SNACK;
				elsif pe_req = '1' then
					PE_IN <= INPE;
				elsif sending = '1' then
					PE_IN <= INLC;
				else
					PE_IN <= S0;
				end if;
			when INPE =>
				PE_IN <= WAITREQ;
			-- when CONTLC =>
			-- 	if lc_counter = 10 then
			-- 		PE_IN <= INLC;
			-- 	else
			-- 		PE_IN <= S0;
			-- 	end if;	
			when INLC =>
				PE_IN <= S0;
			when SNACK =>
				PE_IN <= WAITREQ;
			when WAITREQ =>
				if pe_req = '0' then
					PE_IN <= S0;
				else
					PE_IN <= WAITREQ;
				end if;
			when others =>
				PE_IN <= S0;
		end case;
	end process;

	no_space <= '1' when first+1 = last else
				'0';

	-- Ack and Nack to PE
	pe_ack		<=  '1' 	when EA_IN = INPE else
					pe_ack 	when EA_IN = WAITREQ else
					'0';
				
	pe_nack		<=  '1' 	when EA_IN = SNACK else
					pe_nack when EA_IN = WAITREQ else
					'0';


	process(clock,reset)
	begin
		if reset = '1' then
			first 			<= (others => '0');
			buffer_source  <= (others => (others => '0'));
			buffer_target  <= (others => (others => '0'));
			buffer_payload <= (others => (others => '0'));
			buffer_service <= (others => (others => '0'));
			buffer_opmode  <= (others => '0');
		elsif rising_edge(clock) then
				if (EA_IN = INPE) and (no_space = '0') then
					buffer_source(CONV_INTEGER(first))  	<= pe_source;  
					buffer_target(CONV_INTEGER(first))  	<= pe_target;  
					buffer_payload(CONV_INTEGER(first))		<= pe_payload; 
					buffer_service(CONV_INTEGER(first)) 	<= pe_service; 
					buffer_opmode(CONV_INTEGER(first))  	<= pe_opmode;
					first <= first+1;     
				elsif (EA_IN = INLC) and (no_space = '0') then
					buffer_source(CONV_INTEGER(first))  	<= reg_source;
					buffer_opmode(CONV_INTEGER(first))  	<= '0';    
					if (unr_internal = '1') or (packetType = x"6") or (packetType = x"5") or (packetType = x"1") then
						buffer_service(CONV_INTEGER(first)) 	<= LC_NOTIFICATION;
						buffer_target(CONV_INTEGER(first))  	<= x"0007";  -- Master addr 
						buffer_payload(CONV_INTEGER(first))		<= unr_link_controls(7 downto 0);
					else 
						buffer_service(CONV_INTEGER(first)) 	<= TARGET_UNREACHABLE_SERVICE;
						buffer_target(CONV_INTEGER(first))  	<= (reg_target and x"0fff"); 
						buffer_payload(CONV_INTEGER(first))		<= unr_link_controls(7 downto 0); --x"AA";
					end if;
					-- if  (packetType /= x"6") then
					-- 	buffer_service(CONV_INTEGER(first)) 	<= TARGET_UNREACHABLE_SERVICE;
					-- 	buffer_target(CONV_INTEGER(first))  	<= (reg_target and x"0fff");
					-- else -- if internal, outro serviço?
					-- 	buffer_service(CONV_INTEGER(first)) 	<= LC_NOTIFICATION;
					-- 	buffer_target(CONV_INTEGER(first))  	<= x"0003";  
					-- end if;
					first <= first+1; 
				end if;					

		end if;
	end process;


	-- type state_out is (SInit, SSend, SWaitAck);
	-- signal EA_OUT, PE_OUT : state_out;
	seek_target 	<= buffer_target(CONV_INTEGER(last)); 
	seek_source 	<= buffer_source(CONV_INTEGER(last)); 
	seek_payload	<= buffer_payload(CONV_INTEGER(last));
	seek_service	<= buffer_service(CONV_INTEGER(last));
	seek_opmode 	<= buffer_opmode(CONV_INTEGER(last));
	-- buffer_used	(CONV_INTEGER(first))    	<= '1';

	process(clock,reset)
	begin
		if reset = '1' then
			EA_OUT <= SInit;
			seek_req <= '0';
			last 	 <= (others => '0');  
			-- buffer_used    <= (others => '0');
		elsif rising_edge(clock) then
			case EA_OUT is
				when SInit =>
					if last /= first then
						EA_OUT <= SSend;	
					end if;
				when SSend =>
					seek_req 		<= '1';  
					EA_OUT <= SWaitAck;   	
				when SWaitAck =>
					if seek_ack = '1' then
						EA_OUT <= SInit;
						last <= last +1;
						-- buffer_used(CONV_INTEGER(last)) <= '0'; 
						seek_req 		<= '0';  
					elsif seek_nack = '1' then
						EA_OUT <= SInit;
						seek_req 		<= '0';  
					else
						EA_OUT <= SWaitACK;
					end if;
				when others =>
					EA_OUT <= SInit;
			end case;
		end if;
	end process;

end Seek_Local_Controller; 