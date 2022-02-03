#!/usr/bin/python3
from control import RouterControl
from gui import *
from standards import *
from file_handler import *
import sys
# import bplustree # https://pypi.org/project/bplustree/

global width,height
#control
width=800
height=800


def main():
    # dim=(4,4)
    # logs=dict()
    project = sys.argv[1]

    try:
        ( dim, logs) = load_files(project)
    except LOG_FOLDER_NOT_FOUND (Exception):
        print("Routers log folder not found!!")
        exit(0)
    except LOG_FOLDER_IS_EMPTY (Exception):
        print("Routers log folder is empty!")
        exit(0)
    except ROUTER_LOG_EXCEPTION (Exception):
        print("Json file not present!")
        exit(0)
    except TESTCASE_NOT_FOUND_EXCEPTION (Exception):
        print("Yaml file not present!")
        exit(0)
    except TESTCASE_EXCEPTION (Exception):
        print("Yaml file inconsistent!")
        exit(0)
    # print(logs)
    routers=[]


    global width,height

    (x,y) = int(width/dim[0]),int(height/dim[1])
    # x=y #(int(x*1),  int(y*1))
    if x < 220 or x > 280:
        x=220
        y=220
        canvas_size=(dim[0]*x+10,dim[1]*y+10)
    else:
        canvas_size=(width,height)
    # if(canvas_size[0] < width):
    #     width=canvas_size[0]
    # if(canvas_size[1] < height):
    #     height=canvas_size[1]
    (box_size) = x,y #ajusta espaco para cada router
    rede=NetworkView(canvas_size,width,height)
    for j in range(dim[0]): #linha
        for i in range(dim[1]): #coluna
            # calcula coordenadas na caixa baseado na posicao
            coord = rede.draw_boxes((i,dim[1]-j-1),box_size) # desenho comeca por baixo, por isso a coordenada J eh decrementada

            bordas=28
            draw_box(rede.getCanvas(),*soma_tup(coord,(bordas,bordas,-bordas,-bordas)))
            # Box(rede.getCanvas(),coord,box_size,color="orange").draw()
            router_addres = (i,j)
            nr=RouterControl(rede.getCanvas(),(i,j),logs[(i,j)],coord)
            routers.append(nr)
            # nr.insert_component()
            for u in range (0,5):
            # u = 0
                for port in range(0,6):
                    if rede.test_limits(dim,u,i,j) : # nao desenha as bordas
                        nr.portas[port][u].draw() # mandar desenhar

    rede.draw(dim,canvas_size,routers)
    rede.data_loop(routers)

if __name__=="__main__":
    main()