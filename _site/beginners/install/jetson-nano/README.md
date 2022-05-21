# How to install Docker 19.03 on NVIDIA Jetson Nano

The NVIDIA® Jetson Nano™ Developer Kit is an AI computer for makers, learners, and developers that brings the power of modern artificial intelligence to a low-power, easyto-use platform. Get started quickly with out-of-the-box support for many popular
peripherals, add-ons, and ready-to-use projects.

Jetson Nano is supported by the comprehensive NVIDIA® JetPack™ SDK, and has the performance and capabilities needed to run modern AI workloads. JetPack includes:

• Full desktop Linux with NVIDIA drivers
• AI and Computer Vision libraries and APIs
• Developer tools
• Documentation and sample code

## Pre-requisite:

- Flash Jetson Nano SD card Image
- No need to enable SSH




## Verifying OS running on Jetson Nano

```
jetson@jetson-desktop:~$ sudo cat /etc/os-release
[sudo] password for jetson:
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
jetson@jetson-desktop:~$
```


## Verifying Docker

```
jetson@jetson-desktop:~$ sudo docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        6247962
 Built:             Tue Feb 26 23:51:35 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server:
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       6247962
  Built:            Wed Feb 13 00:24:14 2019
  OS/Arch:          linux/arm64
  Experimental:     false
jetson@jetson-desktop:~$
```

## Updating Jetson

```
sudo apt update
```

## Installing Docker 19.03

```
sudo apt install curl
```

```
curl -sSL https://get.docker.com/ | sh
```

```
jetson@jetson-desktop:~$ sudo docker version
Client: Docker Engine - Community
 Version:           19.03.2
 API version:       1.40
 Go version:        go1.12.8
 Git commit:        6a30dfc
 Built:             Thu Aug 29 05:32:21 2019
 OS/Arch:           linux/arm64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          19.03.2
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.8
  Git commit:       6a30dfc
  Built:            Thu Aug 29 05:30:53 2019
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc8
  GitCommit:        425e105d5a03fabd737a126ad93d62a9eeede87f
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
jetson@jetson-desktop:~$
```

## Installing Docker Compose

```
root@jetson-desktop:/home/jetson# /usr/bin/docker-compose version
docker-compose version 1.17.1, build unknown
docker-py version: 2.5.1
CPython version: 2.7.15+
OpenSSL version: OpenSSL 1.1.1  11 Sep 2018
root@jetson-desktop:/home/jetson#
```

## Connecting Logictech Webcam


```
root@jetson-desktop:~/docker-cctv-raspbian# docker ps
CONTAINER ID        IMAGE                             COMMAND             CREATED             STATUS              PORTS                    NAMES
b6ff860d4f2a        ajeetraina/docker-cctv-raspbian   "motion"            6 seconds ago       Up 2 seconds        0.0.0.0:8081->8081/tcp   hopeful_newton
root@jetson-desktop:~/docker-cctv-raspbian#
```

```
jetson@jetson-desktop:~$ docker run arm64v8/hello-world
Unable to find image 'arm64v8/hello-world:latest' locally
latest: Pulling from arm64v8/hello-world
3b4173355427: Pull complete
Digest: sha256:5970f71561c8ff01d1d97782f37b0142315c53f31ad23c22883488e36a6dcbcb
Status: Downloaded newer image for arm64v8/hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (arm64v8)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/

jetson@jetson-desktop:~$
```

