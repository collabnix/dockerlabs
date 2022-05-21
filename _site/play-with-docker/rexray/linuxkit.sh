#!/bin/sh


#Ensure that you have the following commands running on your MacOS

# login as root
# VBoxManage setproperty websrvauthlibrary null
# vboxwebsrv -H 0.0.0.0 -v

apk update
apk add make git 
curl -LO https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk && apk add --allow-untrusted glibc-2.23-r3.apk -force
curl -sSL https://dl.bintray.com/emccode/rexray/install | INSECURE=1 sh

tee -a  /etc/rexray/config.yml << EOF 

libstorage:
  service: virtualbox
  integration:
    volume:
      operations:
        mount:
          preempt: true
virtualbox:
  endpoint: http://192.168.1.5:18083
  volumePath: /Users/<username>/Volumes
  controllerName: SATA"
  
  #  docker volume create -d rexray --name pg_data --opt=size=1
  # docker run -dit --name pg -e POSTGRES_PASSWORD=mysecretpassword --volume-driver=rexray -v pg_data:/var/lib/postgresql/data postgres
  
