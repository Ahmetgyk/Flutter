import time

y = 0

yon = ""


while True:
    dosya = open("A2A.txt","r",encoding="utf-8")
    veri = dosya.read()
    y = int(veri)
    
    if y == 0:
        yon = "ust"
    elif y == 1:
        yon = "alt"
    elif y == 2:
        yon = "sag"
    elif y == 3:
        yon = "sol"
    else:
        yon = "dur"
        
    print(y) 
    
    time.sleep(0.01)