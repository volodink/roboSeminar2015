#include <SPI.h>
#include "RF24.h"

RF24 radio(7,8);

const uint64_t pipe = 0xE8E8F0F0E1LL;

int msg[1];

String theMessage = "";

void setup(void)
{
  Serial.begin(9600);

  radio.begin();
  radio.setPALevel(RF24_PA_LOW);
  radio.openReadingPipe(1,pipe);
  radio.startListening();
  
  //Serial.println("Radio receiver ready.");
}
void loop(void)
{
  if (radio.available())
  {
    radio.read(msg, 1); 
    char theChar = msg[0];
    if (msg[0] != 2)
    {
       theMessage.concat(theChar);
    }
    else
    {
       Serial.println(theMessage);
       theMessage= ""; 
    }
  }
}


