# Docker on IOT(Arduino Uno) using Johnny-Five 

![](https://github.com/sangam14/docker-IOT/blob/master/Webp.net-resizeimage.jpg)

Johnny-Five is the JavaScript Robotics & IoT Platform. Released by Bocoup in 2012, Johnny-Five is maintained by a community of passionate software developers and hardware engineers. Over 75 developers have made contributions towards building a robust, extensible and composable ecosystem.

Johnny-Five has been tested with a variety of Arduino-compatible Boards. For non-Arduino based projects, platform-specific IO Plugins are available. IO Plugins allow Johnny-Five code to communicate with any hardware in whatever language that platform speaks!

# Prerequisites

At least an Arduino or compatible board (Uno, Mega, Leonardo, Fio, Pro, Pro Mini)


- Arduino UNO
- Arduino Leonardo
- Arduino MEGA
- Arduino FIO
- Arduino Pro
- Arduino Pro Mini
- TinyDuino
- Sparkfun Inventor's Kit (Recommended for getting started)

## OSX

```
Install Node.js >= 0.10.x
Install Xcode
Install node-gyp npm install -g node-gyp
```

## Windows

Via @ThomasDeutsch on https://github.com/rwldrn/johnny-five/issues/48#issuecomment-7696662

```
Install Node.js >= 0.10.x 32 bit (unless anyone can confirm success with 64 bit)
npm --add-python-to-path install --global --production windows-build-tools
Install node-gyp npm install -g node-gyp
```

## Ubuntu and Debian

```
Install Node.js >= 0.10.x apt-get install nodejs
Install the nodejs-legacy package apt-get install nodejs-legacy
Install build-essential or a suitable alternative apt-get install build-essential
```

## Arch Linux

```
Install Node.js pacman -S nodejs
Install Arduino Libraries (for firmware flashing) pacman -S arduino
```

# Hello World

Generally Arduino boards (Uno, Mega, Leonardo, Fio, Mini) come pre-flashed with the compiled StandardFirmata firmware. In most cases, getting started is as simple as...

```
mkdir nodebot && cd nodebot;
npm install johnny-five;
```

Now open your text editor and create a new file called "strobe.js", in that file type or paste the following:

```
var five = require("johnny-five"),
    board = new five.Board();

board.on("ready", function() {
  // Create an Led on pin 13
  var led = new five.Led(13);

  // Strobe the pin on/off, defaults to 100ms phases
  led.strobe();
});
```

Make sure the board is plugged into your host machine (desktop, laptop, raspberry pi, etc). Now, in your terminal, type or paste the following:

```
node strobe.js
Troubleshooting
```

# Firmware

The StandardFirmataPlus firmware is the one that is used for Johnny-Five to communicate with the board. That means you have to install it first, then you can execute the nodejs programs. Arduiono IDE

```
Open Arduino IDE
Verify correct port and board
Navigate to File > Examples > Firmata > StandardFirmataPlus
Load sketch onto board.
Packaged
```

Install arduino package on your operating system ).
Make a firmware folder and save this firmware.ino into it. if the link is dead again and not appearing in the Arduino IDE, use this gist backup.
Install arduino libraries via arduino --install-library "Firmata,Servo" in the Terminal.
Flash the arduino board via arduino --board "arduino:avr:uno" --upload ./path/to/firmware/firmware.ino. Remember to change your board according to what you use. See below on how to figure out that identifier.
If the upload was successful, the board is now prepared for johnny-five usage.
Finding out your Board identifier for arduino-tools

Go to the package index file of the Arduino tools.
Download the url entry of the package that contains your boards, for example http://downloads.arduino.cc/cores/avr-1.6.18.tar.bz2.
Inside the archive, there's a boards.txt file that contains all supported boards. These boards can be used as the last part of the identifier. For example, the boards.txt lists yun meaning the arduino --board "arduino:avr:yun" has to be used.
List of Arduino Board identifiers (May 2017)

This is a compiled list that may not be up-to-date. Use the method described above in case you can't find your board here.

```
"arduino:avr:yun" for Arduino Yun
"arduino:avr:uno" for Arduino/Genuino Uno
"arduino:avr:diecimila" for Arduino Duemilanove or Diecimila
"arduino:avr:nano" for Arduino Nano
"arduino:avr:mega" for Arduino/Genuio Mega or Mega 2560
"arduino:avr:megaADK" for Arduino Mega ADK
"arduino:avr:leonardo" for Arduino Leonardo
"arduino:avr:leonardoeth" for Arduino Leonardo ETH
"arduino:avr:micro" for Arduino/Genuino Micro
"arduino:avr:esplora" for Arduino Esplora
"arduino:avr:mini" for Arduino Mini
"arduino:avr:ethernet" for Arduino Ethernet
"arduino:avr:fio" for Arduino Fio
"arduino:avr:bt" for Arduino BT
"arduino:avr:LilyPadUSB" for LilyPad Arduino USB
"arduino:avr:lilypad" for LilyPad Arduino
"arduino:avr:pro" for Arduino Pro
"arduino:avr:atmegang" for Arduino NG or older
"arduino:avr:robotControl" for Arduino Robot Control
"arduino:avr:robotMotor" for Arduino Robot Motor
"arduino:avr:gemma" for Arduino Gemma
"arduino:avr:circuitplay32u4cat" for Arduino Circuit Playground
"arduino:avr:yunmini" for Arduino Yun Mini
"arduino:avr:chiwawa" for Arduino Industrial 101
"arduino:avr:one" for Linino One
"arduino:avr:unowifi" for Arduino Uno WiFi
Other
```
Sometimes Windows systems will fail to compile native dependencies, if you run across this case try:

```npm install johnny-five --msvs_version=2012```



# Step 1:
```Install Docker Machine
Install VirtualBox
```

# Step 2:
Create your local docker-machine VM
```
$ docker-machine create local -d virtualbox
```
# Step 3:
Stop your Docker VM
```$ docker-machine stop local ```
Now, open VirtualBox

![](https://github.com/sangam14/docker-IOT/blob/master/vm1.png)

Go to settings and mount your Arduino

![](https://github.com/sangam14/docker-IOT/blob/master/vm2.png)

# Step 4:
At this point, you should be able to use your Arduino with Johnny-Five and Docker
```$ docker run -ti --privileged node /bin/bash
# mkdir test && cd test
# npm install johnny-five
# apt-get update && apt-get install -y vim
# vim test.js
```
And now for the code, the standard Johnny-Five hello world
```
var five = require(“johnny-five”);
var board = new five.Board();
board.on(“ready”, function() { 
  var led = new five.Led(13); 
  led.blink(500); 
});
```
Run the code
```
# node test.js
```
If everything worked, you should see a blinking light!

![](https://github.com/sangam14/docker-IOT/blob/master/ezgif.com-gif-maker.gif)


reference:http://johnny-five.io


## Contributor - 

Sangam Biradar - smbiradar14@gmail.com - https://engineitops.icu


