# What to expect without correct setup
```
$ docker run -it --rm --gpus all debian
docker: Error response from daemon: linux runtime spec devices: could not select device driver "" with capabilities: [[gpu]].
```
This means that nvidia could not properly register with docker. Usually because the drivers are not properly installed on the host. This could also mean the nvidia container tools were installed without restarting the docker daemon: you need to restart the docker daemon.

# Pre-setup: provisioning a GPU node with correct drivers
Spin up a machine with GPU, on AWS EC2 `g2.2xlarge` with Ubuntu should work fine. Tested on 16.04 xenial but feel free to test other OSes.

## Verify that Nvidia GPU is available by running:

```
sudo lspci | grep -i nvidia
00:03.0 VGA compatible controller: NVIDIA Corporation GK104GL [GRID K520] (rev a1)
```

## Install Nvidia drivers

- The official page is https://www.nvidia.com/Download/index.aspx but read on for a simpler way to install drivers on Ubuntu
- Canonical provides “magic driver install” that Nvidia doesn’t officially support but running the following as root worked for me:
```
sudo apt-get install ubuntu-drivers-common \
	&& sudo ubuntu-drivers autoinstall
```
- Reboot

# Additional setup for docker to work with Nvidia GPUs

This may or may not have been done already depending on whether you have already installed docker-nvidia or not.

Follow instructions at https://nvidia.github.io/nvidia-container-runtime/ to tap into Nvidia’s apt/yum repositories then run:

```
apt-get install nvidia-container-runtime
```

Make sure that nvidia-container-runtime-hook is accessible from $PATH:
```
$ which nvidia-container-runtime-hook
/usr/bin/nvidia-container-runtime-hook
```

Restart the docker daemon to pick up the nvidia driver.

# 99% usecase: use all GPUs

“Hello world”

```
$ docker run -it --rm --gpus all ubuntu nvidia-smi
Thu Apr  4 21:47:41 2019
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 384.130                Driver Version: 384.130                   |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GRID K520           Off  | 00000000:00:03.0 Off |                  N/A |
| N/A   36C    P0    39W / 125W |      0MiB /  4036MiB |      0%      Default |
+-------------------------------+----------------------+----------------------+
+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

# Specifying a particular device

```
$ docker run -it --rm --gpus device=GPU-3a23c669-1f69-c64e-cf85-44e9b07e7a2a ubuntu nvidia-smi
...
```
