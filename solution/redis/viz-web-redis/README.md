# Visualizer + Redis + Docker Swarm

```
$ docker service create --name myredis --publish 6379:6379 --replicas 5 --mount type=volume,source=data,destination=/home/docker/data redis:3.0.6
dkbe281eyx1ixadec1q6iexq7
overall progress: 5 out of 5 tasks 
1/5: running   
2/5: running   
3/5: running   
4/5: running   
5/5: running   
verify: Service converged
```
