# Installing Docker Community Edition on RHEL 7.x


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Linux System</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Install Red Hat Enterprise Linux on your system


## Steps

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast
```


** Please Note:

Before you install Docker, you need to install "container-selinux", "container-selinux" package. It  is available from the rhel-7-server-extras-rpms . You might need to enable that in 7.x


```
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras
```

## Install the latest version of Docker CE on RHEL:

```
sudo yum -y install docker-ce
```

Alternatively, you can specify a specific version of Docker CE:


```
sudo yum -y install docker-ce-<version>-<release>
```

## Initiating Docker Service:

```
sudo systemctl start docker
```

## Testing your Docker CE installation:

```
sudo docker run hello-world
```

## Contributor


