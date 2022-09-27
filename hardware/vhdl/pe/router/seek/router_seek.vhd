------------------------------------------------------------------
---
--- seek router module 17/07/2015
--
--- File function: Implements an auxiliary NoC using broadcast mode to 
--    send messages with different services
---
--- Responsibles: Luciano L. Caimi, Vinicius M. Fochi, Eduardo Wachter, 
--- 
--- Contact: luciano.caimi@acad.pucrs.br
--
------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use ieee.numeric_std.all;
use work.standards.all;
use work.seek_pkg.all;

entity router_seek is
		generic (
                router_address        			: regflit;
				debug_build 					: boolean := true
        );
		port(
				clock							: in	std_logic;
				reset   						: in	std_logic;

				-- log, desativado ao ser sintetizado LOG ARTUR
				-- synthesis translate_off
				in_tick_counter								: in	std_logic_vector(31 downto 0);
				-- systhensis translate on

				in_source_router_seek           : in	regNportNsource_neighbor;
				in_target_router_seek           : in	regNportNtarget_neighbor;
				in_payload_router_seek			: in	regNportNpayload_neighbor;
				in_service_router_seek			: in 	regNport_seek_bitN_service;
				in_req_router_seek				: in	std_logic_vector(NPORT_SEEK-1 downto 0);
				in_ack_router_seek				: in	std_logic_vector(NPORT_SEEK-1 downto 0);
				in_nack_router_seek				: in	std_logic_vector(NPORT_SEEK-1 downto 0);
				in_fail_router_seek				: in	std_logic_vector(NPORT_SEEK-1 downto 0);
				in_opmode_router_seek			: in	std_logic_vector(NPORT_SEEK-1 downto 0);
													                             
				out_req_router_seek				: out	std_logic_vector(NPORT_SEEK-1 downto 0); 
				out_ack_router_seek				: out	std_logic_vector(NPORT_SEEK-1 downto 0);
				out_nack_router_seek			: out	std_logic_vector(NPORT_SEEK-1 downto 0);				
				out_opmode_router_seek			: out	std_logic_vector(NPORT_SEEK-1 downto 0);				
				out_service_router_seek			: out	regNport_seek_bitN_service;
				out_source_router_seek        	: out	regNportNsource_neighbor;
				out_target_router_seek        	: out	regNportNtarget_neighbor;
				out_payload_router_seek			: out	regNportNpayload_neighbor;
				
				in_sel_reg_backtrack_seek		: in std_logic_vector(1 downto 0);	-- 2 bits de seleção de registrador do backtrack
				out_reg_backtrack_seek			: out std_logic_vector(31 downto 0);	-- 32 bits do registrador do backtrack	
				out_req_send_kernel_seek		: out std_logic;	
				in_ack_send_kernel_seek			: in  std_logic	;
				in_AppID_reg                    : in  regNtarget	
		    );
end entity;  

architecture router_seek of router_seek is
	
	-- FSM States
	-- type T_ea_manager is (S_INIT, ARBITRATION, TEST_SERVICE, SERVICE_BACKTRACK, BACKTRACK_PROPAGATE, INIT_BACKTRACK, PREPARE_NEXT,
	-- 	BACKTRACK_MOUNT, CLEAR_TABLE, COMPARE_TARGET, SEND_LOCAL, PROPAGATE, WAIT_ACK_PORTS, INIT_CLEAR, END_BACKTRACK, COUNT);
	signal EA_manager, PE_manager  : T_ea_manager;

	-- FSM States
	-- type T_ea_manager_input is (S_INIT_INPUT, ARBITRATION_INPUT, LOOK_TABLE_INPUT, TEST_SPACE_AVAIL, SERVICE_INPUT, TABLE_WRITE_INPUT,
	-- 	WRITE_BACKTRACK_INPUT, TEST_SEND_LOCAL, WRITE_CLEAR_INPUT, WAIT_REQ_DOWN, WAIT_REQ_DOWN_NACK, SEND_NACK);
	signal EA_manager_input, PE_manager_input  : T_ea_manager_input;
	--EA (Estado Atual) / PE (Proximo Estado)

	-- Movi as declara��es dos tipos de entradas de tabela e constante REG_BACKTRACK_SIZE para o arquivo seek_pkg

signal	sel_port,next_port,next_port1								: integer range 0 to 4;
signal	sel, prox, prox1,free_index, source_index					: integer range 0 to 7;
signal	int_in_req_router_seek, int_out_ack_router_seek				: std_logic_vector(NPORT_SEEK-1 downto 0);
signal  int_out_req_router_seek, int_in_ack_router_seek				: std_logic_vector(NPORT_SEEK-1 downto 0);
signal	vector_ack_ports, vector_nack_ports							: std_logic_vector(NPORT_SEEK-2 downto 0);
signal	reg_backtrack												: std_logic_vector(REG_BACKTRACK_SIZE-1 downto 0);			
signal	compare_is_source											: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
signal	pending_table, used_table, pending_local, task				: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
signal	opmode_table												: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
signal	compare_bactrack_pending_in_table							: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
signal	compare_searchpath_pending_in_table							: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
signal  compare_service_pending_in_table							: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
signal  count_clear													: std_logic_vector(4 downto 0);
signal	backtrack_port												: std_logic_vector(1 downto 0);
signal  req_task, req_int, is_my_turn_send_backtrack				: std_logic;
signal	in_the_table, space_aval_in_the_table, nack_recv			: std_logic;
signal	backtrack_pending_in_table, searchpath_pending_in_table		: std_logic;
signal  service_pending_in_table									: std_logic;
signal  fail_with_mode_in, fail_with_mode_out						: std_logic_vector(NPORT_SEEK-1 downto 0);
signal	source_table	 											: source_table_type;
signal	target_table	 											: target_table_type;
signal	service_table	 											: service_table_type;
signal	payload_table	 											: payload_table_type;
signal	my_payload_table 											: payload_table_type;
signal	backtrack_port_table										: backtrack_port_table_type; -- porta que chegou a requisição
signal	source_router_port_table									: source_router_port_table_type;
signal  backtrack_id 												: std_logic_vector(TARGET_SIZE-1 downto 0);

alias reg_backtrack_0:std_logic_vector(31 downto 0)   is reg_backtrack(31 downto  0);
alias reg_backtrack_1:std_logic_vector(31 downto 0)   is reg_backtrack(63 downto 32);
alias reg_backtrack_2:std_logic_vector(31 downto 0)   is reg_backtrack(95 downto 64);
  
begin	

--out_reg_backtrack_seek <= reg_backtrack_0 when in_sel_reg_backtrack_seek = "00" else 
--						  reg_backtrack_1 when in_sel_reg_backtrack_seek = "01" else 
--						  reg_backtrack_2 ;

