
# How to install Docker for Windows on your Laptop?

Open up Powershell as administrator and run the below command to enable HyperV.

```
Enable-WindowsOptionalFeature -Online -FeatureName:Microsoft-Hyper-V -All
```

#  How to Keep Windows Container Running?

## Scenario: I created a new container however as soon as its created its status is stopped, why?

A. Consider running the following command to create a new container:

    docker run -d --name demo1 microsoft/windowsservercore

As soon as the container is created it will stopped which can be shown with

    docker ps -a

The reason for this is the docker model does not follow the same model as a traditional Windows instance. Docker cares about the processes that run in the containers and as soon as the process that the Docker container was created to run exits then the container hosting the process is automatically stopped. One solution is to make sure you specify a process that constantly runs, for example:

    docker run -d --name demo1 microsoft/windowsservercore ping -t localhost

This works as the container is created to run a never ending ping to itself (although is wasteful with resources). A better option than this but using the same approach is Microsoft has an actual script available at https://github.com/Microsoft/Virtualization-Documentation/blob/master/windows-server-container-tools/Wait-Service/Wait-Service.ps1 that runs while the service it is monitoring stays running which will keep the container running even when detached, for example it could be configured to monitor the IIS service in a container.

The other option is to rewrite your application to run as a synchronous process instead of a background service and make that the process that the container runs and the container stays running while the application is executing.


You can also use docker start to run a container that is stopped however this is not a good solution as it requires multiple steps to create and keep the container running and really goes against the lifecycle model of a container.
