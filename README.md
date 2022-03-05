# JoyKbTester
Joystick and Keyboard controller tester for Atari 2600
Test Cart for joysticks and keypads to help with the development of one of my projects.  

On the splash screen press SELECT to start the test.

![title screen](/doc/splash.png "Title Screen")

It will read the state of DIFFICULTY switches being A for joystick and B for keyboard and enter one of the following modes.

## Left: Joystick, Right: Joystick ## 
![Left Joystick Right Joystick](/doc/joyjoy.png)
 
## Left: Joystick, Right: Keyboard ##
![Left Joystick Right Keyboard](/doc/joykey.png)

## Left: Keyboard, Right: Joystick ##
![Left Keyboard Right Joystick](/doc/keyjoy.png)

## Left: Keyboard, Right: Keyboard ##
![Left Keyboard Right Keyboard](/doc/keykey.png)

### Note on Joysticks ###
The program can test joysticks with 
[Omega Race Booster Grip](https://atariage.com/controller_page.php?SystemID=2600&ControllerID=12 "Booster Grip at Atariage")
The button state is show using 2 methods:

- The score counter shows the logic state of the TIA inputs (1/0) in the following order: 

![Button State in Score](/doc/SCORE.png)

- The second method is graphical and consider the fire button active low while the thumb and trigger buttons are active high.

![Graphical Representation](/doc/buttons.png)

 