with in_sel_reg_backtrack_seek select 
     out_reg_backtrack_seek <= 	reg_backtrack_0 when "00", 
								reg_backtrack_1 when "01",
								reg_backtrack_2 when others;

	OUTPUT_PORT_WRITE: for j in 0 to (NPORT_SEEK-1) generate  
		 out_source_router_seek(j)	<=	source_table(sel);  
		 out_target_router_seek(j)	<=	target_table(sel);
		 out_service_router_seek(j)	<=	service_table(sel);	
		 out_payload_router_seek(j)	<=  payload_table(sel);
		 out_opmode_router_seek(j)  <=  opmode_table(sel);
	end generate;   
   
   COMPARE_SERVICE: for i in 0 to TABLE_SEEK_LENGHT-1 generate
        
		compare_is_source(i) <= '1' when source_table(i) = in_source_router_seek(sel_port) and used_table(i)='1'
									    else '0';
								    
		compare_bactrack_pending_in_table(i) <= '1' when service_table(i) = BACKTRACK_SERVICE and source_table(i) = in_source_router_seek(sel_port) and pending_table(i) = '1' and used_table(i)='1'
									    else '0';	-- precisa para saber se tem um backtrack pendente na tabela nesse caso não pode entrar nenhum outro backtrack							    

		compare_searchpath_pending_in_table(i) <= '1' when service_table(i) = SEARCHPATH_SERVICE and source_table(i) = in_source_router_seek(sel_port) and pending_table(i) = '1' and used_table(i)='1'
									    else '0';	-- precisa para saber se tem um SEARCHPATH pendente na tabela nesse caso não pode entrar o backtrack							    
    
		compare_service_pending_in_table(i) <= '1' when source_table(i) = in_source_router_seek(sel_port) and pending_table(i) = '1' and used_table(i)='1'
									    else '0';	
    end generate;    

	req_int <= int_in_req_router_seek(EAST) or int_in_req_router_seek(WEST) or int_in_req_router_seek(NORTH) or int_in_req_router_seek(SOUTH) or int_in_req_router_seek(LOCAL); -- or bit a bit da requisição das portas EAST,SOUTH, NORTH, WEST e LOCAL
	task <= used_table and (pending_table or pending_local);
	is_my_turn_send_backtrack <= '1' when (payload_table(sel) - my_payload_table(sel)) = 1 else '0'; 
	nack_recv <= vector_nack_ports(EAST) or vector_nack_ports(WEST) or vector_nack_ports(NORTH) or vector_nack_ports(SOUTH);  
	
	
	
	
-- fail wrapper
  --   int_in_req_router_seek <= in_req_router_seek and not(in_fail_router_seek);
  --   out_ack_router_seek <= int_out_ack_router_seek or in_fail_router_seek;
     
  --   int_in_ack_router_seek <= in_ack_router_seek or in_fail_router_seek;    
  --   out_req_router_seek <= int_out_req_router_seek and not(in_fail_router_seek);

  	 fail_with_mode_in <= in_fail_router_seek and in_opmode_router_seek;
     int_in_req_router_seek <= in_req_router_seek and not(fail_with_mode_in);
     out_ack_router_seek <= int_out_ack_router_seek or fail_with_mode_in;
     
  --    int_in_ack_router_seek <= in_ack_router_seek or fail_with_mode;    
	 -- out_req_router_seek <= int_out_req_router_seek and not(fail_with_mode);
	 fail_with_mode_out(EAST)  <= in_fail_router_seek(EAST)  and opmode_table(sel);
	 fail_with_mode_out(WEST)  <= in_fail_router_seek(WEST)  and opmode_table(sel);
	 fail_with_mode_out(NORTH) <= in_fail_router_seek(NORTH) and opmode_table(sel);
	 fail_with_mode_out(SOUTH) <= in_fail_router_seek(SOUTH) and opmode_table(sel);
	 fail_with_mode_out(LOCAL) <= in_fail_router_seek(LOCAL) and opmode_table(sel);

    int_in_ack_router_seek <= in_ack_router_seek or fail_with_mode_out;
	--  int_in_ack_router_seek <= in_ack_router_seek;    
    
	out_req_router_seek <= int_out_req_router_seek and not(fail_with_mode_out); 
	--  out_req_router_seek <= int_out_req_router_seek;  
    




-- Dependent code: VHDL 2008 -> directive -2008 to compile     
      in_the_table 	<=  or compare_is_source; 
      req_task		<=	or task;
      backtrack_pending_in_table <= or compare_bactrack_pending_in_table; -- precisa para saber se tem um backtrack pendente na tabela nesse caso não pode entrar nenhum outro backtrack							    
      searchpath_pending_in_table <= or compare_searchpath_pending_in_table; -- precisa para saber se tem um seachpath pendente na tabela nesse caso não pode entrar o backtrack ainda					    
	  space_aval_in_the_table <=  nand used_table;	
	  service_pending_in_table <= or compare_service_pending_in_table;

-----------------------------------------------------------------------
					
process(reset, clock)--processo que trata a logica do proximo estado do FSM manager
begin
			   if reset = '1' then
					EA_manager_input  <= S_INIT_INPUT;				
			   elsif clock'event and clock='1' then     
					EA_manager_input <= PE_manager_input;
		       end if;
end process;

