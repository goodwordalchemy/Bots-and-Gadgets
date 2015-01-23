// this is a branch of the Interactive painting processing sketch, modifying to load previous image

import processing.serial.*;

int slideStep = 75;  // how many pixels to slide in/out

// The current image and the next image to display
PImage currentImage, nextImage, previousImage;

// The index of the current image
int imgIndex = 0;

// Keeps track of the horizontal slide position.  A negative number
// indicates sliding in from the left
int slideOffset;

// All the image files found in this sketch's data directory
String[] fileList;

// A serial port that we use to talk to Arduino.
Serial myPort;

// This class is used to filter the list of files in the data directory
// so that the list includes only image
class FilterImages implements java.io.FilenameFilter {
  public boolean accept(File dir, String fname) {
    String[] extensions = {".png", ".jpeg", ".gif", ".tga", ".jpg"};
    
    // Don't accept a file unless it has one of the specified extensions
    for (int i = 0; i < extensions.length; i++) {
      if (fname.toLowerCase().endsWith( extensions[i]) ) {
        return true;
      }
    }
    return false;
  }
}

// This loads the filenames into the fileList
void loadFileNames() {
  java.io.File dir = new java.io.File(dataPath(""));
  fileList = dir.list(new FilterImages());
}

// The Processing setup method that's run once
void setup() {
  size(displayWidth, displayHeight); // Go fullscreen
  
  loadFileNames();  // Load the filenames
  
  /*
  This cetners images on the screen.  to work correctly with
  this mode, we'll be using image coordinates from the center 
  of the screen (1/2 of the screen height and width).
  */
  imageMode(CENTER);
  
  // Load the current image and resize it.
  currentImage = loadImage(fileList[0]);
  currentImage.resize(0, height);
  
  // List all the available serial ports:
  println(Serial.list());
  
  myPort = new Serial(this, Serial.list()[5], 9600);
}

// Go to the next image
void advanceSlide() {
  imgIndex++; // go to the next image
  if (imgIndex >= fileList.length) { // make sure we're within bounds
    imgIndex = 0;
  }
  slideOffset = width; // Start sliding in from the right
}

void reverseSlide() {
  imgIndex--; // go to previous image
  if (imgIndex < 0) { // make sure we're within bounds
    imgIndex = fileList.length - 1;
  }
  slideOffset = width * - 1; // Start sliding in from the left
}

void draw() {
  // Put up a black background and display the current image.
  background(0);
  image(currentImage, width/2, height/2);
  
  // Is the image supposed to be sliding?
  if (slideOffset != 0) {
    
    if (slideOffset > 0) { // Slide from the right (next)
      // Load the next image at the specified offset.
      image(nextImage, slideOffset + width/2, height/2);
      slideOffset -= slideStep;
      if (slideOffset < 0) {
        slideOffset = 0;
      }
    }
    if (slideOffset < 0) { // Slide from the right (next)
      // Load the next image at the specified offset.
      image(previousImage, slideOffset + width/2, height/2);
      slideOffset += slideStep;
      if (slideOffset > 0) {
        slideOffset = 0;
      }
    }
    if (slideOffset == 0) {
      currentImage = nextImage;
    }
  } 
  else {
    
    // If we're not sliding, read the serial port.
    if (myPort.available() > 0) {
      char inByte = myPort.readChar();
      print(inByte); //Displays the character that was read
      
      if (inByte == 'F') { 
        advanceSlide();
      }
      if (inByte == 'B') { 
        reverseSlide();
      }
      
      // Load and resize next image
      nextImage = loadImage(fileList[imgIndex]);
      nextImage.resize(0, height);
      
      // Load and resize previous image
      previousImage = loadImage(fileList[imgIndex]);
      previousImage.resize(0, height);
      
    }
  }
}


