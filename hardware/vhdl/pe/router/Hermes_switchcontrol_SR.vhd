---------------------------------------------------------------------------------------------------
--
-- Title       : Switch Control
-- Design      : QoS
-- Company     : GAPH
--
---------------------------------------------------------------------------------------------------
--
-- File        : Switch_Control.vhd
-- Generated   : Thu Mar  6 17:08:38 2008
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--							   
-- Description : Serves the port requests and controls the ports switching table.
--					
-- Circuit Switching: Connections established only by channels 0 (High priority channel)
---------------------------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_unsigned.all;
use ieee.numeric_std.all;
use work.standards.all;
							   
entity SwitchControl_SR_write is
generic( 
	address		: regmetadeflit_32 := (others=>'0')
);
port(
    clock 		    : in  std_logic;
    reset 		    : in  std_logic;  
    req_routing     : in  regNport;
	eop_in          : in  regNport;
	bop_in          : in  regNport;
    ack_routing     : out regNport;     
    data_in_header  : in  arrayNport_regflit_32;
    data_in_header_fixed  : in  arrayNport_regflit_32;
    sender 		    : in  regNport;	
	next_flit	    : out regNport;
    enable_shift    : out regNport;
	table		    : out matrixNportNport_std_logic;

    tx_internal		: in regNport;--needed by SR

    --signals for writing source target pair
    target          : out regflit;
    source          : out regflit
    );
end SwitchControl_SR_write;


architecture SwitchControl_SR_write of SwitchControl_SR_write is

type state is (S0,S1,S2,S2a,S3,Sshift);
signal EA: state;

-- sinais do arbitro
signal ask				       : std_logic;
signal sel,prox         	   : integer range 0 to (NPORT-1);
signal header 			       : regflit_32;
signal header_fixed 	       : regflit_32;

-- sinais do controle
signal dirx,diry: integer range 0 to (NPORT-1);
signal lx,ly,tx,ty: regquartoflit_32 := (others=> '0');

signal free_port: regNport;	 
signal rot_table: matrixNportNport_std_logic;
signal try_again: boolean;
signal even_line: boolean;

signal target_internal : regflit;

signal shift_counter	: std_logic_vector(3 downto 0);
signal aux_cont    : integer range 15 downto 0;

--alias target:regmetadeflit                      is header(METADEFLIT-1 downto 0);

alias Xsource:std_logic_vector(5 downto 0)		is header_fixed(FLIT16+11 downto FLIT16+6);
alias Ysource:std_logic_vector(5 downto 0)		is header_fixed(FLIT16+5 downto FLIT16);

alias priority:std_logic                        is header(TAM_FLIT-8);
alias routing:std_logic                         is header(TAM_FLIT-6);

--source routing
alias flit_type:std_logic_vector(3 downto 0)    is header(TAM_FLIT_32-1 downto TAM_FLIT_32-4);
alias sr_valid_0:std_logic                      is header(TAM_FLIT_32-5);
alias sr_channel_0:std_logic                    is header(TAM_FLIT_32-6);
alias sr_port_0:std_logic_vector(1 downto 0)    is header(TAM_FLIT_32-7 downto TAM_FLIT_32-8);

