# from os import name
import os
import tkinter as tkk
from time import sleep
from tkinter.constants import *
from tkinter.font import BOLD
from standards import *

# global speed, tick, pause

global images, fps
fps = 60 # frames drawed p/second
images=dict()
##############################################################################
# Elementos gráficos da simulação
# 

class GElements():
    #  coords:tuple[int,int]  # somente python 3.9 em diante...
    def __init__(self, C:tkk.CallWrapper, coords:tuple, img:str) -> None:
        self.C=C
        self.coords = coords
        self.img = img
        self.canvas_id = None
        # print("construtor")
        # print(self.C)
    def draw(self):
        im=load_image(self.img)
        self.canvas_id=self.C.create_image(self.coords,image=im,anchor=NW)
    def hidde(self):
        self.C.itemconfig(self.canvas_id,state="hidden")
    def show(self):
        self.C.itemconfig(self.canvas_id,state="normal")

class SignalRepresentation():
    def __init__(self,C:tkk.CallWrapper,coords:tuple) -> None:
        self.coords = coords
        self.C = C
    def update(self,value):
        'Must Be implemented'
        raise NotImplemented
    def draw(self):
        'Must Be implemented'
        raise NotImplemented

class Label(SignalRepresentation):
    def __init__(   self, C:tkk.CallWrapper,coords: tuple,*text, pre_text:str='{}',
                    font_size:int=8,bold:bool=False,font_name:str="Helvetica",pos="nw") -> None:
        super().__init__(C,coords)
        self.text=text
        self.font_size=font_size
        self.pos=pos
        self.font_name=font_name
        self.bold=bold
        self.pre_text=pre_text
    def update(self, *text,font_size=None,bold=None):
        self.text=text

        font_size=self.font_size if font_size == None else font_size
        self.bold=self.bold if bold == None else bold
        self.C.itemconfig(   self.canvas_id,
                        text=self.pre_text.format(*self.text if self.text is tuple else self.text),
                        state='normal',
                        font=(self.font_name, self.font_size, BOLD if self.bold else NORMAL))
    def draw(self,state='hidde'):
        self.canvas_id = self.C.create_text(self.coords,
                        text=self.pre_text.format(*self.text if self.text is tuple else self.text),
                        state=state,
                        font=(self.font_name, self.font_size, BOLD if self.bold else NORMAL),anchor=self.pos)

class Arrow(SignalRepresentation):
    def __init__(self, C:tkk.CallWrapper, coords:tuple, imgReject:str ,imgInactive:str,imgActive:str) -> None:
        super().__init__(C,coords)
        # print(f"C: {C}")
        self.val = 0
        self.rejectArrow=GElements(C,coords,imgReject)
        self.inactiveArrow=GElements(C,coords,imgInactive)
        self.activeArrow=GElements(C,coords,imgActive)
    def __repr__(self) -> str:
        return f"coordenadas: {self.coords} estado: {'ativo' if self.val else 'inativo'}"
    def draw(self):
        self.inactiveArrow.draw()
        self.activeArrow.draw()
        self.rejectArrow.draw()
    def update(self,val):
        self.val = val
        if val==1:
            self.rejectArrow.hidde()
            self.inactiveArrow.hidde()
            self.activeArrow.show()
        elif val==-1:
            self.rejectArrow.show()
            self.inactiveArrow.hidde()
            self.activeArrow.hidde()
        else:
            self.rejectArrow.hidde()
            self.inactiveArrow.show()
            self.activeArrow.hidde()

    
