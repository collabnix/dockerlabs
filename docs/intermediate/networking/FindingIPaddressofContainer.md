# Finding IP address of Container

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

If you want to get the IP address of the container running on your system "docker inspect" with --format option will be helpful.
Create a container and pass the container name or id to the "docker inspect" with --format or -f option. 

```docker
$ docker run --rm -dit  --name no-net-alpine alpine:latest ash
8a90992643c7b75e8d4daaf6d55fd9961c264f8f1af49d3e9ed420b657706ef9

$ docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' no-net-alpine
172.17.0.2

```
