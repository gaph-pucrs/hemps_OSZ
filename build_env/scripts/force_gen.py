# from sys import argv
import sys
import random as rand

def main():
    x = 3
    y = 3
    ga_cols = 0
    ga_rows = 2
    rate = 10
    gen_force_file(x,y,ga_cols,ga_rows,rate)
    return x

def gen_force_file(x,y,ga_cols,ga_rows,rate):
    rand.seed(333)
    # it's reference in the variable file1
    sigs = open("signals" , "w")
    

    for i in range(0, 10):
        rand.randint(0,x)
        rand.randint(0,y)
        # Writing to file
        sigs.write("/test_bench/HeMPS/slave"+str(rand.randint(0,x))+"x"+str(rand.randint(0,y))+"/RouterCCwrapped/RouterCC_AP/coreRouter/tx(7) 1 1 ms -cancel 3 ms\n")
        # sigs.write("\nWriting to file:)" + str(x) + str(y) + str(ga_cols) + str(ga_rows) + str(rate) )
        
    # Closing file
    sigs.close()
    # "/test_bench/HeMPS/slave0x0/RouterCCwrapped/RouterCC_AP/coreRouter/tx(7) 1 1 ms -cancel 3 ms"
main()