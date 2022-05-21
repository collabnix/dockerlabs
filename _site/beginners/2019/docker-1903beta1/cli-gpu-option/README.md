# Test Drive --gpus option under Docker 19.03.0 Beta 3

## Pre-requisite:

- Create a GCP instance selecting Ubuntu 18.04 as OS 
- Select 1x GPU while you select CPU


## Setting up Ubuntu Environment



```
sudo apt-get install ubuntu-drivers-common \
	&& sudo ubuntu-drivers autoinstall
```

## Reboot the system

## Create a file named nvidia-container-runtime-script.sh and save it

```
$ cat script 
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | \
  sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
```

## Execute the script

```
sh nvidia-container-runtime-script.sh
```

```
$ ./script 
OK
deb https://nvidia.github.io/libnvidia-container/ubuntu18.04/$(ARCH) /
deb https://nvidia.github.io/nvidia-container-runtime/ubuntu18.04/$(ARCH) /
Hit:1 http://archive.canonical.com/ubuntu bionic InRelease
Get:2 https://nvidia.github.io/libnvidia-container/ubuntu18.04/amd64  InRelease [1139 B]                
Get:3 https://nvidia.github.io/nvidia-container-runtime/ubuntu18.04/amd64  InRelease [1136 B]           
Hit:4 http://security.ubuntu.com/ubuntu bionic-security InRelease                                       
Get:5 https://nvidia.github.io/libnvidia-container/ubuntu18.04/amd64  Packages [4076 B]                 
Get:6 https://nvidia.github.io/nvidia-container-runtime/ubuntu18.04/amd64  Packages [3084 B]            
Hit:7 http://us-east4-c.gce.clouds.archive.ubuntu.com/ubuntu bionic InRelease
Hit:8 http://us-east4-c.gce.clouds.archive.ubuntu.com/ubuntu bionic-updates InRelease
Hit:9 http://us-east4-c.gce.clouds.archive.ubuntu.com/ubuntu bionic-backports InRelease
Fetched 9435 B in 1s (17.8 kB/s)                   
Reading package lists... Done
```
## Installing NVIDIA container runtime

```
$ sudo apt-get install nvidia-container-runtime
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
  grub-pc-bin libnuma1
Use 'sudo apt autoremove' to remove them.
The following additional packages will be installed:
  libnvidia-container-tools libnvidia-container1 nvidia-container-runtime-hook
The following NEW packages will be installed:
  libnvidia-container-tools libnvidia-container1 nvidia-container-runtime nvidia-container-runtime-hook
0 upgraded, 4 newly installed, 0 to remove and 8 not upgraded.
Need to get 2406 kB of archives.
After this operation, 9765 kB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 https://nvidia.github.io/libnvidia-container/ubuntu18.04/amd64  libnvidia-container1 1.0.2-1 [59.1 kB]
Get:2 https://nvidia.github.io/libnvidia-container/ubuntu18.04/amd64  libnvidia-container-tools 1.0.2-1 [15.4 kB]
Get:3 https://nvidia.github.io/nvidia-container-runtime/ubuntu18.04/amd64  nvidia-container-runtime-hook 1.4.0-1 [575 kB]
Get:4 https://nvidia.github.io/nvidia-container-runtime/ubuntu18.04/amd64  nvidia-container-runtime 2.0.0+docker18.09.6-3 [1757 kB]
Fetched 2406 kB in 0s (22.1 MB/s)              
Selecting previously unselected package libnvidia-container1:amd64.
(Reading database ... 81744 files and directories currently installed.)
Preparing to unpack .../libnvidia-container1_1.0.2-1_amd64.deb ...
Unpacking libnvidia-container1:amd64 (1.0.2-1) ...
Selecting previously unselected package libnvidia-container-tools.
Preparing to unpack .../libnvidia-container-tools_1.0.2-1_amd64.deb ...
Unpacking libnvidia-container-tools (1.0.2-1) ...
Selecting previously unselected package nvidia-container-runtime-hook.
Preparing to unpack .../nvidia-container-runtime-hook_1.4.0-1_amd64.deb ...
Unpacking nvidia-container-runtime-hook (1.4.0-1) ...
Selecting previously unselected package nvidia-container-runtime.
Preparing to unpack .../nvidia-container-runtime_2.0.0+docker18.09.6-3_amd64.deb ...
Unpacking nvidia-container-runtime (2.0.0+docker18.09.6-3) ...
Setting up libnvidia-container1:amd64 (1.0.2-1) ...
Setting up libnvidia-container-tools (1.0.2-1) ...
Processing triggers for libc-bin (2.27-3ubuntu1) ...
Setting up nvidia-container-runtime-hook (1.4.0-1) ...
Setting up nvidia-container-runtime (2.0.0+docker18.09.6-3) ...
```

```
which nvidia-container-runtime-hook
/usr/bin/nvidia-container-runtime-hook
```

## Installing Docker


```
curl -fsSL https://test.docker.com -o test-docker.sh 
```

## Execute the script

```
sh test-docker.sh
```

## Verifying Docker Installation

```
$ sudo docker version
Client:
 Version:           19.03.0-beta3
 API version:       1.40
 Go version:        go1.12.4
 Git commit:        c55e026
 Built:             Thu Apr 25 02:58:59 2019
 OS/Arch:           linux/amd64
 Experimental:      false
Server:
 Engine:
  Version:          19.03.0-beta3
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.4
  Git commit:       c55e026
  Built:            Thu Apr 25 02:57:32 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
```

## Verifying --gpus option under ```docker run ```

```
$ docker run --help | grep -i gpus
      --gpus gpu-request               GPU devices to add to the container ('all' to pass all GPUs)
 ```
  
 
 ## 
 
 ```
 $ sudo docker run -it --rm --gpus all ubuntu nvidia-smi
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
f476d66f5408: Pull complete 
8882c27f669e: Pull complete 
d9af21273955: Pull complete 
f5029279ec12: Pull complete 
Digest: sha256:d26d529daa4d8567167181d9d569f2a85da3c5ecaf539cace2c6223355d69981
Status: Downloaded newer image for ubuntu:latest
Tue May  7 15:52:15 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.116                Driver Version: 390.116                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla P4            Off  | 00000000:00:04.0 Off |                    0 |
| N/A   39C    P0    22W /  75W |      0MiB /  7611MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
:~$ 
```

## Listing out GPU devices

```
$ sudo docker run -it --rm --gpus all ubuntu nvidia-smi -L
GPU 0: Tesla P4 (UUID: GPU-fa974b1d-3c17-ed92-28d0-805c6d089601)
```

```
$ sudo docker run -it --rm --gpus all ubuntu nvidia-smi  --query-gpu=index,name,uui
d,serial --format=csv
index, name, uuid, serial
0, Tesla P4, GPU-fa974b1d-3c17-ed92-28d0-805c6d089601, 0325017070224
```


## Verify nvidia-smi once you run nvidia/digits container

```
$ sudo docker run -it --rm --gpus all ubuntu nvidia-smi
Tue May  7 16:27:37 2019       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 390.116                Driver Version: 390.116                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  Tesla P4            Off  | 00000000:00:04.0 Off |                    0 |
| N/A   51C    P0    24W /  75W |    129MiB /  7611MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```

```
sudo docker run -it --rm --gpus all -p 5000:5000 nvidia/digits
```




