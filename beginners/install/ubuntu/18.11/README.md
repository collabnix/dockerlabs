# Installing Docker 18.06 CE on Ubuntu 18.11


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Google Cloud Platform</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with Google Cloud Engine (Free Tier)
- Pick up Ubuntu 18.10 as OS instance


## Installing Docker Community Editon 18.06

### Updating Ubuntu 18.11 Repository

```
$sudo apt update
```

### Using Snap to install Docker CE 18.06

```
$sudo snap install docker
```

```
$ sudo snap install docker
docker 18.06.1-ce from Docker, Inc (docker-inc) installed
```

```
$ sudo docker version
Client:
 Version:           18.06.1-ce
 API version:       1.38
 Go version:        go1.10.4
 Git commit:        e68fc7a
 Built:             Mon Oct  1 14:25:31 2018
 OS/Arch:           linux/amd64
 Experimental:      false
Server:
 Engine:
  Version:          18.06.1-ce
  API version:      1.38 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       e68fc7a
  Built:            Mon Oct  1 14:25:33 2018
  OS/Arch:          linux/amd64
  Experimental:     false
  ```
