//Arduino code:
#include <Servo.h>

Servo servo;  
int pos = 0;


void setup(){
  servo.attach(9);
  Serial.begin(19200); // 19200 is the rate of communication
 
}

void loop() {
  static int val = 0; // value to be sent to the servo
  if ( Serial.available()) 
  {
    val = Serial.read(); // read input from processing
    servo.write(val);
    val = 0;
  }
}

