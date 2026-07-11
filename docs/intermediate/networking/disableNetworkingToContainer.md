# Disable networking for a container

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


If we want to disable the networking stack on a container, we can use the "--network none" flag when starting the container. Within the container, only the loopback device is created.

## Steps to implement this

1. Create a container

```docker
$ docker run --rm -dit --network none --name no-net-alpine alpine:latest ash
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
4fe2ade4980c: Pull complete
Digest: sha256:621c2f39f8133acb8e64023a94dbdf0d5ca81896102b9e57c0dc184cadaf5528
Status: Downloaded newer image for alpine:latest
b961be5a20f2795125b85818ea2522ebb173beb36ec43fe10ed78cbd9a1a5d9e

```

2. Check the container’s network stack, by executing "ip link show" networking commands within the container. Notice that no eth0 was created.

```docker
$ docker exec no-net-alpine ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN qlen 1
    link/ipip 0.0.0.0 brd 0.0.0.0
3: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN qlen 1
    link/tunnel6 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00 brd 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
```

3. You can check that no routing table available in this container

```docker
$ docker exec no-net-alpine ip route
$
```

4. Stop the container

```docker
$ docker stop no-net-alpine
no-net-alpine
```

5. Container will be automatically removed while stop,  because it was created with the --rm flag.

```docker
$ docker container rm no-net-alpine
Error: No such container: no-net-alpine
```

## Without "--network none" option

If we do not use "--network none" then we can see below differences.

```docker
$ docker run --rm -dit  --name no-net-alpine alpine:latest ash
8a90992643c7b75e8d4daaf6d55fd9961c264f8f1af49d3e9ed420b657706ef9

$ docker exec no-net-alpine ip link show
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN qlen 1
    link/ipip 0.0.0.0 brd 0.0.0.0
3: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN qlen 1
    link/tunnel6 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00 brd 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
10: eth0@if11: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
```
You could see eth0 related info in networking command output.
