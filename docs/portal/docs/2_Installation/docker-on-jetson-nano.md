# Getting Started with NVIDIA Jetson Nano

![image](https://user-images.githubusercontent.com/34368930/212855112-8895c2f4-6aba-4724-9185-b866e369de95.png)



## Table of Contents

1. [Intent](#Intent)
2. [Hardware](#hardware)
3. [Software](#Software)
4. [Preparing Your Jetson Nano](#preparing-your-jetson-nano)
   - [Flashing SD card image](#1-flashing-sd-card-image)
   - [Vefifying Docker Binaries](#2-verifying-if-it-is-shipped-with-docker-binaries)


## Intent

Everything and anything you want to know about NVIDIA Jetson Nano, Docker & K3s support

## Hardware

- Jetson Nano
- A Camera Module
- A 5V 4Ampere Charger
- 64GB SD card

## Software

- Jetson SD card image from https://developer.nvidia.com/embedded/downloads
- Etcher software installed on your system

## Preparing Your Jetson Nano

### 1. Preparing Your Raspberry Pi Flashing Jetson SD Card Image

 - Unzip the SD card image
 - Insert SD card into your system. 
 - Bring up Etcher tool and select the target SD card to which you want to flash the image.

![image](https://user-images.githubusercontent.com/34368930/212854917-8ead3f07-03f4-4189-8eb0-dbbcaed4ee7f.png)


```
sudo lshw -C system
pico2                       
    description: Computer
    product: NVIDIA Jetson Nano Developer Kit
    serial: 1422919082257
    width: 64 bits
    capabilities: smp cp15_barrier setend swp
```

### CUDA Compiler and Libraries

```
ajeetraina@ajeetraina-desktop:~/meetup$ nvcc --version
-bash: nvcc: command not found
ajeetraina@ajeetraina-desktop:~/meetup$ export PATH=${PATH}:/usr/local/cuda/bin
ajeetraina@ajeetraina-desktop:~/meetup$ export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda/lib64
ajeetraina@ajeetraina-desktop:~/meetup$ source ~/.bashrc
ajeetraina@ajeetraina-desktop:~/meetup$ nvcc --version
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2019 NVIDIA Corporation
Built on Wed_Oct_23_21:14:42_PDT_2019
Cuda compilation tools, release 10.2, V10.2.89
```

### DeviceQuery

```
$ pwd

/usr/local/cuda/samples/1_Utilities/deviceQuery
sudo make
```

```
ajeetraina@ajeetraina-desktop:/usr/local/cuda/samples/1_Utilities/deviceQuery$ sudo make
/usr/local/cuda-10.2/bin/nvcc -ccbin g++ -I../../common/inc  -m64    -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -gencode arch=compute_53,code=sm_53 -gencode arch=compute_61,code=sm_61 -gencode arch=compute_62,code=sm_62 -gencode arch=compute_70,code=sm_70 -gencode arch=compute_72,code=sm_72 -gencode arch=compute_75,code=sm_75 -gencode arch=compute_75,code=compute_75 -o deviceQuery.o -c deviceQuery.cpp
/usr/local/cuda-10.2/bin/nvcc -ccbin g++   -m64      -gencode arch=compute_30,code=sm_30 -gencode arch=compute_32,code=sm_32 -gencode arch=compute_53,code=sm_53 -gencode arch=compute_61,code=sm_61 -gencode arch=compute_62,code=sm_62 -gencode arch=compute_70,code=sm_70 -gencode arch=compute_72,code=sm_72 -gencode arch=compute_75,code=sm_75 -gencode arch=compute_75,code=compute_75 -o deviceQuery deviceQuery.o
mkdir -p ../../bin/aarch64/linux/release
cp deviceQuery ../../bin/aarch64/linux/release
ajeetraina@ajeetraina-desktop:/usr/local/cuda/samples/1_Utilities/deviceQuery$ ls
Makefile  NsightEclipse.xml  deviceQuery  deviceQuery.cpp  deviceQuery.o  readme.txt
ajeetraina@ajeetraina-desktop:/usr/local/cuda/samples/1_Utilities/deviceQuery$ ./deviceQuery
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "NVIDIA Tegra X1"
  CUDA Driver Version / Runtime Version          10.2 / 10.2
  CUDA Capability Major/Minor version number:    5.3
  Total amount of global memory:                 3956 MBytes (4148387840 bytes)
  ( 1) Multiprocessors, (128) CUDA Cores/MP:     128 CUDA Cores
  GPU Max Clock rate:                            922 MHz (0.92 GHz)
  Memory Clock rate:                             13 Mhz
  Memory Bus Width:                              64-bit
  L2 Cache Size:                                 262144 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 32768
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            Yes
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            No
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 0 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.2, CUDA Runtime Version = 10.2, NumDevs = 1
Result = PASS
```

### 2. Verifying if it is shipped with Docker Binaries

```
ajeetraina@ajeetraina-desktop:~$ sudo docker version
[sudo] password for ajeetraina: 
Client:
 Version:           19.03.6
 API version:       1.40
 Go version:        go1.12.17
 Git commit:        369ce74a3c
 Built:             Fri Feb 28 23:47:53 2020
 OS/Arch:           linux/arm64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.6
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.17
  Git commit:       369ce74a3c
  Built:            Wed Feb 19 01:06:16 2020
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.3.3-0ubuntu1~18.04.2
  GitCommit:        
 runc:
  Version:          spec: 1.0.1-dev
  GitCommit:        
 docker-init:
  Version:          0.18.0
  GitCommit:       
```

### 3. Checking Docker runtime 

Starting with JetPack 4.2, NVIDIA has introduced a container runtime with Docker integration. This custom runtime enables Docker containers to access the underlying GPUs available in the Jetson family.

```
pico@pico1:/tmp/docker-build$ sudo nvidia-docker version
NVIDIA Docker: 2.0.3
Client:
 Version:           19.03.6
 API version:       1.40
 Go version:        go1.12.17
 Git commit:        369ce74a3c
 Built:             Fri Feb 28 23:47:53 2020
 OS/Arch:           linux/arm64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.6
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.17
  Git commit:       369ce74a3c
  Built:            Wed Feb 19 01:06:16 2020
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.3.3-0ubuntu1~18.04.2
  GitCommit:        
 runc:
  Version:          spec: 1.0.1-dev
  GitCommit:        
 docker-init:
  Version:          0.18.0
  GitCommit:
```

## Installing Docker Compose on NVIDIA Jetson Nano

Jetson Nano doesnt come with Docker Compose installed by default. You will need to install it first:

```
export DOCKER_COMPOSE_VERSION=1.27.4
sudo apt-get install libhdf5-dev
sudo apt-get install libssl-dev
sudo pip3 install docker-compose=="${DOCKER_COMPOSE_VERSION}"
apt install python3
apt install python3-pip
pip install docker-compose
```

```
docker-compose version
docker-compose version 1.26.2, build unknown
docker-py version: 4.3.1
CPython version: 3.6.9
OpenSSL version: OpenSSL 1.1.1  11 Sep 2018
```




Next, add default runtime for NVIDIA:

Edit /etc/docker/daemon.json

```
{
    "runtimes": {
        "nvidia": {
            "path": "/usr/bin/nvidia-container-runtime",
            "runtimeArgs": []
        }
    },

    "default-runtime": "nvidia",
    "node-generic-resources": [ "NVIDIA-GPU=0" ]
}

```

Restart the Docker Daemon

```
systemctl restart docker
```


## Identify the Jetson board


```
pico@pico1:~$ git clone https://github.com/jetsonhacks/jetsonUtilities
Cloning into 'jetsonUtilities'...
remote: Enumerating objects: 123, done.
remote: Counting objects: 100% (39/39), done.
remote: Compressing objects: 100% (30/30), done.
remote: Total 123 (delta 15), reused 23 (delta 8), pack-reused 84
Receiving objects: 100% (123/123), 32.87 KiB | 5.48 MiB/s, done.
Resolving deltas: 100% (49/49), done.
pico@pico1:~$ cd jetson
-bash: cd: jetson: No such file or directory
pico@pico1:~$ cd jetsonUtilities/
```

```
pico@pico1:~/jetsonUtilities$ ls
LICENSE  README.md  jetsonInfo.py  scripts

pico@pico1:~/jetsonUtilities$ python3 jetsonInfo.py 
NVIDIA Jetson Nano (Developer Kit Version)
 L4T 32.4.4 [ JetPack 4.4.1 ]
   Ubuntu 18.04.5 LTS
   Kernel Version: 4.9.140-tegra
 CUDA 10.2.89
   CUDA Architecture: 5.3
 OpenCV version: 4.1.1
   OpenCV Cuda: NO
 CUDNN: 8.0.0.180
 TensorRT: 7.1.3.0
 Vision Works: 1.6.0.501
 VPI: 4.4.1-b50
 Vulcan: 1.2.70
```

## Install the latest version of CUDA

```
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/sbsa/cuda-ubuntu1804.pin
sudo mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.3.1/local_installers/cuda-repo-ubuntu1804-11-3-local_11.3.1-465.19.01-1_arm64.deb
sudo dpkg -i cuda-repo-ubuntu1804-11-3-local_11.3.1-465.19.01-1_arm64.deb
sudo apt-key add /var/cuda-repo-ubuntu1804-11-3-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda
```

## Verify Docker runtime


```
docker info | grep runtime
 Runtimes: nvidia runc io.containerd.runc.v2 io.containerd.runtime.v1.linux
```



## Testing GPU Support


We’ll use the deviceQuery NVIDIA test application (included in L4T) to check that we can access the GPU in the cluster. First, we’ll create a Docker image with the appropriate software, run it directly as Docker, then run it using containerd ctr and finally on the Kubernetes cluster itself.


### Running deviceQuery on Docker with GPU support

### Create a directory

```
mkdir test
cd test
```

### Copy the sample files

Copy the demos where deviceQuery is located to the working directory where the Docker image will be created:

```
cp -R /usr/local/cuda/samples .
```

### Create a Dockerfile

```
FROM nvcr.io/nvidia/l4t-base:r32.5.0
RUN apt-get update && apt-get install -y --no-install-recommends make g++
COPY ./samples /tmp/samples
WORKDIR /tmp/samples/1_Utilities/deviceQuery
RUN make clean && make
CMD ["./deviceQuery"]
```


```
sudo docker build -t ajeetraina/jetson_devicequery . -f Dockerfile
```

```
pico@pico2:~/test$ sudo docker run --rm --runtime nvidia ajeetraina/jetson_devicequery:latest
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "NVIDIA Tegra X1"
  CUDA Driver Version / Runtime Version          10.2 / 10.2
  CUDA Capability Major/Minor version number:    5.3
  Total amount of global memory:                 3963 MBytes (4155383808 bytes)
  ( 1) Multiprocessors, (128) CUDA Cores/MP:     128 CUDA Cores
  GPU Max Clock rate:                            922 MHz (0.92 GHz)
  Memory Clock rate:                             13 Mhz
  Memory Bus Width:                              64-bit
  L2 Cache Size:                                 262144 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 32768
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            Yes
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            No
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 0 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.2, CUDA Runtime Version = 10.2, NumDevs = 1
Result = PASS
```

Test 2: Running deviceQuery on containerd with GPU support


Since K3s uses containerd as its runtime by default, we will use the ctr command line to test and deploy the deviceQuery image we pushed on containerd with this script:

```
#!/bin/bash
IMAGE=ajeetraina/jetson_devicequery:latest
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
ctr i pull docker.io/${IMAGE}
ctr run --rm --gpus 0 --tty docker.io/${IMAGE} deviceQuery
```


## Execute the script

```
sudo sh usectr.sh
```

```
sudo sh usectr.sh 
docker.io/ajeetraina/jetson_devicequery:latest:                                   resolved       |++++++++++++++++++++++++++++++++++++++| 
manifest-sha256:dfeaad4046f78871d3852e5d5fb8fa848038c57c34c6554c6c97a00ba120d550: done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:4438ebff930fb27930d802553e13457783ca8a597e917c030aea07f8ff6645c0:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:b1cdeb9e69c95684d703cf96688ed2b333a235d5b33f0843663ff15f62576bd4:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:bf60857fb4964a3e3ce57a900bbe47cd1683587d6c89ecbce4af63f98df600aa:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:0aac5305d11a81f47ed76d9663a8d80d2963b61c643acfce0515f0be56f5e301:    done           |++++++++++++++++++++++++++++++++++++++| 
config-sha256:37987db6d6570035e25e713f41e665a6d471d25056bb56b4310ed1cb1d79a100:   done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:f0f57d03cad8f8d69b1addf90907b031ccb253b5a9fc5a11db83c51aa311cbfb:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:08c23323368d4fde5347276d543c500e1ff9b712024ca3f85172018e9440d8b0:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:04da93b342eb651d6b94c74a934a3290697573a907fa0a06067b538095601745:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:f84ceb6e8887e9b3b454813459ee97c2b9730869dbd37d4cca4051958b7a5a36:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:93752947af53e2a3225e145b359b956df36e20521b5dde0fe6d3fb92fd2a9538:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:b235194751dee33624fc154603f7e25ecdfbb02538fb7d55fa796df9afa95fee:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:905b1329c1d473c79650e33b882d980b3522fb72e58ecd3456c4fb3c4039fe92:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:8931d5ba88b488c949f77f990e8f9198b153ceb71afd0369eac9c39beb38f2d6:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:cfb2938be99fb944fe31165bdf44532a5536865ce53b12eb7758d1e2a51ad33e:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:606a67bb8db9a1111022bdc6406442e11c1a66653136c5c777114bf67b61038a:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:2f37138d1c8ac71d9314a0f8996ba69579bbc6ee6a57440557bc7eef486ed292:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:9ce7ce1da17c2b8149573d1d73132f61a73083f0cd498eeb7a0da404fd77db14:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:a36863a728ec9221c83c745f40511946dfd63beca0f10c9afcc774ef7a98e420:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:86dd6e5994e2c15f2783d8d543327479ccee7f3b20023dd962fdb9a211071e16:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:f5299db1221c515de91f59d84b79f2f839f9c94a5d0cc7fad04134e23ec9b88a:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:15a5811e1a7bf377cbac066b04e0b36b4c1a41ca63eb3c67c17b734577f6beea:    done           |++++++++++++++++++++++++++++++++++++++| 
layer-sha256:cb893097de39451407d7167b312ec56eaea80baa041877af8239dbe833fa044b:    done           |++++++++++++++++++++++++++++++++++++++| 
elapsed: 81.4s                                                                    total:  305.5  (3.8 MiB/s)                                       
unpacking linux/arm64/v8 sha256:dfeaad4046f78871d3852e5d5fb8fa848038c57c34c6554c6c97a00ba120d550...

done

./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "NVIDIA Tegra X1"
  CUDA Driver Version / Runtime Version          10.2 / 10.2
  CUDA Capability Major/Minor version number:    5.3
  Total amount of global memory:                 3963 MBytes (4155383808 bytes)
  ( 1) Multiprocessors, (128) CUDA Cores/MP:     128 CUDA Cores
  GPU Max Clock rate:                            922 MHz (0.92 GHz)
  Memory Clock rate:                             13 Mhz
  Memory Bus Width:                              64-bit
  L2 Cache Size:                                 262144 bytes
  Maximum Texture Dimension Size (x,y,z)         1D=(65536), 2D=(65536, 65536), 3D=(4096, 4096, 4096)
  Maximum Layered 1D Texture Size, (num) layers  1D=(16384), 2048 layers
  Maximum Layered 2D Texture Size, (num) layers  2D=(16384, 16384), 2048 layers
  Total amount of constant memory:               65536 bytes
  Total amount of shared memory per block:       49152 bytes
  Total number of registers available per block: 32768
  Warp size:                                     32
  Maximum number of threads per multiprocessor:  2048
  Maximum number of threads per block:           1024
  Max dimension size of a thread block (x,y,z): (1024, 1024, 64)
  Max dimension size of a grid size    (x,y,z): (2147483647, 65535, 65535)
  Maximum memory pitch:                          2147483647 bytes
  Texture alignment:                             512 bytes
  Concurrent copy and kernel execution:          Yes with 1 copy engine(s)
  Run time limit on kernels:                     Yes
  Integrated GPU sharing Host Memory:            Yes
  Support host page-locked memory mapping:       Yes
  Alignment requirement for Surfaces:            Yes
  Device has ECC support:                        Disabled
  Device supports Unified Addressing (UVA):      Yes
  Device supports Compute Preemption:            No
  Supports Cooperative Kernel Launch:            No
  Supports MultiDevice Co-op Kernel Launch:      No
  Device PCI Domain ID / Bus ID / location ID:   0 / 0 / 0
  Compute Mode:
     < Default (multiple host threads can use ::cudaSetDevice() with device simultaneously) >

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.2, CUDA Runtime Version = 10.2, NumDevs = 1
Result = PASS


```

### Test 3: Running deviceQuery on the K3s cluster

```
pico@pico2:~/test$ cat pod_deviceQuery.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: devicequery
spec:
  containers:
    - name: nvidia
      image: ajeetraina/jetson_devicequery:latest

      command: [ "./deviceQuery" ]
pico@pico2:~/test$
```


```
sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml kubectl apply -f ./pod_deviceQuery.yaml
pod/devicequery created
```

```
pico@pico2:~/test$ sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml kubectl describe pod devicequery
Name:         devicequery
Namespace:    default
Priority:     0
Node:         pico4/192.168.1.163
Start Time:   Sun, 13 Jun 2021 09:16:44 -0700
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  nvidia:
    Container ID:  
    Image:         ajeetraina/jetson_devicequery:latest
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Command:
      ./deviceQuery
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mcrmv (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-api-access-mcrmv:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  78s   default-scheduler  Successfully assigned default/devicequery to pico4
  Normal  Pulling    77s   kubelet            Pulling image "ajeetraina/jetson_devicequery:latest"
pico@pico2:~/test$
```


```
cat pod_deviceQuery_jetson4.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: devicequery
spec:
  nodeName: pico4
  containers:
    - name: nvidia
      image: ajeetraina/jetson_devicequery:latest
      command: [ "./deviceQuery" ]
pico@pico2:~/test$ 
```

```
pico@pico2:~/test$ sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml kubectl describe pod devicequery
Name:         devicequery
Namespace:    default
Priority:     0
Node:         pico4/192.168.1.163
Start Time:   Sun, 13 Jun 2021 09:16:44 -0700
Labels:       <none>
Annotations:  <none>
Status:       Running
IP:           10.42.1.3
IPs:
  IP:  10.42.1.3
Containers:
  nvidia:
    Container ID:  containerd://fd502d6bfa55e2f80b2d50bc262e6d6543fd8d09e9708bb78ecec0b2e09621c3
    Image:         ajeetraina/jetson_devicequery:latest
    Image ID:      docker.io/ajeetraina/jetson_devicequery@sha256:dfeaad4046f78871d3852e5d5fb8fa848038c57c34c6554c6c97a00ba120d550
    Port:          <none>
    Host Port:     <none>
    Command:
      ./deviceQuery
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Error
      Exit Code:    1
      Started:      Sun, 13 Jun 2021 09:21:50 -0700
      Finished:     Sun, 13 Jun 2021 09:21:50 -0700
    Ready:          False
    Restart Count:  5
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-mcrmv (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             False 
  ContainersReady   False 
  PodScheduled      True 
Volumes:
  kube-api-access-mcrmv:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                    From               Message
  ----     ------     ----                   ----               -------
  Normal   Scheduled  7m51s                  default-scheduler  Successfully assigned default/devicequery to pico4
  Normal   Pulled     5m45s                  kubelet            Successfully pulled image "ajeetraina/jetson_devicequery:latest" in 2m5.699757621s
  Normal   Pulled     5m43s                  kubelet            Successfully pulled image "ajeetraina/jetson_devicequery:latest" in 1.000839703s
  Normal   Pulled     5m29s                  kubelet            Successfully pulled image "ajeetraina/jetson_devicequery:latest" in 967.072951ms
  Normal   Pulled     4m59s                  kubelet            Successfully pulled image "ajeetraina/jetson_devicequery:latest" in 1.025604394s
  Normal   Created    4m59s (x4 over 5m45s)  kubelet            Created container nvidia
  Normal   Started    4m59s (x4 over 5m45s)  kubelet            Started container nvidia
  Warning  BackOff    4m20s (x8 over 5m42s)  kubelet            Back-off restarting failed container
  Normal   Pulling    2m47s (x6 over 7m51s)  kubelet            Pulling image "ajeetraina/jetson_devicequery:latest"
```


```
pico@pico2:~/test$ sudo KUBECONFIG=/etc/rancher/k3s/k3s.yaml kubectl apply -f ./pod_deviceQuery_jetson4.yaml
pod/devicequery configured
```

