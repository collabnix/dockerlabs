## Mounting host directory into container

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
- Click on "Add New Node"

Execute the following commands:


## Creating "test" directory
```
mkdir test
```


## Cleaning the system
```
docker system prune
```

## Cleaning the Volumes

```
docker volume prune
```

## Listing out the Volumes


```
docker volume ls
```


## Mounting host directory into container


```
docker run --env MESSAGE="GOOD Afternoon" --env FILENAME=afternoon_message\
 --mount type=bind,source="$(pwd)"/test,target=/data \
 sagarj/volume_test:1
```

## Verifying the Docker Volume

```
docker volume ls
```

# Verifying the File placed in container sitting on Host console

```
cd ./test
```

```
ls
```

```
cat afternoon_message
 ```