class ArrowInput (Arrow):
    def __init__(self, C:tkk.CallWrapper, coords:tuple, direction:int) -> None:
        if (direction==stds.EAST):
            super().__init__(C, coords, "images/red_left.gif","images/left.gif","images/green_left.gif")
        if (direction==stds.WEST):
            super().__init__(C, coords, "images/red_right.gif","images/right.gif","images/green_right.gif")
        if (direction==stds.NORTH):
            super().__init__(C, coords, "images/red_down.gif","images/down.gif","images/green_down.gif")
        if (direction==stds.SOUTH):
            super().__init__(C, coords, "images/red_up.gif","images/up.gif","images/green_up.gif")
        if (direction==stds.LOCAL):
            super().__init__(C, coords, "images/red_local_in.gif","images/local_in.gif","images/green_local_in.gif")

class ArrowOutput (Arrow):
    def __init__(self, C:tkk.CallWrapper, coords:tuple, direction:int,canvas_id1=-1,canvas_id2=-1) -> None:
        if (direction==stds.EAST or direction==stds.WEST):
            super().__init__(C, coords, "images/red_undirected_h.gif","images/undirected_h.gif","images/green_undirected_h.gif")
        if (direction==stds.NORTH or direction==stds.SOUTH):
            super().__init__(C, coords, "images/red_undirected_v.gif","images/undirected_v.gif","images/green_undirected_v.gif")
        if (direction==stds.LOCAL):
            super().__init__(C, coords, "images/red_local_out.gif", "images/local_out.gif", "images/green_local_out.gif")

class Box(SignalRepresentation):
    def __init__(   self, C:tkk.CallWrapper, coords: tuple,size:tuple,color="red",alpha=False, state='normal') -> None:
        super().__init__(C,coords)
        self.size=size
        self.color=color
        self.alpha=alpha
        self.state=state
    def update(self, color:str,state='normal'):
        self.state=state
        self.color=color
        self.C.itemconfig(self.canvas_id,fill=self.color,state=self.state)
    def draw(self):
        x1,y1= self.coords
        x2,y2=soma_tup(self.coords,self.size)
        if self.alpha:
            self.canvas_id = self.C.create_rectangle(x1,y1,x2,y2, fill=self.color,stipple="gray25", state=self.state)
        else:
            self.canvas_id = self.C.create_rectangle(x1,y1,x2,y2, fill=self.color,state=self.state)

def draw_box(C,x1,y1,x2,y2):
    # global top,self.frame_principal,C
    C.create_rectangle(x1,y1,x2,y2, fill="orange")

def load_image(name): # carrega imagens e evita o carregamento repetido caso já estiver presente na memória
    global images
    if images.get(name)==None:
        try:
            imgpath=os.environ.get("HEMPS_PATH")+"/build_env/gui_router_seek/"+name
            images.update({name:tkk.PhotoImage(file=imgpath)})
        except FileNotFoundError:
            try:
                images.update({name:tkk.PhotoImage(file=name)})
            except FileNotFoundError:
                imgpath="../../build_env/gui_router_seek/"+name
                images.update({name:tkk.PhotoImage(file=imgpath)})
            
    return images.get(name)
