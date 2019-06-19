# How to monitor a Docker Swarm with Blinkt! LED

## Pre-requisite:

- A Raspberry Pi
- Blinkt

Blinkt! is an eight super-bright RGB LED indicators that are ideal for adding visual notifications to your Raspberry Pi without breaking the bank!
Inspired by Alex Ellis' work with his Raspberry Pi Zero Docker Cluster, we developed these boards for him to use as status indicators. Blinkt! offers eight APA102 pixels in the smallest (and cheapest) form factor to plug straight onto your Raspberry Pi.

Each pixel on Blinkt! is individually controllable and dimmable allowing you to create gradients, pulsing effects, or just flash them on and off like crazy. The data and clock lines are connected to GPIO #23 and #24 respectively but for simplicity you can just use our Python library to drive them.

## Features

- Eight APA102 RGB LEDs
- Individually controllable pixels
- Sits directly on top of your Pi in a tiny footprint
- Fits inside most Pi cases
- Doesn't interfere with PWM audio
- Blinkt! pinout
- Compatible with Raspberry Pi 3B+, 3, 2, B+, A+, Zero, and Zero W
- Python library
- Comes fully assembled


## Installing Docker on all 3 Nodes - 1 Manager and 2 worker nodes

```
root@raspberrypi:/home/pi# docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:57:21 2018
 OS/Arch:           linux/arm
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:17:57 2018
  OS/Arch:          linux/arm
  Experimental:     false
root@raspberrypi:/home/pi# 
```

## Setting up Swarm Manager Node

```
root@raspberrypi:/home/pi# docker swarm init --advertise-addr 192.168.43.134 --listen-addr 192.168.43.134:2377
Swarm initialized: current node (j7i394an31gsevxt3fndzvum5) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-1zbsutds2u5gk5qwx0qbf95uccogrjx1ukszxxxxx-bcptng4inxxxldvvx17tn2l 192.168.43.134:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

root@raspberrypi:/home/pi# 

```


## 

```
pi@raspberrypi:~ $ sudo docker swarm join --token SWMTKN-1-1zbsutds2u5gk5qwx0qbf95uccogrjx1ukszysmxxxbcptng4invy1abldvvx17tn2l 192.168.43.134:2377
This node joined a swarm as a worker.
pi@raspberrypi:~ $ 
```



## Listing the Nodes

```
root@raspberrypi:/home/pi# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
ijnqkk7vybzts7ohgt63fteoo     raspberrypi         Ready               Active                                  18.09.0
j7i394an31gsevxt3fndzvum5 *   raspberrypi         Ready               Active              Leader              18.09.0
let43cp6uoankngeg5lmd91mn     raspberrypi         Ready               Active                                  18.09.0
root@raspberrypi:/home/pi# 
```

## Running Monitor Service 

```
root@raspberrypi:/home/pi# docker service create --name monitor --mode global --restart-condition any --mount type=bind,src=/sys,dst=/sys --mount type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock stefanscherer/monitor:1.1.0
kvgvohexsc2e8yapol0ulwq5q
overall progress: 3 out of 3 tasks 
ijnqkk7vybzt: running   [==================================================>] 
let43cp6uoan: running   [==================================================>] 
j7i394an31gs: running   [==================================================>] 
verify: Service converged 
root@raspberrypi:/home/pi# 
```


## 

```
root@raspberrypi:/home/pi# docker service create --name whoami stefanscherer/whoami:1.1.0
jd5e5hlswu8ruxgfhgbwtww84
overall progress: 1 out of 1 tasks 
1/1: running   [==================================================>] 
verify: Service converged 
```

## Scaling the Service to 4

```
root@raspberrypi:/home/pi# docker service scale whoami=4
whoami scaled to 4
overall progress: 4 out of 4 tasks 
1/4: running   [==================================================>] 
2/4: running   [==================================================>] 
3/4: running   [==================================================>] 
4/4: running   [==================================================>] 
verify: Service converged 
```

## Scaling the service to 16

```
root@raspberrypi:/home/pi# docker service scale whoami=16
whoami scaled to 16
overall progress: 16 out of 16 tasks 
1/16: running   [==================================================>] 
2/16: running   [==================================================>] 
3/16: running   [==================================================>] 
4/16: running   [==================================================>] 
5/16: running   [==================================================>] 
6/16: running   [==================================================>] 
7/16: running   [==================================================>] 
8/16: running   [==================================================>] 
9/16: running   [==================================================>] 
10/16: running   [==================================================>] 
11/16: running   [==================================================>] 
12/16: running   [==================================================>] 
13/16: running   [==================================================>] 
14/16: running   [==================================================>] 
15/16: running   [==================================================>] 
16/16: running   [==================================================>] 
verify: Service converged 
```

## Scaling the Service to 32

```
root@raspberrypi:/home/pi# docker service scale whoami=32
whoami scaled to 32
overall progress: 32 out of 32 tasks 
verify: Service converged 
```

## Scaling the Service back to 4

```
root@raspberrypi:/home/pi# docker service scale whoami=4
whoami scaled to 4
overall progress: 4 out of 4 tasks 
1/4: running   [==================================================>] 
2/4: running   [==================================================>] 
3/4: running   [==================================================>] 
4/4: running   [==================================================>] 
verify: Service converged 
```



## Listing out the service

```
root@raspberrypi:/home/pi# docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                         PORTS
h7ap83sidbw8        monitor             global              2/2                 stefanscherer/monitor:1.1.0   
root@raspberrypi:/home/pi# 

```


## Listing the Nodes


```
root@raspberrypi:/home/pi# docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
ijnqkk7vybzts7ohgt63fteoo     raspberrypi         Ready               Active                                  18.09.0
j7i394an31gsevxt3fndzvum5 *   raspberrypi         Ready               Active              Leader              18.09.0
let43cp6uoankngeg5lmd91mn     raspberrypi         Down                Active                                  18.09.0
root@raspberrypi:/home/pi# 
```

## Rolling Updates

```
root@raspberrypi:/home/pi# docker service update --image stefanscherer/whoami:1.2.0 \
>   --update-parallelism 4  --update-delay 2s whoami
whoami
overall progress: 2 out of 4 tasks 
1/4: preparing [=================================>                 ] 
2/4: running   [==================================================>] 
3/4: preparing [=================================>                 ] 
4/4: running   [==================================================>] 
root@raspberrypi:/home/pi# 
```
