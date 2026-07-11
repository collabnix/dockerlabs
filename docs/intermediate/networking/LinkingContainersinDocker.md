# Linking Containers in Docker

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>

  </tr>
  <tr>
    <td class="tg-yw4l"><b> Mac OS</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>

  </tr>

</table>

## Pre-requisite

- A linux system (here we have used macbook)
- Docker installed

In order to connect together multiple docker containers or services running inside docker container, ‘–link’ flag can be used in order to securely connect and provide a channel to transfer information from one container to another.
A simple application of using a Wordpress container linked to MySQL container, can explain this well

1. Pull the latest MySql container

```docker
$ docker pull mysql:latest
latest: Pulling from library/mysql
a5a6f2f73cd8: Already exists
936836019e67: Pull complete
283fa4c95fb4: Pull complete
1f212fb371f9: Pull complete
e2ae0d063e89: Pull complete
5ed0ae805b65: Pull complete
0283dc49ef4e: Pull complete
a7e1170b4fdb: Pull complete
88918a9e4742: Pull complete
241282fa67c2: Pull complete
b0fecf619210: Pull complete
bebf9f901dcc: Pull complete
Digest: sha256:b7f7479f0a2e7a3f4ce008329572f3497075dc000d8b89bac3134b0fb0288de8
Status: Downloaded newer image for mysql:latest

```

2. Run MySql Container in detach mode (MySQL 8 changed the password authentication method. We're looking for the mysql_native_password plugin, hence "--default-authentication-plugin=mysql_native_password" option require)

```docker
$ docker run --name mysql01 -e MYSQL_ROOT_PASSWORD=Password1234 -d mysql --default-authentication-plugin=mysql_native_password
fdabd410a66e4b65ec959677c932ccad79542ee9081d86ad2cbd0e2fe0265f1d
```

3. Pull Wordpress docker container

```docker
$ docker pull wordpress:latest
latest: Pulling from library/wordpress
a5a6f2f73cd8: Already exists
633e0d1cd2a3: Pull complete
fcdfdf7118ba: Pull complete
4e7dc76b1769: Pull complete
c425447c8835: Pull complete
75780b7b9977: Pull complete
33ed51bc30e8: Pull complete
7c4215700bc4: Pull complete
d4f613c1e621: Pull complete
de5465a3fde0: Pull complete
6d373ffaf200: Pull complete
991bff14f001: Pull complete
d0a8c1ecf326: Pull complete
aa3627a535bb: Pull complete
a36be75bb622: Pull complete
98ebddb8e6ca: Pull complete
ed6e19b74de1: Pull complete
18b9cc4a2286: Pull complete
dfe625c958ac: Pull complete
Digest: sha256:f431a0681072aff336acf7a3736a85266fe7b46de116f29a2ea767ff55ad8f54
Status: Downloaded newer image for wordpress:latest
```

4. Run the wordpress container linking it to MySQL Container (will run the database container with name “mysql-wordpress” and will set root password for MySQL container)

```docker
$ docker run --name wordpress01 --link mysql01 -p 8080:80 -e WORDPRESS_DB_HOST=mysql01:3306 -e WORDPRESS_DB_USER=root -e WORDPRESS_DB_PASSWORD=Password1234 -e WORDPRESS_DB_NAME=wordpress -e WORDPRESS_TABLE_PREFIX=wp_ -d wordpress
83b1f3215b01e7640246eb945977052bbf64f500a5b7fa18bd5a27841b01289b
```
5. Check the status of the Containers

```docker
$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                  NAMES
83b1f3215b01        wordpress           "docker-entrypoint.s…"   33 seconds ago       Up 32 seconds       0.0.0.0:8080->80/tcp   wordpress01
fdabd410a66e        mysql               "docker-entrypoint.s…"   About a minute ago   Up About a minute   3306/tcp, 33060/tcp    mysql01

```
6. As, we have linked both the container now wordpress container can be accessed from browser using the address http://localhost:8080 and setup of wordpress can be done easily.

![alt text](https://github.com/amitatha82/dockerlabs/blob/master/images/wordpress.png)