begin

	--signals for writing source target pair
	source <= header_fixed(TAM_FLIT_32-1 downto FLIT16);
	target <= header_fixed(FLIT16-1 downto 0);
	target_internal	<= "000" & header(12 downto 8) & "000" & header(4 downto 0);
	--input port

    ask <=	req_routing(LOCAL0) or req_routing(LOCAL1) or req_routing(EAST0) or req_routing(WEST0) or 
    		req_routing(NORTH0) or req_routing(SOUTH0) or req_routing(EAST1) or req_routing(WEST1) or 
    		req_routing(NORTH1) or req_routing(SOUTH1);
   
	-- Pega o header do pacote selecionado pelo Round Robin
	header 			<= data_in_header(sel);
	header_fixed 	<= data_in_header_fixed(sel);

    lx <= address((METADEFLIT_32 - 1) downto QUARTOFLIT_32);
    ly <= address((QUARTOFLIT_32 - 1) downto 0);

    tx <= header((METADEFLIT_32 - 1) downto QUARTOFLIT_32);
    ty <= header((QUARTOFLIT_32 - 1) downto 0);

    dirx <= WEST0 when lx > tx else EAST0;
    diry <= NORTH0 when ly < ty else SOUTH0;

    -- Round Robin: seleciona uma das portas de entrada para o roteamento (prox).	
	process(sel,req_routing)
    begin
        case sel is
            when LOCAL0 => 
				if req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
                elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
                elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
                elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;				
                else prox<=LOCAL0; end if;
                
            when LOCAL1 => 
				if req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
			    elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
			    elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
			    elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
                else prox<=LOCAL1; end if;
								
            when EAST0 => 
				if req_routing(EAST1)='1' then prox<=EAST1;
				elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
                elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
                elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				else prox<=EAST0; end if;
					
			when EAST1 => 
				if req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
                elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
                elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;				
				else prox<=EAST1; end if;
							
            when WEST0 => 
				if req_routing(WEST1)='1' then  prox<=WEST1;
				elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
                elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
				else prox<=WEST0; end if;
					
			when WEST1 => 
				if req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
                elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
				elsif req_routing(WEST0)='1' then  prox<=WEST0;				
				else prox<=WEST1; end if;
							
            when NORTH0 =>
				if req_routing(NORTH1)='1' then prox<=NORTH1;
                elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
				elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
				else prox<=NORTH0; end if;
					
			when NORTH1 =>
				if req_routing(SOUTH0)='1' then prox<=SOUTH0;
				elsif req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
				elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
				elsif req_routing(NORTH0)='1' then prox<=NORTH0;                
				else prox<=NORTH1; end if;
						   
             when SOUTH0 => 
				if req_routing(SOUTH1)='1' then prox<=SOUTH1;
				elsif req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
				elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
				elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
				else prox<=SOUTH0; end if;
					
			when SOUTH1 => 
				if req_routing(LOCAL0)='1' then prox<=LOCAL0;
				elsif req_routing(LOCAL1)='1' then prox<=LOCAL1;
				elsif req_routing(EAST0)='1' then prox<=EAST0;
				elsif req_routing(EAST1)='1' then prox<=EAST1;
				elsif req_routing(WEST0)='1' then  prox<=WEST0;
				elsif req_routing(WEST1)='1' then  prox<=WEST1;
				elsif req_routing(NORTH0)='1' then prox<=NORTH0; 
				elsif req_routing(NORTH1)='1' then prox<=NORTH1;
				elsif req_routing(SOUTH0)='1' then prox<=SOUTH0;				
				else prox<=SOUTH1; end if;
					
			when others =>
        end case;
    end process; 
     	 
	process(clock,reset)
	variable packet_toward_high_label : boolean;
    variable counter : integer;
    begin		  	   
		if reset = '1' then
			sel             <= LOCAL0;
            ack_routing     <= (others => '0');
			rot_table       <= (others=>(others=>'0'));	
			next_flit       <= (others => '0');
            counter        := 0;
			try_again       <= false;
			EA              <= S0;
			enable_shift	<= (others => '0');
			shift_counter 	<= (others=>'0');

		elsif rising_edge(clock) then
	        case EA is
	            -- Takes the port selected by the Round Robin.
				when S0 =>
					-- Wait for a port request.
					if ask = '1' then						
						if try_again and sel /= prox and req_routing(sel) = '1' then

							try_again <= false;
						else
							sel <= prox;
							try_again <= true;
						end if;
						
						EA <= S1;
					else
						EA <= S0;
                    end if;

                    
					-- Updates the switch table.
					for i in 0 to NPORT-1 loop
						if sender(i) = '0' then
							rot_table(i) <= (others=>'0');
						end if;
					end loop;
                    enable_shift 		<= (others=>'0');
                    shift_counter 		<= (others=>'0');

				when S1 =>

                	-- Executes the source routing algorithm
					if header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = PACKET_SWITCHING_SR then
                        if sr_valid_0 = '0' then --this is a valid flit
                            --if sel (input port) is the same that sr_port_0 (output port) means that it should be routed to local port
                            if (((sel = EAST0 or sel = EAST1) and sr_port_0 = "00") or ((sel = WEST0 or sel = WEST1) and sr_port_0 = "01") or ((sel = NORTH0 or sel = NORTH1) and sr_port_0 = "10") or ((sel = SOUTH0 or sel = SOUTH1) and sr_port_0 = "11")) then
                                --if free_port(LOCAL0+to_integer(unsigned'("" & sr_channel_0))) = '1' then
                                if free_port(LOCAL1) = '1' then
	                                ack_routing(sel) <= '1';
	                                --rot_table(sel)(LOCAL0+to_integer(unsigned'("" & sr_channel_0))) <= '1';
	                                rot_table(sel)(LOCAL1) <= '1';
									EA <= S3;
								else 
                                	EA <= S0;
                                end if;
                            elsif free_port(to_integer(unsigned(sr_port_0))*2+to_integer(unsigned'("" & sr_channel_0))) = '1' then--else, try to route to port given by sr_port_0
                                ack_routing(sel) <= '1';
                                rot_table(sel)(to_integer(unsigned(sr_port_0))*2+to_integer(unsigned'("" & sr_channel_0))) <= '1';
								EA <= Sshift;
                                --enable_shift(sel)<= '1';
                            else
                                EA <= S0;
                            end if;
                        else --all sr_valid fields are NOT valid, discart the first flit
                            next_flit(sel) <= '1';
                            EA <= S2;
                        end if;

	                -- Executes the distributed XY routing algorithm
                    else
						-- Packet achieved the target_internal
	                    if target_internal = address  then
	                      	if header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = PACKET_SWITCHING_XY or header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = IO_PACKET or header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = PACKET_SWITCHING_YX then
	                        	if free_port(LOCAL1)='1' then
	                        	    rot_table(sel)(LOCAL1) <= '1';
	                        	    ack_routing(sel) <= '1';
	                        	    EA <= S3;
	                        	else
	                        	    EA <= S0;
	                        	end if;
							
                            -- elsif  header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = OUT_WRAPPER then
                            --     if free_port(LOCAL1)='1' then
                            --         rot_table(sel)(LOCAL1) <= '1';
                            --         ack_routing(sel) <= '1';
                            --         EA <= S3;
                            --     else
                            --         EA <= S0;
                            --     end if;

	                      	elsif  header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = OUT_NORTH then
	                        	if free_port(NORTH0)='1' then
	                        	    rot_table(sel)(NORTH0) <= '1';
	                        	    ack_routing(sel) <= '1';
	                        	    EA <= S3;
	                        	else
	                        	    EA <= S0;
	                        	end if;

	                      	elsif  header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = OUT_SOUTH then
	                        	if free_port(SOUTH0)='1' then
	                        	    rot_table(sel)(SOUTH0) <= '1';
	                        	    ack_routing(sel) <= '1';
	                        	    EA <= S3;
	                        	else
	                        	    EA <= S0;
	                        	end if;

	                      	elsif  header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = OUT_EAST then
	                        	if free_port(EAST0)='1' then
	                        	    rot_table(sel)(EAST0) <= '1';
	                        	    ack_routing(sel) <= '1';
	                        	    EA <= S3;
	                        	else
	                        	    EA <= S0;
	                        	end if;

	                      	elsif  header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = OUT_WEST then
	                        	if free_port(WEST0)='1' then
	                        	    rot_table(sel)(WEST0) <= '1';
	                        	    ack_routing(sel) <= '1';
	                        	    EA <= S3;
	                        	else
	                        	    EA <= S0;
	                        	end if;
	                    	end if;
	                    	
						-- Special case: IO Packet using YX overrides usual XY routing (CHANNEL 1)
						elsif header(TAM_FLIT_32-1 downto TAM_FLIT_32-4) = PACKET_SWITCHING_YX then
							
							-- First route through Y axis
							if ly/=ty then	
	                    	    if free_port(diry+1) = '1' then			-- Verifies if the channel 1 is free
	                    	        ack_routing(sel) <= '1';
	                    	        rot_table(sel)(diry+1) <= '1';
	                    	        EA <= S3;
	                    	    else 
	                    	        EA <= S0; 
	                    	    end if;

							-- Then route through X axis
							else
								if free_port(dirx+1) = '1' then			-- Verifies if the channel 1 is free
	                    		    ack_routing(sel) <= '1';
	                    		    rot_table(sel)(dirx+1) <= '1'; 
	                    		    EA <= S3;
								else 
	                    		    EA <= S0; 
	                    		end if;
							end if;
						
						-- Procedes with the regular XY algorithm (CHANNEL 0)
						else
						
							-- Packet is switched to EAST or WEST
	                    	if lx /= tx then
	                    	    if free_port(dirx) = '1' then			-- Verifies if the channel 0 is free 
	                    	        ack_routing(sel) <= '1';
	                    	        rot_table(sel)(dirx) <= '1';
	                    	        EA <= S3;
	                    	    else 
	                    	        EA <= S0; 
	                    	    end if;
								
	                    	-- Packet is switched to NORTH or SOUTH 
	                    	elsif free_port(diry) = '1' then			-- Verifies if the channel 0 is free
	                    	    ack_routing(sel) <= '1';
	                    	    rot_table(sel)(diry) <= '1'; 
	                    	    EA <= S3;
	                    	else 
	                    	    EA <= S0; 
	                    	end if;
						end if;

	                end if;
				when Sshift =>
					--if shift_counter = "01" then

					if tx_internal(to_integer(unsigned(sr_port_0))*2+to_integer(unsigned'("" & sr_channel_0))) = '1' then
						EA 					<= S0;
                        enable_shift(sel)	<= '1';
					--elsif tx_internal(to_integer(unsigned(sr_port_0))*2+to_integer(unsigned'("" & sr_channel_0))) = '1' then
					--else
						--shift_counter 		<= shift_counter + '1';
					end if;

					ack_routing(sel)	<= '0';
                    
				-- Time for Input Buffer removes the first flit.
				when S2 =>
					next_flit(sel)<= '0'; 
					EA <= S2a;
					
				-- Waits the request routing for the next multicast destination.
				when S2a =>
					if req_routing(sel) = '1' then
						EA <= S1;
					else
						EA <= S2a;
					end if;
				
				-- Time for Input Buffer to low the 'req_routing' signal.
				when S3 =>
					ack_routing(sel)<='0';
					EA <= S0;


				when others =>
					EA <= S0;
				
	        end case;  
		end if;
    end process;
    				  
	table <= rot_table;
			
	-- Mantém atualizada a tabela de portas livres.
	free_port(LOCAL0) <= not (rot_table(EAST0)(LOCAL0) or rot_table(EAST1)(LOCAL0) or rot_table(SOUTH0)(LOCAL0) or rot_table(SOUTH1)(LOCAL0) or rot_table(WEST0)(LOCAL0) or rot_table(WEST1)(LOCAL0) or rot_table(NORTH0)(LOCAL0) or rot_table(NORTH1)(LOCAL0)); 
    --free_port(LOCAL1) <= not (rot_table(EAST0)(LOCAL1) or rot_table(EAST1)(LOCAL1) or rot_table(SOUTH0)(LOCAL1) or rot_table(SOUTH1)(LOCAL1) or rot_table(WEST0)(LOCAL1) or rot_table(WEST1)(LOCAL1) or rot_table(NORTH0)(LOCAL1) or rot_table(NORTH1)(LOCAL1));
	free_port(LOCAL1) <= not (rot_table(EAST0)(LOCAL1) or rot_table(EAST1)(LOCAL1) or rot_table(SOUTH0)(LOCAL1) or rot_table(SOUTH1)(LOCAL1) or rot_table(WEST0)(LOCAL1) or rot_table(WEST1)(LOCAL1) or rot_table(NORTH0)(LOCAL1) or rot_table(NORTH1)(LOCAL1) or rot_table(LOCAL1)(LOCAL1));
	free_port(EAST0)  <= not (rot_table(LOCAL0)(EAST0) or rot_table(LOCAL1)(EAST0) or rot_table(WEST0)(EAST0) or rot_table(WEST1)(EAST0) or rot_table(NORTH0)(EAST0) or rot_table(NORTH1)(EAST0) or rot_table(SOUTH0)(EAST0) or rot_table(SOUTH1)(EAST0));
	free_port(EAST1)  <= not (rot_table(LOCAL0)(EAST1) or rot_table(LOCAL1)(EAST1) or rot_table(WEST0)(EAST1) or rot_table(WEST1)(EAST1) or rot_table(NORTH0)(EAST1) or rot_table(NORTH1)(EAST1) or rot_table(SOUTH0)(EAST1) or rot_table(SOUTH1)(EAST1));
	free_port(WEST0)  <= not (rot_table(LOCAL0)(WEST0) or rot_table(LOCAL1)(WEST0) or rot_table(EAST0)(WEST0) or rot_table(EAST1)(WEST0) or rot_table(SOUTH0)(WEST0) or rot_table(SOUTH1)(WEST0) or rot_table(NORTH0)(WEST0) or rot_table(NORTH1)(WEST0)); 
	free_port(WEST1)  <= not (rot_table(LOCAL0)(WEST1) or rot_table(LOCAL1)(WEST1) or rot_table(EAST0)(WEST1) or rot_table(EAST1)(WEST1) or rot_table(SOUTH0)(WEST1) or rot_table(SOUTH1)(WEST1) or rot_table(NORTH0)(WEST1) or rot_table(NORTH1)(WEST1));
	free_port(SOUTH0) <= not (rot_table(LOCAL0)(SOUTH0) OR rot_table(LOCAL1)(SOUTH0) or rot_table(EAST0)(SOUTH0) OR rot_table(EAST1)(SOUTH0) OR rot_table(WEST0)(SOUTH0) OR rot_table(WEST1)(SOUTH0) OR rot_table(NORTH0)(SOUTH0) OR rot_table(NORTH1)(SOUTH0));
	free_port(SOUTH1) <= not (rot_table(LOCAL0)(SOUTH1) OR rot_table(LOCAL1)(SOUTH1) or rot_table(EAST0)(SOUTH1) OR rot_table(EAST1)(SOUTH1) OR rot_table(WEST0)(SOUTH1) OR rot_table(WEST1)(SOUTH1) OR rot_table(NORTH0)(SOUTH1) OR rot_table(NORTH1)(SOUTH1));
	free_port(NORTH0) <= not (rot_table(LOCAL0)(NORTH0) OR rot_table(LOCAL1)(NORTH0) or rot_table(EAST0)(NORTH0) OR rot_table(EAST1)(NORTH0) OR rot_table(WEST0)(NORTH0) OR rot_table(WEST1)(NORTH0) OR rot_table(SOUTH0)(NORTH0) OR rot_table(SOUTH1)(NORTH0));
	free_port(NORTH1) <= not (rot_table(LOCAL0)(NORTH1) OR rot_table(LOCAL1)(NORTH1) or rot_table(EAST0)(NORTH1) OR rot_table(EAST1)(NORTH1) OR rot_table(WEST0)(NORTH1) OR rot_table(WEST1)(NORTH1) OR rot_table(SOUTH0)(NORTH1) OR rot_table(SOUTH1)(NORTH1));
				
	
end SwitchControl_SR_write;
