# Verifying host-level settings that impact Docker networking


Docker relies on the host being capable of performing certain functions to make Docker networking work. Namely, your Linux host must be configured to allow IP forwarding. In
addition, since the release of Docker 1.7, you may now choose to use hairpin Network Address Translation (NAT) rather than the default Docker user land proxy. In this recipe, we'll
review the requirement for the host to have IP forwarding enabled. We'll also talk about NAT hairpin and discuss the host-level requirements for that option as well. In both cases, we'll
show Docker's default behavior with regard to its settings as well as how you can alter them.

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Ubuntu 18.04</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side

Most Linux distributions default the IP forward value to disabled or 0. Fortunately for us, in a default configuration, Docker takes care of updating this setting to the correct value
when the Docker service starts. For instance, let's take a look at a freshly rebooted host that doesn't have the Docker service enabled at boot time. If we check the value of the setting
before starting Docker, we can see that it's disabled. Starting the Docker engine automatically enables the setting for us:


```
user@docker1:~$ more /proc/sys/net/ipv4/ip_forward
0
```

```
user@docker1:~$ sudo systemctl start docker
```

```
user@docker1:~$ sysctl net.ipv4.ip_forward
net.ipv4.ip_forward = 1
```
