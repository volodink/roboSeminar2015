#include <SPI.h>
#include "RF24.h"

// Setup radio
RF24 radio(7,8);

String theMessage = "";
int msg[1];

const uint64_t pipe = 0xE8E8F0F0E1LL;

void setup(void)
{
  Serial.begin(9600);
  
  radio.begin();
  radio.setPALevel(RF24_PA_LOW);
  radio.openWritingPipe(pipe);
}

// get message, e.g. S90R100 and send it via nrf24l01
void loop(void)
{
  if ( Serial.available() )
  {
    while (Serial.available() > 0)
    {
      theMessage += Serial.readStringUntil('\n');
    }
    
    int messageSize = theMessage.length();
    
    for (int i = 0; i < messageSize; i++)
    {
      int charToSend[1];
      charToSend[0] = theMessage.charAt(i);
      radio.write(charToSend,1);
    }  
    
    msg[0] = 2; 
    radio.write(msg, 1);
    radio.powerDown(); 
    
    delay(10);
    radio.powerUp();
    
    theMessage = "";
  }
}