##############################################################################################################################
# I/O e loop
class NetworkView():
    def __init__(self,canvas_size:tuple,width,height) -> None:
        self.setup_screen(*canvas_size,width,height+40)
        self.tick=0
        self.speed=1
        self.pause=1
    def breakloop(self,event:tkk.Event=None): # evento para parar o programa
        # global loop
        self.loop=False

    def getCanvas(self):
        return self.C

    def print_speed(self):return "Speed: {:.2f} tick/frame {}".format(self.speed,"PAUSED" if self.pause else '')
    def print_tick(self):
        # global max_tick
        return f"Tick: {self.tick} of {self.max_tick}"

    def mouse_event(self,event:tkk.Event):
        # global hbar, vbar
        # print(f"event: {event}")
        print (f"{event.x}x{event.y}")
        # print(f"h: {C.winfo_width()} v: {C.winfo_height()}")
        print(f"rolagem h:{self.hbar.get()}\nrolagem v{self.vbar.get()}")
        print(f"h: {event.x+(self.C.winfo_width()*(1-self.hbar.get()[1]))} v: {event.y*(1+self.vbar.get()[0])}")
        print(event)
        # print(C.yview_scroll(event.y,'units'))
        # tkk.Frame(bg="#333333",name="pe",width=400,height=400)

    def change_speed_event(self,event:tkk.Event):
        # global speed, pause, tick, jump
        change = 0
        if event.state==16:
            change=1
        elif event.state==17:
            change=10
        elif event.state==20:
            change=100
        if event.keysym == 'equal' or event.keysym == 'plus' or event.keysym == 'KP_Add':
            self.speed+=change
        elif event.keysym == 'minus' or event.keysym == 'underscore' or event.keysym == 'KP_Subtract':
            self.speed-=change
        elif event.keysym == 'space':
            self.pause = (self.pause + 1) % 2
        elif event.keysym == "Up": #proximo evento
            self.jump = 1
            # print (jump)
        elif event.keysym == "Down": #evento anterior
            self.jump = -1
            # print (jump)
        elif event.keysym == "Right":
            self.tick += 1
        elif event.keysym == "Left":
            self.tick -= 1

    def setup_keys(self):
        # https://stackoverflow.com/questions/32289175/list-of-all-tkinter-events
        # eventos: bind ou bind_all 
        self.C.bind("<Button-1>",lambda b:self.mouse_event(b))
        self.C.bind("<less>",lambda b:self.change_speed_event(b))

        self.top.bind("<Key>",lambda b:self.change_speed_event(b)) # top.bind("<Left>",tick_event) #key abrange estes todos
        self.top.bind("<Escape>",lambda b:self.breakloop(b))
        self.top.protocol("WM_DELETE_WINDOW", self.breakloop)
    
        self.top.bind("<KP_Add>",lambda b:self.change_speed_event(b))
        self.top.bind("<KP_Subtract>",lambda b:self.change_speed_event(b))
        # incrementar a velocidade
        self.C.bind_all("-",lambda b:self.change_speed_event(b))
        self.C.bind_all("=",lambda b:self.change_speed_event(b))
        # com shift incrementa ainda mais velocidade mais
        self.C.bind_all("_",lambda b:self.change_speed_event(b))  
        self.C.bind_all("+",lambda b:self.change_speed_event(b))
        # control incrementa aaaiiinnnda mais

        self.top.bind_all("<space>",lambda b:self.change_speed_event(b))
        self.C.bind_all("q",lambda b:self.breakloop(b))
        # t=teste()
        # C.bind_all("m",lambda b: t.evento(b))
        # C.bind_all("qQ",breakloop)
    # def repintar(id, valor):

    def data_loop(self,routers:dict):
        # global loop, labels, pause, tick, jump, max_tick, filterval
        self.filterval=''
        self.jump=0
        self.loop=True
        self.blink=0
        past_tick=-1
        # jumpval=1
        while (self.loop):
            sleep(1/fps)
            if self.filterval!='' and self.jump==1:
                next=[rx.filter_next_value(self.selections,self.filterval,self.tick) for rx in routers]
                next=[n for n in next if n > self.tick]
                print("aqui")
                if len(next) > 0:
                    self.tick=min(next)
                self.jump=0
            elif self.filterval!='' and self.jump==-1:
                prev=[rx.filter_prior_value(self.selections,self.filterval,self.tick) for rx in routers]
                prev=[n for n in prev if n < self.tick]
                if len(prev) > 0:
                    self.tick=max(prev)
                self.jump=0
            
            if self.jump==-1 and self.filterval=='': #pular para evento anterior ou proximo
                # print ("pula")
                if len(self.selections) >= 1:
                    self.tick=max([rx.get_prior_signals_event(self.selections,self.tick) for rx in routers])
                else:
                    self.tick=max([rx.get_prior_event(self.tick) for rx in routers])
                self.jump=0
            elif self.jump==1 and self.filterval=='':
                # print ("pula")
                if len(self.selections) >= 1:
                    eventos=[rx.get_next_signals_event(self.selections,self.tick) for rx in routers]
                else:
                    eventos=[rx.get_next_event(self.tick) for rx in routers]
                print(eventos)
                self.tick=min(eventos)
                self.jump=0

            if not self.pause:
                self.tick += self.speed
            
            if self.tick>=self.max_tick: self.tick=self.max_tick; pause=1
            if self.tick < 0: self.tick = 0; pause = 1
            if self.top == None: return
            if(self.tick!=past_tick):
                # print(f"{'#'*40} Tick: {tick} {'#'*40}")
                for r in routers:
                    r.set_time(self.tick)
            self.C.itemconfig(self.labels['speed'],text=self.print_speed())
            self.C.itemconfig(self.labels['tick'],text=self.print_tick())
            past_tick=self.tick
            # self.C.update()
            self.top.update_idletasks()
            self.top.update()
        
        print("Bye!")
        self.C.destroy()
        self.frame_principal.destroy()
        self.top.destroy()

    def draw_boxes(self,pos,size:tuple):
        a =  mult_tup(pos,size)  + mult_tup(soma_tup(pos,(1,1)),size)
        return a

    def test_limits(self,dim,side,i,j)-> bool:
        w = ((side != stds.WEST and i == 0) or i !=0)
        e = ((side != stds.EAST and i == dim[0]-1) or i !=dim[0]-1)
        n = ((side != stds.NORTH and j == dim[1]-1) or j !=dim[1]-1)
        s = ((side != stds.SOUTH and j == 0) or j !=0)
        return w and e and n and s
    def set_speed(self,v=None,p=False,j=None,fval=False):
        # global speed,pause,self.jump, filterval
        if fval!=False:
            self.filterval=fval
            print(f"buscar por evento:{fval}")
        if p:
            self.pause =(self.pause + 1) % 2
        elif isinstance(v,int) and v!=None:
            try:
                v=int(v)
            except:
                self.msg_window(self.top,"Erro","Caracteres inválidos!")
            self.speed=v
        elif j:
            self.jump=j
            # print(jump)
    def set_tick(self,v):
        # global tick, max_tick
        try:
            v=int(v)
            if v in range(0,self.max_tick+1) and isinstance(v,int):
                self.tick=v
            else:
                self.msg_window(self.top,"Erro","Valor fora do intervalo")
        except:
            self.msg_window(self.top,"Erro","Caracteres inválidos!")

    def msg_window(self,pai,title,text):
        msg_window=tkk.Toplevel(self.top)
        msg_window.geometry("300x140")
        msg_window.resizable(width=False, height=False) #https://stackoverflow.com/questions/21958534/how-can-i-prevent-a-window-from-being-resized-with-tkinter
        msg_window.title(title)
        l=tkk.Label(msg_window,text=text)
        b=tkk.Button(msg_window,text="Ok",command=lambda : msg_window.destroy())
        l.pack(expand=2)
        b.pack(expand=2)
        b.bind("<Return>",lambda : msg_window.destroy())
        b.bind("<KP_Enter>",lambda : msg_window.destroy())
        pai.wait_window(msg_window)

    def select_signals(self,listbox:tkk.Listbox,filter_window:tkk.Toplevel):
        # global selections
        self.selections = [*listbox.get(0,listbox.size())]
        listbox.grab_release()
        filter_window.destroy()
        print(f"selections: {self.selections}")
    def filter_window(self,routers):
        # global selections
        print(f"selections: {self.selections}")
        filter_window=tkk.Toplevel(self.top)
        filter_window.geometry("400x600")
        filter_window.resizable(width=False, height=False)
        filter_window.title("Filter")
        # https://www.tutorialspoint.com/python/tk_listbox.htm
        signal_selection = tkk.Listbox(filter_window,selectmode=SINGLE,height=5)
        signal_selection.insert(END,*tuple(routers[0].get_all_signals().keys()))
        signal_selection.pack(side=LEFT,expand=2,fill=Y)

        buttons=tkk.Label(filter_window)
        buttons.pack(side=LEFT,fill=Y)
        # signal_selection.get()
        signal_selection2 = tkk.Listbox(filter_window,selectmode=SINGLE,height=5)
        if len(self.selections):
            signal_selection2.insert(END,*tuple(self.selections))
        try:
            tkk.Button(buttons,text=">>",command=lambda : signal_selection2.insert(END, signal_selection.selection_get()) ).pack(expand=2)
            tkk.Button(buttons,text="<<",command=lambda : signal_selection2.delete(*signal_selection2.curselection()) ).pack(expand=2)
            tkk.Button(buttons,text="Ok",command=lambda : self.select_signals(signal_selection2,filter_window)).pack(expand=2)
        except:
            self.msg_window(filter_window,"Ops!","Seleção incorreta")
        
        signal_selection2.pack(side=LEFT,expand=2,fill=Y)
        self.top.wait_window(filter_window)

