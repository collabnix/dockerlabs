# Switching to Windows Container under Docker Desktop for Windows

Docker Desktop for Windows is Docker designed to run on Windows 10. It is a native Windows application that provides an easy-to-use development environment for building, shipping, and running dockerized apps. Docker Desktop for Windows uses Windows-native Hyper-V virtualization and networking and is the fastest and most reliable way to develop Docker apps on Windows. 
Docker Desktop for Windows supports running both Linux and Windows Docker containers.

```
PS C:\Users\Ajeet_Raina> docker version
Client: Docker Engine - Community
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        6247962
 Built:             Sun Feb 10 04:12:31 2019
 OS/Arch:           windows/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.24)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 04:28:48 2019
  OS/Arch:          windows/amd64
  Experimental:     false
  ```
  
 ## Verify if we have mplatform/mquery image built on top of Windows Platform
 
 ```
  Unable to find image 'mplatform/mquery:latest' locally
latest: Pulling from mplatform/mquery
db6020507de3: Pull complete
f11a2bcbeb86: Pull complete
Digest: sha256:e15189e3d6fbcee8a6ad2ef04c1ec80420ab0fdcf0d70408c0e914af80dfb107
Status: Downloaded newer image for mplatform/mquery:latest
Image: hello-world
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v5
   - linux/arm/v7
   - linux/arm64
   - linux/386
   - linux/ppc64le
   - linux/s390x
   - windows/amd64:10.0.14393.2551
   - windows/amd64:10.0.16299.846
   - windows/amd64:10.0.17134.469
   - windows/amd64:10.0.17763.194
```





  
