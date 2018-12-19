# How to Run Multiple Python Versions on a Docker Host

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side


## Search Python Docker Images in DockerHub

```
$ docker search python
NAME                                  DESCRIPTION                                     STARS               OFFICIAL            AUTOMATED
python                                Python is an interpreted, interactive, objec…   3590                [OK]
django                                Django is a free web application framework, …   759                 [OK]
pypy                                  PyPy is a fast, compliant alternative implem…   157                 [OK]
kaggle/python                         Docker image for Python scripts run on Kaggle   105                                     [OK]
frolvlad/alpine-python3               The smallest Docker image with Python 3.5 (~…   90                                      [OK]
centos/python-35-centos7              Platform for building and running Python 3.5…   32
resin/raspberrypi3-python             The Python buildpack image for Python apps f…   30
arm32v7/python                        Python is an interpreted, interactive, objec…   28
amazon/aws-eb-python                  AWS Elastic Beanstalk Python Image              24
joyzoursky/python-chromedriver        Python with Chromedriver, for running automa…   16                                      [OK]
circleci/python                       Python is an interpreted, interactive, objec…   16
centos/python-36-centos7              Platform for building and running Python 3.6…   12
centos/python-27-centos7              Platform for building and running Python 2.7…   11
iron/python                           Tiny Python Microcontainer                      9
resin/raspberrypi3-alpine-python      The Python buildpack image for Python apps. …   7
microsoft/azure-functions-python3.6   Azure functions python image                    5                                       [OK]
dockershelf/python                    Repository for docker images of Python. Test…   4                                       [OK]
resin/beaglebone-black-python         The Python buildpack image for Python apps f…   3
bitnami/python                        Bitnami Python Docker Image                     3                                       [OK]
publicisworldwide/python-conda        Basic Python environments with Conda.           3                                       [OK]
centos/python-34-centos7              Platform for building and running Python 3.4…   2
komand/python-plugin                  DEPRECATED: Komand Python SDK                   2                                       [OK]
resin/qemux86-alpine-python           The Python buildpack image for Python apps. …   1
openshift/python-33-centos7           DEPRECATED: A Centos7 based Python v3.3 imag…   0
qbtrade/python                        python 3.5.0 with requirements                  0
```

## Running Python 3.6-based Docker Container


```
$ docker run -dit python:3.6
```

```
Unable to find image 'python:3.6' locally
3.6: Pulling from library/python
54f7e8ac135a: Pull complete
d6341e30912f: Pull complete
087a57faf949: Pull complete
5d71636fb824: Pull complete
0c1db9598990: Pull complete
2eeb5ce9b924: Pull complete
a8c530378055: Pull complete
687ed2fb2a0d: Pull complete
620aea26e853: Pull complete
Digest: sha256:fc34d5b6cf5d00a6139a74370dc27ddc9ce18303e2210d0f199a6050cc29aa45
Status: Downloaded newer image for python:3.6
4411349d2e1c5407617201d8e9f9523d34f7105f82f5c53fad23bf3a67dacd54
```


## Running Python 2.7-based Docker Container

```
[node1] (local) root@192.168.0.18 ~
$ docker run -dit python:2.7
Unable to find image 'python:2.7' locally
2.7: Pulling from library/python
54f7e8ac135a: Already exists
d6341e30912f: Already exists
087a57faf949: Already exists
5d71636fb824: Already exists
0c1db9598990: Already exists
220bd9a491ba: Pull complete
97b15521fe5d: Pull complete
1b44c1054690: Pull complete
6b8b382a68d7: Pull complete
Digest: sha256:1bb98a04d037d9766110499d36bf2f3a2aa43965b4aa345da91f6de75f3816d8
Status: Downloaded newer image for python:2.7
dd4b7a0da1b56af242e9853fd512d4af4ddfa919fceaa6e6068a20f9fe0ab880
[node1] (local) root@192.168.0.18 ~
```

## Verifying both Docker Container

```
[node1] (local) root@192.168.0.18 ~
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
dd4b7a0da1b5        python:2.7          "python2"           18 seconds ago      Up 17 seconds                           hardcore_shaw
4411349d2e1c        python:3.6          "python3"           26 seconds ago      Up 25 seconds                           romantic_spence
[node1] (local) root@192.168.0.18 ~
```

## Verifying Python Version in each Docker Container


```
[node1] (local) root@192.168.0.18 ~
$ docker run python:2.7 python -V
Python 2.7.15
[node1] (local) root@192.168.0.18 ~
$ docker run python:3.6 python -V
Python 3.6.7
```


<a href="https://asciinema.org/a/Udlbay9cNe4ek2ncSlWQclkPO" target="_blank"><img src="https://github.com/collabnix/dockerlabs/blob/master/beginners/helloworld/helloworld.png" /></a>


## Maintained by:
Ajeet Singh Raina