```
jetson@jetson-desktop:~$ sudo docker info | grep nvidia
 Runtimes: nvidia runc
jetson@jetson-desktop:~$ sudo dpkg --get-selections | grep nvidia
libnvidia-container-tools                       install
libnvidia-container0:arm64                      install
nvidia-container-runtime                        install
nvidia-container-runtime-hook                   install
nvidia-docker2                                  deinstall
nvidia-l4t-3d-core                              install
nvidia-l4t-apt-source                           install
nvidia-l4t-bootloader                           install
nvidia-l4t-camera                               install
nvidia-l4t-ccp-t210ref                          install
nvidia-l4t-configs                              install
nvidia-l4t-core                                 install
nvidia-l4t-cuda                                 install
nvidia-l4t-firmware                             install
nvidia-l4t-graphics-demos                       install
nvidia-l4t-gstreamer                            install
nvidia-l4t-init                                 install
nvidia-l4t-kernel                               install
nvidia-l4t-kernel-dtbs                          install
nvidia-l4t-kernel-headers                       install
nvidia-l4t-multimedia                           install
nvidia-l4t-multimedia-utils                     install
nvidia-l4t-oem-config                           install
nvidia-l4t-tools                                install
nvidia-l4t-wayland                              install
nvidia-l4t-weston                               install
nvidia-l4t-x11                                  install
nvidia-l4t-xusb-firmware                        install
jetson@jetson-desktop:~$
```

Installing cuda drivers

