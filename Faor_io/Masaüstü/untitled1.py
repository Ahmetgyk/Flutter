from tkinter import *
import sqlite3
import serial
import time
import json

arduino = serial.Serial(port='COM3', baudrate=115200, timeout=.1)

conv = sqlite3.connect("Veri1.db")
cursorv = conv.cursor()

def tabloOlustur():
   cursor.execute("CREATE TABLE IF NOT EXISTS data (kontrol INT, sicaklik FLOAT, depo INT, batarya INT, sure1 INT, sure2 INT, sure3 INT, akim INT, resim TEXT, engel INT, ivme INT, hiz INT, log TEXT, kor1 INT, kor2 INT, sagalt1 INT, sagalt2 INT, solalt1 INT, solalt2 INT, sagust1 INT, sagust2 INT, solust1 INT, solust2 INT)")

   conv.commit() 
   
def tabloSil():
    cursor.execute(f"DELETE FROM data")
    con.commit() 
    
def dosyaOku():
    dosya = open("deneme.txt","r",encoding="utf-8")
    oku = dosya.read()
    liste = json.loads(oku)
    
    con.commit()
    
    return liste

def veriyaz(liste):
    cursor.execute("INSERT INTO data (kontrol, sicaklik, depo, batarya, sure1, sure2, sure3, akim, resim, engel, ivme, hiz, log, kor1, kor2, sagalt1, sagalt2, solalt1, solalt2, sagust1, sagust2, solust1, solust2) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                   (liste["kontrol"], liste["sicaklik"], liste["depo"], liste["batarya"], liste["sure1"], liste["sure2"], liste["sure3"],
                    liste["akim"], liste["resim"], liste["engel"], liste["ivme"], liste["hiz"], liste["log"], liste["kor1"], liste["kor2"], 
                    liste["sagalt1"], liste["sagalt2"], liste["solalt1"], liste["solalt2"], liste["sagust1"], liste["sagust2"],
                    liste["solust1"], liste["solust2"]))

def jsonDonustur(veri):
    liste = json.loads(veri)
    
    return liste

def ard_yaz(x):
    arduino.write(bytes(x, 'utf-8'))

def ard_oku():
    data = arduino.readline()
    return data


while True:
    if not arduino.isOpen():
        arduino.open()
    
    tabloOlustur()
    tabloSil()
    
    hamDegerler = ard_oku()
    okunanliste = jsonDonustur(hamDegerler) #okunandegerler => {"kon" : 0,,,,,,,}
    
    veriyaz(okunanliste)
    
    dosya = open("deneme.txt","w",encoding="utf-8")
    dosya.write(okunanliste)
    
    dosya = open("A2A.txt","r",encoding="utf-8")
    veri = dosya.read()
    ard_yaz(veri)
    
    time.sleep(0.01)