# Working with Docker Images

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


## Listing the Docker Images

```
$ docker images
```

```
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              4ab4c602aa5e        6 weeks ago         1.84kB
```

## Show all images (default hides intermediate images)

```
docker images -a
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
hello-world         latest              4ab4c602aa5e        6 weeks ago         1.84kB
```


# List images by name and tag

The docker images command takes an optional [REPOSITORY[:TAG]] argument that restricts the list to images that match the argument. If you specify REPOSITORY but no TAG, the docker images command lists all images in the given repository.

To demo this, let us pull all various versions of alpine OS

```
docker pull alpine:3.6
docker pull alpine:3.7
docker pull alpine:3.8
docker pull alpine:3.9
```

```
[node4] (local) root@192.168.0.20 ~
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
alpine              3.6                 43773d1dba76        7 days ago          4.03MB
alpine              3.7                 6d1ef012b567        7 days ago          4.21MB
alpine              3.8                 dac705114996        7 days ago          4.41MB
alpine              3.9                 5cb3aa00f899        7 days ago          5.53MB
```

```
[node4] (local) root@192.168.0.20 ~
$ docker images alpine:3.7
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
alpine              3.7                 6d1ef012b567        7 days ago          4.21MB
```

## List the full length image IDs

```
$ docker images --no-trunc
REPOSITORY          TAG                 IMAGE ID                                                                  CREATED
     SIZE
alpine              3.6                 sha256:43773d1dba76c4d537b494a8454558a41729b92aa2ad0feb23521c3e58cd0440   7 days ago
     4.03MB
alpine              3.7                 sha256:6d1ef012b5674ad8a127ecfa9b5e6f5178d171b90ee462846974177fd9bdd39f   7 days ago
     4.21MB
alpine              3.8                 sha256:dac7051149965716b0acdcab16380b5f4ab6f2a1565c86ed5f651e954d1e615c   7 days ago
     4.41MB
alpine              3.9                 sha256:5cb3aa00f89934411ffba5c063a9bc98ace875d8f92e77d0029543d9f2ef4ad0   7 days ago
     5.53MB
```

# Listing out images with filter

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              94e814e2efa8        3 days ago          88.9MB
alpine              3.6                 43773d1dba76        7 days ago          4.03MB
alpine              3.7                 6d1ef012b567        7 days ago          4.21MB
alpine              3.8                 dac705114996        7 days ago          4.41MB
alpine              3.9                 5cb3aa00f899        7 days ago          5.53MB
```

If you want to filter out just alpine

```
$ docker images --filter=reference='alpine'
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
alpine              3.6                 43773d1dba76        7 days ago          4.03MB
alpine              3.7                 6d1ef012b567        7 days ago          4.21MB
alpine              3.8                 dac705114996        7 days ago          4.41MB
alpine              3.9                 5cb3aa00f899        7 days ago          5.53MB
```


## Explanation

The [REPOSITORY[:TAG]] value must be an “exact match”. 



## Did you Know?

```

```


## Additional Reference


## Where to get help:

## Where to file issues:


## Contributor

[Ajeet Singh Raina](mailto:ajeetraina@gmail.com)


## Supported architectures: (more info)
amd64, arm32v5, arm32v7, arm64v8, i386, ppc64le, s390x, windows-amd64


[Next: Saving Images and Containers as Tar Files for Sharing](http://dockerlabs.collabnix.com/beginners/saving-images-as-tar/)