# draw canvas and setup de screen
    def setup_screen(self,c_width,c_height,width,height):
        # global self.top,self.frame_principal,C,hbar,vbar
        self.top = tkk.Tk(className="BrNoC Debugger")
        img = load_image("images/icon.gif")
        self.top.iconphoto(False,img)
        self.frame_principal = tkk.Frame(self.top,background="white")#,width=c_width,height=c_height)
        self.C = tkk.Canvas(self.frame_principal,background="black", width=c_width, height=c_height,scrollregion=(0,0,c_width,c_height))

        self.hbar=tkk.Scrollbar(self.frame_principal,orient=HORIZONTAL)
        self.hbar.pack(side=BOTTOM,fill=X)
        self.hbar.config(command=self.C.xview)
        # hbar.get()
        self.vbar=tkk.Scrollbar(self.frame_principal,orient=VERTICAL)
        self.vbar.pack(side=RIGHT,fill=Y)
        self.vbar.config(command=self.C.yview)

        # C.config(width=c_width,height=c_height)
        self.C.config(xscrollcommand=self.hbar.set, yscrollcommand=self.vbar.set)
    


        print(f"w{width} h{height}")

    def draw(self,dim:tuple,res,routers):
        self.width,self.height= res
        # global labels, max_tick, selections, filterval

        self.labels=dict()
        self.max_tick=max([rx.get_prior_event(int("7FFFFF",16)) for rx in routers])
        [rx.set_max_tick(self.max_tick) for rx in routers] # diz para todos qual o tick máximo
        self.labels.update({'tick':self.C.create_text(self.width/2,0,anchor=N,fill="white", font=("Helvetica", 12, BOLD),text=self.print_tick())})
        self.labels.update({'speed':self.C.create_text(self.width/2,self.height,anchor=S,fill="white", font=("Helvetica", 12, BOLD),text=self.print_speed())})
        
        self.setup_keys() # configurar teclas

        control_frame=tkk.Frame(self.top, width=self.width, height=50)
        control_frame.pack(side=TOP,padx = 5, pady = 5,fill=None,expand=False)

        self.C.pack(side=BOTTOM)
        self.frame_principal.pack(anchor=CENTER,expand=True)#,fill=BOTH)
        # self.top.resizable(width=False, height=False)

        rewind_frame=tkk.Frame(control_frame, width=self.width, height=30)
        rewind_frame.pack(side=LEFT,fill=X)
        
        # rewind_frame.minsize(width=self.width, height=40)
        under_bar=tkk.Frame(rewind_frame, width=self.width, height=10)
        under_bar.pack(side=TOP,fill=X,padx = 5, pady = 5)

        entry_goto=tkk.Entry(under_bar,background="white",fg="#000000")
        entry_goto.pack(side=LEFT)#,padx = 5, pady = 5)
        entry_goto.bind("<Return>",lambda e: self.set_tick(entry_goto.get()) )
        entry_goto.bind("<KP_Enter>",lambda e: self.set_tick(entry_goto.get()) )
        tkk.Button(under_bar,text="goto",command=lambda : self.set_tick(entry_goto.get())).pack(side=LEFT)

        # # ['pause','--','-']
        tkk.Button(under_bar,text=">||",command=lambda :self.set_speed(p=True)).pack(side=LEFT)
        tkk.Button(under_bar,text="---",command=lambda :self.set_speed(v=self.speed-100)).pack(side=LEFT)
        tkk.Button(under_bar,text="--",command=lambda :self.set_speed(v=self.speed-10)).pack(side=LEFT)
        tkk.Button(under_bar,text="-",command=lambda :self.set_speed(v=self.speed-1)).pack(side=LEFT)
        tkk.Label(under_bar,text="speed").pack(side=LEFT)
        tkk.Button(under_bar,text="+",command=lambda :self.set_speed(v=self.speed+1)).pack(side=LEFT)
        tkk.Button(under_bar,text="++",command=lambda :self.set_speed(v=self.speed+10)).pack(side=LEFT)
        tkk.Button(under_bar,text="+++",command=lambda :self.set_speed(v=self.speed+100)).pack(side=LEFT)
        
        under_bar2=tkk.Frame(rewind_frame, width=self.width, height=10,padx=5,pady=5)
        under_bar2.pack(side=TOP,anchor=CENTER)

        findvalue=tkk.Entry(under_bar2,background="white",fg="#000000")
        findvalue.pack(side=LEFT)#,padx = 5, pady = 5)
        findvalue.bind("<Return>",lambda e: lambda :self.set_speed(fval=findvalue.get()) )
        findvalue.bind("<KP_Enter>",lambda e: lambda :self.set_speed(fval=findvalue.get()) )
        tkk.Button(under_bar2,text="filter",command=lambda :self.set_speed(fval=findvalue.get()) ).pack(side=LEFT)

        tkk.Button(under_bar2,text="<<",command=lambda :self.set_speed(j=-1)).pack(side=LEFT,fill=X)
        tkk.Label(under_bar2,text="event").pack(side=LEFT)
        tkk.Button(under_bar2,text=">>",command=lambda :self.set_speed(j=1)).pack(side=LEFT,fill=X)
        
        tkk.Button(under_bar2,text="<",command=lambda :self.set_tick(self.tick-1)).pack(side=LEFT,fill=X)
        tkk.Label(under_bar2,text="tick").pack(side=LEFT)
        tkk.Button(under_bar2,text=">",command=lambda :self.set_tick(self.tick+1)).pack(side=LEFT,fill=X)
        # side_bar=tkk.Frame(control_frame)
        img = load_image("images/icon.gif")
        self.selections=[]
        tkk.Button(control_frame,text="Events\nfilter",command=lambda a = routers:self.filter_window(a)).pack(side=LEFT,anchor=N)
        # tkk.Label(control_frame,text="BrNoC",image=img).pack(side=RIGHT,expand=2,anchor=E)
        logo=tkk.Canvas(control_frame,width=80,height=80)
        logo.create_image((0,0),image=img,anchor=NW)
        
        logo.pack(side=RIGHT,expand=False,anchor=N)
        # signal_selection = tkk.Listbox(control_frame,selectmode=EXTENDED,height=5)
        # signal_selection.insert(END,*tuple(routers[0].get_all_signals().keys()))
        # signal_selection.pack(side=RIGHT,expand=2)
        # tkk.Button(under_bar2,text=">>",command=lambda :set_speed(j=1)).pack(side=LEFT,fill=X)
        # # tkk.Frame
        # for i in range(dim[0]):
        #     for j in range(dim[1]):
        #         pass

        # print(routers[0].filter_next_value(['fsm1'],"1",0))
        self.top.update()
        print ("Tudo desenhado, entrando no loop")