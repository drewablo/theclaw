#include <Servo.h> 
 
class Sweeper
{
  Servo servo;              // the servo
  int pos;              // current servo position 
  int increment;        // increment to move for each interval
  int updateStartInterval;      // interval between updates
  int updateQuickInterval;
  unsigned long lastUpdate; // last update of position
 
public: 
  Sweeper(int startInterval, int quickInterval)
  {
    updateStartInterval = startInterval;
	updateQuickInterval = quickInterval;
    increment = 1;
  }
  
  void Attach(int pin)
  {
    servo.attach(pin);
  }
  
  void Detach()
  {
    servo.detach();
  }
  
  void Update()
  {
    if((pos <= 30) || (pos>=150)) {
	  if((millis() - lastUpdate) > updateStartInterval)  // time to update
      {
        lastUpdate = millis();
        pos += increment;
        servo.write(pos);
        Serial.println(pos);
        if ((pos >= 180) || (pos <= 0)) // end of sweep
        {
           // reverse direction
          increment = -increment;
        }
        Serial.println(increment);
      }
	}
	else if((pos > 30) || (pos <150))
	{
      if((millis() - lastUpdate) > updateQuickInterval)  // time to update
      {
        lastUpdate = millis();
        pos += increment;
        servo.write(pos);
        Serial.println(pos);
        if ((pos >= 180) || (pos <= 0)) // end of sweep
        {
           // reverse direction
          increment = -increment;
        }
        Serial.println(increment);
      }
	}
	
  }
};

 
Sweeper sweeper1(50,5);

 
void setup() 
{ 
  Serial.begin(9600);
  sweeper1.Attach(9);

} 
 
 
void loop()
{ 
  sweeper1.Update();

}
