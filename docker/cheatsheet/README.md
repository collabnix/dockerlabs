# The Ultimate Docker Cheat Sheet

<br> <br> 

## Complete Docker CLI 

![full](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet8.png)

<br>
<br>

## Container Management CLIs

<br>


![container_management](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet1.png)

## Inspecting The Container 
<br>

![Inspecting The Container](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet3.png)

## Interacting with Container
![Interacting with Container1](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet4.png)

## Image Management Commands 
<br>

 ![image management commands](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet5.png)
 
## Image Transfer Commands 
 <br>
 
 ![Image Transfer Comnands](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet6.png)


## Builder Main Commands
<br>

![Builder Main Commands](https://raw.githubusercontent.com/sangam14/dockercheatsheets/master/dockercheatsheet7.png)





## The Docker CLI 

<br>

Manage images
-------------
<br>

### `docker build`
<br>

```yml
docker build [options] .
  -t "app/container_name"    # name
```

Create an `image` from a Dockerfile.


### `docker run`
<br>

```yml
docker run [options] IMAGE
  # see `docker create` for options
```

Run a command in an `image`.

Manage containers
-----------------

<br>

### `docker create`
<br>

```yml
docker create [options] IMAGE
  -a, --attach               # attach stdout/err
  -i, --interactive          # attach stdin (interactive)
  -t, --tty                  # pseudo-tty
      --name NAME            # name your image
  -p, --publish 5000:5000    # port map
      --expose 5432          # expose a port to linked containers
  -P, --publish-all          # publish all ports
      --link container:alias # linking
  -v, --volume `pwd`:/app    # mount (absolute paths needed)
  -e, --env NAME=hello       # env vars
```

#### Example
<br>

```
$ docker create --name app_redis_1 \
  --expose 6379 \
  redis:3.0.2
```

Create a `container` from an `image`.

### `docker exec`
<br>

```yml
docker exec [options] CONTAINER COMMAND
  -d, --detach        # run in background
  -i, --interactive   # stdin
  -t, --tty           # interactive
```

#### Example

```
$ docker exec app_web_1 tail logs/development.log
$ docker exec -t -i app_web_1 rails c
```

Run commands in a `container`.


### `docker start`

```yml
docker start [options] CONTAINER
  -a, --attach        # attach stdout/err
  -i, --interactive   # attach stdin

docker stop [options] CONTAINER
```

Start/stop a `container`.


### `docker ps`

```
$ docker ps
$ docker ps -a
$ docker kill $ID
```

Manage `container`s using ps/kill.

Images
------

### `docker images`

```sh
$ docker images
  REPOSITORY   TAG        ID
  ubuntu       12.10      b750fe78269d
  me/myapp     latest     7b2431a8d968
```

```sh
$ docker images -a   # also show intermediate
```

Manages `image`s.

### `docker rmi`

```yml
docker rmi b750fe78269d
```

Deletes `image`s.

Also see
--------

 * [Getting Started](http://www.docker.io/gettingstarted/) _(docker.io)_
 
 
# Dockerfile

### Inheritance

```docker
FROM ruby:2.2.2
```

### Variables

```docker
ENV APP_HOME /myapp
RUN mkdir $APP_HOME
```

### Initialization

```docker
RUN bundle install
```

```docker
WORKDIR /myapp
```

```docker
VOLUME ["/data"]
# Specification for mount point
```

```docker
ADD file.xyz /file.xyz
COPY --chown=user:group host_file.xyz /path/container_file.xyz
```

### Onbuild

```docker
ONBUILD RUN bundle install
# when used with another file
```

### Commands

```docker
EXPOSE 5900
CMD    ["bundle", "exec", "rails", "server"]
```

### Entrypoint

```docker
ENTRYPOINT ["executable", "param1", "param2"]
ENTRYPOINT command param1 param2
```

Configures a container that will run as an executable.

```docker
ENTRYPOINT exec top -b
```

This will use shell processing to substitute shell variables, and will ignore any `CMD` or `docker run` command line arguments.

### Metadata

```docker
LABEL version="1.0"
```

```docker
LABEL "com.example.vendor"="ACME Incorporated"
LABEL com.example.label-with-value="foo"
```

```docker
LABEL description="This text illustrates \
that label-values can span multiple lines."
```

## See also

- <https://docs.docker.com/engine/reference/builder/>


# docker-compose


### Basic example

```yaml
# docker-compose.yml
version: '2'

services:
  web:
    build: .
    # build from Dockerfile
    context: ./Path
    dockerfile: Dockerfile
    ports:
     - "5000:5000"
    volumes:
     - .:/code
  redis:
    image: redis
```

### Commands

```sh
docker-compose start
docker-compose stop
```

```sh
docker-compose pause
docker-compose unpause
```

```sh
docker-compose ps
docker-compose up
docker-compose down
```

## Reference
{: .-three-column}

### Building

```yaml
web:
  # build from Dockerfile
  build: .
```

```yaml
  # build from custom Dockerfile
  build:
    context: ./dir
    dockerfile: Dockerfile.dev
```

```yaml
  # build from image
  image: ubuntu
  image: ubuntu:14.04
  image: tutum/influxdb
  image: example-registry:4000/postgresql
  image: a4bc65fd
```

### Ports

```yaml
  ports:
    - "3000"
    - "8000:80"  # guest:host
```

```yaml
  # expose ports to linked services (not to host)
  expose: ["3000"]
```

### Commands

```yaml
  # command to execute
  command: bundle exec thin -p 3000
  command: [bundle, exec, thin, -p, 3000]
```

```yaml
  # override the entrypoint
  entrypoint: /app/start.sh
  entrypoint: [php, -d, vendor/bin/phpunit]
```

### Environment variables

```yaml
  # environment vars
  environment:
    RACK_ENV: development
  environment:
    - RACK_ENV=development
```

```yaml
  # environment vars from file
  env_file: .env
  env_file: [.env, .development.env]
```

### Dependencies

```yaml
  # makes the `db` service available as the hostname `database`
  # (implies depends_on)
  links:
    - db:database
    - redis
```

```yaml
  # make sure `db` is alive before starting
  depends_on:
    - db
```

### Other options

```yaml
  # make this service extend another
  extends:
    file: common.yml  # optional
    service: webapp
```

```yaml
  volumes:
    - /var/lib/mysql
    - ./_data:/var/lib/mysql
```

## Advanced features


### Labels

```yaml
services:
  web:
    labels:
      com.example.description: "Accounting web app"
```

### DNS servers

```yaml
services:
  web:
    dns: 8.8.8.8
    dns:
      - 8.8.8.8
      - 8.8.4.4
```

### Devices

```yaml
services:
  web:
    devices:
    - "/dev/ttyUSB0:/dev/ttyUSB0"
```

### External links

```yaml
services:
  web:
    external_links:
      - redis_1
      - project_db_1:mysql
```

### Hosts

```yaml
services:
  web:
    extra_hosts:
      - "somehost:192.168.1.100"
```

### sevices 
To view list of all the services runnning in swarm 

```
docker service ls 

```
To see all running services 

```
docker stack services stack_name
```
to see all services logs 

```
docker service logs stack_name service_name 
```
To scale services quickly across qualified node 
```
docker service scale stack_name_service_name=replicas
```
### clean up 

To clean or prune unused (dangling) images
```
docker image prune 
```
To remove all images which are not in use containers , add - a 
```
docker image prune -a 
```
To prune your entire system 
```
docker system prune 
```
To leave swarm 
```
docker swarm leave  
```
To remove swarm ( deletes all volume data and database info)
```
docker stack rm stack_name  
```
To kill all running containers 
```
docker kill $(docekr ps -q ) 
```


## Contributor - 

[Sangam biradar](https://twitter.com/BiradarSangam) - Docker Community Leader 


