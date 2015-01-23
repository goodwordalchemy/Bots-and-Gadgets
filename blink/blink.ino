/* 
  Blink
  Turns on an LED for one second, then off for one second, repeatedly.
*/
int LedPin = 2;

void setup () {
  // initialize the digital pin as an output
  
  pinMode (LedPin, OUTPUT);
}

void loop () {
  digitalWrite(LedPin, HIGH);
  delay(1000);
  digitalWrite(LedPin, LOW);
  delay(1000);
}

