#include <Servo.h> 

// Setting up pins
int echoPin = 9; 
int trigPin = 10;
int servoPin = 8;

// Create servo object;
Servo myservo;

// Starting servo position in degrees
int initialServoPosition = 90;
int angle = 5;
int turnDelay = 50;

void doServoSweep();

void setup()
{ 
  Serial.begin (9600);
  
  myservo.attach(servoPin);
  
  pinMode(trigPin, OUTPUT); 
  pinMode(echoPin, INPUT);
 
  myservo.write(initialServoPosition);
  delay(2000); 
} 

int getRange()
{
  int duration, range; 
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2); 
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10); 
  digitalWrite(trigPin, LOW); 
  
  duration = pulseIn(echoPin, HIGH); 
  
  range = (duration / 58) * 10; // main black magic :)
   
  return range;
}

void loop()
{
  // do one full sweep
  doServoSweep();
    
  // wait next cycle
  delay(2000);
}

void doServoSweep()
{
  int range;

  // to the left
  for (int servoPosition = initialServoPosition; servoPosition < 180; servoPosition += angle)
  {
    myservo.write(servoPosition);
    
    range = getRange();
    
    Serial.print("S");
    Serial.println(servoPosition);
    Serial.print("R");
    Serial.println(range);
    
    delay(turnDelay);
  }
  
  // and back ...
  for (int servoPosition = 180; servoPosition >= initialServoPosition; servoPosition -= angle)
  {
    myservo.write(servoPosition);
 
    range = getRange();
 
    Serial.print("S");
    Serial.println(servoPosition);
    Serial.print("R");
    Serial.println(range);   
   
    delay(turnDelay);
  }
  
  // to the right ...
  for (int servoPosition = initialServoPosition; servoPosition >= 0; servoPosition -= angle)
  {
    myservo.write(servoPosition);
 
    range = getRange();
 
    Serial.print("S");
    Serial.println(servoPosition);
    Serial.print("R");
    Serial.println(range);   
   
    delay(turnDelay);
  }

  // and back to center ...
  for (int servoPosition = 0; servoPosition <= initialServoPosition; servoPosition += angle)
  {
    myservo.write(servoPosition);
 
    range = getRange();
 
    Serial.print("S");
    Serial.println(servoPosition);
    Serial.print("R");
    Serial.println(range);   
   
    delay(turnDelay);
  }
  
  
}



