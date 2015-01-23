import processing.serial.*;

// A serial port that we use to talk to Arduino.
Serial myPort;

// the processing setup method that run once
void setup() {
  size(320, 320); // create a window
  
  // List all the available serial ports:
  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[5], 9600);
}

void draw() {
  // Put up a black background.
  background(0);
  
  // Read the serial port.
  if (myPort.available() > 0) {
    char inByte = myPort.readChar();
    print(inByte); //Displays the character that was read
  }
}