----
----  INPUT TABLE DATA PATH  - lógica sequencial do circuito de inserção na tabela
----
process(clock, reset)--processo que gerencia cada estado manager
begin
		if reset = '1' then
			int_out_ack_router_seek 	<= (others => '0');
			sel_port             		<= LOCAL;
			count_clear 				<= (others => '0');		
 			pending_table				<= (others => '0');
 			pending_local				<= (others => '0');
 			used_table					<= (others => '0');	
 			opmode_table				<= (others => '1');	
			out_nack_router_seek 	  	<= (others => '0');
					
		elsif clock'event and clock='1' then   
				case EA_manager_input is
					when S_INIT_INPUT =>	
						int_out_ack_router_seek(sel_port) 			<= '0';
					    out_nack_router_seek(sel_port) 				<= '0';
					
					when WAIT_REQ_DOWN	=>
						int_out_ack_router_seek(sel_port) 		<= '1';

					when ARBITRATION_INPUT =>
						sel_port <= next_port;				
						
					when LOOK_TABLE_INPUT =>																		
																												    
					when TEST_SPACE_AVAIL =>  																		
						if in_the_table = '1' and ( in_service_router_seek(sel_port) /= BACKTRACK_SERVICE and in_service_router_seek(sel_port) /= CLEAR_SERVICE) then -- (TESTAR ---> ) and in_service_router_seek(sel_port) /= CLEAR_SERVICE then
							int_out_ack_router_seek(sel_port) 		<= '1';
						elsif in_the_table = '0' and in_service_router_seek(sel_port) = CLEAR_SERVICE then
							int_out_ack_router_seek(sel_port) 		<= '1';
						end if;
						if in_the_table = '1' and sel_port = LOCAL and in_service_router_seek(sel_port) /= CLEAR_SERVICE then
						--if in_the_table = '1' and in_service_router_seek(sel_port) /= CLEAR_SERVICE then
							-- report "SERVICE " & CONV_STRING_8BITS("000" & in_service_router_seek(sel_port)) & " from LOCAL not added to the table! POSSIBLE ERROR!!!!";
						end if;
									
					when TABLE_WRITE_INPUT =>			
						int_out_ack_router_seek(sel_port) 			<= '1';					
						source_table(free_index) 					<=	in_source_router_seek(sel_port);   	
						target_table(free_index) 					<=	in_target_router_seek(sel_port);   	
						service_table(free_index) 					<=  in_service_router_seek(sel_port);
						opmode_table(free_index)					<=  in_opmode_router_seek(sel_port);
						backtrack_port_table(free_index)			<=	std_logic_vector(to_unsigned(sel_port, 3));
						pending_table(free_index)					<= '1';
						pending_local(free_index)					<= '0';
						used_table(free_index)						<= '1';												
						if in_service_router_seek(sel_port) = SEARCHPATH_SERVICE or  in_service_router_seek(sel_port) = BACKTRACK_SERVICE then
							payload_table(free_index) 						<=  in_payload_router_seek(sel_port)+1;
						else
							payload_table(free_index) 				<=  in_payload_router_seek(sel_port);
						end if;
										
					when WRITE_CLEAR_INPUT =>	
						int_out_ack_router_seek(sel_port) 			<= '1';
						service_table(source_index) 				<=  CLEAR_SERVICE;
						pending_table(source_index)					<= '1';
						--clear is broadcasted to all ports by setting backtrack port to LOCAL
						backtrack_port_table(source_index)			<=	std_logic_vector(to_unsigned(LOCAL, 3));
						
					when WRITE_BACKTRACK_INPUT =>						
						int_out_ack_router_seek(sel_port) 			<= '1';
						service_table(source_index) 				<= BACKTRACK_SERVICE;
						target_table(source_index)					<= in_target_router_seek(sel_port);
						payload_table(source_index) 				<= in_payload_router_seek(sel_port);
						pending_table(source_index)					<= '1';
						my_payload_table(source_index)				<= payload_table(source_index);
						source_router_port_table(source_index)		<= std_logic_vector(to_unsigned(sel_port, 2));
						
					when SEND_NACK =>
						if int_out_ack_router_seek(sel_port) = '0' then 
							out_nack_router_seek(sel_port) 				<= '1';	
						else
							out_nack_router_seek(sel_port) 				<= '0';	
						end if;	
					when others => 
					
				end case;	
---------------------------------------------------------------------------------------------------------------
				case  EA_manager is 
				    when WAIT_ACK_PORTS =>   
						--if nack_recv = '0' then
						--	pending_table(sel)		<=  '0';
			            --else
						--	pending_table(sel)		<=  '1';
						--end;
						if  ((vector_ack_ports or vector_nack_ports) = "1111" )  then
							pending_table(sel)		<= nack_recv; -- veja como funciona acima
						end if;	
						
				    when CLEAR_TABLE =>   
						if(EA_manager_input = S_INIT_INPUT) then
							pending_table(sel)		<=  '0';
							pending_local(sel)		<=  '0';
							used_table(sel)			<=  '0';
							if  target_table(sel) = router_address and used_table(sel) = '1' then 
							--	report "end CLEAR: " 
							--	 & CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
							--	 & CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
							--	 & CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
							--	 & CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
							--	 & CONV_STRING_8BITS("000" & service_table(sel)) & " " 
							--	 & CONV_STRING_8BITS("00"&payload_table(sel)) 
							--	 & " " & CONV_STRING_4BITS( CONV_VECTOR4(TABLE_SEEK_LENGHT ) );
								 
							end if;							
						end if;

					when SEND_LOCAL =>		
						if int_in_ack_router_seek(LOCAL) = '1' then
			            	pending_table(sel)		<=  '0';
			            	pending_local(sel)		<=  '0';
						elsif in_nack_router_seek(LOCAL) = '1' then
			            	--pending_table(sel)		<=  '1';
			            	pending_local(sel)		<=  '1';
			            end if;			            

					when INIT_BACKTRACK =>	
						pending_table(sel)		<= '1';		
						target_table(sel) 		<= (TARGET_SIZE-1 downto 2 => '0') & backtrack_port_table(sel)(1 DOWNTO 0);   	
						service_table(sel) 		<= BACKTRACK_SERVICE;
						--source_table(sel)		<= (others	=> '0') & source_table(sel)(TARGET_SIZE-1 downto  0);
					
					when PREPARE_NEXT =>
						pending_table(sel)		<=  is_my_turn_send_backtrack;  -- veja como funciona acima
						target_table(sel)		<=  (TARGET_SIZE-1 downto 2 => '0') & source_router_port_table(sel);
						payload_table(sel)		<=  my_payload_table(sel);				
						 
					when BACKTRACK_MOUNT =>	
			            pending_table(sel)		<=  '0';
			            payload_table(sel) 			<=  my_payload_table(sel);		            
			            
			        when S_INIT =>    	
			            count_clear 			<= "00000"; 

			        when COUNT =>
			        	count_clear <= count_clear(3 downto 0)&'1';
			        	--count_clear <= "00001";
			        
			        when INIT_CLEAR =>
			        	if (count_clear >= "11111") then
			        		service_table(sel) 		<=  CLEAR_SERVICE;	
							pending_table(sel)		<= '1';
							backtrack_port_table(source_index)			<=	std_logic_vector(to_unsigned(LOCAL, 3));
			        	end if;

					when others => null;

				end case;
		end if;
end process;			

