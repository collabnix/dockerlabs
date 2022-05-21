# eXo Platform in a Docker Container!

In this article, we will see just how easy it is to execute the eXo Platform in a Docker container, to make your data persist across container restarts and to plug your eXo Platform deployment into a MySQL database.


To be able to test the content of this article, you need to have the following:

- Docker 1.11 and above (use Docker4Mac or Docker4Windows if you are on one of these two environments, which do not natively support Docker)
- Docker Compose 1.7 and above
- Internet access (for downloading Docker images)
- Coffee (because downloading Docker images can take longer than actually doing a build with Maven 😉 )


First of all, let’s make it simple and start the Community edition of the eXo Platform in a Docker container. For this, we will use the Docker image called exoplatform/exo-community with its default settings (the first run will of course take the longest because it involves downloading the container):


```sh
$ docker run -ti --rm --name exo \
$ -p 8080:8080 \
$ exoplatform/exo-community:4.3
```


After some time, you will see this message appear in the logs: Server startup in 58220 ms . This indicates that the eXo Platform is initialized and you can start testing your installation by pointing your browser to http://localhost:8080/.


What would happen now if you stop and recreate your container? The answer is your data will disappear because it has been stored directly within the container itself. To overcome this issue, we will use Docker volumes in order to maintain data outside the container. Let’s start by creating two volumes:
```sh
$ docker volume create --name=data
$ docker volume create --name=logs
```

```sh
$ docker run -ti --rm --name exo \
$  -p 8080:8080 \
$  -v data:/srv/exo \
$  -v logs:/var/log/exo \
$  exoplatform/exo-community:4.3
```
From now on, persistent eXo Platform data (including JCR indexes, Values Storage, etc.) will be stored in the data volume, while logs will go in the logs volume. So you can now stop and delete your container and, when starting a new one, find all of your data available. Is that it? Does this mean I can now move to production since my data can now survive container restarts? Certainly not yet as we still don’t have a database suitable for use in production. In fact, unless configured otherwise, our eXo Platform Docker image uses an HSQLDB database that works great for tests but should not be used in production. We will therefore use MySQL 5.5 as our production database. (Note that the eXo Platform does support other database solutions. See here.) Let’s first start our MySQL server in a Docker container:
# MySQL data volume creation
```sh
$ docker volume create --name=mysql_data
``` 
# MySQL server start with an exo schema
```sh
docker run -d --name mysql \
  -v mysql_data:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=my-secret-pw \
  -e MYSQL_DATABASE=exo \
  -e MYSQL_USER=exo \
  -e MYSQL_PASSWORD=exo \
  mysql:5.5
``` 
# Check MySQL logs
```sh
docker logs mysql
```
Now that the database is ready, we can start the eXo Platform while configuring the image so that it uses MySQL. This image, provided by eXo, provides a set of parameters allowing us to adapt the behavior of the image at the time the container is created. (For a detailed list of these parameters, you may refer to this online documentation.)
``` sh
# creating new clean volumes for eXo Platform persistent data
docker volume create --name=exo_data
docker volume create --name=exo_logs
 
# starting eXo Platform configured with MySQL
docker run -ti --rm --name exo \
  -p 8080:8080 \
  -v exo_data:/srv/exo \
  -v exo_logs:/var/log/exo \
  --link mysql:mysql \
  -e EXO_DB_TYPE=mysql \
  -e EXO_DB_NAME=exo \
  -e EXO_DB_USER=exo \
  -e EXO_DB_PASSWORD=exo \
  -e EXO_DB_HOST=mysql \
  -e EXO_ADDONS_LIST=exo-jdbc-driver-mysql \
  exoplatform/exo-community:4.3
``` 
There it is! A new instance of the eXo Platform now connected to a MySQL database. All your user data will of course survive any recreation of your container. Simply login to your new social intranet, invite other people and start collaborating.
So you’re running the eXo Platform in production and all is great. But let’s face it: startup is still a tad complicated. To further simplify this, we will use Docker Compose in order to be able to control our complete environment with one simple command.

``` sh
# stop eXo Platform running container
docker stop exo
 
# stop MySQL running container
docker stop mysql
docker rm mysql
``` 
To that end, let us first stop and delete all previously started containers:

``` sh
version: '2'
services:
  exo:
    image: exoplatform/exo-community:4.3
    environment:
      EXO_DB_TYPE: mysql
      EXO_DB_NAME: exo
      EXO_DB_USER: exo
      EXO_DB_PASSWORD: exo
      EXO_DB_HOST: mysql
      EXO_ADDONS_LIST: exo-jdbc-driver-mysql
    expose:
      - "8080"
    ports:
      - "8080:8080"
    volumes:
      - exo_data:/srv/exo
      - exo_logs:/var/log/exo
    links:
      - mysql
    depends_on:
      - mysql
  mysql:
    image: mysql:5.5
    environment:
      MYSQL_ROOT_PASSWORD: my-secret-pw
      MYSQL_DATABASE: exo
      MYSQL_USER: exo
      MYSQL_PASSWORD: exo
    volumes:
      - mysql_data:/var/lib/mysql
volumes:
  exo_data:
    external:
      name: exo_data
  exo_logs:
    external:
      name: exo_logs
  mysql_data:
    external:
      name: mysql_data
```
We can now start our whole setup (i.e., the MySQL database and the eXo Platform) with the following simple command:
``` sh
docker-compose -f ./docker-compose.yml up
```
