# How to authenticate your DockerHub Account with new V2 API and list out all your repositories

The following example script demonstrates authentication with the new V2 API.

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


## Steps

## Install jq

```
apk update
apk add jq
```

## Cloning the Repository

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/dockerhub/
```

## Setting up username and password

Edit the file and add your username and password:

```
vi authenticate_hub_api.sh
```

Set up your username and password and save it.

## Executing the Script

```
....
ajeetraina/infrakit:v1.1
ajeetraina/infrakit:latest
ajeetraina/nagios:latest
ajeetraina/nagios-docker:latest
ajeetraina/syscfg-minimal:v1.0
ajeetraina/apache-jmeter-base:latest
ajeetraina/windows-mysql:latest
ajeetraina/jmeter-server:latest
ajeetraina/ubuntu17.04:latest
ajeetraina/hellonode:latest
ajeetraina/hellonode:2
ajeetraina/hellonode:3
ajeetraina/hellonode:1
ajeetraina/kernel-ubuntu:4.10.0-20
ajeetraina/kernel-ubuntu:4.10.0-19
ajeetraina/wordpress.dockerapp:1.1.0
ajeetraina/wordpress.dockerapp:latest
ajeetraina/wordpress.dockerapp:1.0.1
ajeetraina/portus_web:latest
ajeetraina/centos-7.2:latest
ajeetraina/mysql-server:latest
ajeetraina/portus_web1:latest
ajeetraina/webmin:latest
ajeetraina/myproject1:latest
ajeetraina/jmeter-master:latest
ajeetraina/catweb:latest
ajeetraina/ideastation-app1:latest
ajeetraina/apache-php:latest
ajeetraina/ideastation-db1:latest
ajeetraina/hadoop:latest
ajeetraina/ideastation-app:latest
ajeetraina/ubuntu-nettools:latest
ajeetraina/haskell-prometheus:latest
ajeetraina/jmeter-base:latest
ajeetraina/redhatcert:latest
ajeetraina/rhcertification:latest
ajeetraina/scaleio-tb:latest
ajeetraina/portus_db1:latest
ajeetraina/portus_web2:latest
ajeetraina/mypython:latest
ajeetraina/scaleio-primary-mdm:latest
ajeetraina/redfishtool:latest
ajeetraina/centos:7
ajeetraina/ideastation-dbb1:latest
ajeetraina/ubuntu-python:latest
ajeetraina/hello-python:latest
ajeetraina/scaleio-secondary-mdm:latest
ajeetraina/scaleio-gateway:latest
ajeetraina/apache-docker:latest
ajeetraina/ubuntuwithgit:latest
ajeetraina/apache:latest
ajeetraina/myalpine:latest
ajeetraina/rhcert:latest
ajeetraina/docker-python-web:latest
ajeetraina/linux_tweet_app:2.0
ajeetraina/linux_tweet_app:1.0
ajeetraina/alpine-npm:latest
ajeetraina/nvidia-exporter:latest
ajeetraina/callme:latest
ajeetraina/redhat-cert:latest
ajeetraina/webpage:latest
ajeetraina/webpage:1
ajeetraina/syscfg:latest
ajeetraina/myubuntu:latest
ajeetraina/debian-omsa:latest
ajeetraina/hello-openfaas:latest
ajeetraina/mydock:latest
ajeetraina/ubuntu-git:latest
ajeetraina/openusm_analytics:latest
ajeetraina/intro1:latest
ajeetraina/prometheus-nvidia-hpc:latest
ajeetraina/firefox:latest
ajeetraina/alpine-git:1.0
ajeetraina/alpine-git:latest
ajeetraina/redfish_dell:latest
ajeetraina/mygit:latest
ajeetraina/hello-world:v1.0
ajeetraina/jbpm-postgresql:latest
```

