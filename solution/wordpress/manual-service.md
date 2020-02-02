# Run the below Service CLIs

```
docker service create --env WORDPRESS_DB_HOST=wordpressdb1 --env WORDPRESS_DB_PASSWORD=collab123 --network collabnet --replicas 4 --name wordpressapp --publish 80:80/tcp wordpress:latest
```


```
docker service create --replicas 1 --name wordpressdb1 --network collabnet --env MYSQL_ROOT_PASSWORD=collab123 --env MYSQL_USER=wordpress --env MYSQL_PASSWORD=collab123 --env MYSQL_DATABASE=wordpress mysql:5.7
```
