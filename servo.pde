#include <Servo.h> 
 
class Sweeper
{
  Servo servo;              // the servo
  int pos = 1500;              // current servo position 
  int increment;        // increment to move for each interval
  int longUpdateInterval;      // interval between updates
  unsigned long lastUpdate; // last update of position
  
 
public: 
  Sweeper(int longInterval, int inc)
  {
    longUpdateInterval = longInterval;
    increment = inc;
  }
  
  void Attach(int pin)
  {
    servo.attach(pin);
  }
  
  void Detach()
  {
    servo.detach();
  }
  
  void Update(int pin)
  {
    Attach(pin);
    if((millis() - lastUpdate) > longUpdateInterval)  // time to update
    {
      lastUpdate = millis();
      pos += increment;
      servo.writeMicroseconds(pos);
      Serial.println(pos);    
      if (pos >= 2000 || pos <= 1000)
      {
        increment = -increment;
      }
    }
  }
};

Sweeper sweeper1(20, 10);

 
void setup() 
{ 
  Serial.begin(9600);
//  sweeper1.Attach(9);

} 
 
 
void loop() 
{ 
  sweeper1.Update(9);

}
