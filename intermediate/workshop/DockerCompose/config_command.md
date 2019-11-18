# Lab #3: Config Command
The `docker-compose config` command validate the docker-compose file and view the compose file.

## Pre-requisite:

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

# Assignment
- Create a docker-compose.yml file
- Validate the docker-compose file
- Testing docker-compose config with wrong config



### Create a docker-compose.yml file

Copy the below contents:

```
version: '3.1'
services:
  #Nginx Service
   webserver:
     image: nginx:alpine
     container_name: webserver
     restart: unless-stopped
     ports:
       - "80:80"
       - "443:443"
```

Or Clone the repository:

```
git clone https://github.com/collabnix/dockerlabs
cd intermediate/workshop/compose/lab/3/config/
cat docker-compose.yml
```


### Validate the docker-compose file
```
$ docker-compose config
services:
  webserver:
    container_name: webserver
    image: nginx:alpine
    ports:
    - 80:80/tcp
    - 443:443/tcp
    restart: unless-stopped
version: '3.1'
```
### Testing docker-compose config with wrong config
Lets just change the instruction `services` to `service` and test.
```
$docker-compose config

ERROR: The Compose file './docker-compose.yml' is invalid because:
Invalid top-level property "service". Valid top-level sections for this Compose file are: services, secrets, version, networks, volumes, and extensions starting with "x-".

You might be seeing this error because you're using the wrong Compose file version. Either specify a supported version (e.g "2.2" or "3.3") and place your service definitions under the `services` key, or omit the `version` key and place your service definitions at the root of the file to use version 1.
For more on the Compose file format versions, see https://docs.docker.com/compose/compose-file/
```

## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [Lab #4: Build Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/Lab_%231:Build_Command.html)
