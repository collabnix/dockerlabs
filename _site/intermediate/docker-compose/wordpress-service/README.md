# Running a Wordpress Service with MySQL Database

The docker-compose.yml file is as such:

```
  1 version: "3.2"
  2
  3 services:
  4  db:
  5   image: mysql:5.7
  6   restart: always
  7   volumes:
  8    - type: bind
  9      source: "db_data"
 10      target: "/var/lib/mysql"
 11   environment:
 12    MYSQL_ROOT_PASSWORD: db
 13    MYSQL_DATABASE: wordpress
 14  wordpress:
 15   image: wordpress:latest
 16   restart: always
 17   volumes:
 18    - type: bind
 19      source: "wp_data"
 20      target: "/var/www/html"
 21   ports:
 22    - "8080:80"
 23   environment:
 24    WORDPRESS_DB_HOST: db:3306
 25    WORDPRESS_DB_NAME: wordpress
 26    WORDPRESS_DB_USER: root
 27    WORDPRESS_DB_PASSWORD: db
 28   depends_on:
 29    - db
 30 volumes:
 31  db_data:
 32  wp_data:
 
```

To run the application:

```
$ ls
docker-compose.yml
[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose up -d
Creating network "wordpress-service_default" with the default driver
Creating volume "wordpress-service_db_data" with default driver
Creating volume "wordpress-service_wp_data" with default driver
Pulling db (mysql:5.7)...
5.7: Pulling from library/mysql
fc7181108d40: Pull complete
787a24c80112: Pull complete
a08cb039d3cd: Pull complete
4f7d35eb5394: Pull complete
5aa21f895d95: Pull complete
a742e211b7a2: Pull complete
0163805ad937: Pull complete
62d0ebcbfc71: Pull complete
559856d01c93: Pull complete
c849d5f46e83: Pull complete
f114c210789a: Pull complete
Pulling wordpress (wordpress:latest)...
latest: Pulling from library/wordpress
743f2d6c1f65: Pull complete
6307e89982cc: Pull complete
807218e72ce2: Pull complete
5108df1d03f8: Pull complete
901e0b6a7fe5: Pull complete
5ffe11e7ab2c: Pull complete
da5f7a507956: Pull complete
48ea1a967cbe: Pull complete
5713018ac172: Pull complete
262a3efdbbcd: Pull complete
ab9ac7d19374: Pull complete
a961ffd1454e: Pull complete
49b9eaee30fc: Pull complete
baf306c67506: Pull complete
49e88235b85c: Pull complete
01a12bfa7e4d: Pull complete
4d06dca1fe90: Pull complete
08bc76506436: Pull complete
ddf03088f1fc: Pull complete
Creating wordpress-service_db_1 ... done
Creating wordpress-service_wordpress_1 ... done
```

## Checking The Running Instances

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS
      NAMES
03f5e3bf6b3d        wordpress:latest    "docker-entrypoint.s…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/
tcp   wordpress-service_wordpress_1
8f9113611197        mysql:5.7           "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp, 33060/t
cp    wordpress-service_db_1



[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose ps
            Name                           Command               State          Ports
---------------------------------------------------------------------------------------------
wordpress-service_db_1          docker-entrypoint.sh mysqld      Up      3306/tcp, 33060/tcp
wordpress-service_wordpress_1   docker-entrypoint.sh apach ...   Up      0.0.0.0:8080->80/tcp



[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose top
wordpress-service_db_1
PID    USER   TIME   COMMAND
----------------------------
1119   999    0:00   mysqld

wordpress-service_wordpress_1
PID    USER   TIME         COMMAND
-----------------------------------------
1257   root   0:00   apache2 -DFOREGROUND
1695   xfs    0:00   apache2 -DFOREGROUND
1696   xfs    0:00   apache2 -DFOREGROUND
1697   xfs    0:00   apache2 -DFOREGROUND
1698   xfs    0:00   apache2 -DFOREGROUND
1699   xfs    0:00   apache2 -DFOREGROUND
```

## Wordpress Application deployed and made available on port 8080 of host

![8080 Exposed](https://github.com/Prashansa-K/Docker/blob/master/Docker%20Compose/wordpress-service/8080%20port.png)

![Wordpress](https://github.com/Prashansa-K/Docker/blob/master/Docker%20Compose/wordpress-service/wordpress.png)

## Update docker-compose.yml and rebuild the appliction stack with a single command

Change ports value to "5000:80"

```
$ docker-compose up -d
wordpress-service_db_1 is up-to-date
Recreating wordpress-service_wordpress_1 ... done


$ docker-compose ps
            Name                           Command               State          Ports
---------------------------------------------------------------------------------------------
wordpress-service_db_1          docker-entrypoint.sh mysqld      Up      3306/tcp, 33060/tcp
wordpress-service_wordpress_1   docker-entrypoint.sh apach ...   Up      0.0.0.0:5000->80/tcp
```

## Stopping the services

```
$ docker-compose stop
Stopping wordpress-service_wordpress_1 ... done
Stopping wordpress-service_db_1        ... done


[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose ps
            Name                           Command               State    Ports
-------------------------------------------------------------------------------
wordpress-service_db_1          docker-entrypoint.sh mysqld      Exit 0
wordpress-service_wordpress_1   docker-entrypoint.sh apach ...   Exit 0
```

## Starting the stopped containers

```
$ docker-compose  start
Starting db        ... done
Starting wordpress ... done

[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose ps
            Name                           Command               State          Ports
---------------------------------------------------------------------------------------------
wordpress-service_db_1          docker-entrypoint.sh mysqld      Up      3306/tcp, 33060/tcp
wordpress-service_wordpress_1   docker-entrypoint.sh apach ...   Up      0.0.0.0:5000->80/tcp

[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose ps --services
db
wordpress
```

## Restarting the services

```
$ docker-compose  restart
Restarting wordpress-service_wordpress_1 ... done
Restarting wordpress-service_db_1        ... done
```

## Removing the services

1) Stopping and removing containers all at once
```
$ docker-compose down
Stopping wordpress-service_wordpress_1 ... done
Stopping wordpress-service_db_1        ... done
Removing wordpress-service_wordpress_1 ... done
Removing wordpress-service_db_1        ... done
Removing network wordpress-service_default
```

2) Stopping and removing containers along with attached volumes

```
$ docker-compose down --volumes
Stopping wordpress-service_wordpress_1 ... done
Stopping wordpress-service_db_1        ... done
Removing wordpress-service_wordpress_1 ... done
Removing wordpress-service_db_1        ... done
Removing network wordpress-service_default
Removing volume wordpress-service_db_data
Removing volume wordpress-service_wp_data``

```

3) Removing Stopped Containers

```
$ docker-compose stop
Stopping wordpress-service_wordpress_1 ... done
Stopping wordpress-service_db_1        ... done
[node2] (local) root@192.168.0.12 ~/Docker/Docker Compose/wordpress-service
$ docker-compose rm
Going to remove wordpress-service_wordpress_1, wordpress-service_db_1
Are you sure? [yN] y
Removing wordpress-service_wordpress_1 ... done
Removing wordpress-service_db_1        ... done
```

## Contributor

[Prashansa Kulshrestha](https://github.com/Prashansa-K)
