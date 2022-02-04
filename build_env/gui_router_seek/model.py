
# https://pythonhosted.org/BTrees/
# Usando árvore B com suporte a chaves de valores intermediários
# desta forma posso acessar os 
# cuidado, bug ao usar minKey em alguns intervalos
from BTrees.OOBTree import OOBTree
from standards import services
class RouterModel():
    def __init__(self, router_address:tuple,log:dict):
        self.valores_atuais=dict()
        # print(log)
        self.router_address=router_address
        # no primeiro instante todos os nomes de entradas são impressos pelo logger da BrNoC
        self.nome_sinal = [sinal for sinal in log['entradas'][0].keys() if sinal != "tick"]
        self.historico_sinal = dict() # histórico de sinais
        #exemplo de acesso: 
        for k in self.nome_sinal:# Atribui os nomes de cada sinal a árvore B que conterá o histórico daquele sinal
            self.historico_sinal.update({k:OOBTree()})

        for amostra in log['entradas']:
            tick=amostra["tick"]
            for sinal in [a for a in amostra if a != "tick"]:
                self.historico_sinal[sinal].update({tick:amostra[sinal]})
        self.set_time(0)
        self.local_max_tick=self.get_prior_event(int("7FFFFF",16))
        # sinais criados posteriormente
        self.load_sec_zones() # sec_zone e sec_zone_ID
        self.save_when_writed() # writed
    def get_next_signals_event(self,signals, time:int):
        next = int("7FFFFFF",16)
        for port in signals:
            bt = self.historico_sinal[port]
            # try: #pode não haver a chave em questão
            # print (f"arvore {port} de {self.router_address} at time {time}")
            # mk = bt.minKey(time+1) # tem algum bug quando acesso a chave 20195 ou maior
            chaves=[a for a in bt.keys() if a>time] # contorno buscando manualmente entre as chaves(q são poucas)
            if len(chaves) >= 1:
                mk = min(chaves)
            # else: return next
            # print(f'{"{}x{}".format(*self.router_address)}next event: tick {time} porta {port} minkey: {mk}')
                if mk <= next and self.get_value_at(time,port) != bt[mk] and mk>=time:
                    next = mk
            # except: pass
        return next # if next!= int("7FFFFFF",16) else time # se não encontrar...

    def get_prior_signals_event(self, signals,time:int):
        prior = -1
        for port in signals:
            bt = self.historico_sinal[port]
            # try:#caso entre -1
            if time-1 == -1: break
            mk = bt.maxKey(time-1)
            # print(f'{"{}x{}".format(*self.router_address)}prior event: tick {time} porta {port} maxkey: {mk}')
            if mk > prior and self.get_value_at(time,port) != bt[mk] and mk<time:
                prior = mk
            # except: pass
        return prior if prior!=-1 else time # se não encontrar...

    def load_sec_zones(self):
        'Setting up sec zone by router'
        self.nome_sinal.append('sec_zone')
        self.historico_sinal.update({'sec_zone':OOBTree()})
        self.historico_sinal['sec_zone'].update({0:0})

        self.nome_sinal.append('sec_zone_ID')
        self.historico_sinal.update({'sec_zone_ID':OOBTree()})
        self.historico_sinal['sec_zone_ID'].update({0:(-1,-1)})
        # criar zonas seguras
        # SET_SECURE_ZONE_SERVICE		"00111"-- diz no payload na parte superior: linha e coluna canto inferior esquerdo e superior direito
        # SET_SZ_RECEIVED_SERVICE       "11101"--
        # SET_EXCESS_SZ_SERVICE			"11110"-- elimina da zona segura linha e coluna inferior esquerda até a superior direita
        # SECURE_ZONE_CLOSED_SERVICE	"01011"-- confirma que a zona segura está fechada(wrappers fechados)
        # eliminar zonas seguras:
        # OPEN_SECURE_ZONE_SERVICE		"01010"-- mesma logica, canto inferior esquerdo até superior direito
        # SECURE_ZONE_OPENED_SERVICE	"01100"-- confirma que a zona segura não está mais ativa
        # vou numerar o estado de sec zone conforme a orde acima: 0 até 4
        print(f"router {self.router_address}")

        # for inout in ['out','in']:
        inout='in'
        for at_tick in self.historico_sinal[inout+'_service']:
            val = self.get_value_at(at_tick,inout+'_service')
            # print(f"{at_tick} {inout} times:")
            if val[1] in [
                '00111' # SET_SECURE_ZONE_SERVICE = 1
                # ,'11101' # SET_SZ_RECEIVED_SERVICE
                ,'11110' # SET_EXCESS_SZ_SERVICE = 0
                ,'01011' # SECURE_ZONE_CLOSED_SERVICE = 2
                ,'01010' # OPEN_SECURE_ZONE_SERVICE = 1
                ,'01100' # SECURE_ZONE_OPENED_SERVICE = 0
                ]:
                source=self.get_value_at(at_tick,inout+'_source')
                target=self.get_value_at(at_tick,inout+'_target')
                payload=self.get_value_at(at_tick,inout+'_payload')
                if self.limits(self.router_address,self.target_port_to_int(target[1]),self.payload_port_to_int(payload[1])):
                    print(f"{at_tick} - {inout} service {services[val[1]]}, source: {source} target {self.target_port_to_int(target[1])} payload {self.payload_port_to_int(payload[1])}")
                    print(f"is {self.router_address} inside {services[val[1]]} limits {self.limits(self.router_address,self.target_port_to_int(target[1]),self.payload_port_to_int(payload[1]))}\n")
        
                    if val[1] == '00111':   # SET_SECURE_ZONE_SERVICE = 1
                        self.historico_sinal['sec_zone'].update({at_tick:1})
                        self.historico_sinal['sec_zone_ID'].update({at_tick:self.payload_port_to_int(payload[1])})

                    elif val[1] == '11110': # SET_EXCESS_SZ_SERVICE = 0
                        if self.get_value_at(at_tick,'sec_zone_ID')[1] == self.payload_port_to_int(payload[1]): # se perternce a zona de RH
                            if(self.router_address != self.payload_port_to_int(payload[1])): # se não for o RH
                                self.historico_sinal['sec_zone'].update({at_tick:0}) # desativa
                                self.historico_sinal['sec_zone_ID'].update({at_tick:(-1,-1)}) # tira da zona segura


                    elif val[1] == '01011': # SECURE_ZONE_CLOSED_SERVICE = 2
                        print(f"habilitacao da zona segura em {self.router_address} sz {self.get_value_at(at_tick,'sec_zone_ID')[1]} payload {self.payload_port_to_int(payload[1])}")
                        if self.get_value_at(at_tick,'sec_zone_ID')[1] == self.payload_port_to_int(payload[1]):
                            print("ativou")
                            self.historico_sinal['sec_zone'].update({at_tick:2})
                    elif val[1] == '01010': # OPEN_SECURE_ZONE_SERVICE = 1
                        if self.get_value_at(at_tick,'sec_zone_ID')[1] == self.payload_port_to_int(payload[1]):
                            self.historico_sinal['sec_zone'].update({at_tick:1})
                        
                    elif val[1] == '01100': # SECURE_ZONE_OPENED_SERVICE = 0
                        if self.get_value_at(at_tick,'sec_zone_ID')[1] == self.payload_port_to_int(payload[1]):
                            self.historico_sinal['sec_zone'].update({at_tick:0})
        # print([a for a in self.historico_sinal['in_service'].keys() ])
        # print(self.historico_sinal['in_service'].maxKey(31791))  
        ###

        # for times in self.historico_sinal['in_service'].keys():
        #     print(times)
        # print(self.get_value_at(31817,'in_service'))
    def save_when_writed(self):
        'salva em writed a linha que foi escrita por último'
        self.nome_sinal.append('writed')
        self.historico_sinal.update({'writed':OOBTree()})
        self.historico_sinal['writed'].update({0:0})
        for at_tick in self.historico_sinal['fsm1']:
            state = self.get_value_at(at_tick,'fsm1')
            if state[1] == 5: # table write
                val = self.get_value_at(at_tick,'free_index')[1]
                self.historico_sinal['writed'].update({at_tick:val})

    target_port_to_int = lambda self,a: tuple(map (lambda b:int(b,16), list(a[3:5])))
    payload_port_to_int=lambda self,a : tuple(map ( lambda b:int(b,2) ,[a[0:4],a[4:8]] ))
    limits=lambda self,a,b,c:a[0]>=b[0] and a[0]<=c[0] and a[1]>=b[1] and a[1]<=c[1]
    def get_next_event(self, time:int):
        return self.get_next_signals_event(self.nome_sinal,time)
    def get_prior_event(self, time:int):
        return self.get_prior_signals_event(self.nome_sinal,time)
    
    def get_value_at(self, time:int,port:str):
        '"Returns the value of port at time, and the time it was changed(tick)"'
        bt = self.historico_sinal[port]
        try:
            mk = bt.maxKey(time)
        except: pass
        # print(f"router {self.router_address} setOnTick:{mk} sinal:{port} valor: {bt[mk]}")
        return (mk,bt[mk])

    def get_all_values(self):
        return self.valores_atuais

    def set_time(self,time):
        if(time<0):return #sem bagunça nesta casa!
        # print(f"{self.router_address} setting tick: {time}")
        self.sim_time = time
        for p in self.nome_sinal:
            self.valores_atuais.update({p:self.get_value_at(time,p)})

    def __repr__(self)-> str:
        log:str = f"router {self.router_address} at {self.sim_time}"
        for sinal in self.nome_sinal:
            tick,val= self.get_value_at(self.sim_time,sinal)
            log+=f"    setOnTick:{tick} sinal:{sinal} valor: {val}"
        return log
    def __str__(self) -> str:
        return self.__repr__()