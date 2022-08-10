from tkinter import *
import sqlite3
import time
import json

master = Tk()

sic = 0
dep = 0
bat = 0
aki = 0
eng = 0
ivm = 0
hiz = 0
y = 0


conv = sqlite3.connect("Veri1.db")
cursorv = conv.cursor()

def tabloOlusturVeri():
   cursorv.execute("CREATE TABLE IF NOT EXISTS veri (sag INT, sol INT, ileri INT, geri INT, bassag INT, bassol INT, guc INT, bas INT)")

   conv.commit() 

def veriYazVeri(sag, sol, ileri, geri, bassag, bassol, guc, bas):

    cursorv.execute("INSERT INTO veri  (sag, sol, ileri, geri, bassag, bassol, guc, bas) VALUES(?, ?, ?, ?, ?, ?, ?, ?)",
                   (sag, sol, ileri, geri, bassag, bassol, guc, bas))
    
    conv.commit() 

def tabloSilVeri():
    cursorv.execute(f"DELETE FROM veri")
    conv.commit() 

def dosyaOkuVeri():
    dosya = open("hareket.txt","r",encoding="utf-8")
    oku = dosya.read()
    veri = json.loads(oku)
    print(veri["guc"])
    
    return veri


for i in range(2):
    print(i)
    tabloOlusturVeri()
    tabloSilVeri()
    veri = dosyaOkuVeri()
    veriYazVeri(veri["sag"], veri["sol"], veri["ileri"], veri["geri"], veri["bassag"], veri["bassol"], veri["guc"], veri["bas"])
    print(i)

con = sqlite3.connect("Data1.db")
cursor = con.cursor()

def tabloOlustur1():
   cursor.execute("CREATE TABLE IF NOT EXISTS data (kontrol INT, sicaklik FLOAT, depo INT, batarya INT, sure1 INT, sure2 INT, sure3 INT, akim INT, resim TEXT, engel INT, ivme INT, hiz INT, log TEXT, kor1 INT, kor2 INT, sagalt1 INT, sagalt2 INT, solalt1 INT, solalt2 INT, sagust1 INT, sagust2 INT, solust1 INT, solust2 INT)")

def demeneVerisi(x, sic, dep, bat, aki, eng, ivm, hiz):

    cursor.execute("INSERT INTO data (kontrol, sicaklik, depo, batarya, sure1, sure2, sure3, akim, resim, engel, ivme, hiz, log, kor1, kor2, sagalt1, sagalt2, solalt1, solalt2, sagust1, sagust2, solust1, solust2) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                   (x, sic, dep, bat, 3, 36, 12, aki, "res", eng, ivm,  hiz, "Arac calismaya basladi",
                    -33.003, 151.003, -33.001, 151.001, -33.005, 151.001, -33.001, 151.005, -33.005, 151.005))
    
    con.commit()
   
def tabloSil():
    cursor.execute(f"DELETE FROM data")
    con.commit() 

def dosyaOku():
    dosya = open("deneme.txt","r",encoding="utf-8")
    oku = dosya.read()
    veri = json.loads(oku)
    
    con.commit()
    
    return oku

def get_all_users( json_str = True ):
    conn = sqlite3.connect("Data1.db")
    conn.row_factory = sqlite3.Row
    db = conn.cursor()

    rows = db.execute('''
    SELECT * from data
    ''').fetchall()

    conn.commit()
    conn.close()

    if json_str:
        return json.dumps( [dict(ix) for ix in rows] ) #CREATE JSON

    return rows


dosya = open("deneme.txt","w",encoding="utf-8")
dosya.write("")
    
tabloSil()
demeneVerisi(0, 0, 0, 0, 0, 0, 0, 0)


canvas = Canvas(master, height = 650, width = 150)
canvas.pack()

frame_ust = Frame(master, bg = "#add8e6")
frame_ust.place(relx = 0.05, rely = 0.05, relwidth = 0.9, relheight = 0.9)

var = IntVar()

konO = Radiobutton(frame_ust, text = "Otonom", variable = var, value = 1)
konO.pack(anchor = NW, pady = 5, padx = 15)

konM = Radiobutton(frame_ust, text = "Manuel", variable = var, value = 2)
konM.pack(anchor = NW, pady = 5, padx = 15)


def upd(x):
    sic = sc1.get()
    dep = sc2.get()
    bat = sc3.get()
    aki = sc4.get()
    eng = sc5.get()
    ivm = sc6.get()
    hiz = sc7.get()
    
    tabloSil()
    demeneVerisi(x, sic, dep, bat, aki, eng, ivm, hiz)

    dosya = open("deneme.txt","w",encoding="utf-8")
    dosya.write("")
    
    s = get_all_users()
 
    s =  s[1:len(get_all_users()) - 1]
    dosya1 = open("deneme.txt","w",encoding="utf-8")
    dosya1.write(s)
    

sc1 = Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc1.pack(padx = 0, pady = 0)  
bt1 = Button(frame_ust, text="sicaklik", width = 10)
bt1.pack(padx = 0, pady = 0)

sc2 = Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc2.pack(padx = 0, pady = 0)  
bt2 = Button(frame_ust, text="depo", width = 10)
bt2.pack(padx = 0, pady = 0)

sc3= Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc3.pack(padx = 0, pady = 0)  
bt3 = Button(frame_ust, text="batarya", width = 10)
bt3.pack(padx = 0, pady = 0)

sc4 = Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc4.pack(padx = 0, pady = 0)  
bt4 = Button(frame_ust, text="akim", width = 10)
bt4.pack(padx = 0, pady = 0)

sc5 = Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc5.pack(padx = 0, pady = 0)  
bt5 = Button(frame_ust, text="engel", width = 10)
bt5.pack(padx = 0, pady = 0)

sc6 = Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc6.pack(padx = 0, pady = 0)  
bt6 = Button(frame_ust, text="ivme", width = 10)
bt6.pack(padx = 0, pady = 0)

sc7 = Scale(frame_ust, from_ = 0, to = 100, length = 100, orient = "horizontal")
sc7.pack(padx = 0, pady = 0)  
bt7 = Button(frame_ust, text="hiz", width = 10)
bt7.pack(padx = 0, pady = 0)

btu = Button(frame_ust, text="up", width = 10, command = lambda:upd(0))
btu.pack(padx = 0, pady = 0)

while True:
    dosya = open("A2A.txt","r",encoding="utf-8")
    veri = dosya.read()
    y = int(veri)
        
    print(y) 
    
    master.update()
    
    time.sleep(0.01)


#for x in range(15):
 #   tabloSil()
  #  demeneVerisi(x, sic, dep, bat, aki, eng, ivm, hiz)

   # dosya = open("deneme.txt","w",encoding="utf-8")
    #dosya.write("")
    
    #s = get_all_users()
 
#    s =  s[1:391]
 #   dosya1 = open("deneme.txt","w",encoding="utf-8")
  #  dosya1.write(s)
                          
   # print(x)
    
    #time.sleep(0.01)