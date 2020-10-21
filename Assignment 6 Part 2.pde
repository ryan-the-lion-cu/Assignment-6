// Graphing sketch

// This program takes ASCII-encoded strings from the serial port at 9600 baud
// and graphs them. It expects values in the range 0 to 1023, followed by a
// newline, or newline and carriage return

// created 20 Apr 2005
// updated 24 Nov 2015
// by Tom Igoe
// This example code is in the public domain.

import processing.serial.*;

Serial myPort; // The serial port
float inByte = 0;
int xPos = 200;// horizontal position of the graph
int yPos = 150;

void setup () {
  // set the window size:
  size(400, 300);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[2], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(0);
}

void draw () {
  background(0);
  circle(xPos, yPos, 50);
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    String[] splitData = inString.split(",");
    // convert to an int and map to the screen height:

    float xVal = float(splitData[0]);
    float yVal = float(splitData[1]);

    println("X value: " + xVal);
    println("Y value: " + yVal);

    //These if statements control the movement of the object
    //based off the xVal and yVal taken from the joystick
    if (xVal > 510)
    {
      xPos = xPos + 3;
    }
    if (xVal < 490)
    {
      xPos = xPos - 3;
    }
    if (yVal > 510)
    {
      yPos = yPos + 3;
    }
    if (yVal < 490)
    {
      yPos = yPos - 3;
    }
    
    //These if statements prevent the object from moving off the screen
    if (xPos >= 400)
    {
      xPos = 400;
    }
    if (xPos <= 0)
    {
      xPos = 0;
    }
    if (yPos >= 300)
    {
      yPos = 300;
    }
    if (yPos <= 0)
    {
      yPos = 0;
    }
  }
}
