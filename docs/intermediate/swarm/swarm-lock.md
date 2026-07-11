# Locking docker swarm

Docker introduced native swarm support in Docker v1.12
Docker swarm uses raft consensus algorithm to maintain consensus between the nodes of a swarm cluster. Docker engine maintains raft logs which in turn holds the data of `cluster configuration`, `status of nodes` and other sensitive data.

Docker v1.13 introduced the concept of secrets, With secrets a developer could encrypt the sensitive data and give access of decrypted data to particular swarm services using swarm stack configuration.

In v1.13, Docker also encrypts the raft logs at rest and stores the encryption key in `/var/lib/docker/swarm/certificates` directory in each swarm manager of the cluster. If a malicious user has access to any of the manager nodes, He can easily get the encrption key, decrypt the logs and get hands on sensitive data available in the raft logs (Secrets are also stored in the raft logs).

To bypass this possibilty of disaster and protect the encryption key, Docker introduced swarm `autolock` feature which allows us to take the ownership of the keys.

***Note:***<br/>
If you enable `autolock` feature, Whenever your manager node restarts you have to manually supply the key in order for the manager node to decrypt the logs.

## Enabling autolock feature

There are various ways enable `autolock` feature.

### While initializing the swarm

```docker
docker swarm init --autolock
```
![Image](https://github.com/collabnix/dockerlabs/tree/master/intermediate/swarm/images/lock.png)

Store the swarm unlock key in a safe place.

### If swarm is already initialized

```
docker swarm update --autolock=true
```
![Image](https://github.com/collabnix/dockerlabs/tree/master/swarm/images/lock2.png)

## Disabling autolock feature

If you want to disable autolock feature and the swarm is already initilized, Use the command mentioned below.

```docker
docker swarm update --autolock=false
```
![Image](https://github.com/collabnix/dockerlabs/tree/master/swarm/images/lock3.png)

## Retrieving unlock key

If you lost the unlock key and you still have quorum of managers in the cluster, You can retrieve the unlock key by using the following command on the manager.

```docker
docker swarm unlock-key
```
![Image](https://github.com/collabnix/dockerlabs/tree/master/swarm/images/lock4.png)

***Note:***
Unlock key can only be retrieved on a unlocked manager.

## Unlocking a swarm

If a swarm is locked (When a manager node restarts) one has to manaually unlock the swarm using the unlock key.

```docker
docker swarm unlock
```
![Image](https://github.com/collabnix/dockerlabs/tree/master/swarm/images/lock5.png)

## Certain scenarios

* If a manager node is restarted it will be locked by default and has to be unlocked using the swarm unlock key.

* If a manager node is restarted and you don't have the unlock key but quorom of managers is maintined in the cluster. Then unlock key can be retrieved using the command mentioned above on any of the unlocked managers.

* If a manager node is restarted and you don't have the unlock key and quorum is also lost. Then there is no option bu for the manager is leave the swarm and join bas a new manager.

# Contributor

[Akshit Grover](https://github.com/akshitgrover)
