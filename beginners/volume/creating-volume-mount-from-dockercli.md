## Creating Volume Mount from **docker run** command & sharing same Volume Mounts among multiple containers

Create a file with name volume_test and paste the following content:

```
FROM ubuntu:latest
RUN mkdir /data
ENV MESSAGE=HI
ENV FILENAME=test
WORKDIR /data
ENTRYPOINT echo ${MESSAGE} > ${FILENAME} && ls
```

Execute following commands:

```
docker build -f volume_test -t sagarj/volume_test:1 .

docker run --env MESSAGE="GOOD Morning" --env FILENAME=morning_message\
 --mount type=volume,source=demo,target=/data \
 sagarj/volume_test:1
 
 docker run --env MESSAGE="GOOD Afternoon" --env FILENAME=afternoon_message\
  --mount type=volume,source=demo,target=/data \
  sagarj/volume_test:1

docker volume ls

cd /var/lib/docker/volumes/demo/_data

ls

cat morning_message &&  cat afternoon_message
```
