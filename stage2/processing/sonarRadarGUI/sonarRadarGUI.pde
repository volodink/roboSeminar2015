import processing.serial.*;

Serial port;

int angleData = 0;
int sonarData = 0;

void setup()
{
  //  fullScreen();
  size(800, 600);  
  frameRate(30);
  smooth();

  println("Available serial ports:");
  println(Serial.list());
  
  port = new Serial(this, Serial.list()[4], 9600);
  
  port.bufferUntil('\n');
}

void draw() {
  int dataPointCounter = 64;

  // clears all
  background(1);

  //while (port.available() > 0) {
    //serialEvent(port.read()); // read data
  //}

  for (int i = 0; i < dataPointCounter; i++)
    drawLine(getAngleData(), scaleData(getSonarData()));
}

void serialEvent(int serial) 
{
  try {    // try-catch because of transmission errors
  
  } 
  catch(Exception e) {
    println("no valid data");
  }
}

int scaleData(int x)
{
  int maxRadius = 350; // in pixels
  int maxDistance = 4000; // in mm

  return (int)((x*400)/4000); // in pixels
}

int getAngleData() {
  return (int)random(0, 180);
  //return angleData;
}

int getSonarData()
{
  // read serial data
  return (int)random(0, 4000); // in mm
  
}

void drawLine(int angle, int radius)
{
  float angleIdentity = TWO_PI/(float)360;

  int x = (int)(radius * cos(angle*angleIdentity));
  int y = (int)(radius * sin(angle*angleIdentity));

  stroke(255, 0, 255);           
  line(width/2, height, (width/2)-x, (height)-y);
}