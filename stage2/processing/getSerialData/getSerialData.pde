import processing.serial.*;

Serial myPort;  // Create object from Serial class

String str;

void setup()
{
  size(800, 600);

  String portName = Serial.list()[4];
  print (Serial.list());
  myPort = new Serial(this, portName, 115200);
}

void draw()
{
  if ( myPort.available() > 0) {
    str = myPort.readString();
    println (str);    
  }
}