----
----  INPUT TABLE FSM process  2 - computa o próximo estado a partir dos valores atuais de estado e sinais de controle - lógica combinacional
----
--process(EA_manage, todos os sinais de if)
process(PE_manager, EA_manager, EA_manager_input, req_int, in_the_table, space_aval_in_the_table, backtrack_pending_in_table, searchpath_pending_in_table, in_req_router_seek, compare_service_pending_in_table, sel_port, in_service_router_seek, service_pending_in_table)
begin
		case EA_manager_input is		

			when S_INIT_INPUT =>			
				if req_int = '1' then 
					PE_manager_input	<= 	ARBITRATION_INPUT;						
				else
					PE_manager_input	<=	S_INIT_INPUT;	 
				end if;				
							
			when ARBITRATION_INPUT =>				
				PE_manager_input <= LOOK_TABLE_INPUT;
				
			when LOOK_TABLE_INPUT =>			
				PE_manager_input <= TEST_SPACE_AVAIL;
			
			when TEST_SPACE_AVAIL =>
				--if sel =  source_index then
				--	PE_manager_input <= SEND_NACK;
				--elsif space_aval_in_the_table = '1' then 								
				if space_aval_in_the_table = '1' then 								
					PE_manager_input <= SERVICE_INPUT;
				elsif in_service_router_seek(sel_port) = CLEAR_SERVICE and in_the_table = '1' and space_aval_in_the_table = '0' and sel /=  source_index then --Se for um serviço de clear & e o source já estiver na tabela & tabela está cheia
				--elsif in_service_router_seek(sel_port) = CLEAR_SERVICE and in_the_table = '1' and space_aval_in_the_table = '0' then --Se for um serviço de clear & e o source já estiver na tabela & tabela está cheia
					PE_manager_input	<=	WRITE_CLEAR_INPUT;	 					
				elsif in_service_router_seek(sel_port) = BACKTRACK_SERVICE and in_the_table = '1' and space_aval_in_the_table = '0' 
				and backtrack_pending_in_table = '0' and searchpath_pending_in_table = '0'then 
				-- Se for um serviço de backtrack & e o source já estiver na tabela & tabela está cheia
				-- Serve para caso a tabela estiver cheia o serviço de backtrack possa substituir o search_path 
				   if EA_manager /= WAIT_ACK_PORTS then -- se  o tratamento da mensagem anterior ainda não teminou não pode sobrescrever pois o pending ficará em 0 "matando" a backtrack
						PE_manager_input	<=	WRITE_BACKTRACK_INPUT;-- avaliar se não basta fazer as comparaçṍes de clear_service e backtrack aqui no test_space_avial trocando a ordem das comparações
				   else 
						PE_manager_input <= SEND_NACK;
				   end if;
				else 																
					PE_manager_input <= SEND_NACK;	 -- se não houver espaço e não for CLEAR nem BACKTRACK manda nack para o roteador
				end if;
				
			when SERVICE_INPUT =>
				-- if in_service_router_seek(sel_port) = CLEAR_SERVICE and sel =  source_index and pending_table(sel) = '1' then -- se chegou um CLEAR e a máquina 2 está tratando o seek, dá um nack para reescalonar depois
				-- 	PE_manager_input <= SEND_NACK;
				-- els
				if  in_service_router_seek(sel_port) /= CLEAR_SERVICE and service_pending_in_table = '1' then
					PE_manager_input <= SEND_NACK;
				elsif in_service_router_seek(sel_port) = BACKTRACK_SERVICE	  and (backtrack_pending_in_table = '1' or searchpath_pending_in_table = '1') then
					PE_manager_input <= SEND_NACK;
				elsif in_service_router_seek(sel_port) = BACKTRACK_SERVICE  and backtrack_pending_in_table = '0'  then
					PE_manager_input <= WRITE_BACKTRACK_INPUT;
				elsif in_service_router_seek(sel_port) = CLEAR_SERVICE and in_the_table = '1' then 
					PE_manager_input <= TEST_SEND_LOCAL; 
				elsif in_service_router_seek(sel_port) /= CLEAR_SERVICE  and in_the_table = '0' then -- não é um serviço de clear e ele não está na tabela // escreve ele na tabela
					PE_manager_input <= TABLE_WRITE_INPUT;
				else 
					PE_manager_input <= WAIT_REQ_DOWN;
				end if;				
				
			when TEST_SEND_LOCAL => 
				if PE_manager = SEND_LOCAL or PE_manager = COMPARE_TARGET  then
					PE_manager_input	<= 	TEST_SEND_LOCAL;						
				else
					PE_manager_input	<=	WRITE_CLEAR_INPUT;	 
				end if;

			when WAIT_REQ_DOWN	=>
				if in_req_router_seek(sel_port) = '1' then 
					PE_manager_input	<= 	WAIT_REQ_DOWN;						
				else
					PE_manager_input	<=	S_INIT_INPUT;	 
				end if;

			when WAIT_REQ_DOWN_NACK	=>
				if in_req_router_seek(sel_port) = '1' then 
					PE_manager_input	<= 	WAIT_REQ_DOWN_NACK;						
				else
					PE_manager_input	<=	S_INIT_INPUT;	 
				end if;
				

			when SEND_NACK	=>
				PE_manager_input<=	WAIT_REQ_DOWN_NACK;	

			when others =>
				PE_manager_input	<=	WAIT_REQ_DOWN;			
		end case;
end process;		

----
----  PROCESSING DATA PATH  - lógica sequencial - contém todos dos registradores necessários ao circuito 
----
process(clock, reset)--processo que gerencia cada estado manager
	begin
		if reset = '1' then
					sel             			<= ROW0;
					vector_ack_ports			<= (others => '0');
					vector_nack_ports			<= (others => '0');
					reg_backtrack				<= (others => '0');
					backtrack_id 				<= (others => '1');--value invalid
					out_req_send_kernel_seek	<= '0';
					
		elsif clock'event and clock='1' then   
				case EA_manager is
					when S_INIT =>	
						
						vector_ack_ports		<= (others => '0');
						vector_nack_ports		<= (others => '0');
						int_out_req_router_seek		<= (others => '0');
						out_req_send_kernel_seek <= '0';
						
					when ARBITRATION =>
							sel <= prox;						
											     	                        
					when TEST_SERVICE=>
						backtrack_port 			<= backtrack_port_table(sel)(1 DOWNTO 0);
						if source_table(sel)(TARGET_SIZE-1 downto 0) = router_address and service_table(sel) = BACKTRACK_SERVICE and backtrack_id = x"FFFF" then
							backtrack_id 		<= source_table(sel)(SOURCE_SIZE-1 downto TARGET_SIZE);
						end if;

					when BACKTRACK_MOUNT =>			
						reg_backtrack 			<= reg_backtrack(REG_BACKTRACK_SIZE - 3 downto 0) & target_table(sel)(1 downto 0);		            					
					
					when END_BACKTRACK =>	
						reg_backtrack 			<= reg_backtrack(REG_BACKTRACK_SIZE - 3 downto 0) & source_router_port_table(sel);
						backtrack_id 			<= (others => '1');
						
					when BACKTRACK_PROPAGATE =>							
						int_out_req_router_seek(to_integer(unsigned(backtrack_port)))	<= '1';
										
					when PREPARE_NEXT =>
						int_out_req_router_seek(to_integer(unsigned(backtrack_port))) 	<= '0';						
						
					when SEND_LOCAL =>
						if (service_table(sel) = SEND_KERNEL_SERVICE) then
							out_req_send_kernel_seek <= '1';
						else
							int_out_req_router_seek(LOCAL)     	<= '1';
						end if;	

						
					when PROPAGATE =>							
						for j in 0 to (NPORT_SEEK-2) loop  
						--if (j /= to_integer(unsigned((backtrack_port_table(sel)))))  then       -- Backtrack local, CLEAR não passava                
							--if (j /= to_integer(unsigned((backtrack_port_table(sel)))) OR service_table(sel) = CLEAR_SERVICE)  then   
							if (j /= to_integer(unsigned((backtrack_port))) OR service_table(sel) = CLEAR_SERVICE)  then   
								int_out_req_router_seek(j)	<= '1';
							end if;
						end loop;	
					
					when WAIT_ACK_PORTS =>

						--do not execute acks when backtrack port is local
						-- if backtrack_port_table(sel) /= x"4" then
						-- if (backtrack_port_table(sel) /= x"4" and service_table(sel) /= CLEAR_SERVICE) then
						if (backtrack_port /= x"4" and service_table(sel) /= CLEAR_SERVICE) then
							vector_ack_ports(to_integer(unsigned(backtrack_port_table(sel)(1 DOWNTO 0)))) <= '1';
						end if;
						for j in 0 to (NPORT_SEEK-2) loop  
