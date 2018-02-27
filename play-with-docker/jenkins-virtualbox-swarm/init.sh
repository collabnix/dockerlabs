#!/usr/bin/env bash
cd $(dirname $0)

docker network create db --driver overlay
docker service create --name db --network db -e MYSQL_ROOT_PASSWORD=test mysql:5.7.17
docker secret create db-alpha db-alpha-secret.json
docker secret create db-beta db-beta-secret.json
docker secret create db-prod db-prod-secret.json
