# The Better Way To Deploy Your Production web services With Docker & Docker compose, Docker Netwoking 

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
    <td class="tg-yw4l"><b>10 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side



in this artical i'm going to show you the better way to deploy our production web services,in basically we are going to see technique of running multiple production container using docker.
when you do dockering in day to day work than you can come across with docker compose really docker is magical tool !!
We are gifted with tools in this modern era and we should utilize them to deliver services seamlessly.

## Traditional approach (Know the existing things)

![webservice1](https://github.com/sangam14/web_services/blob/master/web-services2.png)
<br>
In old approach, these pieces are installed on a VPS.<br>
1.Application Server (Node JS, Java or Python)<br>
2.Proxy Server (Apache, Nginx)<br>
3.Cache Server (Redis, Memcached)<br>
4.Database Server(MySQL, PostgreSQL and MongoDB etc)<br>

in the old approad not preffered bacause of cutomation is taking place everyone using CI/CD deployemnet.we can also capture a snapshot of given eniroment to reduce risk into wrong set of condition deploying services.

according to microservice, the tightly coupled logiic and deploy them separately. its means in above diagram the every application server in more independent and talk via HTTP or RPC. but its doesn't mean you need to choose X number of VPS instane to run services.

but container provide nice way to simulate and and isolation feature within same machine or server.its era of containerization 
If you wrote a service and planning to deploy it on AWS EC2 or any cloud VPS, don’t deploy your stuff as a single big chunk. Instead, run that distributed code in the containers. We are going to see how to containerize our deployment using Docker and Docker Compose.

lets see in practical.
![](https://github.com/sangam14/web_services/blob/master/web-service3.png)
Steps to follow:


Clone the Repository:

```
git clone https://github.com/sangam14/web_services.git
```

Change directory to dockerapp1 as shown below:


```
cd webservices 
```

Bringing up app using Docker Compose:
 
```
docker-compose up 
```

for [PWD](https://labs.play-with-docker.com/) click on port you will get health check page 

![](https://github.com/sangam14/web_services/blob/master/web-service-4.png)


health check by curl 

```
$ curl http://localhost/api/v1/healthcheck
"2018-11-01T03:26:07.605Z/"
```
## Important thing

If you see, we are creating a simple express service with a health check endpoint.
```
https://github.com/sangam14/web_services/blob/master/app/server.js

```

we are added nginx configuration file.
```
https://github.com/sangam14/web_services/blob/master/nginx/default.conf
```

```
upstream service { 
    server app:8080;
}
```
nginx and app both are bridged using mynetwork, one can access another by the service name. So DNS is already taken care by docker. If this privilege is not available, we need to hard code IP in Nginx configuration file or assign a static IP from the subnet in the docker-compose.yam file. This is a wonderful thing about docker networking.

```
version: "2"
services:
    nginx:
        build: ./nginx
        ports:
          - "80:80"
        networks:
          - mynetwork
    app:
        build: ./app
        networks:
          - mynetwork
        expose: 
          - 8080
networks:
    mynetwork: 
        driver: bridge
```

![webservice1](https://github.com/sangam14/web_services/blob/master/web-services1.png)
By default, all the containers we create will fall under the same Internal IP range(Subnet). Docker networking allows us to create custom networks with additional properties like automatic DNS resolution etc.

In the above YAML file, we are creating a network called mynetwork. The services(containers) app and nginx will lie in the same subnet and can communicate to each other without the need of exposing the web service container to the outside world. In this way, we can make a single entry point to our web service that is through the Nginx service. If anyone tries to access app service directly they cannot do it because it is hidden. This actually secures our application.

## Contributor - 

Sangam biradar - smbiradar14@gmail.com -www.codexplus.in 
