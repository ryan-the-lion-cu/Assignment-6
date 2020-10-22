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
int R = 0;
int G = 0;
int B = 0;


void setup () {
  // set the window size:
  size(400, 300);

  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()

  println(Serial.list()); //Used to check which serial ports are avaliable

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using.
  myPort = new Serial(this, Serial.list()[0], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');

  // set initial background:
  background(R, G, B);
}

void draw () {
  background(R, G, B);  //Updates the background and circle location
  circle(xPos, yPos, 30);

  //The RGB int values will interval up as the program runs,
  //creating a colorful changing background
  R = R + 1;
  G = G + 3;
  B = B + 5;
  if (R >= 255)
  {
    R = 0;
  }
  if (G >= 255)
  {
    G = 0;
  }
  if (B >= 255)
  {
    B = 0;
  }
}


void serialEvent (Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    String[] splitData = inString.split(",");
    // convert to an int and map to the screen height:

    float xVal = float(splitData[0]); //Assigns x serial val to xVal
    float yVal = float(splitData[1]);  //Assigns y serial val to yVal

    println("X value: " + xVal);  //Prints to console for user to see
    println("Y value: " + yVal);

    //These if statements control the movement of the object
    //based off the xVal and yVal taken from the joystick
    if (xVal > 510)  //If joystick is pushed right, move right
    {
      xPos = xPos + 3;
    }
    if (xVal < 490)  //If joystick is pushed left, move left
    {
      xPos = xPos - 3;
    }
    if (yVal > 510)  //If joystick is pushed up, move up
    {
      yPos = yPos + 3;
    }
    if (yVal < 490)  //If joystick is pushed down, move down
    {
      yPos = yPos - 3;
    }

    //These if statements prevent the object from moving off the screen
    if (xPos >= 400)  //If object reaches right edge, stop moving
    {
      xPos = 400;
    }
    if (xPos <= 0)  //If object reaches left edge, stop moving
    {
      xPos = 0;
    }
    if (yPos >= 300)  //If object reaches bottom edge, stop moving
    {
      yPos = 300;
    }
    if (yPos <= 0)  //If object reaches top edge, stop moving
    {
      yPos = 0;
    }
  }
}