```
jetson@jetson-desktop:~$ sudo apt install cuda*
Reading package lists... Done
Building dependency tree
Reading state information... Done
Note, selecting 'cuda-nvprune-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvgraph-10-0' for glob 'cuda*'
Note, selecting 'cuda-cublas-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-gdb-10-0' for glob 'cuda*'
Note, selecting 'cuda-curand-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-cupti-10-0' for glob 'cuda*'
Note, selecting 'cuda-libraries-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvrtc-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-minimal-build-10-0' for glob 'cuda*'
Note, selecting 'cuda-libraries-10-0' for glob 'cuda*'
Note, selecting 'cuda-cusolver-10-0' for glob 'cuda*'
Note, selecting 'cuda-cusparse-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvrtc-10-0' for glob 'cuda*'
Note, selecting 'cuda-cufft-10-0' for glob 'cuda*'
Note, selecting 'cuda-cusparse-10-0' for glob 'cuda*'
Note, selecting 'cuda-npp-10-0' for glob 'cuda*'
Note, selecting 'cuda-tools-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvtx-10-0' for glob 'cuda*'
Note, selecting 'cuda-cudart-10-0' for glob 'cuda*'
Note, selecting 'cuda-license-10-0' for glob 'cuda*'
Note, selecting 'cuda-license-10-1' for glob 'cuda*'
Note, selecting 'cuda-nvdisasm-10-0' for glob 'cuda*'
Note, selecting 'cuda-samples-10-0' for glob 'cuda*'
Note, selecting 'cuda-documentation-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvcc-10-0' for glob 'cuda*'
Note, selecting 'cuda-toolkit-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvgraph-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-cudart-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvml-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-gpu-library-advisor-10-0' for glob 'cuda*'
Note, selecting 'cuda-nsight-compute-addon-l4t-10-0' for glob 'cuda*'
Note, selecting 'cuda-cublas-10-0' for glob 'cuda*'
Note, selecting 'cuda-core-10-0' for glob 'cuda*'
Note, selecting 'cuda-cusolver-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-compiler-10-0' for glob 'cuda*'
Note, selecting 'cuda-npp-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-repo-l4t-10-0-local-10.0.326' for glob 'cuda*'
Note, selecting 'cuda-curand-10-0' for glob 'cuda*'
Note, selecting 'cuda-command-line-tools-10-0' for glob 'cuda*'
Note, selecting 'cuda-cufft-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-driver-dev-10-0' for glob 'cuda*'
Note, selecting 'cuda-memcheck-10-0' for glob 'cuda*'
Note, selecting 'cuda-gdb-src-10-0' for glob 'cuda*'
Note, selecting 'cuda-misc-headers-10-0' for glob 'cuda*'
Note, selecting 'cuda-cuobjdump-10-0' for glob 'cuda*'
Note, selecting 'cuda-nvprof-10-0' for glob 'cuda*'
cuda-toolkit-10-0 is already the newest version (10.0.326-1).
cuda-samples-10-0 is already the newest version (10.0.326-1).
cuda-samples-10-0 set to manually installed.
cuda-nvtx-10-0 is already the newest version (10.0.326-1).
cuda-nvtx-10-0 set to manually installed.
cuda-gdb-10-0 is already the newest version (10.0.326-1).
cuda-gdb-10-0 set to manually installed.
cuda-nvprof-10-0 is already the newest version (10.0.326-1).
cuda-nvprof-10-0 set to manually installed.
cuda-cudart-dev-10-0 is already the newest version (10.0.326-1).
cuda-cudart-dev-10-0 set to manually installed.
cuda-nvgraph-dev-10-0 is already the newest version (10.0.326-1).
cuda-nvgraph-dev-10-0 set to manually installed.
cuda-misc-headers-10-0 is already the newest version (10.0.326-1).
cuda-misc-headers-10-0 set to manually installed.
cuda-libraries-dev-10-0 is already the newest version (10.0.326-1).
cuda-libraries-dev-10-0 set to manually installed.
cuda-curand-dev-10-0 is already the newest version (10.0.326-1).
cuda-curand-dev-10-0 set to manually installed.
cuda-cuobjdump-10-0 is already the newest version (10.0.326-1).
cuda-cuobjdump-10-0 set to manually installed.
cuda-nvml-dev-10-0 is already the newest version (10.0.326-1).
cuda-nvml-dev-10-0 set to manually installed.
cuda-cusparse-10-0 is already the newest version (10.0.326-1).
cuda-cusparse-10-0 set to manually installed.
cuda-cupti-10-0 is already the newest version (10.0.326-1).
cuda-cupti-10-0 set to manually installed.
cuda-cufft-dev-10-0 is already the newest version (10.0.326-1).
cuda-cufft-dev-10-0 set to manually installed.
cuda-command-line-tools-10-0 is already the newest version (10.0.326-1).
cuda-command-line-tools-10-0 set to manually installed.
cuda-cusolver-dev-10-0 is already the newest version (10.0.326-1).
cuda-cusolver-dev-10-0 set to manually installed.
cuda-cusolver-10-0 is already the newest version (10.0.326-1).
cuda-cusolver-10-0 set to manually installed.
cuda-nvdisasm-10-0 is already the newest version (10.0.326-1).
cuda-nvdisasm-10-0 set to manually installed.
cuda-nvprune-10-0 is already the newest version (10.0.326-1).
cuda-nvprune-10-0 set to manually installed.
cuda-nvrtc-dev-10-0 is already the newest version (10.0.326-1).
cuda-nvrtc-dev-10-0 set to manually installed.
cuda-documentation-10-0 is already the newest version (10.0.326-1).
cuda-documentation-10-0 set to manually installed.
cuda-gpu-library-advisor-10-0 is already the newest version (10.0.326-1).
cuda-gpu-library-advisor-10-0 set to manually installed.
cuda-cufft-10-0 is already the newest version (10.0.326-1).
cuda-cufft-10-0 set to manually installed.
cuda-nvcc-10-0 is already the newest version (10.0.326-1).
cuda-nvcc-10-0 set to manually installed.
cuda-cublas-dev-10-0 is already the newest version (10.0.326-1).
cuda-cublas-dev-10-0 set to manually installed.
cuda-license-10-0 is already the newest version (10.0.326-1).
cuda-license-10-0 set to manually installed.
cuda-cublas-10-0 is already the newest version (10.0.326-1).
cuda-cublas-10-0 set to manually installed.
cuda-npp-dev-10-0 is already the newest version (10.0.326-1).
cuda-npp-dev-10-0 set to manually installed.
cuda-memcheck-10-0 is already the newest version (10.0.326-1).
cuda-memcheck-10-0 set to manually installed.
cuda-curand-10-0 is already the newest version (10.0.326-1).
cuda-curand-10-0 set to manually installed.
cuda-nvgraph-10-0 is already the newest version (10.0.326-1).
cuda-nvgraph-10-0 set to manually installed.
cuda-compiler-10-0 is already the newest version (10.0.326-1).
cuda-compiler-10-0 set to manually installed.
cuda-nsight-compute-addon-l4t-10-0 is already the newest version (10.0.326-1).
cuda-nsight-compute-addon-l4t-10-0 set to manually installed.
cuda-driver-dev-10-0 is already the newest version (10.0.326-1).
cuda-driver-dev-10-0 set to manually installed.
cuda-nvrtc-10-0 is already the newest version (10.0.326-1).
cuda-nvrtc-10-0 set to manually installed.
cuda-cudart-10-0 is already the newest version (10.0.326-1).
cuda-cudart-10-0 set to manually installed.
cuda-cusparse-dev-10-0 is already the newest version (10.0.326-1).
cuda-cusparse-dev-10-0 set to manually installed.
cuda-npp-10-0 is already the newest version (10.0.326-1).
cuda-npp-10-0 set to manually installed.
cuda-tools-10-0 is already the newest version (10.0.326-1).
cuda-tools-10-0 set to manually installed.
cuda-repo-l4t-10-0-local-10.0.326 is already the newest version (1.0-1).
The following packages were automatically installed and are no longer required:
  apt-clone archdetect-deb bogl-bterm busybox-static cryptsetup-bin dpkg-repack gir1.2-timezonemap-1.0
  gir1.2-xkl-1.0 grub-common kde-window-manager kinit kio kpackagetool5 kwayland-data kwin-common kwin-data
  kwin-x11 libdebian-installer4 libkdecorations2-5v5 libkdecorations2private5v5 libkf5activities5
  libkf5attica5 libkf5completion-data libkf5completion5 libkf5declarative-data libkf5declarative5
  libkf5doctools5 libkf5globalaccel-data libkf5globalaccel5 libkf5globalaccelprivate5 libkf5idletime5
  libkf5jobwidgets-data libkf5jobwidgets5 libkf5kcmutils-data libkf5kcmutils5 libkf5kiocore5 libkf5kiontlm5
  libkf5kiowidgets5 libkf5newstuff-data libkf5newstuff5 libkf5newstuffcore5 libkf5package-data
  libkf5package5 libkf5plasma5 libkf5quickaddons5 libkf5solid5 libkf5solid5-data libkf5sonnet5-data
  libkf5sonnetcore5 libkf5sonnetui5 libkf5textwidgets-data libkf5textwidgets5 libkf5waylandclient5
  libkf5waylandserver5 libkf5xmlgui-bin libkf5xmlgui-data libkf5xmlgui5 libkscreenlocker5
  libkwin4-effect-builtins1 libkwineffects11 libkwinglutils11 libkwinxrenderutils11 libqgsttools-p1
  libqt5designer5 libqt5help5 libqt5multimedia5 libqt5multimedia5-plugins libqt5multimediaquick-p5
  libqt5multimediawidgets5 libqt5opengl5 libqt5positioning5 libqt5printsupport5 libqt5qml5 libqt5quick5
  libqt5quickwidgets5 libqt5sensors5 libqt5sql5 libqt5test5 libqt5webchannel5 libqt5webkit5
  libxcb-composite0 libxcb-cursor0 libxcb-damage0 os-prober python3-dbus.mainloop.pyqt5 python3-icu
  python3-pam python3-pyqt5 python3-pyqt5.qtsvg python3-pyqt5.qtwebkit python3-sip
  qml-module-org-kde-kquickcontrolsaddons qml-module-qtmultimedia qml-module-qtquick2 rdate tasksel
  tasksel-data ubuntu-fan
Use 'sudo apt autoremove' to remove them.
The following NEW packages will be installed:
  cuda-core-10-0 cuda-gdb-src-10-0 cuda-libraries-10-0 cuda-minimal-build-10-0
0 upgraded, 4 newly installed, 0 to remove and 276 not upgraded.
Need to get 0 B/35.3 MB of archives.
After this operation, 36.4 MB of additional disk space will be used.
Do you want to continue? [Y/n] Y
Get:1 file:/var/cuda-repo-10-0-local-10.0.326  cuda-core-10-0 10.0.326-1 [2,606 B]
Get:2 file:/var/cuda-repo-10-0-local-10.0.326  cuda-gdb-src-10-0 10.0.326-1 [35.3 MB]
Get:3 file:/var/cuda-repo-10-0-local-10.0.326  cuda-libraries-10-0 10.0.326-1 [2,578 B]
Get:4 file:/var/cuda-repo-10-0-local-10.0.326  cuda-minimal-build-10-0 10.0.326-1 [2,554 B]
debconf: delaying package configuration, since apt-utils is not installed
Selecting previously unselected package cuda-core-10-0.
(Reading database ... 137992 files and directories currently installed.)
Preparing to unpack .../cuda-core-10-0_10.0.326-1_arm64.deb ...
Unpacking cuda-core-10-0 (10.0.326-1) ...
Selecting previously unselected package cuda-gdb-src-10-0.
Preparing to unpack .../cuda-gdb-src-10-0_10.0.326-1_arm64.deb ...
Unpacking cuda-gdb-src-10-0 (10.0.326-1) ...
Selecting previously unselected package cuda-libraries-10-0.
Preparing to unpack .../cuda-libraries-10-0_10.0.326-1_arm64.deb ...
Unpacking cuda-libraries-10-0 (10.0.326-1) ...
Selecting previously unselected package cuda-minimal-build-10-0.
Preparing to unpack .../cuda-minimal-build-10-0_10.0.326-1_arm64.deb ...
Unpacking cuda-minimal-build-10-0 (10.0.326-1) ...
Setting up cuda-gdb-src-10-0 (10.0.326-1) ...
*** LICENSE AGREEMENT ***
By using this software you agree to fully comply with the terms and
conditions of the EULA (End User License Agreement). The EULA is located
at /usr/local/cuda-10.0/doc/EULA.txt. The EULA can also be found at
http://docs.nvidia.com/cuda/eula/index.html. If you do not agree to the
terms and conditions of the EULA, do not use the software.

Setting up cuda-minimal-build-10-0 (10.0.326-1) ...
Setting up cuda-core-10-0 (10.0.326-1) ...
WARN: Package cuda-core-10-0 has been deprecated.
      Please install cuda-compiler-10-0 instead.

Setting up cuda-libraries-10-0 (10.0.326-1) ...
```

