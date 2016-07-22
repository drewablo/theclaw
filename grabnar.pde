
import processing.serial.*;       

int pos=90; // set servo's value to center

Serial port; // 

void setup()
{
  size(360, 100);
  frameRate(100);
  println(Serial.list()); // List COM ports
  port = new Serial(this, "COM6", 19200);
}

void draw()
{
    fill(150);
  if ((mousePressed == true) && (mouseX <=360) && (mouseX >= 0))
  {
    rect(0,0,360,100);
    fill(255,0,0);
    rect(0, 0, mouseX, 100);
    textSize(32);
    fill(255);
    text(mouseX/2, 160, 50);
    update(mouseX);
  }


}


void update(int x)
{
    //Calculate servo postion from mouse
    pos= abs(x/2);
    pos = constrain(pos, 0, 180);

    //Output the servo position ( from 0 to 180)
    port.write(pos);
    println(pos);
}
