# Using Docker Network


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side


## Instructions

 - Display all the existent networks in the host:

```
$ docker network ls
```

 - Let's create a new bridge network:

```
$ docker network create -d bridge my-bridge-network
```

 - Run a container linked to the created network:
```
$ docker run -d -p 8081:8081 -e "port=8081" --name app --network=my-bridge-network selaworkshops/python-app:2.0
```

 - Find the container internal ip using:

```
$ docker inspect app
```

```
"Networks": {
                "my-bridge-network": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": [
                        "cf148e899ea8"
                    ],
                    "NetworkID": "82057fd5c45f1d62b0a96ac905af529ef6715e9f1038e6307f83b6698717dcfa",
                    "EndpointID": "24c5ac91c33c089427cf2f81cdc09c3ee4db09ecc0cb3b8298ba223689c10f4a",
                    "Gateway": "172.21.0.1",
                    "IPAddress": "172.21.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:15:00:02",
                    "DriverOpts": null
                }
            }
```

 - Write down the IPAddress of "my-bridge-network" (you may have diffrent address than the above)
 - Open a new terminal windows and run an ubuntu container in interactive mode:

```
$ docker run -it --name client alpine:latest
```

 - Install curl in the client container:

```
$ apk --no-cache add curl  
```

 - From the client container terminal try to browse to the app container:
 (change the IP Address accordingly)

```
$ curl 172.21.0.2:8081 --connect-timeout 5
```

 - You will get no access and the connection will be terminated due to timeout 

```
$ curl: (28) Connection timed out after 5000 milliseconds
```

 - From the regular terminal run the command below to attach the client container to the created network:

```
$ docker network connect my-bridge-network client
```

 - From the client container terminal try to browse to the app container again:
 (change the IP Address accordingly)

```
$ curl 172.21.0.2:8081 --connect-timeout 5
```

```
<h1>Python App</h1>
```

 - Inspect the network from the regular terminal and look for the linked containers:

```
$ docker inspect my-bridge-network
```

```
"Containers": {
            "793a39c035a8988c1768f6061f1721ac124293502edb46ed16e06111f9bdbd61": {
                "Name": "client",
                "EndpointID": "1e2b7be275a10962c105fe01a85254ebb69dab33a60b1d9d9bc23bcfef1f337d",
                "MacAddress": "02:42:ac:15:00:03",
                "IPv4Address": "172.21.0.3/16",
                "IPv6Address": ""
            },
            "cf148e899ea8e91d9b12e2f1333bdbb144cebca9e088e6e5bfec63dd48c33ab8": {
                "Name": "app",
                "EndpointID": "24c5ac91c33c089427cf2f81cdc09c3ee4db09ecc0cb3b8298ba223689c10f4a",
                "MacAddress": "02:42:ac:15:00:02",
                "IPv4Address": "172.21.0.2/16",
                "IPv6Address": ""
            }
        },
```

 - Disconnect both containers from the created network (regular terminal):

```
$ docker network disconnect my-bridge-network app
$ docker network disconnect my-bridge-network client
```

 - Delete the network:

```
$ docker network rm my-bridge-network
```

 - Ensure that the network was deleted:

```
$ docker network ls
```

 - Exit from the client container and close the terminal:

```
$ exit
$ exit
```
Next >> [Lab #1: Listing the Networks](http://dockerlabs.collabnix.com/networking/A1-network-basics.html#step-2-list-networks)
