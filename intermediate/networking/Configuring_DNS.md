# Configuring DNS

How to customize the host name and DNS of the configuration container? The secret is that Docker uses virtual files to mount three related configuration files for the container.

Use the `mount` command in the container to see the mount information:

 ```$ mount /dev/disk/by-uuid/1fec...ebdf on /etc/hostname type ext4 ... /dev/disk/by-uuid/1fec...ebdf on /etc/hosts type ext4 ... tmpfs on /etc/resolv.conf type tmpfs ... ```

- This mechanism allows the DNS configuration of all Docker containers to be updated immediately after the host host's DNS information is updated via the``` /etc/resolv.conf ```file.

Configure DNS for all containers, or add the following to the ```/etc/docker/daemon.json``` file to set it up.
```
 { "dns" : [ "114.114.114.114" , "8.8.8.8" ] } 
 ```
This way the container DNS is automatically configured to 114.114.114.114 and 8.8.8.8 each time it is started. Use the following command to prove that it has taken effect.
```
 $ docker run -it --rm ubuntu:18.04 cat etc/resolv.conf nameserver 114.114.114.114 nameserver 8.8.8.8 
 ```
If the user wants to manually specify the configuration of the container, you can add the following parameters when starting the container with the ```docker run ```command:

```-h HOSTNAME ```or ```--hostname=HOSTNAME ```sets the hostname of the container, which will be written to``` /etc/hostname``` and``` /etc/hosts ```container. But it is not docker container ls , neither in the docker container ls nor in the other container's ```/etc/hosts``` .

```--dns=IP_ADDRESS ```Add the DNS server to the ```/etc/resolv.conf``` of the container and let the container use this server to resolve all hostnames that are not in``` /etc/hosts``` .

```--dns-search=DOMAIN ```sets the search domain of the container. When the search domain is set to .example.com , when searching for a host named host, DNS not only searches for host but also searches for``` host.example.com``` .

Note: If the last two parameters are not specified when the container starts, Docker will default to configuring the container with``` /etc/resolv.conf``` on the host.


## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)
