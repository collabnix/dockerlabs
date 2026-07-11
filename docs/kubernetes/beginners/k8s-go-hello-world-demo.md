# Run Golang Hello World App: Kubernetes in 5 min 


Language: **Golang**

Cluster management: **Kubernetes, via Minikube**

Containerization: **Docker (+DockerHub)**

Driver/Hypervisor: **xhyve**


Over the past 3 or so years, it seems the term “containerization” and the name “Kubernetes” have been amplified throughout the tech community non-stop. Even with that being so, as a developer, it can be easy to shy away from Kubernetes as its learning curve is notorious for being a steep one. But everyone’s gotta start somewhere, right? This tutorial will give you a basic overview of some of main features of Kubernetes, while walking you through the process of running a simple HelloWorld Golang application locally on your machine to running it on Kubernetes. 



### Prep & Installations:

- Be sure [Golang](https://golang.org/doc/install) is installed and Go tools are set up to run our application.
- You’ll need to download [Homebrew](https://docs.brew.sh/Installation.html) to download your driver. In this tutorial we’ll be using [xhyve](https://github.com/mist64/xhyve).
- Install Docker (We'll be using [Docker for Mac](https://docs.docker.com/docker-for-mac/#preferences) for this tutorial)



**Now let’s get into it!**


## Create a Minikube Cluster:

In this tutorial, we’ll be using Minikube to create a cluster locally. If you are not using a Mac, see the [Minikube installation guide](https://github.com/kubernetes/minikube) as the instructions might be different. 

Use curl to download the latest release of Minikube:

        curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64 && \
        chmod +x minikube && \
        sudo mv minikube /usr/local/bin/
        
        
        ```
```
Biradars-MacBook-Air-4:~ sangam$ minikube start
😄  minikube v1.2.0 on darwin (amd64)
🔥  Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
🐳  Configuring environment for Kubernetes v1.15.0 on Docker 18.09.6
💾  Downloading kubeadm v1.15.0
💾  Downloading kubelet v1.15.0
🚜  Pulling images ...
🚀  Launching Kubernetes ... 
⌛  Verifying: apiserver proxy etcd scheduler controller dns
🏄  Done! kubectl is now configured to use "minikube"
Biradars-MacBook-Air-4:~ sangam$ kubectl
kubectl controls the Kubernetes cluster manager. 

Find more information at: https://kubernetes.io/docs/reference/kubectl/overview/

Basic Commands (Beginner):
  create         Create a resource from a file or from stdin.
  expose         Take a replication controller, service, deployment or pod and expose it as a new Kubernetes Service
  run            Run a particular image on the cluster
  set            Set specific features on objects

Basic Commands (Intermediate):
  explain        Documentation of resources
  get            Display one or many resources
  edit           Edit a resource on the server
  delete         Delete resources by filenames, stdin, resources and names, or by resources and label selector

Deploy Commands:
  rollout        Manage the rollout of a resource
  scale          Set a new size for a Deployment, ReplicaSet, Replication Controller, or Job
  autoscale      Auto-scale a Deployment, ReplicaSet, or ReplicationController

Cluster Management Commands:
  certificate    Modify certificate resources.
  cluster-info   Display cluster info
  top            Display Resource (CPU/Memory/Storage) usage.
  cordon         Mark node as unschedulable
  uncordon       Mark node as schedulable
  drain          Drain node in preparation for maintenance
  taint          Update the taints on one or more nodes

Troubleshooting and Debugging Commands:
  describe       Show details of a specific resource or group of resources
  logs           Print the logs for a container in a pod
  attach         Attach to a running container
  exec           Execute a command in a container
  port-forward   Forward one or more local ports to a pod
  proxy          Run a proxy to the Kubernetes API server
  cp             Copy files and directories to and from containers.
  auth           Inspect authorization

Advanced Commands:
  diff           Diff live version against would-be applied version
  apply          Apply a configuration to a resource by filename or stdin
  patch          Update field(s) of a resource using strategic merge patch
  replace        Replace a resource by filename or stdin
  wait           Experimental: Wait for a specific condition on one or many resources.
  convert        Convert config files between different API versions

Settings Commands:
  label          Update the labels on a resource
  annotate       Update the annotations on a resource
  completion     Output shell completion code for the specified shell (bash or zsh)

Other Commands:
  api-resources  Print the supported API resources on the server
  api-versions   Print the supported API versions on the server, in the form of "group/version"
  config         Modify kubeconfig files
  plugin         Provides utilities for interacting with plugins.
  version        Print the client and server version information

Usage:
  kubectl [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).
Biradars-MacBook-Air-4:~ sangam$ 

 ```

Now we’re gonna use Homebrew to install the driver:

        brew install docker-machine-driver-xhyve
        sudo chown root:wheel $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
        sudo chmod u+s $(brew --prefix)/opt/docker-machine-driver-xhyve/bin/docker-machine-driver-xhyve
        
        
 install

 
```

Biradars-MacBook-Air-4:~ sangam$ minikube start
😄  minikube v1.2.0 on darwin (amd64)
🔥  Creating virtualbox VM (CPUs=2, Memory=2048MB, Disk=20000MB) ...
🐳  Configuring environment for Kubernetes v1.15.0 on Docker 18.09.6
💾  Downloading kubeadm v1.15.0
💾  Downloading kubelet v1.15.0


```

We need to install Kubernetes’ kubectl command-line tool, which will be our right hand for interacting with our cluster:

        brew install kubectl




Now let’s go ahead and start the Minikube cluster:

        minikube start --vm-driver=xhyve

>(Note that the --vm-driver=xhyve  flag specifies that you are using Docker for Mac)




Next, you’ll need to configure kubectl to communicate specifically to the minikube cluster. In order to do that, we have to set the Minikube context, as such:

        kubectl config use-context minikube

Now let’s check to see if kubectl is all configured to interact with our cluster:

        kubectl cluster-info




### What just happened?..

So the first thing we did was create a Kubernetes cluster via a VM called Minikube. MiniKube is a popular tool used to run Kubernetes locally. Then we installed a hypervisor (xhyve) for Docker to run on Minikube.

After that, we configured Kubernetes’ command line-tool, **_kubectl_**, to communicate specifically with our minikube cluster. 


----

## Now Let’s Create our Golang application!


Go and download the HelloWorld source code by running the commands below:

        git clone https://github.com/sangam14/k8s-go-hello-world-demo.git
        cd k8s-go-hello-world-demo/helloworld


```
Biradars-MacBook-Air-4:helloworld sangam$ docker build -t helloworld:v1 .
Sending build context to Docker daemon  17.92kB
Step 1/2 : FROM golang:onbuild
onbuild: Pulling from library/golang
ad74af05f5a2: Pull complete 
2b032b8bbe8b: Pull complete 
a9a5b35f6ead: Pull complete 
25d9840c55bc: Pull complete 
d792ec7d64a3: Pull complete 
be556a93c22e: Pull complete 
3a5fce283a1e: Pull complete 
0621865a0c2e: Pull complete 
Digest: sha256:c0ec19d49014d604e4f62266afd490016b11ceec103f0b7ef44875801ef93f36
Status: Downloaded newer image for golang:onbuild
# Executing 3 build triggers
 ---> Running in 4d7162ec6ff8
+ exec go get -v -d
Removing intermediate container 4d7162ec6ff8
 ---> Running in e4b44faa7f26
+ exec go install -v
app
Removing intermediate container e4b44faa7f26
 ---> 46f0d00080fc
Step 2/2 : EXPOSE 8080
 ---> Running in 177d0bcde920
Removing intermediate container 177d0bcde920
 ---> 72ac82991fdb
Successfully built 72ac82991fdb
Successfully tagged helloworld:v1
Biradars-MacBook-Air-4:helloworld sangam$ 


````

> Our app is a simple http web server that prints a "Hello World" message. You can give it a test run using 
**go run helloworld.go** and then opening **http://localhost:8080** in your browser.


>**NOTE**: If you take a look inside the repo, a Dockerfile has already been created. A Dockerfile typically contains all the instructions on how the image is built. However, if you open our Dockerfile, you will notice that it looks a little vague with only two simple commands. Is this Dockerfile complete? Actually, yes! Golang has a variant called “onbuild” which simplifies the build process for our Docker image. When we use the onbuild variant, we’re implying that our image application should be built with generalized instructions as any generic Go application, and the image automatically copies the package source then builds the program and configures it to run upon startup. 


In the next step, we’ll be packaging our application in a Docker container.

----

## Create our Docker Image

Now let’s build our container image and tag it:

        docker build -t helloworld:v1 .


Let’s double check to see if our build succeeded. If it was, we’ll see our image listed by running this command:

        docker images
        
```
Biradars-MacBook-Air-4:helloworld sangam$    docker images
REPOSITORY                                 TAG                 IMAGE ID            CREATED              SIZE
helloworld                                 v1                  72ac82991fdb        About a minute ago   704MB
```

---- 

### Push your Docker Image to the Cloud

Now we need to push our container to a **_registry_**. A container registry is library is a library of docker images. Docker hosts a free registry called DockerHub, that’s the one we’ll be pushing our container to.

If you’re running Docker for Mac, make sure you’re logged into your Docker account and that Docker is running on your machine. You can do that by clicking the Docker icon at the top of your screen. You should see a green light to verify that it’s running. 

First you’ll need to sign up to [create an account on DockerHub](https://hub.docker.com). 

([Click here for these instructions using other operating systems](https://docs.docker.com/docker-for-windows/install/).)


Go to [https://hub.docker.com](https://hub.docker.com), log in, then create a repository called hello-world (_ex. timirahj/hello-world_). 


Now let’s log into the Docker Hub from the command line:

        docker login


Go ahead and enter your credentials when prompted.



>If you’ve installed Docker for Mac, you can log into your Docker account by clicking the Docker whale icon at the top of your screen as shown below.


![docker-image](https://raw.githubusercontent.com/sangam14/k8s-go-hello-world-demo/master/Docker-screenshot.png)


> The green light indicates that Docker is currently running. ([Click here for these instructions using other operating systems](https://docs.docker.com/docker-for-windows/install/).)





Now we’ll need to check the image ID:

        docker images


Your output should look something like this:

        REPOSITORY              TAG       IMAGE ID         CREATED           SIZE
        helloworld              v1       056yb71fy406      5 minutes ago    1.076 GB
        monty_grapher          latest    pp58734h67dd     12 minutes ago    1.658 GB
        steph/train            latest    9857j776f554      8 days ago       1.443 GB



Update your image’s tag and the name of your Docker Hub repo:

        docker tag helloworld:v1 yourhubusername/hello-world:v1


Finally, push the image to your Docker Hub repo:

        docker push yourhubusername/hello-world




```
Biradars-MacBook-Air-4:helloworld sangam$ docker tag helloworld:v1 sangam14/hello-world:v1
Biradars-MacBook-Air-4:helloworld sangam$ docker push sangam14/hello-world
The push refers to repository [docker.io/sangam14/hello-world]
82c8a7f71889: Pushed 
d94c6198e159: Pushed 
e15881a3c920: Pushed 
dfd527c9b5e7: Mounted from library/golang 
36ba0159de56: Mounted from library/golang 
4ff814ecd9f4: Mounted from library/golang 
74f1f103792f: Mounted from library/golang 
6367890e52bf: Mounted from library/golang 
f3ed6cb59ab0: Mounted from library/golang 
654f45ecb7e3: Mounted from library/golang 
2c40c66f7667: Mounted from library/golang 
v1: digest: sha256:0c36322fb51c5d6d2c980c62c9b340081554fdb252c967a94b3489a7bf453867 size: 2624
```
---- 

Golang app https://hub.docker.com/r/sangam14/hello-world. pull the ready container 

### Run the Container

We can test out our container image locally first by running this command (_be sure to replace ‘yourusername’ with your actual DockerHub username_):

        docker run --p 8080:8080 yourusername/hello-world:v1

Then open a new tab in your terminal and enter: 

        curl http://localhost:8080
        
Lo and behold, there’s our _**‘Hello World’**_ message.



 ### What just happened?..
 
So after we downloaded the application, we then created a container image for our application to and its dependencies to live in. We then pushed that image to Docker Hub, Docker’s official container registry. Pushing our container to the cloud gives us the abilty to access that container any given time, even if we tear down our local cluster, or if we want to pull that container to live in separate cluster. After that, we ran the container, binding our local port to the port of the container (_8080:8080_). 

----

## Deploy


In Kubernetes, containers are interpreted as objects called [Pods](https://kubernetes.io/docs/concepts/workloads/pods/pod/) (one or more containers in a group). The Pod in our cluster only has one container, the one we just created.

Now how do we manage this Pod? Kubernetes provides a special supervisor for Pods called [Deployments](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/). Deployments are responsible for monitoring and managing everything from scaling, to version upgrades, to overall health of Pods.


To create a deployment, we’ll have to use Kubernetes’ kubectl for the following command:

        kubectl run helloworld --image=yourusername/hello-world:v1 --port=8080



Once the Terminal confirms that your deployment has been created, we can view it by running

        kubectl get deployments

Your output should look something like this:

        NAME         DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
        helloworld    1         1         1            1           3m


Now let’s take a look at our Pod:

        kubectl get pods

        NAME                                         READY     STATUS    RESTARTS   AGE
        helloworld-7447bd7d5d-lwnxh                   1/1      Running      0        1m




### What just happened?..

Woah! So now our container lives inside a Pod, and Kubernetes has given us a manager, a Deployment, to keep tabs on our Pods health, scaling and load-balancing, and versioning. 


Now let’s take a look at this via the **Kubernetes dashboard**. Open the dashboard in your browser with this command:

        minikube dashboard


You should see something similar to this…

![dashboard](https://github.com/sangam14/k8s-go-hello-world-demo/blob/master/dashboard-ui.png)


It’s your cluster in the flesh! The top centered section displays the statuses of your workloads within the cluster. Workloads are objects used to manage and run your containers in your cluster -- so for example, you should see circles that represent your Pods, Deployments, and Replica Sets. Each of those objects fall in the workload category. The circles are pass/fail pie charts, with green indicating the percentage of success and red indicating the percentage of failures. For example, let’s say we have 3 Pods in our cluster, and 1 of our Pods has died for whatever reason. The Pod chart would be shown as mostly green representing 67% and partially red representing 33%.

The Kubernetes dashboard is super handy, giving a clean and straightforward visual representation for all the elements related to our cluster. 


----

## Create a Service

In order to make our Pod accessible outside of the cluster, we have to create what’s called a _“Service”_. A service provides an IP address that maps to a set of pods with identical [labels](https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/#label-selectors). 

Every Pod is born with its own unique IP address. When a service is created, the IP addresses of Pods become endpoints of the service, and the service load-balances over its endpoints. A service can also exclusively internal to the cluster. The internal/external state of a Service is controlled by setting a _Service Type_. When set to type **LoadBalancer**, the service is made public and the IP address is exposed from the cluster and mapped to the endpoints (i.e. the Pods).

 

Go ahead and create a Service by running the command below:

        kubectl expose deployment helloworld --type=LoadBalancer
        
                
```
Biradars-MacBook-Air-4:k8s-go-hello-world-demo sangam$  kubectl expose deployment helloworld --type=LoadBalancer
service/helloworld exposed
```

> Here we use the  **--type=LoadBalancer** flag to indicate that we want our Service to be exposed outside of our cluster.

Now let’s test to see if our Service is accessible:

        minikube service helloworld
 ```       
  Biradars-MacBook-Air-4:k8s-go-hello-world-demo sangam$ minikube service helloworld
🎉  Opening kubernetes service default/helloworld in default browser...

```

![browser](https://github.com/sangam14/k8s-go-hello-world-demo/blob/master/browser_go_app.png)

> This uses a local IP address that serves our app and opens up a browser displaying our “Hello World” message.


![service image](https://github.com/sangam14/k8s-go-hello-world-demo/blob/master/K8s_Diagrams1-4-1.jpg)

> Check out this diagram of our service.


---- 

## Scaling our App

Our application is available for external use! But what if there’s too much usage? Too many requests, too much traffic? Our Pod is still liable to get overworked and ultimately fail if the traffic becomes too heavy. Deployments solve this issue by creating replica Pods to add the the cluster. You can define how many replicas you need to be running at all times.

We can accomplish this by running the **_kubectl scale_** command. Let’s go ahead and use it to create 2 replicas:

        kubectl scale deployment hello-world --replicas=3


>Note: Since we are creating 2 more replicas, we set the value to **_3_** because that will be the **total number** of Pods in the Deployment.


Let’s check to see if the number of replicas have been updated:

        kubectl get deployment hello-world
        NAME        DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
        hello-world   3         3           3            2        1m


        kubectl get pods
        NAME                           READY     STATUS     RESTARTS      AGE
        hello-world-5dc98cf5d6-7w9vs   1/1       Running       0          23h
        hello-world-5dc98cf5d6-p2bxs   1/1       Running       0          16s
        hello-world-5dc98cf5d6-scqhq   1/1       Running       0          16s

And now our Service will automatically begin distributing traffic amongst these three Pods. 

![service-image-update](https://github.com/sangam14/k8s-go-hello-world-demo/blob/master/Service_Diagrams1-3.jpg)


---- 

## Updating your Application
 
Now what if we need go and to make changes to our application? What if we want to change our message from _“Hello World!!”_ to _“Finally Completed this Tutorial!!”_?


Let’s go into our source code (**_helloworld.go file_**) for our application and change it to return our new message.

_Change line 16 in helloworld.go to:_
 
        fmt.Fprint(rw, "Finally Completed this Tutorial!!")
        
Now we want to build a new version of our Docker image:

        docker build -t yourhubusername/hello_world:v2 .
        
Update the image for the Deployment:

        kubectl set image deployment/helloworld helloworld=yourhubusername/hello_world:v2

Now we can check for our updated message:

        minikube service helloworld

---- 

## A Clean Finish

Now after all that hard work… **let’s throw it all away!**

You can clean out your cluster simply by using:

        kubectl delete service helloworld
        kubectl delete deployment helloworld

Stop Minikube, then delete it:
        
        minikube stop
        minikube delete


 # Contributor: 
 [sangam biradar](https://twitter.com/BiradarSangam)
 
 https://engineitops.icu



