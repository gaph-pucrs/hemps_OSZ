------------------------------------------------------------------
---
--- Logging 
--
--- File function: Implements an auxiliary NoC using broadcast mode to
--    send messages with different services
---
--- Responsibles:  Artur B. Mallmann, Luciano L. Caimi
---
--- Contact: arturbmallmann@gmail.com, luciano.caimi@acad.pucrs.br
--
------------------------------------------------------------------

-- synthesis translate_off
library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use ieee.numeric_std.all;

-- pra escrita em arquivos
use std.textio.all;

use work.standards.all;
use work.seek_pkg.all;

entity logging is
	generic (
		router_address        			: regflit -- tamanho dos endere�amentos � de 16bits, ou seja 2 bytes ou 4 nibbles podendo ser representado como 4 hexadecimais
	);
	port(

		clock															: in	std_logic;
		reset															: in	std_logic;
		in_tick_counter													: in	std_logic_vector(31 downto 0);
		EA_manager														: in T_ea_manager;
		EA_manager_input												: in T_ea_manager_input;

		------------------------------------------------------in-------------------------------------------
		in_source_router_seek											: in regNportNsource_neighbor;
		in_target_router_seek											: in regNportNtarget_neighbor;
		in_service_router_seek											: in regNport_seek_bitN_service;
		in_payload_router_seek											: in regNportNpayload_neighbor;

		in_req_router_seek												: in std_logic_vector(NPORT_SEEK-1 downto 0);
		in_ack_router_seek												: in std_logic_vector(NPORT_SEEK-1 downto 0);
		in_nack_router_seek												: in std_logic_vector(NPORT_SEEK-1 downto 0);
		in_fail_router_seek												: in std_logic_vector(NPORT_SEEK-1 downto 0);
		in_opmode_router_seek											: in std_logic_vector(NPORT_SEEK-1 downto 0);

		in_sel_reg_backtrack_seek										: in std_logic_vector(1 downto 0);	-- 2 bits de sele��o de registrador do backtrack
		in_ack_send_kernel_seek											: in std_logic;
		------------------------------------------------------out-------------------------------------------
		out_req_router_seek												: in std_logic_vector(NPORT_SEEK-1 downto 0);
		out_ack_router_seek												: in std_logic_vector(NPORT_SEEK-1 downto 0);
		out_nack_router_seek											: in std_logic_vector(NPORT_SEEK-1 downto 0);
		out_opmode_router_seek											: in std_logic_vector(NPORT_SEEK-1 downto 0);

		out_service_router_seek											: in regNport_seek_bitN_service;
		out_source_router_seek											: in regNportNsource_neighbor;
		out_target_router_seek											: in regNportNtarget_neighbor;
		out_payload_router_seek											: in regNportNpayload_neighbor;

		out_reg_backtrack_seek											: in std_logic_vector(31 downto 0);	-- 32 bits do registrador do backtrack
		out_req_send_kernel_seek										: in std_logic;
		
		------------------------------------------------------signal-------------------------------------------
		sel_port														: in integer range 0 to 4;
		next_port														: in integer range 0 to 4;
		next_port1														: in integer range 0 to 4;

		sel																: in integer range 0 to 7;
		prox															: in integer range 0 to 7;
		prox1															: in integer range 0 to 7;
		free_index														: in integer range 0 to 7;
		source_index													: in integer range 0 to 7;

		int_in_req_router_seek, int_out_ack_router_seek					: in std_logic_vector(NPORT_SEEK-1 downto 0);
		int_out_req_router_seek, int_in_ack_router_seek					: in std_logic_vector(NPORT_SEEK-1 downto 0);
		vector_ack_ports, vector_nack_ports								: in std_logic_vector(NPORT_SEEK-2 downto 0);
		reg_backtrack													: in std_logic_vector(REG_BACKTRACK_SIZE-1 downto 0);
		compare_is_source												: in std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		pending_table, used_table, pending_local, task					: in std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		opmode_table													: in std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		compare_bactrack_pending_in_table								: in std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		compare_searchpath_pending_in_table								: in std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		compare_service_pending_in_table								: in std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		count_clear														: in std_logic_vector(4 downto 0);
		backtrack_port													: in std_logic_vector(1 downto 0);
		req_task, req_int, is_my_turn_send_backtrack					: in std_logic;
		in_the_table, space_aval_in_the_table, nack_recv				: in std_logic;
		backtrack_pending_in_table, searchpath_pending_in_table			: in std_logic;
		service_pending_in_table										: in std_logic;
		fail_with_mode_in, fail_with_mode_out							: in std_logic_vector(NPORT_SEEK-1 downto 0);

		source_router_port_table										: in source_router_port_table_type;
		backtrack_id													: in std_logic_vector(TARGET_SIZE-1 downto 0)

	);
			
	signal output_state	: std_logic_vector(3 downto 0);
	signal input_state	: std_logic_vector(3 downto 0);
	signal seek_cycles	: integer range 0 to 2**16;

	-- converter o endere�o em string
	function print_router (	vec :std_logic_vector(15 downto 0)) -- valor de 16 bits
	return string is
		-- variable str1,str2: string(1 to 2);
		variable output_str: string(1 to 5);
	begin
		-- este tipo de concatena��o deve ser feito atrav�s de recurs�o
		output_str := CONV_STRING_8BITS(vec(15 downto 8)) & "x" & CONV_STRING_8BITS(vec(7 downto 0));
		return output_str;
	end function;

	function bit_to_string ( vec :std_logic ) return string is
	begin
		if vec then
			return "1";
		end if;
		return "0";
	end function;
	
	-- converter o vetor bin�rio para string
	function print_port (	vec :std_logic_vector;
							size:natural) -- valor de 16 bits
	return string is
		-- variable val: string(1 to 1);
		variable output_str: string(1 to size);
	begin
		-- este tipo de concatena��o deve ser feito atrav�s de recurs�o.
		-- report "porta:" & integer'image(size) & " bit: " & bit'image(to_bit(vec(size-1))) & "str: " & val;
		if(size > 1 ) then
			output_str := bit_to_string(vec(size-1))&print_port(vec(size-1 downto 0),size-1); -- LOCAL SOUTH NORTH WEST EAST
		else
			output_str := bit_to_string(vec(size-1));
		end if;
		-- report "voltando" & output_str;
		return output_str;
	end function;


	-- conve��o de std_logic_vector para string
	function vec_to_string (vec :std_logic_vector) return string is
	begin
		return integer'image(to_integer(unsigned(vec)));
	end function;



	procedure format_key_value (	chave: in string;
									valor: in string;
									linha: inout line) is
	begin
		write (linha, ' '&'"');
		write (linha, chave & '"');
		write (linha, ':'&valor &','& LF);
	end procedure;



	procedure log_std_logic_vector (	linha		: inout line;
										chave		: in string;
										pastvalue	: std_logic_vector;
										realvalue	: std_logic_vector;
										write_tick	: inout bit
	) is
	begin
		if realvalue /= pastvalue or seek_cycles = 0 then
			format_key_value(chave,vec_to_string(realvalue),linha);
			write_tick := '1';
		end if;
	end procedure;



	procedure log_portas (	linha		: inout line;
							chave		: in string;
							pastvalue	: std_logic_vector;
							realvalue	: std_logic_vector;
							write_tick	: inout bit;
							size		: integer

	) is
	begin
		if realvalue/= pastvalue or seek_cycles = 0 then
			format_key_value(chave,'"' & print_port(realvalue,size) & '"',linha);
			write_tick := '1';
		end if;
	end procedure;

	procedure log_address (	linha		: inout line;
							chave		: in string;
							pastvalue	: std_logic_vector;
							realvalue	: std_logic_vector;
							write_tick	: inout bit
	) is
	begin
		if realvalue/= pastvalue or seek_cycles = 0 then
			format_key_value(chave,'"' & print_router( realvalue ) & '"',linha);
			write_tick := '1';
		end if;
	end procedure;

	procedure log_std_logic (	linha		: inout line;
								chave		: in string;
								pastvalue	: std_logic;
								realvalue	: std_logic;
								write_tick	: inout bit
	) is
	begin
		if realvalue/=pastvalue or seek_cycles = 0 then
			format_key_value(chave,'"'&bit_to_string(realvalue)&'"',linha);
			write_tick := '1';
		end if;
	end procedure;



	procedure log_integer (	linha		: inout line;
							chave		: in string;
							pastvalue	: in integer;
							realvalue	: in integer;
							write_tick	: inout bit
	) is
	begin
		if realvalue /= pastvalue or seek_cycles = 0 then
			format_key_value(chave,integer'image(realvalue),linha);
			write_tick := '1';
		end if;
	end procedure;
end entity;

--  {
--	 tick : 1;
--	 fsm1 : 0000;
--	 fsm2 : 0000;
--	 in_source_router_seek: 3;
--	}
architecture logging of logging is
begin
	-- output FSM states

	-- type T_ea_manager is (S_INIT, ARBITRATION, TEST_SERVICE, SERVICE_BACKTRACK, BACKTRACK_PROPAGATE, INIT_BACKTRACK, PREPARE_NEXT,
	-- 	BACKTRACK_MOUNT, CLEAR_TABLE, COMPARE_TARGET, SEND_LOCAL, PROPAGATE, WAIT_ACK_PORTS, INIT_CLEAR, END_BACKTRACK, COUNT);
	
	with EA_manager select
	output_state <=
		"0000" when S_INIT,-- 0
		"0001" when ARBITRATION,-- 1
		"0010" when TEST_SERVICE,-- 2
		"0011" when SERVICE_BACKTRACK,-- 3
		"0100" when BACKTRACK_PROPAGATE,-- 4
		"0101" when INIT_BACKTRACK,-- 5
		"0110" when PREPARE_NEXT,-- 6
		"0111" when BACKTRACK_MOUNT,-- 7
		"1000" when CLEAR_TABLE,-- 8
		"1001" when COMPARE_TARGET,-- 9
		"1010" when SEND_LOCAL,--10
		"1011" when PROPAGATE,--11
		"1100" when WAIT_ACK_PORTS,--12
		"1101" when INIT_CLEAR,--13
		"1110" when END_BACKTRACK,--14
		"1111" when COUNT,--15
		(others => 'X') when others;

	-- input FSM States

	-- type T_ea_manager_input is (S_INIT_INPUT, ARBITRATION_INPUT, LOOK_TABLE_INPUT, TEST_SPACE_AVAIL, SERVICE_INPUT, TABLE_WRITE_INPUT,
	-- 	WRITE_BACKTRACK_INPUT, TEST_SEND_LOCAL, WRITE_CLEAR_INPUT, WAIT_REQ_DOWN, WAIT_REQ_DOWN_NACK, SEND_NACK);

	with EA_manager_input select
	input_state <=
		"0000" when S_INIT_INPUT,-- 0
		"0001" when ARBITRATION_INPUT,-- 1
		"0010" when LOOK_TABLE_INPUT,-- 2
		"0011" when TEST_SPACE_AVAIL,-- 3
		"0100" when SERVICE_INPUT,-- 4
		"0101" when TABLE_WRITE_INPUT,-- 5
		"0110" when WRITE_BACKTRACK_INPUT,-- 6
		"0111" when TEST_SEND_LOCAL,-- 7
		"1000" when WRITE_CLEAR_INPUT,-- 8
		"1001" when WAIT_REQ_DOWN,-- 9
		"1010" when WAIT_REQ_DOWN_NACK,--10
		"1011" when SEND_NACK,--11
		(others => 'X') when others;


	process(clock,in_tick_counter,EA_manager_input, EA_manager)
		-- sinais antigos
		variable past_tick															: std_logic_vector(31 downto 0);
		variable past_input_state													: std_logic_vector(3 downto 0);
		variable past_output_state													: std_logic_vector(3 downto 0);
		------------------------------------------------------in----------------------------------------------------
		variable past_in_source_router_seek											: regNportNsource_neighbor;
		variable past_in_target_router_seek											: regNportNtarget_neighbor;
		variable past_in_service_router_seek										: regNport_seek_bitN_service;
		variable past_in_payload_router_seek										: regNportNpayload_neighbor;

		variable past_in_req_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_in_ack_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_in_nack_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_in_fail_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_in_opmode_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);

		variable past_in_sel_reg_backtrack_seek										: std_logic_vector(1 downto 0);	-- 2 bits de sele��o de registrador do backtrack
		variable past_in_ack_send_kernel_seek										: std_logic;
		------------------------------------------------------out-------------------------------------------
		variable past_out_req_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_out_ack_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_out_nack_router_seek											: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_out_opmode_router_seek										: std_logic_vector(NPORT_SEEK-1 downto 0);

		variable past_out_service_router_seek										: regNport_seek_bitN_service;
		variable past_out_source_router_seek										: regNportNsource_neighbor;
		variable past_out_target_router_seek										: regNportNtarget_neighbor;
		variable past_out_payload_router_seek										: regNportNpayload_neighbor;

		variable past_out_reg_backtrack_seek										: std_logic_vector(31 downto 0);	-- 32 bits do registrador do backtrack
		variable past_out_req_send_kernel_seek										: std_logic;
		
		------------------------------------------------------signal-------------------------------------------
		variable past_sel_port														: integer range 0 to 4;
		variable past_next_port														: integer range 0 to 4;
		variable past_next_port1													: integer range 0 to 4;

		variable past_sel															: integer range 0 to 7;
		variable past_prox															: integer range 0 to 7;
		variable past_prox1															: integer range 0 to 7;
		variable past_free_index													: integer range 0 to 7;
		variable past_source_index													: integer range 0 to 7;

		variable past_int_in_req_router_seek, PAST_past_int_out_ack_router_seek		: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_int_out_req_router_seek, PAST_past_int_in_ack_router_seek		: std_logic_vector(NPORT_SEEK-1 downto 0);
		variable past_vector_ack_ports, PAST_vector_nack_ports						: std_logic_vector(NPORT_SEEK-2 downto 0);
		variable past_reg_backtrack													: std_logic_vector(REG_BACKTRACK_SIZE-1 downto 0);
		variable past_compare_is_source												: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		variable past_pending_table, PAST_used_table, PAST_pending_local, PAST_task	: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		variable past_opmode_table													: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		variable past_compare_bactrack_pending_in_table								: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		variable past_compare_searchpath_pending_in_table							: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		variable past_compare_service_pending_in_table								: std_logic_vector(TABLE_SEEK_LENGHT-1 downto 0);
		variable past_count_clear													: std_logic_vector(4 downto 0);
		variable past_backtrack_port												: std_logic_vector(1 downto 0);
		variable past_req_task, PAST_req_int, PAST_is_my_turn_send_backtrack		: std_logic;
		variable past_in_the_table, PAST_space_aval_in_the_table, PAST_nack_recv	: std_logic;
		variable past_backtrack_pending_in_table, PAST_searchpath_pending_in_table	: std_logic;
		variable past_service_pending_in_table										: std_logic;
		variable past_fail_with_mode_in, PAST_fail_with_mode_out					: std_logic_vector(NPORT_SEEK-1 downto 0);

		variable past_source_router_port_table										: source_router_port_table_type;
		variable past_backtrack_id													: std_logic_vector(TARGET_SIZE-1 downto 0);

		variable past_id															: std_logic_vector(TARGET_SIZE-1 downto 0);
		variable id																	: std_logic_vector(TARGET_SIZE-1 downto 0);

		variable past_source														: std_logic_vector(TARGET_SIZE-1 downto 0);
		variable source																: std_logic_vector(TARGET_SIZE-1 downto 0);

		variable past_t_id															: std_logic_vector(TARGET_SIZE-1 downto 0);
		variable t_id																: std_logic_vector(TARGET_SIZE-1 downto 0);

		variable past_t_source														: std_logic_vector(TARGET_SIZE-1 downto 0);
		variable t_source															: std_logic_vector(TARGET_SIZE-1 downto 0);
		-- escrita em arquivo
		variable linha				: line;
		variable filestatus			: FILE_OPEN_STATUS;
		variable devnullstatus		: FILE_OPEN_STATUS;
		constant debug_uri			: string := "debug/router_seek/";
		-- constant debug_uri			: string := "/media/artur/HD2TBpart1/router_seek/";
		file arquivo				: TEXT;
		file devnull				: TEXT;
		variable write_tick			: bit;
	begin
		if reset = '1' then
			past_tick := (others=>'0');
			past_id := (others=>'0');
			past_source := (others=>'0');
			seek_cycles <= 0;
			file_open(filestatus, arquivo, debug_uri & print_router( router_address ) & ".json", write_mode); -- limpar o arquivo
			file_close(arquivo);
			write_tick := '0';
		elsif clock = '1' and clock'event then
				write_tick := '0';
				-- if (input_state /= past_input_state) or (output_state /= past_output_state) then
				if seek_cycles /= 0 then
					write(linha,","&LF);
				else
					report "past_out_req" & print_port(past_out_req_router_seek,NPORT_SEEK) &LF& "out_req" & print_port(out_req_router_seek,NPORT_SEEK) ;
					seek_cycles <= 1;
					write(linha,'{'&'"'&"entradas"&'"'&":["&LF);
				end if;
				write(linha,"{"&LF);
				-- format_key_value("tick",vec_to_string(in_tick_counter),linha);
				-- log_std_logic_vector (linha,chave,pastvalue,realvalue)
				log_std_logic_vector(linha, "fsm1", past_input_state,input_state,write_tick);
				log_std_logic_vector(linha, "fsm2", past_output_state,output_state,write_tick);
				------------------------------------------------------in----------------------------------------------------
				log_portas(linha,"in_req", past_in_req_router_seek, in_req_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"in_ack", past_in_ack_router_seek, in_ack_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"in_nack", past_in_nack_router_seek, in_nack_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"in_fail", past_in_fail_router_seek, in_fail_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"in_opmode", past_in_opmode_router_seek, in_opmode_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"fail_with_mode_in", past_fail_with_mode_in, fail_with_mode_in,write_tick,NPORT_SEEK);

				-- if (input_state /= past_input_state) or (output_state /= past_output_state) then
				-- if EA_manager_input'event or seek_cycles=0 then
					-- source 16 bits bits menos significativos source, ID 16 bits mais significativos
					log_integer(linha,"sel_port",past_sel_port,sel_port,write_tick);
					log_integer(linha, "free_index", past_free_index,free_index,write_tick);

					source:=in_source_router_seek(sel_port)(TARGET_SIZE-1 downto 0);
					id:=in_source_router_seek(sel_port)(SOURCE_SIZE-1 downto TARGET_SIZE);

					log_address(linha,"in_source",past_source,source,write_tick);--source
					log_portas(linha,"in_id",past_id,id,write_tick,TARGET_SIZE);--id
					log_address(linha,"in_target",past_in_target_router_seek(past_sel_port),in_target_router_seek(sel_port),write_tick);--target
					log_portas(linha,"in_service",past_in_service_router_seek(past_sel_port),in_service_router_seek(sel_port),write_tick,TAM_SERVICE_SEEK);--service
					log_portas(linha,"in_payload",past_in_payload_router_seek(past_sel_port),in_payload_router_seek(sel_port),write_tick,SEEK_PAYLOAD_SIZE);--payload
				-- end if;
				-- if EA_manager'event or seek_cycles=0 then
					-- source 16 bits bits menos significativos source, ID 16 bits mais significativos
					log_integer(linha,"sel",past_sel,sel,write_tick);
					log_portas(linha,"used_table",past_used_table,used_table,write_tick,TABLE_SEEK_LENGHT);
					-- indice 0, pois as portas todas r
					
					t_source := out_source_router_seek (4)(TARGET_SIZE-1 downto 0);
					t_id:= out_source_router_seek (4)(SOURCE_SIZE-1 downto TARGET_SIZE);

					log_address(linha,"out_source",past_t_source,t_source,write_tick);--source
					log_portas(linha,"out_id",past_t_id,t_id,write_tick,TARGET_SIZE);--id
					log_address(linha,"out_target",past_out_target_router_seek(4),out_target_router_seek(4),write_tick);--target
					log_portas(linha,"out_service",past_out_service_router_seek(4),out_service_router_seek(4),write_tick,TAM_SERVICE_SEEK);--out_service
					log_portas(linha,"out_payload",past_out_payload_router_seek(4),out_payload_router_seek(4),write_tick,SEEK_PAYLOAD_SIZE);--in_payload
					
					log_portas(linha,"pending_local",past_pending_local,pending_local,write_tick,TABLE_SEEK_LENGHT);
					log_portas(linha,"pending_table",past_pending_table,pending_table,write_tick,TABLE_SEEK_LENGHT);
					-- log_portas(searchpath_pending_in_table)
				-- end if;
				-- log_std_logic_vector(linha,"in_sel_reg_backtrack_seek", past_in_sel_reg_backtrack_seek, in_sel_reg_backtrack_seek);
				log_std_logic(linha,"in_ack_send_kernel_seek", past_in_ack_send_kernel_seek, in_ack_send_kernel_seek,write_tick);
				------------------------------------------------------out-------------------------------------------
				log_portas(linha,"out_req", past_out_req_router_seek, out_req_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"out_ack", past_out_ack_router_seek, out_ack_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"out_nack", past_out_nack_router_seek, out_nack_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"out_opmode", past_out_opmode_router_seek, out_opmode_router_seek,write_tick,NPORT_SEEK);
				log_portas(linha,"fail_with_mode_out", past_fail_with_mode_out, fail_with_mode_out,write_tick,NPORT_SEEK);

				-- log_std_logic_vector(linha,"out_reg_backtrack_seek", past_out_reg_backtrack_seek, out_reg_backtrack_seek);
				

				
				-- escrita em disco
				if(write_tick = '1')then
					write (linha,' '&'"'&"tick"&'"'&':'& vec_to_string (in_tick_counter) &LF&"}");
					
					file_open(filestatus, arquivo, debug_uri & print_router( router_address ) & ".json", append_mode);
					writeline(arquivo, linha);
					file_close(arquivo);
				-- limpeza do buffer
				else
					file_open(devnullstatus, devnull, "/dev/null", append_mode); -- para limpar o buffer quando n�o houver escrita em arquivo
				 	writeline(devnull,linha);
					file_close(devnull);
				end if;


				-- salva contexto
				past_tick			:= in_tick_counter;
				past_input_state	:= input_state;
				past_output_state	:= output_state;

				past_in_req_router_seek := in_req_router_seek;
				past_in_ack_router_seek := in_ack_router_seek;
				past_in_nack_router_seek := in_nack_router_seek;
				past_in_fail_router_seek := in_fail_router_seek;
				past_in_opmode_router_seek := in_opmode_router_seek;
				past_fail_with_mode_in := fail_with_mode_in;
				past_in_sel_reg_backtrack_seek := in_sel_reg_backtrack_seek;

				past_free_index := free_index;
				past_sel_port := sel_port;
				past_sel := sel;

				past_used_table := used_table;
				past_source			:= source;--source
				past_id				:= id;--id
				-- past_in_source_router_seek := in_source_router_seek;
				past_in_target_router_seek := in_target_router_seek;--target
				past_in_service_router_seek := in_service_router_seek;--service
				past_in_payload_router_seek := in_payload_router_seek;--payload

				past_t_source			:= t_source;--source
				past_t_id				:= t_id;--id
				-- past_out_source_router_seek := out_source_router_seek;
				past_out_target_router_seek := out_target_router_seek;--target
				past_out_service_router_seek := out_service_router_seek;--service
				past_out_payload_router_seek := out_payload_router_seek;--payload

				past_pending_local := pending_local;
				past_pending_table := pending_table;

				past_in_ack_send_kernel_seek := in_ack_send_kernel_seek;

				past_out_req_router_seek := out_req_router_seek;
				past_out_ack_router_seek := out_ack_router_seek;
				past_out_nack_router_seek := out_nack_router_seek;
				past_out_opmode_router_seek := out_opmode_router_seek;
				past_fail_with_mode_out := fail_with_mode_out;
				past_out_reg_backtrack_seek := out_reg_backtrack_seek;
			-- end if;
		end if;
	end process;


end architecture;

-- synthesis translate_on