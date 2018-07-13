# OpenFaas on Docker Swarm running on Docker for Mac 18.05.0 RC1

```
export DOCKER_ORCHESTRATOR=swarm
```

## Setting up a single Node Swarm Mode Cluster

```
docker swarm init
```

## Listing the Nodes

```
docker node ls
```

## Settin up OpenFaas Stack

```
cd faas
./deploy-stack.sh
```

```
 ./deploy_stack.sh
Deploying stack
Creating network func_functions
Creating config func_prometheus_config
Creating config func_prometheus_rules
Creating config func_alertmanager_config
Creating service func_nodeinfo
Creating service func_wordcount
Creating service func_queue-worker
Creating service func_prometheus
Creating service func_nats
Creating service func_hubstats
Creating service func_faas-swarm
Creating service func_gateway
Creating service func_alertmanager
Creating service func_base64
Creating service func_markdown

Creating service func_echoit
```

## Setting up Faas CLI

```
curl -sSL https://cli.openfaas.com | sudo sh
```

## Testing NodeInfo Function
```
faas-cli invoke func_nodeinfo
Reading from STDIN - hit (Control + D) to stop.
Hostname: e368862d42df

Platform: linux
Arch: x64
CPU count: 2
Uptime: 2306
[Captains-Bay]🚩 >  uptime
```

