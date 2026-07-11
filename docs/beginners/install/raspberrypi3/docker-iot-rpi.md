# Docker On IOT  
![](https://github.com/sangam14/Docker-IOT-rpi/blob/master/DockerIOTrpi.gif)




# Why the IoT Needs Docker
That’s somewhat surprising. Containers are well-positioned to address some of the main challenges that developers face when deploying software to IoT devices:

# Minimal hardware resources. 
Many IoT devices lack powerful computing and memory resources. Their ability to process software updates is therefore limited. Containers can help on this front because installing a new container image does not require much computing power. An IoT device needs simply to download an image, put it wherever it’s going to live and remove the old image. Configuration processing is minimal.

# Geographic distribution. 
In some use cases, IoT devices are spread across a large geographic area. Delivering software to them from a single central repository may not work well. With Docker, it’s easy to spin up image registries in multiple locations to serve the entire network well.

# Limited or sporadic network access. 
Despite the implications of the term “internet of things,” not all devices on the internet of things are well-connected to the internet. They may have limited network bandwidth, or be online only occasionally. Docker can help to deliver software updates under these circumstances because when container images are updated, Docker downloads only the parts of the image that have changed. (Resin.io is taking this efficiency a step further through delta updates, which enable an even more selective download process when updating a container image.)

# Widely varying device environments.
The software that runs on an IoT device could be almost anything. The diversity of software configurations on IoT devices would normally make application installation difficult, because applications would have to be configured for each type of environment if installed via traditional methods. With containers, however, the operating system version and other software variables are much less important. As long as the device runs some kind of Linux distribution and has a container runtime, you can install a containerized application on it without special configuration.

# prepare the circuit:


![](https://github.com/sangam14/Docker-IOT-rpi/blob/master/aws_shadow_led-2.png)




# Install Docker on Raspberry pi 


```sudo apt-get update && sudo apt-get upgrade ```

```curl -sSL https://get.docker.com | sh```

```sudo usermod -aG docker your-username ```


# make Directory 
 mkdir Docker-ledblink


# jump into Directory 
 cd Docker-ledblink



nano / vi led_blinker.py 

```
import RPi.GPIO as GPIO
import time

# Configure the PIN # 8
GPIO.setmode(GPIO.BOARD)
GPIO.setup(8, GPIO.OUT)
GPIO.setwarnings(False)

# Blink Interval 
blink_interval = .5 #Time interval in Seconds

# Blinker Loop
while True:
GPIO.output(8, True)
time.sleep(blink_interval)
GPIO.output(8, False)
time.sleep(blink_interval)

# Release Resources
GPIO.cleanup()
```

nano / vi Dockerfile 
```
# Python Base Image from https://hub.docker.com/r/arm32v7/python/
FROM arm32v7/python:2.7.13-jessie

# Copy the Python Script to blink LED
COPY led_blinker.py ./

# Intall the rpi.gpio python module
RUN pip install --no-cache-dir rpi.gpio

# Trigger Python script
CMD ["python", "./led_blinker.py"]

```


# build dockerfile 
```
pi@raspberrypi:~/docker-ledblink $ ls
Dockerfile  led_blinker.py
pi@raspberrypi:~/docker-ledblink $ docker build -t "docker_blinker:v1" .Sending build context to Docker daemon  3.072kB
Step 1/4 : FROM arm32v7/python:2.7.13-jessie
 ---> fd232f7d5f5f
Step 2/4 : COPY led_blinker.py ./
 ---> Using cache
 ---> 2c20ac080696
Step 3/4 : RUN pip install --no-cache-dir rpi.gpio
 ---> Using cache
 ---> 1d7557012625
Step 4/4 : CMD ["python", "./led_blinker.py"]
 ---> Using cache
 ---> 856014f90903
Successfully built 856014f90903
Successfully tagged docker_blinker:v1


````

# Run container 
```
pi@raspberrypi:~/docker-ledblink $ docker container run --device /dev/gpiomem -d docker_blinker:v1
fbea78493630d0c5e623e3b25427931bd4e8e16d8f181c805f021f558822e355

```

OR 

```docker container run --privileged -d docker_blinker:v1```

# stop container 

```
 docker stop $(docker ps -a -q)
```
 
 
 slides:
 https://www.slideshare.net/sangambiradar370/docker-on-iot-dockercon19-sfo-recap-announcements-bangalore
 
 # Contributor: 
 [sangam biradar](https://twitter.com/BiradarSangam)
 
 https://engineitops.icu


