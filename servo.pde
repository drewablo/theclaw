#include <Servo.h>
#include <CapacitiveSensor.h>

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

  void Start()
  {
    servo.write(180);
	  delay(5000);
  }


  void Update()
  {
    if((pos <= 30) || (pos >= 150)) {
	  if((millis() - lastUpdate) > updateStartInterval)  // time to update
      {
        if ((pos >= 180) || (pos <= 0)) // end of sweep
        {
           // reverse direction
          increment = -increment;
        }
        lastUpdate = millis();
        pos += increment;
        servo.write(pos);
        Serial.println(pos);
        Serial.println(increment);
      }
	  }
	  else if((pos > 30) || (pos < 150))
	  {
      if((millis() - lastUpdate) > updateQuickInterval)  // time to update
      {
        if ((pos >= 180) || (pos <= 0)) // end of sweep
        {
           // reverse direction
          increment = -increment;
        }
        lastUpdate = millis();
        pos += increment;
        servo.write(pos);
        Serial.println(pos);
        Serial.println(increment);
      }
	  }
  }

  void Capture()
  {
    if((millis() - lastUpdate) > updateQuickInterval)  // time to update
    {
      if ((pos >= 180) || (pos <= 0)) // end of sweep
      {
         // reverse direction
        increment = -increment;
      }
      lastUpdate = millis();
      pos += increment;
      servo.write(pos);
      Serial.println(pos);

      Serial.println(increment);
  }
  }
};

class Sensor
{
  CapacitiveSensor cs_4_2 = CapacitiveSensor(4,2);
  int updateStartInterval;
  unsigned long lastUpdate;

public:
  Sensor(int startInterval)
  {
    updateStartInterval = startInterval;
  }
  void calibOff()
  {
    cs_4_2.set_CS_AutocaL_Millis(0xFFFFFFFF);
  }
  bool readSensor()
  {
      if(mills() - updateStartInterval > lastUpdate)
      {
        lastUpdate = millis();
        long total1 =  cs_4_2.capacitiveSensor(30); // number of samples

        Serial.print(millis() - start);        // check on performance in milliseconds
        Serial.print("\t");                    // tab character for debug windown spacing

        Serial.print(total1);                  // print sensor output 1

        if (total1 >= 400)
        {
          return true;
        }
        else
        {
          return false;
        }
      //  delay(10);                             // arbitrary delay to limit data to serial port
      }
    }
  }
};


Sweeper sweeper1(50,5);

Sensor sensor1(10);

void setup()
{
  Serial.begin(9600);
  sensor1.calibOff();
  sweeper1.Attach(9);
  sweeper1.Start();
}


void loop()
{
  if (sensor1.readSesnor() == true)
  {
    sweeper1.capture();
  }
  //sweeper1.Update();
}
