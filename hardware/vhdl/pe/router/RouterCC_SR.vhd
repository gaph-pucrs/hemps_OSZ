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
--  As chaves realizam a transfer�ncia de mensagens entre n�cleos. 
--  A chave possui uma l�gica de controle de chaveamento e 5 portas bidirecionais:
--  East, West, North, South e Local. Cada porta possui uma fila para o armazenamento 
--  tempor�rio de flits. A porta Local estabelece a comunica��o entre a chave e seu 
--  n�cleo. As demais portas ligam a chave �s chaves vizinhas.
--  Os endere�os das chaves s�o compostos pelas coordenadas XY da rede de interconex�o, 
--  onde X � a posi��o horizontal e Y a posi��o vertical. A atribui��o de endere�os �s 
--  chaves � necess�ria para a execu��o do algoritmo de chaveamento.
--  Os m�dulos principais que comp�em a chave s�o: fila, �rbitro e l�gica de 
--  chaveamento implementada pelo controle_mux. Cada uma das filas da chave (E, W, N, 
--  S e L), ao receber um novo pacote requisita chaveamento ao �rbitro. O �rbitro 
--  seleciona a requisi��o de maior prioridade, quando existem requisi��es simult�neas, 
--  e encaminha o pedido de chaveamento � l�gica de chaveamento. A l�gica de 
--  chaveamento verifica se � poss�vel atender � solicita��o. Sendo poss�vel, a conex�o
--  � estabelecida e o �rbitro � informado. Por sua vez, o �rbitro informa a fila que 
--  come�a a enviar os flits armazenados. Quando todos os flits do pacote foram 
--  enviados, a conex�o � conclu�da pela sinaliza��o, por parte da fila, atrav�s do 
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

	clock_tx                : out regNport;
	tx                      : out regNport;
	data_out                : out arrayNport_regflit;
	credit_i                :  in regNport;
	eop_out					: out regNport;

	change_routing			: in regNport;

	target                  : out regflit;
	source                  : out regflit
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
signal bufferAP				: regNport;

signal tx_internal         	: regNport;
begin
	
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
			change_routing	=> change_routing(i)
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
		data_in_header_fixed  => buffer_wire_SC,
		data_in_header  => header_routing,
		sender          => sender,
		next_flit       => next_flit,
		enable_shift    => enable_shift,
		table           => table,
		tx_internal		=> tx_internal,
		target          => target,
		source          => source
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