--							if (int_in_ack_router_seek(j) = '1' or in_nack_router_seek(j) = '1') then
							if (int_in_ack_router_seek(j) = '1') then
								vector_ack_ports(j) 	<= '1';
								int_out_req_router_seek(j) 	<= '0';							
							end if;
							
							if (in_nack_router_seek(j) = '1') then
								vector_nack_ports(j) 	<= '1';
								int_out_req_router_seek(j) 	<= '0';							
							end if;
							
						end loop;
						
					when CLEAR_TABLE =>	
						int_out_req_router_seek <= (others => '0');
						
					when others => null;				
				end case;
		end if;
end process;

----
----  PROCESSING DATA FSM process 1 - atribui o proximo estado calculado ao estado atual - lógica sequencial
----
process(reset, clock)--processo que trata a logica do proximo estado do FSM manager
begin
			   if reset = '1' then
					EA_manager  <= S_INIT;				
			   elsif clock'event and clock='1' then     
					EA_manager <= PE_manager;
		       end if;
end process;

----
---- PROCESSING DATA FSM process  2 - computa o próximo estado a partir dos valores atuais de estado e sinais de controle - lógica compinacional
----
--process(EA_manage, todos os sinais de if)
process(EA_manager, req_task , source_table, service_table, target_table, payload_table, used_table, opmode_table, space_aval_in_the_table, int_in_ack_router_seek, in_nack_router_seek, vector_ack_ports, sel, backtrack_port, vector_nack_ports, in_ack_send_kernel_seek, count_clear)
	begin
		case EA_manager is
			when S_INIT =>			
				if req_task = '1' then 
					PE_manager	<= 	ARBITRATION;						
				else
					PE_manager	<=	S_INIT;	 
				end if;	
				
			when ARBITRATION =>
				PE_manager <= TEST_SERVICE;	
							 
			when TEST_SERVICE=>
				if (pending_table(sel) = '1') and (service_table(sel) = CLEAR_SERVICE or service_table(sel) = SET_SECURE_ZONE_SERVICE or service_table(sel) = START_APP_SERVICE 
					or  service_table(sel) = OPEN_SECURE_ZONE_SERVICE or  service_table(sel) = GMV_READY_SERVICE or  service_table(sel) = FREEZE_TASK_SERVICE or  service_table(sel) = UNFREEZE_TASK_SERVICE 
					or  service_table(sel) = INITIALIZE_SLAVE_SERVICE or  service_table(sel) = NEW_APP_ACK_SERVICE or  service_table(sel) = NEW_APP_SERVICE or  service_table(sel) = INITIALIZE_CLUSTER_SERVICE 
					or  service_table(sel) = LOAN_PROCESSOR_REQUEST_SERVICE or  service_table(sel) = LOAN_PROCESSOR_RELEASE_SERVICE
					or  service_table(sel) = SET_EXCESS_SZ_SERVICE    or service_table(sel) = BR_TO_APPID_SERVICE) then 
					PE_manager <= PROPAGATE;
				-- 	or service_table(sel) = MSG_REQUEST_CONTROL
				elsif (pending_table(sel) = '1') and (service_table(sel) = BACKTRACK_SERVICE) then
					PE_manager <= SERVICE_BACKTRACK;
				elsif pending_local(sel) = '1' then
					PE_manager <= SEND_LOCAL;
				else
					PE_manager <= COMPARE_TARGET; 
				end if;
	 
			when CLEAR_TABLE =>	
				if used_table(sel) = '0' then
					PE_manager <= S_INIT;
				else
					PE_manager <= CLEAR_TABLE;
				end if;
				
			when COMPARE_TARGET =>
				if target_table(sel) /= router_address then
					PE_manager <= PROPAGATE;
				elsif service_table(sel) = SEARCHPATH_SERVICE and target_table(sel) = router_address  then -- é o target e tem que disparar o backtrack
					PE_manager <= INIT_BACKTRACK;
				else
					PE_manager <= SEND_LOCAL;
				end if;	

			when INIT_BACKTRACK =>
				PE_manager <= S_INIT;
				--report "INIT_BACKTRACK: " 
				--& CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
				--	& CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
				--	& CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
				--	& CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
				--	& CONV_STRING_8BITS("00"&payload_table(sel));
							
			when SERVICE_BACKTRACK =>
