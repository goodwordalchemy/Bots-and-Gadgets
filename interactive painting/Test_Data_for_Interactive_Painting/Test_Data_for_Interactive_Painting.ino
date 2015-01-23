void setup() {
  Serial.begin(9600);
  
  // Seed the random number generator
  randomSeed(analogRead(0));
  
  // Send 10 Fs
  Serial.print("FFFFFFFFFF");
  
  // Send 10 Bs
  Serial.print("BBBBBBBBBB");
}

void loop() {
  // Randomly send an F, a B, or nothing.
  if (random(0, 10) > 7) {
    Serial.print("F");
  } else {
    if (random(0,10) > 7) {
      Serial.print("B");
    }
  }
  delay(2000);
}
