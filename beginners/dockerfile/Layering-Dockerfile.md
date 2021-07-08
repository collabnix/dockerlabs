# Understanding Image Layering Concept with Dockerfile

Docker container is a runnable instance of an image, which is actually made by writing a readable/writable layer on top of some read-only layers. 

The parent image used to create another image from a Dockerfile is read-only. When we execute instructions on this parent image, new layers keep adding up.
These layers are created when we run docker build command. 

The instructions RUN, COPY, ADD mostly contribute to the addition of layers in a Docker build. 

Each layer is read-only except the last one - this is added to the image for generating a runnable container. This last layer is called "container layer". All changes made to the container, like making new files, installing applications, etc. are done in this thin layer.

Let's understand this layering using an example:

Consider the Dockerfile given below:

```
FROM ubuntu:latest
RUN mkdir -p /hello/hello
COPY hello.txt /hello/hello
RUN chmod 600 /hello/hello/hello.txt

```


### Layer ID
Each instruction the Dockerfile generates a layer. Each of this layer has a randomly generated unique ID. This ID can be seen at the time of build. See the image below:

![Docker layers during Build](https://raw.githubusercontent.com/Prashansa-K/Docker/master/Writing%20Dockerfiles/layering2.png)

To view all these layers once an image is built from a Dockerfile, we can use docker history command.

![Docker history](https://raw.githubusercontent.com/Prashansa-K/Docker/master/Writing%20Dockerfiles/layering3.png)


To see more information about the Docker image and the layers use `docker inspect` command as such:

```
# docker inspect testimage:latest

[
    {
        "Id": "sha256:c5701e02ed095ae7cabaef9fcef009d1f272206ff707deca13a680e024db7f02",
        "RepoTags": [
            "testimage:latest"
        ],
        "RepoDigests": [],
        "Parent": "sha256:694569c6db07ecef432cee1a9a4a6d45f2fd1f6be16814bf59e101bed966e612",
        "Comment": "",
        "Created": "2019-06-03T23:47:01.026463541Z",
        "Container": "ac8873a003cb9ed972b4675f8d27181b99112e7530a5803ff89780e3ecc18b1c",
        "ContainerConfig": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/sh",
                "-c",
                "chmod 600 /home/hello/hello.txt"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:694569c6db07ecef432cee1a9a4a6d45f2fd1f6be16814bf59e101bed966e612",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "DockerVersion": "18.03.1-ce",
        "Author": "",
        "Config": {
            "Hostname": "",
            "Domainname": "",
            "User": "",
            "AttachStdin": false,
            "AttachStdout": false,
            "AttachStderr": false,
            "Tty": false,
            "OpenStdin": false,
            "StdinOnce": false,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/bash"
            ],
            "ArgsEscaped": true,
            "Image": "sha256:694569c6db07ecef432cee1a9a4a6d45f2fd1f6be16814bf59e101bed966e612",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": null
        },
        "Architecture": "amd64",
        "Os": "linux",
        "Size": 222876395,
        "VirtualSize": 222876395,
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/86a76eac21ae67f6d78e59076107a121e6dfb9cc922e68e1be975fc97e711eb1/diff:/var/lib/docker/overlay2/0604b502d31eff670769257ba3411fca09fbe2eab03343660ba557024915a1e6/diff:/var/lib/docker/overlay2/16af32e079fbc252ea5de044628285d5c3a34fc8441602a762729482666b2431/diff:/var/lib/docker/overlay2/732c4ab0164f92664ce831b4a830251132bf17cbcb7d093334a7a367b1a665e5/diff:/var/lib/docker/overlay2/c8a69709e5093c6eefa317f015cbf1422a446b2fe5d3f3d52a7e0d8af8dc6a28/diff:/var/lib/docker/overlay2/c93b36ec3a753592518727a2ea4547ab4e53d58489b9fae0838b2806e9c18346/diff:/var/lib/docker/overlay2/e67589599c2a5ed3bd74a269f3effaa52f94975fd811a866f1fe2bbcb2edabe4/diff",
                "MergedDir": "/var/lib/docker/overlay2/31c68adcd824f155d23de4197b3d0b8776b079c307c1e4c0f2f8bbc73807adc0/merged",
                "UpperDir": "/var/lib/docker/overlay2/31c68adcd824f155d23de4197b3d0b8776b079c307c1e4c0f2f8bbc73807adc0/diff",
                "WorkDir": "/var/lib/docker/overlay2/31c68adcd824f155d23de4197b3d0b8776b079c307c1e4c0f2f8bbc73807adc0/work"
            },
            "Name": "overlay2"
        },
        "RootFS": {
            "Type": "layers",
            "Layers": [
                "sha256:05b0f7f2a81723fd647744a7340477ef9619f5ddeba3f2ca039dac3dd143cd59",
                "sha256:0c3819952093832ffd8865bf72bc17f2f5475795cffe97e2b4c4ff36e638c244",
                "sha256:14fa4a9494bf9e61f83a1bb96cd9e963ab0cbbdaf8ed91ff5eec5196c5bf7b12",
                "sha256:b33859b66bfd3ad176ccf3be8dbd52d6b9823de8cc26688f2efeb76a0ea24a78",
                "sha256:4622c8e1bdc0716e185fa3b338fa415dfdad3724336315de0bebd173a6ceaf05",
                "sha256:6427efc3a0d7bae1fe315b844703580b2095073dcdf54a6ed9c7b1c0d982d9b0",
                "sha256:59cd898074ac7765bacd76a11724b8d666ed8e9c14e7806dfb20a486102f6f1e",
                "sha256:ad24f18512fddb8794612f7ec5955d06dcee93641d02932d809f0640263b8e79"
            ]
        },
        "Metadata": {
            "LastTagTime": "2019-06-04T05:17:01.430558997+05:30"
        }
    }
]

```

# Do you want to visualize layers of Docker Image?

```
docker run --rm -it -v /var/run/docker.sock:/var/run/docker.sock  wagoodman/dive testimage
```

```
[● Layers]───────────────────────────────────────────────────────────────────────────── [Current Layer Contents]───────────────────────────────────────────────────────────────
Cmp   Size  Command                                                                     Permission     UID:GID       Size  Filetree
     63 MB  FROM e388568efdf7281                                                        drwxr-xr-x         0:0     4.8 MB  ├── bin
    988 kB  [ -z "$(apt-get indextargets)" ]                                            -rwxr-xr-x         0:0     1.1 MB  │   ├── bash
     745 B  set -xe   && echo '#!/bin/sh' > /usr/sbin/policy-rc.d  && echo 'exit 101' > -rwxr-xr-x         0:0      35 kB  │   ├── bunzip2
       7 B  mkdir -p /run/systemd && echo 'docker' > /run/systemd/container             -rwxr-xr-x         0:0        0 B  │   ├── bzcat → bin/bunzip2
       0 B  mkdir -p /hello/hello                                                       -rwxrwxrwx         0:0        0 B  │   ├── bzcmp → bzdiff
      37 B  #(nop) COPY file:666735678ded52c6f9e0693ca27b4dc3d466e3d79c585a58c3b9a91357 -rwxr-xr-x         0:0     2.1 kB  │   ├── bzdiff
      37 B  chmod 600 /hello/hello/hello.txt                                            -rwxrwxrwx         0:0        0 B  │   ├── bzegrep → bzgrep
                                                                                        -rwxr-xr-x         0:0     4.9 kB  │   ├── bzexe
[Layer Details]──────────────────────────────────────────────────────────────────────── -rwxrwxrwx         0:0        0 B  │   ├── bzfgrep → bzgrep
                                                                                        -rwxr-xr-x         0:0     3.6 kB  │   ├── bzgrep
Tags:   (unavailable)                                                                   -rwxr-xr-x         0:0        0 B  │   ├── bzip2 → bin/bunzip2
Id:     e388568efdf72814bd6439a80d822ce06b631689a82292a2b96382d020d63a4c                -rwxr-xr-x         0:0      14 kB  │   ├── bzip2recover
Digest: sha256:43c67172d1d182ca5460fc962f8f053f33028e0a3a1d423e05d91b532429e73d         -rwxrwxrwx         0:0        0 B  │   ├── bzless → bzmore
Command:                                                                                -rwxr-xr-x         0:0     1.3 kB  │   ├── bzmore
#(nop) ADD file:08e718ed0796013f5957a1be7da3bef6225f3d82d8be0a86a7114e5caad50cbc in /   -rwxr-xr-x         0:0      35 kB  │   ├── cat
                                                                                        -rwxr-xr-x         0:0      64 kB  │   ├── chgrp
[Image Details]──────────────────────────────────────────────────────────────────────── -rwxr-xr-x         0:0      60 kB  │   ├── chmod
                                                                                        -rwxr-xr-x         0:0      68 kB  │   ├── chown
Total Image size: 64 MB                                                                 -rwxr-xr-x         0:0     142 kB  │   ├── cp
Potential wasted space: 308 B                                                           -rwxr-xr-x         0:0     121 kB  │   ├── dash
Image efficiency score: 99 %                                                            -rwxr-xr-x         0:0     101 kB  │   ├── date
                                                                                        -rwxr-xr-x         0:0      76 kB  │   ├── dd
Count   Total Space  Path                                                               -rwxr-xr-x         0:0      85 kB  │   ├── df
    2         234 B  /var/lib/dpkg/diversions                                           -rwxr-xr-x         0:0     134 kB  │   ├── dir
    2          74 B  /hello/hello/hello.txt                                             -rwxr-xr-x         0:0      72 kB  │   ├── dmesg
                                                                                        -rwxrwxrwx         0:0        0 B  │   ├── dnsdomainname → hostname
                                                                                        -rwxrwxrwx         0:0        0 B  │   ├── domainname → hostname
                                                                                        -rwxr-xr-x         0:0      35 kB  │   ├── echo
                                                                                        -rwxr-xr-x         0:0       28 B  │   ├── egrep
                                                                                        -rwxr-xr-x         0:0      31 kB  │   ├── false
                                                                                        -rwxr-xr-x         0:0       28 B  │   ├── fgrep
                                                                                        -rwxr-xr-x         0:0      65 kB  │   ├── findmnt
                                                                                        -rwxr-xr-x         0:0     220 kB  │   ├── grep
                                                                                        -rwxr-xr-x         0:0     2.3 kB  │   ├── gunzip
                                                                                        -rwxr-xr-x         0:0     5.9 kB  │   ├── gzexe
                                                                                        -rwxr-xr-x         0:0     102 kB  │   ├── gzip
 ```

## Contributor

[Prashansa Kulshrestha](https://github.com/Prashansa-K/)<br>
[Ajeet S Raina](https://github.com/ajeetraina)
