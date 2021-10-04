------------------------------------------------------------------------------------------------
--
--  DISTRIBUTED HEMPS  - version 5.0
--
--  Research group: GAPH-PUCRS    -    contact   fernando.moraes@pucrs.br
--
--  Distribution:  September 2013
--
--  Source name:  RouterCC.vhd
--
--  Brief description: Top module of the NoC - the NoC is built using only this module
--
---------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------- 
--                                              ROUTER
--
--                                              NORTH               LOCAL
--                       ---------------------------------------------
--                      |                       ******         ****** |
--                      |                       *FILA*         *FILA* |
--                      |                       ******         ****** |
--                      |                   *************             |
--                      |                   *  ARBITRO  *             |
--                      | ******            *************      ****** |
--                 WEST | *FILA*            *************      *FILA* | EAST
--                      | ******            *  CONTROLE *      ****** |
--                      |                   *************             |
--                      |                       ******                |
--                      |                       *FILA*                |
--                      |                       ******                |
--                      -----------------------------------------------
--                                              SOUTH
--
--  As chaves realizam a transferência de mensagens entre núcleos. 
--  A chave possui uma lógica de controle de chaveamento e 5 portas bidirecionais:
--  East, West, North, South e Local. Cada porta possui uma fila para o armazenamento 
--  temporário de flits. A porta Local estabelece a comunicação entre a chave e seu 
--  núcleo. As demais portas ligam a chave às chaves vizinhas.
--  Os endereços das chaves são compostos pelas coordenadas XY da rede de interconexão, 
--  onde X é a posição horizontal e Y a posição vertical. A atribuição de endereços às 
--  chaves é necessária para a execução do algoritmo de chaveamento.
--  Os módulos principais que compõem a chave são: fila, árbitro e lógica de 
--  chaveamento implementada pelo controle_mux. Cada uma das filas da chave (E, W, N, 
--  S e L), ao receber um novo pacote requisita chaveamento ao árbitro. O árbitro 
--  seleciona a requisição de maior prioridade, quando existem requisições simultâneas, 
--  e encaminha o pedido de chaveamento à lógica de chaveamento. A lógica de 
--  chaveamento verifica se é possível atender à solicitação. Sendo possível, a conexão
--  é estabelecida e o árbitro é informado. Por sua vez, o árbitro informa a fila que 
--  começa a enviar os flits armazenados. Quando todos os flits do pacote foram 
--  enviados, a conexão é concluída pela sinalização, por parte da fila, através do 
--  sinal sender.
---------------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.standards.all;
use work.hemps_pkg.all;

entity RouterCC is
generic( address: regmetadeflit_32);
port(
	clock                   : in  std_logic;
	reset                   : in  std_logic;
	clock_rx                : in  regNport;
	rx                      : in  regNport;
	data_in                 : in  arrayNport_regflit;
	credit_o                : out regNport;
	eop_in					: in  regNport;
	fail_in					: in  regNport;
	fail_out				: out regNport;

	clock_tx                : out regNport;
	tx                      : out regNport;
	data_out                : out arrayNport_regflit;
	credit_i                :  in regNport;
	eop_out					: out regNport;

	mask_local_tx_output	: out std_logic;
	io_packet_mask			: out regNport;

	target                  : out regflit;
	source                  : out regflit;
	w_source_target         : out std_logic;
	rot_table				: out matrixNportNport_std_logic;
	w_addr                  : out std_logic_vector(3 downto 0)
);
end RouterCC;

architecture RouterCC of RouterCC is

signal h, ack_h, data_av, sender, data_ack,eop_buffer 	: regNport := (others=>'0');
signal data 											: arrayNport_regflit := (others=>(others=>'0'));

signal buffer_wire_SC									: arrayNport_regflit_32 := (others=>(others=>'0'));
signal header_routing									: arrayNport_regflit_32 := (others=>(others=>'0'));

signal mux_in, mux_out                          		: arrayNport_reg3 := (others=>(others=>'0'));
signal free 											: regNport := (others=>'0');
signal next_flit                                		: regNport; 
signal table                                    		: matrixNportNport_std_logic;

--SR signals
--signals from mux_ctrl to crossbar
signal out_mux_buffer       : arrayNport_regflit;
signal enable_shift         : regNport;

signal tx_internal         	: regNport;
begin
	
	rot_table	<= table;
	fail_out <= "0000000000";

	fifo_generation : for i in 0 to NPORT-1 generate
		Fifo : Entity work.Hermes_buffer
		port map(
			clock 			=> clock,
			reset 			=> reset,
			data_in 		=> data_in(i),
			rx 				=> rx(i),
			eop_in 			=> eop_in(i),
			req_routing 	=> h(i),
			ack_routing 	=> ack_h(i),
			tx 				=> data_av(i),
			eop_out 		=> eop_buffer(i),
			data_out		=> data(i),
			--data_header
			header_routing 	=> header_routing(i),
			header_fixed 	=> buffer_wire_SC(i),
			sender			=> sender(i),
			credit_in 		=> data_ack(i),
			next_flit 		=> next_flit(i),
			credit_out 		=> credit_o(i),
			fail_in			=> fail_in(i)
			);
	end generate ; -- fifo_generation

	SwitchControl_SR_write : Entity work.SwitchControl_SR_write
	generic map(
		address => address
	)
	port map(
		clock           => clock,
		reset           => reset,
		req_routing     => h,
		eop_in			=> eop_in,
		ack_routing     => ack_h,
		io_mask_wrapper => io_packet_mask,
		data_in_header_fixed  => buffer_wire_SC,
		data_in_header  => header_routing,
		sender          => sender,
		next_flit       => next_flit,
		enable_shift    => enable_shift,
		table           => table,
		mask_local_tx_output => mask_local_tx_output,
		tx_internal		=> tx_internal,
		target          => target,
		source          => source,
		w_source_target => w_source_target,
		w_addr          => w_addr
	);

	mux_control: entity work.mux_control
	port map(
		clock           => clock,
		reset           => reset,
		in_buffer       => data,
		out_buffer      => out_mux_buffer,
		--------------------------------------------------------
		credit_i        => data_ack,
		--------------------------------------------------------
		enable_shift    => enable_shift
	);

	Crossbar: Entity work.Hermes_crossbar 
	port map (
		table           => table,
		data            => out_mux_buffer,
		data_av         => data_av,
		data_ack        => data_ack,
		data_out        => data_out,
		tx              => tx_internal,
		credit_i        => credit_i,
		eop_buffer		=> eop_buffer,
		eop_out			=> eop_out
	);

	tx <= tx_internal;

	CLK_TX : for i in 0 to(NPORT-1) generate
		clock_tx(i) <= clock;
	end generate CLK_TX;  

end RouterCC;
