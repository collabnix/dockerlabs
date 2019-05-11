# How to Build ARM-based Docker Image using `docker buildx`?


```
[Captains-Bay]🚩 >  docker buildx --help

Usage:	docker buildx COMMAND

Build with BuildKit

Management Commands:
  imagetools  Commands to work on images in registry

Commands:
  bake        Build from a file
  build       Start a build
  create      Create a new builder instance
  inspect     Inspect current builder instance
  ls          List builder instances
  rm          Remove a builder instance
  stop        Stop builder instance
  use         Set the current builder instance
  version     Show buildx version information 

Run 'docker buildx COMMAND --help' for more information on a command.
```




## Cloning the Repository

```
[Captains-Bay]🚩 >  git clone https://github.com/collabnix/docker-cctv-raspbian
Cloning into 'docker-cctv-raspbian'...
remote: Enumerating objects: 47, done.
remote: Counting objects: 100% (47/47), done.
remote: Compressing objects: 100% (31/31), done.
remote: Total 47 (delta 20), reused 32 (delta 14), pack-reused 0
Unpacking objects: 100% (47/47), done.
```

## Peeping into Dockerfile

```
[Captains-Bay]🚩 >  cat Dockerfile 
FROM resin/rpi-raspbian:latest

RUN apt update && apt upgrade && apt install motion
RUN mkdir /mnt/motion && chown motion /mnt/motion
COPY motion.conf /etc/motion/motion.conf

VOLUME /mnt/motion
EXPOSE 8081
ENTRYPOINT ["motion"]
[Captains-Bay]🚩 >
```


## Building ARM-based Docker Image

```
[Captains-Bay]🚩 >  docker buildx build .
[+] Building 54.5s (7/10)                                                                
[+] Building 66.8s (7/10)                                                                
 => => transferring dockerfile: 268B                                                0.0s
 => [internal] load metadata for docker.io/resin/rpi-raspbian:latest                7.6s
 => [1/4] FROM docker.io/resin/rpi-raspbian:latest@sha256:18be79e066099cce5c676f7  38.2s
 => => resolve docker.io/resin/rpi-raspbian:latest@sha256:18be79e066099cce5c676f77  0.0s
 => => sha256:5fb2b6f7daac67a8465e8201c76828550b811619be473ab594972da3 354B / 354B  5.7s
 => => sha256:78ba3f0466312c019467b178339a89120f2dce298d7c3d5e6840b356 250B / 250B  5.3s
 => => sha256:18be79e066099cce5c676f7733a6ccb4733ed5962a996424ba8a 2.81kB / 2.81kB  0.0s
 => => sha256:6bddb275e70b0083d76083d01be2c3da11f67f526a123adcc 51.54MB / 51.54MB  33.8s
 => => sha256:2734b459704280a5238405384487095392e5414d973554b27545cec0 256B / 256B  5.8s
 => => sha256:9d5b46a00008070b009b685af5846c225ad170f38768416b6391 7.75kB / 7.75kB  3.6s
 => => sha256:67a3f53689ffd00b59f9a7b7f8af0da5b36c9e11e12ba43b3596 1.56kB / 1.56kB  4.2s
 => => sha256:28f1ee4d4d5aa8bb96b3ba6a5e2177b2b58b595edaf601b9aae6 7.48kB / 7.48kB  0.0s
 => => sha256:3eae71a21b9db8bd54d6a189b7587a10f52d6ffee3d868705a89974f 234B / 234B  3.5s
 => => sha256:873755612f304f066db70c4015fdeadc9a81c0e6e25fb1aa833aeba8 229B / 229B  4.6s
 => => sha256:a04aef7b1e2fc4905fea2a685c63bc1eeb94c86149fd1286459206c2 177B / 177B  4.5s
 => => sha256:b98db37cf25231afe68852e2cb21fb8aa465bb7a32ecc9afc6dec100 367B / 367B  6.0s
 => => sha256:ef16d706debb7a56d89bf14958aca2da76bd3d0a42a6762c37302c95 305B / 305B  5.2s
 => => sha256:6b6c68e7ac8567569cee8da92431637e561e7aef5addb70373401d08 363B / 363B  5.5s
 => => unpacking docker.io/resin/rpi-raspbian:latest@sha256:18be79e066099cce5c676f  4.2s
 => [internal] load build context                                                   0.0s
 => => transferring context: 27.72kB                                                0.0s
 => [2/4] RUN cat /.resin/deprecation-warning                                       0.5s
 => [3/4] RUN apt update && apt upgrade && apt install motion                      19.2s
 => => # 100% [Working]                                                      6116 B/s 0s
 => => # 100% [2 InRelease gpgv 15.0 kB] [Waiting for headers]               6116 B/s 0s
 => => # Get:3 http://archive.raspberrypi.org jessie/main armhf Packages [170 kB]       
 => => # 24% [2 InRelease gpgv 15.0 kB] [3 Packages 13.0 kB/170 kB 8%]      6116 B/s 25s 
 => => # 38% [2 InRelease gpgv 15.0 kB] [3 Packages 41.8 kB/170 kB 25%]     6116 B/s 21s


```

