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



```
PS C:\Users\Ajeet_Raina> docker search microsoft
NAME                                       DESCRIPTION
           AUTOMATED
microsoft/dotnet                           Official images for
           [OK]
microsoft/mssql-server-linux               Official images for

microsoft/aspnet                           Microsoft IIS images
           [OK]
microsoft/windowsservercore                The official Windows

microsoft/aspnetcore                       Official images for
           [OK]
microsoft/nanoserver                       The official Nano Se

microsoft/iis                              Microsoft IIS images

microsoft/mssql-server-windows-developer   Official Microsoft S

microsoft/mssql-server-windows-express     Official Microsoft S

microsoft/aspnetcore-build                 Official images for
           [OK]
microsoft/azure-cli                        Official images for
           [OK]
microsoft/powershell                       PowerShell for every
           [OK]
microsoft/vsts-agent                       Official images for

microsoft/dynamics-nav                     Official images for

microsoft/dotnet-samples                   .NET Core Docker Sam
           [OK]
microsoft/bcsandbox                        Business Central San

microsoft/mssql-tools                      Official images for

microsoft/oms                              Monitor your contain
           [OK]
microsoft/cntk                             CNTK images from git
           [OK]
microsoft/wcf                              Microsoft WCF images

microsoft/dotnet-nightly                   Preview images for t
           [OK]
microsoft/dotnet-framework-build           The .NET Framework b
           [OK]
microsoft/mmlspark                         Microsoft Machine Le

microsoft/aspnetcore-build-nightly         Images to build prev
           [OK]
microsoft/cntk-nightly                     CNTK nightly image f

PS C:\Users\Ajeet_Raina>
```

```
PS C:\Users\Ajeet_Raina> docker-compose version
docker-compose version 1.23.2, build 1110ad01
docker-py version: 3.6.0
CPython version: 3.6.6
OpenSSL version: OpenSSL 1.0.2o  27 Mar 2018
PS C:\Users\Ajeet_Raina>

```

































































































































































```


  
