 ## Running Wordpress Blog using a Single Docker Container(Single Node Cluster)


```
docker build -t wordpress -f ./singlecontainer.Dockerfile .
$ docker run -d -p 80:80 wordpress
```


## Running a WordPress Blog Using Two Linked Containers(Single Node Cluster)

```
$ docker pull wordpress:latest
```

```
$ docker pull mysql:latest
```

```
$ docker images
REPOSITORY TAG IMAGE ID CREATED VIRTUAL SIZE
mysql latest 9def920de0a2 4 days ago 282.9 MB
wordpress latest 93acfaf85c71 8 days ago 472.8 MB
```

### Start a MySQL container, give it a name via the --name CLI option, and set the

```

### Running MYSQL Container

```
$ docker run --name mysqlwp -e MYSQL_ROOT_PASSWORD=wordpressdocker \
-e MYSQL_DATABASE=wordpress \
-e MYSQL_USER=wordpress \
-e MYSQL_PASSWORD=wordpresspwd \
-d mysql
```

### Running WordPress and linking it to MYSQL

```
docker run --name wordpress --link mysqlwp:mysql -p 80:80 \
-e WORDPRESS_DB_NAME=wordpress \
-e WORDPRESS_DB_USER=wordpress \
-e WORDPRESS_DB_PASSWORD=wordpresspwd \
-d wordpress
```
