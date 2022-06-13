from gui import ArrowInput, ArrowOutput, Box, Label
from model import RouterModel
from standards import *
from time import sleep
class RouterControl():
    def __init__(self,C, router_address:tuple,log:dict,bounds:tuple):
        self.router_address = router_address
        self.model = RouterModel(router_address,log)
        self.past_free_index=0
        # exibir sinais no instante X

        # Prepara as coordenadas
        # self.bounds = bounds
        x1,y1,x2,y2 = bounds
        local_w = x2-x1
        local_h = y2-y1

        caixa_w = x2-x1-76
        caixa_h = y2-y1-76

        #instancia os vetores
        self.portas=list()
        self.portas.insert(stds.IN_ACK,[])
        self.portas.insert(stds.IN_NACK,[])
        self.portas.insert(stds.OUT_REQ,[])
        self.portas.insert(stds.IN_REQ,[])
        self.portas.insert(stds.OUT_NACK,[])
        self.portas.insert(stds.OUT_ACK,[])

        self.sinais = dict()
        self.sinais.update( {'fsm1' : Label(C,(x1+50,y1+38+caixa_h*.2),"",pre_text="in {}",font_size=7,bold=True,pos='nw')} )
        self.sinais.update( {'fsm2' : Label(C,(x1+50,y2-38-caixa_h*.4),"",pre_text="out {}",font_size=7,bold=True,pos='nw')} )
        self.sinais['fsm1'].draw()
        self.sinais['fsm2'].draw()

        c1=x1+38
        c2=x1+38+caixa_w/8
        c3=x1+38+caixa_w/2.3
        c4=x1+38+caixa_w/1.4

        l1=y1+38+caixa_h*.3
        Label(C,(c1,l1),"L",).draw(state="normal")
        Label(C,(c2,l1),"Src").draw(state="normal")
        Label(C,(c3,l1),"Tgt").draw(state="normal")
        Label(C,(c4,l1),"PayL").draw(state="normal")

        l2=y1+38+caixa_h*.4
        self.sinais.update( {'writed' : Label(C,(c1,l2),"")} )
        self.sinais.update( {'in_source' : Label(C,(c2,l2),"")} )
        self.sinais.update( {'in_target' : Label(C,(c3,l2),"")} )
        self.sinais.update( {'in_payload' : Label(C,(c4,l2),"")} )
    
        l2_5=y1+38+caixa_h*.5
        self.sinais.update( {'in_service' : Label(C,(x1+local_w/2,l2_5),"",pos='n',font_size=7)} )
        # self.sinais.update( {'in_service.' : Label(C,(c1,l2_5),"")} )
        
        l3=y2-38-caixa_h*.3
        Label(C,(c1,l3),"L",).draw(state="normal")
        Label(C,(c2,l3),"Src").draw(state="normal")
        Label(C,(c3,l3),"Tgt").draw(state="normal")
        Label(C,(c4,l3),"PayL").draw(state="normal")

        l4=y2-38-caixa_h*.2
        self.sinais.update( {'sel' : Label(C,(c1,l4),"")} )
        self.sinais.update( {'out_source' : Label(C,(c2,l4),"")} )
        self.sinais.update( {'out_target' : Label(C,(c3,l4),"")} )
        self.sinais.update( {'out_payload' : Label(C,(c4,l4),"")} )


        l4_5=y2-38-caixa_h*.1
        self.sinais.update( {'out_service' : Label(C,(x1+local_w/2,l4_5),"",pos='n',font_size=7)} )
        # self.sinais.update( {'out_service.' : Label(C,(c1,l4_5),"")} )

        self.label_id=Label(C,(x2-32,y1+38),*router_address,font_size=10,pre_text="{} x {}",pos='e')
        self.label_id.draw()
        self.label_id.update(*router_address)

        # self.sinais.update( {'sel' : Label(C,(x2-32,y1+50),"",pre_text="sel: {}",font_size=8,bold=False,pos='e')} )
        self.sinais.update( {'sel_port' : Label(C,(x2-32,y1+47),"",  pre_text="sel_port: {}",font_size=8,bold=False,pos='e')} )
        self.sinais.update( {'free_index' : Label(C,(x2-32,y1+57),"",pre_text="free index:{}",font_size=8,bold=False,pos='e')} )
        self.sinais['sel'].draw()
        self.sinais['sel_port'].draw()

                # self.sinais.update( {'sel' : Label(C,(x2-32,y1+50),"",pre_text="sel: {}",font_size=8,bold=False,pos='e')} )
        self.sinais.update( {'sec_zone_ID' : Label(C,(x2-70,y1+38),"","",pre_text="sz:{},{}",font_size=5,bold=False,pos='e')} )
        self.sinais['sec_zone_ID'].draw()

        self.wrapper=list()

        self.wrapper.insert(stds.EAST,Box(C,(x2-33,y1+3*local_h/7.4),(5,local_h/4)))
        self.wrapper.insert(stds.WEST,Box(C,(x1+28,y1+3*local_h/7.4),(5,local_w/4)))
        self.wrapper.insert(stds.NORTH,Box(C,(x1+3*local_w/7.4,y1+28),(local_w/4,5)))
        self.wrapper.insert(stds.SOUTH,Box(C,(x1+3*local_w/7.4,y2-33),(local_w/4,5)))
        # self.wrapper.insert(stds.LOCAL,Box(C,(x1+28,y1+28),(10,10)))
        for i in range(0,4):
            self.wrapper[i].draw()

        self.opmode=Box(C,(x1+38,y2-38-caixa_h*.4),(10,10))
        self.opmode.draw()
        # test.update("green")
        # self.sinais.update

        # Prepara a localização das portas
        # OBSERVAÇÃO: Precisa ser feito na ordem certa: 
        # EAST, WEST, NORTH, SOUTH, LOCAL
        # Desta forma os indices da lista batem na ordem certa
        # Portas EAST, define posições
        IN_EAST_ACK=(x2 - 26,y1+int(local_h*0.2))
        IN_EAST_NACK=(x2 - 26,y1+int(local_h*0.25))
        OUT_EAST_REQ=(x2 - 26,y1+int(local_h*0.4))

        IN_EAST_REQ=(x2 - 26,y1+int(local_h*0.6))
        OUT_EAST_NACK=(x2 - 26,y1+int(local_h*0.75))
        OUT_EAST_ACK=(x2 - 26,y1+int(local_h*0.8))

        self.portas[stds.IN_ACK].insert(stds.EAST,ArrowInput(C,IN_EAST_ACK,stds.EAST))
        self.portas[stds.IN_NACK].insert(stds.EAST,ArrowInput(C,IN_EAST_NACK,stds.EAST))
        self.portas[stds.OUT_REQ].insert(stds.EAST,ArrowOutput(C,OUT_EAST_REQ,stds.EAST))
        self.portas[stds.IN_REQ].insert(stds.EAST,ArrowInput(C,IN_EAST_REQ,stds.EAST))
        self.portas[stds.OUT_NACK].insert(stds.EAST,ArrowOutput(C,OUT_EAST_NACK,stds.EAST))
        self.portas[stds.OUT_ACK].insert(stds.EAST,ArrowOutput(C,OUT_EAST_ACK,stds.EAST))

        # Portas WEST
        OUT_WEST_ACK=(x1,y1+int(local_h*0.2))
        OUT_WEST_NACK=(x1,y1+int(local_h*0.25))
        IN_WEST_REQ=(x1,y1+int(local_h*0.4))

        OUT_WEST_REQ=(x1,y1+int(local_h*0.6))
        IN_WEST_NACK=(x1,y1+int(local_h*0.75))
        IN_WEST_ACK=(x1,y1+int(local_h*0.8))

        self.portas[stds.IN_ACK].insert(stds.WEST,ArrowInput(C,IN_WEST_ACK,stds.WEST))
        self.portas[stds.IN_NACK].insert(stds.WEST,ArrowInput(C,IN_WEST_NACK,stds.WEST))
        self.portas[stds.OUT_REQ].insert(stds.WEST,ArrowOutput(C,OUT_WEST_REQ,stds.WEST))
        self.portas[stds.IN_REQ].insert(stds.WEST,ArrowInput(C,IN_WEST_REQ,stds.WEST))
        self.portas[stds.OUT_NACK].insert(stds.WEST,ArrowOutput(C,OUT_WEST_NACK,stds.WEST))
        self.portas[stds.OUT_ACK].insert(stds.WEST,ArrowOutput(C,OUT_WEST_ACK,stds.WEST))
        
        # Portas NORTH

        OUT_NORTH_ACK=(x1+int(local_w*0.2),y1)
        OUT_NORTH_NACK=(x1+int(local_w*0.25),y1)
        IN_NORTH_REQ=(x1+int(local_w*0.4),y1)

        OUT_NORTH_REQ=(x1+int(local_w*0.6),y1)
        IN_NORTH_NACK=(x1+int(local_w*0.75),y1)
        IN_NORTH_ACK=(x1+int(local_w*0.8),y1)

        self.portas[stds.IN_ACK].insert(stds.NORTH,ArrowInput(C,IN_NORTH_ACK,stds.NORTH))
        self.portas[stds.IN_NACK].insert(stds.NORTH,ArrowInput(C,IN_NORTH_NACK,stds.NORTH))
        self.portas[stds.OUT_REQ].insert(stds.NORTH,ArrowOutput(C,OUT_NORTH_REQ,stds.NORTH))
        self.portas[stds.IN_REQ].insert(stds.NORTH,ArrowInput(C,IN_NORTH_REQ,stds.NORTH))
        self.portas[stds.OUT_NACK].insert(stds.NORTH,ArrowOutput(C,OUT_NORTH_NACK,stds.NORTH))
        self.portas[stds.OUT_ACK].insert(stds.NORTH,ArrowOutput(C,OUT_NORTH_ACK,stds.NORTH))

        # # Portas SOUTH
        IN_SOUTH_ACK=(x1+int(local_w*0.2),y2-26)
        IN_SOUTH_NACK=(x1+int(local_w*0.25),y2-26)
        OUT_SOUTH_REQ=(x1+int(local_w*0.4),y2-26)

        IN_SOUTH_REQ=(x1+int(local_w*0.6),y2-26)
        OUT_SOUTH_NACK=(x1+int(local_w*0.75),y2-26)
        OUT_SOUTH_ACK=(x1+int(local_w*0.8),y2-26)

        self.portas[stds.IN_ACK].insert(stds.SOUTH,ArrowInput(C,IN_SOUTH_ACK,stds.SOUTH))
        self.portas[stds.IN_NACK].insert(stds.SOUTH,ArrowInput(C,IN_SOUTH_NACK,stds.SOUTH))
        self.portas[stds.OUT_REQ].insert(stds.SOUTH,ArrowOutput(C,OUT_SOUTH_REQ,stds.SOUTH))
        self.portas[stds.IN_REQ].insert(stds.SOUTH,ArrowInput(C,IN_SOUTH_REQ,stds.SOUTH))
        self.portas[stds.OUT_NACK].insert(stds.SOUTH,ArrowOutput(C,OUT_SOUTH_NACK,stds.SOUTH))
        self.portas[stds.OUT_ACK].insert(stds.SOUTH,ArrowOutput(C,OUT_SOUTH_ACK,stds.SOUTH))

        # # Portas LOCAL

        IN_LOCAL_ACK=(x1+int(local_w*0.16),y1+int(local_h*0.22))
        OUT_LOCAL_REQ=(x1+int(local_w*0.20),y1+int(local_h*0.2))
        IN_LOCAL_NACK=(x1+int(local_w*0.24),y1+int(local_h*0.18))

        OUT_LOCAL_ACK=(x1+int(local_w*0.32),y1+int(local_h*0.22))
        IN_LOCAL_REQ=(x1+int(local_w*0.36),y1+int(local_h*0.2))
        OUT_LOCAL_NACK=(x1+int(local_w*0.40),y1+int(local_h*0.18))


        self.portas[stds.IN_ACK].insert(stds.LOCAL,ArrowInput(C,IN_LOCAL_ACK,stds.LOCAL))
        self.portas[stds.IN_NACK].insert(stds.LOCAL,ArrowInput(C,IN_LOCAL_NACK,stds.LOCAL))
        self.portas[stds.OUT_REQ].insert(stds.LOCAL,ArrowOutput(C,OUT_LOCAL_REQ,stds.LOCAL))
        self.portas[stds.IN_REQ].insert(stds.LOCAL,ArrowInput(C,IN_LOCAL_REQ,stds.LOCAL))
        self.portas[stds.OUT_NACK].insert(stds.LOCAL,ArrowOutput(C,OUT_LOCAL_NACK,stds.LOCAL))
        self.portas[stds.OUT_ACK].insert(stds.LOCAL,ArrowOutput(C,OUT_LOCAL_ACK,stds.LOCAL))
        for i in self.sinais.values():
            i.draw()
        self.caixa=Box(C,(x1,y1),(local_w,local_h),color="red",alpha=True,state="hidde")
        self.caixa.draw()
    def set_time(self,time):
        self.model.set_time(time)
        signals=self.model.get_all_values()
        
        # print("\nrouter {}x{}".format(*self.router_address))
        for signal_name,signal_number in zip(['in_ack','in_nack','out_req','in_req','out_nack','out_ack'],range(6)):
            vec = [int(x) for x in signals[signal_name][1]]
            for val,port in zip(vec,range(4,-1,-1)): # local south north west east
                if signal_name in ['in_nack','out_nack']:
                    self.portas[signal_number][port].update(val*-1)
                else:
                    self.portas[signal_number][port].update(val)
            # print(signal_name+f' {vec} string: {signals[signal_name]}')
        
        for k,v in signals.items():
            if k in self.sinais:
                # print(f"{k} - {v[1]}")
                if("service" in k):
                    # self.sinais[k].update(v[1])
                    # self.sinais[k+'.'].update(services[v[1]])
                    self.sinais[k].update(services[v[1]])
                elif("fsm1" == k):
                    self.sinais[k].update(str(v[1])+' '+fsm1[v[1]])
                elif("fsm2" == k):
                    self.sinais[k].update(str(v[1])+' '+fsm2[v[1]])
                elif("sec_zone_ID" == k):
                    self.sinais[k].update(*v[1]) # tupla
                elif("in_payload" == k):
                    self.sinais[k].update(hex(int(v[1],2))) # tupla
                elif("out_payload" == k):
                    self.sinais[k].update(hex(int(v[1],2))) # tupla
                else:
                    self.sinais[k].update(str(v[1]))
            elif k == "in_fail":
                for new_v,i in zip(list(v[1])[1:],range(3,-1,-1)): # exceto porta local
                    self.wrapper[i].update(wrapper_color[new_v]) 
            elif k == "out_opmode":
                self.opmode.update(opmode_color[v[1][0]])
            elif k == "sec_zone":
                if v[1] == 0:  # sem zona segura
                    self.caixa.update(state='hidde', color="red")
                elif v[1] == 1: # zona segura definida
                    self.caixa.update(state='hidde', color='green')
                elif v[1] == 2: # zona segura ativa
                    self.caixa.update(state='normal', color='red')



        
    ################################################################################################### 
    # 
    # 
    #  
    def set_max_tick(self, max_tick):
        self.max_tick=max_tick


    def filter_next_value(self,signals,value,originaltick):
        for signal in signals:
            hsignal=self.model.historico_sinal[signal]
            for tick in [k for k in hsignal.keys() if k>originaltick]:
                if hsignal[tick] == value:
                    return tick
        return originaltick

    def filter_prior_value(self,signals,value,originaltick):
        for signal in signals:
            hsignal=self.model.historico_sinal[signal]
            for tick in [k for k in reversed(hsignal.keys()) if k<originaltick]:
                if hsignal[tick] == value:
                    return tick
        return originaltick
        
    def get_next_event(self,time):
        return self.model.get_next_event(time)

    def get_prior_event(self,time):
        return self.model.get_prior_event(time)

    def get_prior_signals_event(self,signals,time):
        return self.model.get_prior_signals_event(signals,time)

    def get_next_signals_event(self,signals,time):
        return self.model.get_next_signals_event(signals,time)

    def get_all_signals(self):
        return self.model.get_all_values()
    # def 
    # def 
