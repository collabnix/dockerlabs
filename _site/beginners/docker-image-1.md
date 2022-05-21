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

## List out Docker Image digests

```
$ docker images --digests
REPOSITORY          TAG                 DIGEST                    IMAGE ID            CREATED             SIZE
hello-world         latest              sha256:0add3ace90ecb4adbf7777e9aacf18357296e799f81cabc9fde470971e499788   4ab4c602aa5e        6 weeks ago         1.84kB
```

## Image ![alt text](<link>)



## Explanation




## Did you Know?

```

```


## Additional Reference


## Where to get help:

## Where to file issues:


## Maintained by:


## Supported architectures: (more info)
amd64, arm32v5, arm32v7, arm64v8, i386, ppc64le, s390x, windows-amd64


[Next: <Topic Name](https://github.com/collabnix/dockerlabs/blob/master/beginners/b300/<>.md)