--				report "SERVICE_BACKTRACK: " 
--				& CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
--					& CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
--					& CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
--					& CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
--					& CONV_STRING_8BITS(backtrack_id(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & "" 
--					& CONV_STRING_8BITS(backtrack_id(TARGET_SIZE_HALF-1 downto 0)) ;
				if  source_table(sel)(TARGET_SIZE-1 downto 0) /= router_address then
					PE_manager <= BACKTRACK_PROPAGATE;
				elsif source_table(sel)(SOURCE_SIZE-1 downto TARGET_SIZE) = backtrack_id then
					PE_manager <= BACKTRACK_MOUNT;
				else
					PE_manager <= S_INIT;
				end if;					
	
			when BACKTRACK_MOUNT =>
--				report "BACKTRACK_MOUNT: " ;
				if payload_table(sel) = "000010"   then
					PE_manager <= END_BACKTRACK;	
				else	
					PE_manager <= S_INIT;
				end if;	
				
			when END_BACKTRACK =>	
					PE_manager <= SEND_LOCAL;
								
			when INIT_CLEAR =>

				if count_clear /= "11111" then
					PE_manager <= COUNT;
				else	
					PE_manager <= S_INIT ;	
				end if;	

			when COUNT =>
				
				PE_manager <= INIT_CLEAR;	
								
			when BACKTRACK_PROPAGATE =>				 
				if int_in_ack_router_seek(to_integer(unsigned(backtrack_port))) = '1' then
					PE_manager <= PREPARE_NEXT;					
				elsif in_nack_router_seek(to_integer(unsigned(backtrack_port))) = '1' then
					PE_manager <= S_INIT;
				else 
					PE_manager <= BACKTRACK_PROPAGATE; 
				end if;				
												
			when PREPARE_NEXT => 
					PE_manager <= S_INIT;		 						
		
			when SEND_LOCAL =>
				if (int_in_ack_router_seek(LOCAL) = '1'  and service_table(sel) = BACKTRACK_SERVICE) then
					PE_manager <= INIT_CLEAR;
					--report "END_BACKTRACK: " & CONV_STRING_32BITS(reg_backtrack(95 downto 64)) & CONV_STRING_32BITS(reg_backtrack(63 downto 32)) & CONV_STRING_32BITS(reg_backtrack(31 downto 0))& " " & CONV_STRING_8BITS(router_address(15 downto 8)) & " "  & CONV_STRING_8BITS(router_address(7 downto 0));
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = END_TASK_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = END_TASK_OTHER_CLUSTER_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = TASK_ALLOCATED_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = SET_SZ_RECEIVED_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = RCV_FREEZE_TASK_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = TARGET_UNREACHABLE_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = MASTER_CANDIDATE_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = WAIT_KERNEL_SERVICE ) then
					PE_manager <= INIT_CLEAR;	
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = WAIT_KERNEL_SERVICE_ACK ) then
					PE_manager <= INIT_CLEAR;	
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = MSG_DELIVERY_CONTROL ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = SET_AP_SERVICE ) then
					PE_manager <= INIT_CLEAR;	
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = MSG_REQUEST_CONTROL ) then
					PE_manager <= INIT_CLEAR;		
				elsif (in_ack_send_kernel_seek = '1'  and  service_table(sel) = SEND_KERNEL_SERVICE ) then 
					PE_manager <= INIT_CLEAR;
				elsif (in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = FAIL_KERNEL_SERVICE ) then 
					PE_manager <= INIT_CLEAR;	
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = SECURE_ZONE_CLOSED_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = SECURE_ZONE_OPENED_SERVICE ) then
					PE_manager <= INIT_CLEAR;
				elsif (int_in_ack_router_seek(LOCAL) = '1'  and  service_table(sel) = WARD_SERVICE  ) then
					PE_manager <= INIT_CLEAR;	
				elsif (int_in_ack_router_seek(LOCAL) = '1' ) then
					PE_manager <= S_INIT;
					--report "SEND LOCAL: " 
					--& CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
					--& CONV_STRING_8BITS(source_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " " 
					--& CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE-1 downto TARGET_SIZE_HALF)) & " " 
					--& CONV_STRING_8BITS(target_table(sel)(TARGET_SIZE_HALF-1 downto 0)) & " "
					--& CONV_STRING_8BITS("000" & service_table(sel))	& " " 
					--& CONV_STRING_8BITS("00"  & payload_table(sel));
				else 
					PE_manager <= SEND_LOCAL;
				end if;
				
			when PROPAGATE =>	
				PE_manager <= WAIT_ACK_PORTS;
				
			when WAIT_ACK_PORTS =>
				if ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = START_APP_SERVICE  and (source_table(sel)(15 downto 0)) /=  router_address then  	
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" ) and  service_table(sel) = BR_TO_APPID_SERVICE and  (target_table(sel) =  in_AppID_reg) then
						PE_manager <= SEND_LOCAL;		
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = INITIALIZE_CLUSTER_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = INITIALIZE_SLAVE_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = NEW_APP_SERVICE then
					PE_manager <= SEND_LOCAL;					
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = LOAN_PROCESSOR_REQUEST_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = LOAN_PROCESSOR_RELEASE_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = SET_SECURE_ZONE_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = SET_EXCESS_SZ_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = OPEN_SECURE_ZONE_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = FREEZE_TASK_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = GMV_READY_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;	
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = UNFREEZE_TASK_SERVICE and source_table(sel)(15 downto 0) /= router_address then
					PE_manager <= SEND_LOCAL;
				elsif ((vector_ack_ports or vector_nack_ports) = "1111" )  and service_table(sel) = CLEAR_SERVICE then
					PE_manager <= CLEAR_TABLE;				
				elsif  ((vector_ack_ports or vector_nack_ports) = "1111" )   then  	
					PE_manager <= S_INIT;
				else
					PE_manager <= WAIT_ACK_PORTS;
				end if;
				
			when others => 
				PE_manager <= S_INIT;
		end case;
end process;

process(sel_port, int_in_req_router_seek ) -- ROUND ROBIN for port selection
	begin
-------------------------prioridade para atendimento do serviço de CLEAR  - FSM1	
		case sel_port is        
				when EAST => 
						if 	  int_in_req_router_seek(WEST)='1' then  next_port1<=WEST;
						elsif int_in_req_router_seek(NORTH)='1' then next_port1<=NORTH; 
						elsif int_in_req_router_seek(SOUTH)='1' then next_port1<=SOUTH;
						elsif int_in_req_router_seek(LOCAL)='1' then next_port1<=LOCAL;
						else next_port1<=EAST; end if;					
												
				when WEST => 
						if 	  int_in_req_router_seek(NORTH)='1' then next_port1<=NORTH;
						elsif int_in_req_router_seek(SOUTH)='1' then next_port1<=SOUTH;
						elsif int_in_req_router_seek(LOCAL)='1' then next_port1<=LOCAL;
						elsif int_in_req_router_seek(EAST)='1' then  next_port1<=EAST;
						else next_port1<=WEST; end if;				
												
				when NORTH =>				
						if    int_in_req_router_seek(SOUTH)='1' then next_port1<=SOUTH;
						elsif int_in_req_router_seek(LOCAL)='1' then next_port1<=LOCAL;
						elsif int_in_req_router_seek(EAST)='1' then  next_port1<=EAST;
						elsif int_in_req_router_seek(WEST)='1' then  next_port1<=WEST;
						else next_port1<=NORTH; end if;			
										
				when SOUTH => 
						if    int_in_req_router_seek(LOCAL)='1' then next_port1<=LOCAL;
						elsif int_in_req_router_seek(EAST)='1' then  next_port1<=EAST; 
						elsif int_in_req_router_seek(WEST)='1' then  next_port1<=WEST;
						elsif int_in_req_router_seek(NORTH)='1' then next_port1<=NORTH;
						else next_port1<=SOUTH; end if;
						
				when LOCAL => 
						if    int_in_req_router_seek(EAST)='1' then  next_port1<=EAST; 
						elsif int_in_req_router_seek(WEST)='1' then  next_port1<=WEST;
						elsif int_in_req_router_seek(NORTH)='1' then next_port1<=NORTH;
						elsif int_in_req_router_seek(SOUTH)='1' then next_port1<=SOUTH;
						else next_port1<=LOCAL; end if;	
							
				when others => next_port1<=LOCAL;
		end case;
