int x;
void setup() {
 pinMode(13, OUTPUT); 
  
 Serial.begin(115200);
 Serial.setTimeout(1);
}
void loop() {
 while (!Serial.available());
 x = Serial.readString().toInt();
 Serial.print(x);

 if(x == 0)digitalWrite(13, HIGH);
 else digitalWrite(13, LOW);
}
