# Running a WordPress Blog Using Two Linked Containers(Single Node Cluster)

```docker
$ docker pull wordpress:latest
```

```docker
$ docker pull mysql:latest
```

```docker
$ docker images
REPOSITORY TAG IMAGE ID CREATED VIRTUAL SIZE
mysql latest 9def920de0a2 4 days ago 282.9 MB
wordpress latest 93acfaf85c71 8 days ago 472.8 MB
```

Start a MySQL container, give it a name via the --name CLI option, and set the environment variables.

## Running MYSQL Container

```docker
$ docker run --name mysqlwp -e MYSQL_ROOT_PASSWORD=wordpressdocker \
-e MYSQL_DATABASE=wordpress \
-e MYSQL_USER=wordpress \
-e MYSQL_PASSWORD=wordpresspwd \
-d mysql
```

## Running WordPress and linking it to MYSQL

```docker
docker run --name wordpress --link mysqlwp:mysql -p 80:80 \
-e WORDPRESS_DB_NAME=wordpress \
-e WORDPRESS_DB_USER=wordpress \
-e WORDPRESS_DB_PASSWORD=wordpresspwd \
-d wordpress
```

## How to Backup MySQL Data

Starting from the Recipe 1.16, where you set up a WordPress site by using two linked containers, you are going to modify the way you start the MySQL container. Once the containers are started and you have a fully functional WordPress site, you can stop the containers, which stops your application.

At that point, the containers have not been removed entirely yet and the data in the database is still accessible. However, as soon as you remove the containers `(docker rm $(docker ps -aq))`, all data will be
lost.

A way to keep the data, even when containers are removed with the `docker rm -v` command, is to mount a volume from your Docker host inside a container. If you were to delete the MySQL container with only the docker rm command, the volume defined by the image would still persist even if you delete the container. If you look at the Dockerfile used to build the MySQL image, you sill see a reference to `VOLUME /var/lib/mysql`. This means that when you start a container based on this image, you can bind mount a host directory to this mount point inside the container.

Let’s do it:

```docker
$ docker run --name mysqlwp -e MYSQL_ROOT_PASSWORD=wordpressdocker \
-e MYSQL_DATABASE=wordpress \
-e MYSQL_USER=wordpress \
-e MYSQL_PASSWORD=wordpresspwd \
-v /home/docker/mysql:/var/lib/mysql \
-d mysql
```

> Note the `-v /home/docker/mysql:/var/lib/mysql` line that performs this mount.

After doing the WordPress configuration, the /home/docker/mysql directory on the host is populated:

```docker
$ ls mysql/
auto.cnf ibdata1 ib_logfile0 ib_logfile1 mysql performance_schema wordpress
```

To get a dump of the entire MySQL database, use the docker exec command to run `mysqldump` inside the container:

```docker
$ docker exec mysqlwp mysqldump --all-databases \
--password=wordpressdocker > wordpress.backup
```

You can then use the traditional techniques for backup and recovery of the database. For instance, in the cloud, you might want to use an Elastic Block Store (e.g., AWS EBS) mounted on an instance and then mounted inside a container. You can also keep your MySQL dumps inside an Elastic Storage (e.g., AWS S3).
