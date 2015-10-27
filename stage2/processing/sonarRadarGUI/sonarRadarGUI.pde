import processing.serial.*;

Serial port;

//int[] angleData;
//int[] sonarData;

int angleData;
int sonarData;

void setup()
{
  //  fullScreen();
  size(800, 600);  
  frameRate(30);
  smooth();

  println("Available serial ports:");
  println(Serial.list());
  
  port = new Serial(this, Serial.list()[0], 9600);
  
  port.bufferUntil('\n');
  
 // angleData = new int[36];
 // sonarData = new int[36];
  
 // for (int i = 0; i < 36; i++)
 //  angleData[i] = 90;
   
//  for (int i = 0; i < 36; i++)
//   sonarData[i] = 0;
  
  // set inital background:
 background(0);
}

int beginCount = 0;
void draw()
{
  //println(beginCount);
  if (angleData == 0) beginCount++;

  if (beginCount == 5)
  {
    background(1);
    beginCount = 0;
  }

  drawLine(angleData, scaleData(sonarData));
}

void serialEvent(Serial myPort) 
{
  String inString = myPort.readStringUntil('\n');
  //println(inString);
  if (inString != null) {
    inString = trim(inString);
    //println(inString);
    String[] q = splitTokens(inString, "SR");
    angleData = int(q[0]);
    sonarData = int(q[1]);
    //print(angleData); print(" "); println(sonarData);
  }
}

int scaleData(int x)
{
  int maxRadius = 400; // in pixels
  int maxDistance = 500; // in mm

  return (int)((x*maxRadius)/maxDistance); // in pixels
}

void drawLine(int angle, int radius)
{
  float angleIdentity = TWO_PI/(float)360;

  int x = (int)(radius * cos(angle*angleIdentity));
  int y = (int)(radius * sin(angle*angleIdentity));

  stroke(255, 0, 255);           
  line(width/2, height, (width/2)-x, (height)-y);
}
