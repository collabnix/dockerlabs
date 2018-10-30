

Manage images
-------------

### `docker build`

```yml
docker build [options] .
  -t "app/container_name"    # name
```

Create an `image` from a Dockerfile.


### `docker run`

```yml
docker run [options] IMAGE
  # see `docker create` for options
```

Run a command in an `image`.

Manage containers
-----------------

### `docker create`

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

```
$ docker create --name app_redis_1 \
  --expose 6379 \
  redis:3.0.2
```

Create a `container` from an `image`.

### `docker exec`

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



# Docker Compose Cheat sheet

## Basic example

```
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

## Commands


```
docker-compose start
docker-compose stop
docker-compose pause
docker-compose unpause
docker-compose ps
docker-compose up
docker-compose down
```

# Reference

## Building

```
web:
# build from Dockerfile
 build: .
# build from custom Dockerfile
 build:
 context: ./dir
 dockerfile: Dockerfile.dev
# build from image
 image: ubuntu
 image: ubuntu:14.04
 image: tutum/influxdb
 image: example-registry:4000/postgresql
 image: a4bc65fd
```

## Ports

```
ports:
 - "3000"
 - "8000:80" # guest:host
# expose ports to linked services (not to host)
 expose: ["3000"]
 
## Commands
 command to execute
 command: bundle exec thin -p 3000
 command: [bundle, exec, thin, -p, 3000]
# override the entrypoint
 entrypoint: /app/start.sh
 entrypoint: [php, -d, vendor/bin/phpunit]
```

## Environment variables

```
# environment vars
 environment:
 RACK_ENV: development
 environment:
 - RACK_ENV=development
# environment vars from file
 env_file: .env
 env_file: [.env, .development.env]
```

## Dependencies

```
# makes the `db` service available as the hostname `database`
# (implies depends_on)
 links:
 - db:database
 - redis
# make sure `db` is alive before starting
 depends_on:
 - db
```

## Other options

```
# make this service extend another
 extends:
 file: common.yml # optional
 service: webapp
 volumes:
 - /var/lib/mysql
 - ./_data:/var/lib/mysql
```

## Advanced features

## Labels

```
services:
 web:
 labels:
 com.example.description: "Accounting web app
```

## DNS servers

```
services:
 web:
 dns: 8.8.8.8
 dns:
 - 8.8.8.8
 - 8.8.4.4
```

## Devices

```
services:
 web:
 devices:
 - "/dev/ttyUSB0:/dev/ttyUSB0"
```

## External links

```
services:
 web:
 external_links:
 - redis_1
 - project_db_1:mysql
```

## Hosts

```
services:
 web:
 extra_hosts:
 - "somehost:192.168.1.100"
 ```
 
## Contributors

Tathagata Sarkar
