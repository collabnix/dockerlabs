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
  PS C:\Users\Ajeet_Raina> docker run --rm mplatform/mquery hello-world
Unable to find image 'mplatform/mquery:latest' locally
C:\Program Files\Docker\Docker\Resources\bin\docker.exe: Error response from daemon: Get https://registry
/: dial tcp: lookup registry-1.docker.io: no such host.
See 'C:\Program Files\Docker\Docker\Resources\bin\docker.exe run --help'.
PS C:\Users\Ajeet_Raina>
```

Surprisingly, there is NO image as such.



  