end process;
-------------------------prioridade para atendimento do serviço de CLEAR  - FSM1
 next_port <= EAST  when int_in_req_router_seek(EAST)= '1' and in_service_router_seek(EAST)  = CLEAR_SERVICE else
              WEST  when int_in_req_router_seek(WEST)= '1' and in_service_router_seek(WEST)  = CLEAR_SERVICE else
              NORTH when int_in_req_router_seek(NORTH)='1' and in_service_router_seek(NORTH) = CLEAR_SERVICE else
              SOUTH when int_in_req_router_seek(SOUTH)='1' and in_service_router_seek(SOUTH) = CLEAR_SERVICE else
              LOCAL when int_in_req_router_seek(LOCAL)='1' and in_service_router_seek(LOCAL) = CLEAR_SERVICE else
              next_port1; 
 
 

----------------------- if - generate ----------------------------------------

-------------------------  LENGTH 8  -----------------------------------------	  
IF_GEN_8: if TABLE_SEEK_LENGHT = 8 generate  

    --in_the_table 	           <= compare_is_source(0) or compare_is_source(1) or compare_is_source(2) or compare_is_source(3) or compare_is_source(4) or compare_is_source(5) or compare_is_source(6) or compare_is_source(7) ; 
    --req_task		           <= task(0) or task(1) or task(2) or task(3) or task(4) or task(5) or task(6) or task(7) ; 
    --backtrack_pending_in_table <= compare_bactrack_pending_in_table(0) or compare_bactrack_pending_in_table(1) or compare_bactrack_pending_in_table(2) or compare_bactrack_pending_in_table(3) or compare_bactrack_pending_in_table(4) or compare_bactrack_pending_in_table(5) or compare_bactrack_pending_in_table(6) or compare_bactrack_pending_in_table(7) ; 
    --searchpath_pending_in_table <= compare_searchpath_pending_in_table(0) or compare_searchpath_pending_in_table(1) or compare_searchpath_pending_in_table(2) or compare_searchpath_pending_in_table(3) or compare_searchpath_pending_in_table(4) or compare_searchpath_pending_in_table(5) or compare_searchpath_pending_in_table(6) or compare_searchpath_pending_in_table(7) ; 
    --service_pending_in_table   <= compare_service_pending_in_table(0) or compare_service_pending_in_table(1) or compare_service_pending_in_table(2) or compare_service_pending_in_table(3) or compare_service_pending_in_table(4) or compare_service_pending_in_table(5) or compare_service_pending_in_table(6) or compare_service_pending_in_table(7);
 	--space_aval_in_the_table    <= not (used_table(0) and used_table(1) and used_table(2) and used_table(3) and used_table(4) and used_table(5) and used_table(6) and used_table(7) ) ;     	  

	  
-- Table lenght dependent 
    ----  só usa este índice quando space_aval_in_the_table for '1' indica indice da posição livre na tabela
    free_index <= 	0   when used_table(0)='0'  else
					1   when used_table(1)='0'  else
					2   when used_table(2)='0'  else
					3   when used_table(3)='0'  else
					4   when used_table(4)='0'  else
					5   when used_table(5)='0'  else
					6   when used_table(6)='0'  else
					7   ;

---- indice do source encontrado na tabela 
    source_index <= 0   when compare_is_source(0)='1'  else
					1   when compare_is_source(1)='1'  else
					2   when compare_is_source(2)='1'  else
					3   when compare_is_source(3)='1'  else
					4   when compare_is_source(4)='1'  else
					5   when compare_is_source(5)='1'  else
					6   when compare_is_source(6)='1'  else
					7   ; 	

process(sel,task) -- ROUND ROBIN for table task selection
begin
		case sel is
            when ROW0 => 
				if task(ROW1)='1' then    prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
                elsif task(ROW4)='1' then prox<=ROW4;
				elsif task(ROW5)='1' then prox<=ROW5;
                elsif task(ROW6)='1' then prox<=ROW6; 
				elsif task(ROW7)='1' then prox<=ROW7;
                else prox<=ROW0; end if;
                
            when ROW1 => 
				if task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
			    elsif task(ROW4)='1' then  prox<=ROW4;
				elsif task(ROW5)='1' then  prox<=ROW5;
			    elsif task(ROW6)='1' then prox<=ROW6; 
				elsif task(ROW7)='1' then prox<=ROW7;
				elsif task(ROW0)='1' then prox<=ROW0;
                else prox<=ROW1; end if;
								
            when ROW2 => 
				if    task(ROW3)='1' then prox<=ROW3;
				elsif task(ROW4)='1' then  prox<=ROW4;
				elsif task(ROW5)='1' then  prox<=ROW5;
                elsif task(ROW6)='1' then prox<=ROW6; 
				elsif task(ROW7)='1' then prox<=ROW7;
				elsif task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				else prox<=ROW2; end if;
					
			when ROW3 => 
				if    task(ROW4)='1' then  prox<=ROW4;
				elsif task(ROW5)='1' then  prox<=ROW5;
                elsif task(ROW6)='1' then prox<=ROW6; 
				elsif task(ROW7)='1' then prox<=ROW7;
				elsif task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;				
				else prox<=ROW3; end if;
							
            when ROW4 => 
				if    task(ROW5)='1' then  prox<=ROW5;
				elsif task(ROW6)='1' then prox<=ROW6; 
				elsif task(ROW7)='1' then prox<=ROW7;
				elsif task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
				else prox<=ROW4; end if;
					
			when ROW5 => 
				if    task(ROW6)='1' then prox<=ROW6; 
				elsif task(ROW7)='1' then prox<=ROW7;
				elsif task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
				elsif task(ROW4)='1' then  prox<=ROW4;				
				else prox<=ROW5; end if;
							
            when ROW6 =>
				if 	  task(ROW7)='1' then prox<=ROW7;
				elsif task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
				elsif task(ROW4)='1' then  prox<=ROW4;
				elsif task(ROW5)='1' then  prox<=ROW5;
				else prox<=ROW6; end if;
					
			when ROW7 =>
				if    task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
				elsif task(ROW4)='1' then  prox<=ROW4;
				elsif task(ROW5)='1' then  prox<=ROW5;
				elsif task(ROW6)='1' then prox<=ROW6;                
				else prox<=ROW7; end if;
			           					
			when others => NULL;
       end case;
 end process;
					
