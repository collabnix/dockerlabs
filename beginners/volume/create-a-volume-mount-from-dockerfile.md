## Creating Volume Mount from **Dockerfile**



Create a file with name volume and paste the following content to it:

```
FROM ubuntu:latest
RUN mkdir /data
WORKDIR /data
RUN echo "Hello from Volume" > test
VOLUME /data
```

Execute the following commands:

```
docker build -f volume -t collabnix/volume:1 .

docker run collabnix/volume:1

docker volume ls

cd /var/lib/docker/volumes

ls -ltr

cd ./<FOLDER_NAME_WITH_RANDOM_NUMBERS_&_CHARACTERS>

cd ./_data
 
cat test 
```
