import serial
import time

arduino = serial.Serial(port='COM3', baudrate=115200, timeout=.1)

def write_read(x):
    arduino.write(bytes(x, 'utf-8'))
    time.sleep(0.05)
    data = arduino.readline()
    return data

while True:
    if not arduino.isOpen():
        arduino.open()
    
    gönderilicekdosya = open("A2A.txt","r",encoding="utf-8")
    gidenveri = gönderilicekdosya.read()
    y = gidenveri
    
    gelenveri = write_read(y)
    print(gelenveri)
    
    gelicekdosya = open("A2A.txt","w",encoding="utf-8")
    gelicekdosya.write(gelenveri)