end generate;	  
------------------------------------------------------------------------------


-------------------------  LENGTH 4  -----------------------------------------	  
IF_GEN_4: if TABLE_SEEK_LENGHT = 4 generate

    --in_the_table 				<= compare_is_source(0) or compare_is_source(1) or compare_is_source(2) or compare_is_source(3); 
    --req_task					<= task(0) or task(1) or task(2) or task(3); 
    --backtrack_pending_in_table 	<= compare_bactrack_pending_in_table(0) or compare_bactrack_pending_in_table(1) or compare_bactrack_pending_in_table(2) or compare_bactrack_pending_in_table(3) ; 
    --searchpath_pending_in_table <= compare_searchpath_pending_in_table(0) or compare_searchpath_pending_in_table(1) or compare_searchpath_pending_in_table(2) or compare_searchpath_pending_in_table(3); 
    --service_pending_in_table   <= compare_service_pending_in_table(0) or compare_service_pending_in_table(1) or compare_service_pending_in_table(2) or compare_service_pending_in_table(3) ;
 	--space_aval_in_the_table 	<= not (used_table(0) and used_table(1) and used_table(2) and used_table(3));     	  

-- Table lenght dependent 
    ----  só usa este índice quando space_aval_in_the_table for '1' indica indice da posição livre na tabela
    free_index <= 	0   when used_table(0)='0'  else
					1   when used_table(1)='0'  else
					2   when used_table(2)='0'  else
					3   ;

---- indice do source encontrado na tabela 
    source_index <= 0   when compare_is_source(0)='1'  else
					1   when compare_is_source(1)='1'  else
					2   when compare_is_source(2)='1'  else
					3   ; 
				
process(sel,task) -- ROUND ROBIN for table task selection
begin
		case sel is
            when ROW0 => 
				if    task(ROW1)='1' then    prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
                else  prox<=ROW0; end if;
                
            when ROW1 => 
				if    task(ROW2)='1' then prox<=ROW2;
				elsif task(ROW3)='1' then prox<=ROW3;
				elsif task(ROW0)='1' then prox<=ROW0;
                else  prox<=ROW1; end if;
								
            when ROW2 => 
				if    task(ROW3)='1' then prox<=ROW3;
				elsif task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				else  prox<=ROW2; end if;
					
			when ROW3 => 
				if 	  task(ROW0)='1' then prox<=ROW0;
				elsif task(ROW1)='1' then prox<=ROW1;
				elsif task(ROW2)='1' then prox<=ROW2;				
				else  prox<=ROW3; end if;
		           					
			when others => NULL;
		end case;
		
 end process;
					
end generate;
	  
-- log, desativado ao ser sintetizado
-- synthesis translate_off
gen_test_count: if (debug_build) generate
	get_signals: entity work.logging
	generic map (
		router_address => router_address
	)
	port map (
		clock => clock,
		reset => reset,
		in_tick_counter => in_tick_counter,
		EA_manager => EA_manager,
		EA_manager_input	 => EA_manager_input,

		in_source_router_seek => in_source_router_seek,
		in_target_router_seek => in_target_router_seek,
		in_service_router_seek => in_service_router_seek,
		in_payload_router_seek => in_payload_router_seek,

		in_req_router_seek => in_req_router_seek,
		in_ack_router_seek => in_ack_router_seek,
		in_nack_router_seek => in_nack_router_seek,
		in_fail_router_seek => in_fail_router_seek,
		in_opmode_router_seek => in_opmode_router_seek,

		in_sel_reg_backtrack_seek => in_sel_reg_backtrack_seek,
		in_ack_send_kernel_seek	=> in_ack_send_kernel_seek,

		out_req_router_seek => out_req_router_seek,
		out_ack_router_seek => out_ack_router_seek,
		out_nack_router_seek => out_nack_router_seek,
		out_opmode_router_seek => out_opmode_router_seek,

		out_service_router_seek => out_service_router_seek,
		out_source_router_seek => out_source_router_seek,
		out_target_router_seek => out_target_router_seek,
		out_payload_router_seek => out_payload_router_seek,

		out_reg_backtrack_seek => out_reg_backtrack_seek,
		out_req_send_kernel_seek => out_req_send_kernel_seek,

		sel_port => sel_port,
		next_port => next_port,
		next_port1 => next_port1,
		sel => sel,
		prox => prox,
		prox1 => prox1,
		free_index => free_index,
		source_index => source_index,
		int_in_req_router_seek => int_in_req_router_seek,
		int_out_ack_router_seek => int_out_ack_router_seek,
		int_out_req_router_seek => int_out_req_router_seek,
		int_in_ack_router_seek => int_in_ack_router_seek,
		vector_ack_ports => vector_ack_ports,
		vector_nack_ports => vector_nack_ports,
		reg_backtrack => reg_backtrack,
		compare_is_source => compare_is_source,
		pending_table => pending_table,
		used_table => used_table,
		pending_local => pending_local,
		task => task,
		opmode_table => opmode_table,
		compare_bactrack_pending_in_table => compare_bactrack_pending_in_table,
		compare_searchpath_pending_in_table => compare_searchpath_pending_in_table,
		compare_service_pending_in_table => compare_service_pending_in_table,
		count_clear => count_clear,														
		backtrack_port => backtrack_port,
		req_task => req_task,
		req_int => req_int,
		is_my_turn_send_backtrack => is_my_turn_send_backtrack,
		in_the_table => in_the_table,
		space_aval_in_the_table => space_aval_in_the_table,
		nack_recv => nack_recv,
		backtrack_pending_in_table => backtrack_pending_in_table,
		searchpath_pending_in_table => searchpath_pending_in_table,
		service_pending_in_table => service_pending_in_table,
		fail_with_mode_in => fail_with_mode_in,
		fail_with_mode_out => fail_with_mode_out,
		source_router_port_table => source_router_port_table,
		backtrack_id => backtrack_id
	);
end generate gen_test_count;
-- systhensis translate_on

end router_seek;