```
jetson@jetson-desktop:~$ sudo docker run -itd --gpus all -p 5000:5000 nvidia/digits
Unable to find image 'nvidia/digits:latest' locally
latest: Pulling from nvidia/digits
99ad4e3ced4d: Pull complete
ec5a723f4e2a: Pull complete
2a175e11567c: Pull complete
8d26426e95e0: Pull complete
46e451596b7c: Pull complete
79f02f6ab059: Pull complete
59d2eaa1372d: Pull complete
4421cd6e3c30: Pull complete
9a47758649e5: Pull complete
ce8dfeeea4e7: Pull complete
0a4202988172: Pull complete
505bc2c93c81: Pull complete
18dccdda6b6e: Pull complete
a0dbf08682d2: Pull complete
2795e82bc224: Pull complete
a5f44492569e: Pull complete
e10245179830: Pull complete
Digest: sha256:9b37921080efcedb93e1cd138b8981de14c65ca4cdb2dbcbb465d02a0fb6a513
Status: Downloaded newer image for nvidia/digits:latest
539d1440c92563913c787de894f02e68c60aa4edb79571d7b56e29732408901d
jetson@jetson-desktop:~$
```

```
jetson@jetson-desktop:~$ sudo docker run -it --runtime nvidia devicequery
./deviceQuery Starting...

 CUDA Device Query (Runtime API) version (CUDART static linking)

Detected 1 CUDA Capable device(s)

Device 0: "NVIDIA Tegra X1"
  CUDA Driver Version / Runtime Version          10.0 / 10.0
  CUDA Capability Major/Minor version number:    5.3
  Total amount of global memory:                 3956 MBytes (4148543488 bytes)
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

deviceQuery, CUDA Driver = CUDART, CUDA Driver Version = 10.0, CUDA Runtime Version = 10.0, NumDevs = 1
Result = PASS
jetson@jetson-desktop:~$
```

[Next >> Installing K3s on Jetson Nano]()
