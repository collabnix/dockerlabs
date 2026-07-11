# Install and configure a multi-master Kubernetes cluster with kubeadm 


### Prerequisites
For this lab, we will use a standard Ubuntu 16.04 or 18.04 installation as a base image for the seven machines needed. The machines will all be configured on the same network, 10.10.10.0/24, and this network needs to have access to the Internet.

The first machine needed is the machine on which the HAProxy load balancer will be installed. We will assign the IP 10.10.10.93 to this machine.

We also need three Kubernetes master nodes. These machines will have the IPs 10.10.10.90, 10.10.10.91, and 10.10.10.92.

Finally, we will also have three Kubernetes worker nodes with the IPs 10.10.10.100, 10.10.10.101, and 10.10.10.102.

We also need an IP range for the pods. This range will be 10.30.0.0/16, but it is only internal to Kubernetes.

I will use my Linux desktop as a client machine to generate all the necessary certificates, but also to manage the Kubernetes cluster. If you don't have a Linux desktop, you can use the HAProxy machine to do the same thing.<br>

![img](https://raw.githubusercontent.com/apurvabhandari/kubernetes/master/multi-master-with-HA.png) <br>

### Installing the client tools
We will need two tools on the client machine: the Cloud Flare SSL tool to generate the different certificates, and the Kubernetes client, kubectl, to manage the Kubernetes cluster.

#### Installing cfssl
1- Download the binaries.

```
$ wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
$ wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
```

2- Add the execution permission to the binaries.

`$ chmod +x cfssl*`

3- Move the binaries to /usr/local/bin.

```
$ sudo mv cfssl_linux-amd64 /usr/local/bin/cfssl
$ sudo mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
```

4- Verify the installation.

`$ cfssl version`

#### Installing kubectl
1- Download the binary.
```
$wget https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl
```
2- Add the execution permission to the binary.
```
$chmod +x kubectl
```
3- Move the binary to /usr/local/bin.
```
$sudo mv kubectl /usr/local/bin
```
4- Verify the installation.
```
$ kubectl version
```

#### Installing the HAProxy load balancer
As we will deploy three Kubernetes master nodes, we need to deploy an HAPRoxy load balancer in front of them to distribute the traffic.

1- SSH to the 10.10.10.93 Ubuntu machine.<br>

2- Update the machine.
```
$ sudo apt-get update
$ sudo apt-get upgrade
```
3- Install HAProxy.
```
$ sudo apt-get install haproxy
```
4- Configure HAProxy to load balance the traffic between the three Kubernetes master nodes.
```
$ sudo vim /etc/haproxy/haproxy.cfg
global
...
default
...
frontend kubernetes
bind 10.10.10.93:6443
option tcplog
mode tcp
default_backend kubernetes-master-nodes


backend kubernetes-master-nodes
mode tcp
balance roundrobin
option tcp-check
server k8s-master-0 10.10.10.90:6443 check fall 3 rise 2
server k8s-master-1 10.10.10.91:6443 check fall 3 rise 2
server k8s-master-2 10.10.10.92:6443 check fall 3 rise 2
```
5- Restart HAProxy.
```
$ sudo systemctl restart haproxy
```
### Generating the TLS certificates
These steps can be done on your Linux desktop if you have one or on the HAProxy machine depending on where you installed the cfssl tool.

#### Creating a certificate authority
1- Create the certificate authority configuration file.
```
$ vim ca-config.json
{
  "signing": {
    "default": {
      "expiry": "8760h"
    },
    "profiles": {
      "kubernetes": {
        "usages": ["signing", "key encipherment", "server auth", "client auth"],
        "expiry": "8760h"
      }
    }
  }
}
```
2- Create the certificate authority signing request configuration file.
```
$ vim ca-csr.json
{
  "CN": "Kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
  {
    "C": "IE",
    "L": "Cork",
    "O": "Kubernetes",
    "OU": "CA",
    "ST": "Cork Co."
  }
 ]
}
```
3- Generate the certificate authority certificate and private key.
```
$ cfssl gencert -initca ca-csr.json | cfssljson -bare ca
```
4- Verify that the ca-key.pem and the ca.pem were generated.
```
$ ls -la
```
#### Creating the certificate for the Etcd cluster
1- Create the certificate signing request configuration file.
```
$ vim kubernetes-csr.json
{
  "CN": "kubernetes",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
  {
    "C": "IE",
    "L": "Cork",
    "O": "Kubernetes",
    "OU": "Kubernetes",
    "ST": "Cork Co."
  }
 ]
}
```
2- Generate the certificate and private key.
```
$ cfssl gencert \
-ca=ca.pem \
-ca-key=ca-key.pem \
-config=ca-config.json \
-hostname=10.10.10.90,10.10.10.91,10.10.10.92,10.10.10.93,127.0.0.1,kubernetes.default \
-profile=kubernetes kubernetes-csr.json | \
cfssljson -bare kubernetes
```
3- Verify that the kubernetes-key.pem and the kubernetes.pem file were generated.
```
$ ls -la
```
4- Copy the certificate to each nodes.
```
$ scp ca.pem kubernetes.pem kubernetes-key.pem ubuntu@10.10.10.90:~
$ scp ca.pem kubernetes.pem kubernetes-key.pem ubuntu@10.10.10.91:~
$ scp ca.pem kubernetes.pem kubernetes-key.pem ubuntu@10.10.10.92:~
$ scp ca.pem kubernetes.pem kubernetes-key.pem ubuntu@10.10.10.100:~
$ scp ca.pem kubernetes.pem kubernetes-key.pem ubuntu@10.10.10.101:~
$ scp ca.pem kubernetes.pem kubernetes-key.pem ubuntu@10.10.10.102:~
```
### Preparing the nodes for kubeadm

#### Preparing the 10.10.10.90/91/92/100/101/102 machine
Performing below steps on all systems
##### Installing Docker latest version
```
$ sudo -s
# curl -fsSL https://get.docker.com -o get-docker.sh
# sh get-docker.sh
# usermod -aG docker your-user
```
#### Installing kubeadm, kublet, and kubectl
1- Add the Google repository key.
```
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```
2- Add the Google repository.
```
# vim /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io kubernetes-xenial main
```
3- Update the list of packages and install kubelet, kubeadm and kubectl.
```
# apt-get update
# apt-get install kubelet kubeadm kubectl
```
4- Disable the swap.
```
# swapoff -a
# sed -i '/ swap / s/^/#/' /etc/fstab
```

### Installing and configuring Etcd

#### Installing and configuring Etcd on the 10.10.10.90/91/92 machine (All 3 master)

1- SSH to the 10.10.10.90 machine.<br>
2- Create a configuration directory for Etcd.
```
$ sudo mkdir /etc/etcd /var/lib/etcd
```
3- Move the certificates to the configuration directory.
```
$ sudo mv ~/ca.pem ~/kubernetes.pem ~/kubernetes-key.pem /etc/etcd
```
4- Download the etcd binaries.
```
wget https://github.com/etcd-io/etcd/releases/download/v3.3.13/etcd-v3.3.13-linux-amd64.tar.gz
```
5- Extract the etcd archive.
```
$ tar xvzf etcd-v3.3.13-linux-amd64.tar.gz
```
6- Move the etcd binaries to /usr/local/bin.
```
$ sudo mv etcd-v3.3.13-linux-amd64/etcd* /usr/local/bin/
```
7- Create an etcd systemd unit file.
```
$ sudo vim /etc/systemd/system/etcd.service
[Unit]
Description=etcd
Documentation=https://github.com/coreos


[Service]
ExecStart=/usr/local/bin/etcd \
  --name 10.10.10.90 \
  --cert-file=/etc/etcd/kubernetes.pem \
  --key-file=/etc/etcd/kubernetes-key.pem \
  --peer-cert-file=/etc/etcd/kubernetes.pem \
  --peer-key-file=/etc/etcd/kubernetes-key.pem \
  --trusted-ca-file=/etc/etcd/ca.pem \
  --peer-trusted-ca-file=/etc/etcd/ca.pem \
  --peer-client-cert-auth \
  --client-cert-auth \
  --initial-advertise-peer-urls https://10.10.10.90:2380 \
  --listen-peer-urls https://10.10.40.10:2380 \
  --listen-client-urls https://10.10.10.90:2379,http://127.0.0.1:2379 \
  --advertise-client-urls https://10.10.10.90:2379 \
  --initial-cluster-token etcd-cluster-0 \
  --initial-cluster 10.10.10.90=https://10.10.10.90:2380,10.10.10.91=https://10.10.10.91:2380,10.10.10.92=https://10.10.10.92:2380 \
  --initial-cluster-state new \
  --data-dir=/var/lib/etcd
Restart=on-failure
RestartSec=5



[Install]
WantedBy=multi-user.target
```
8- Reload the daemon configuration.
```
$ sudo systemctl daemon-reload
```
9- Enable etcd to start at boot time.
```
$ sudo systemctl enable etcd
```
10- Start etcd.
```
$ sudo systemctl start etcd
```
11- Verify that the cluster is up and running.
```
$ ETCDCTL_API=3 etcdctl member list
```
Perform all the steps on other Master (91 and 92) by replacing IP

### Initializing the master nodes
#### Initializing the Master node 10.10.10.90
1- SSH to the 10.10.10.90 machine.<br>
2- Create the configuration file for kubeadm.
```
$ vim config.yaml
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
kubernetesVersion: stable
apiServerCertSANs:
- 10.10.10.93
controlPlaneEndpoint: "10.10.10.93:6443"
etcd:
  external:
    endpoints:
    - https://10.10.10.90:2379
    - https://10.10.10.91:2379
    - https://10.10.10.92:2379
    caFile: /etc/etcd/ca.pem
    certFile: /etc/etcd/kubernetes.pem
    keyFile: /etc/etcd/kubernetes-key.pem
networking:
  podSubnet: 10.30.0.0/24
apiServerExtraArgs:
  apiserver-count: "3"
```
3- Initialize the machine as a master node.
```
$ sudo kubeadm init --config=config.yaml
```
4- Copy the certificates to the two other masters.
```
$ sudo scp -r /etc/kubernetes/pki ubuntu@10.10.10.91:~
$ sudo scp -r /etc/kubernetes/pki ubuntu@10.10.10.92:~
```
#### Initializing the 2nd master node 10.10.10.91
1- SSH to the 10.10.10.91 machine.<br>
2- Remove the apiserver.crt and apiserver.key.
```
$ rm ~/pki/apiserver.*
```
3- Move the certificates to the /etc/kubernetes directory.
```
$ sudo mv ~/pki /etc/kubernetes/
```
4 - Create the configuration file for kubeadm.
```
$ vim config.yaml
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
kubernetesVersion: stable
apiServerCertSANs:
- 10.10.10.93
controlPlaneEndpoint: "10.10.10.93:6443"
etcd:
  external:
    endpoints:
    - https://10.10.10.90:2379
    - https://10.10.10.91:2379
    - https://10.10.10.92:2379
    caFile: /etc/etcd/ca.pem
    certFile: /etc/etcd/kubernetes.pem
    keyFile: /etc/etcd/kubernetes-key.pem
networking:
  podSubnet: 10.30.0.0/24
apiServerExtraArgs:
  apiserver-count: "3"
  ```
  5- Initialize the machine as a master node.
  ```
  $ sudo kubeadm init --config=config.yaml
  ```
  #### Initializing the 3rd master node 10.10.10.92
  1- SSH to the 10.10.10.92 machine.<br>
  2- Remove the apiserver.crt and apiserver.key.
  ```
  $ rm ~/pki/apiserver.*
  ```
  3- Move the certificates to the /etc/kubernetes directory.
  ```
  $ sudo mv ~/pki /etc/kubernetes/
  ```
  4 - Create the configuration file for kubeadm.
  ```
  $ vim config.yaml
apiVersion: kubeadm.k8s.io/v1alpha3
kind: ClusterConfiguration
kubernetesVersion: stable
apiServerCertSANs:
- 10.10.10.93
controlPlaneEndpoint: "10.10.10.93:6443"
etcd:
  external:
    endpoints:
    - https://10.10.10.90:2379
    - https://10.10.10.91:2379
    - https://10.10.10.92:2379
    caFile: /etc/etcd/ca.pem
    certFile: /etc/etcd/kubernetes.pem
    keyFile: /etc/etcd/kubernetes-key.pem
networking:
  podSubnet: 10.30.0.0/24
apiServerExtraArgs:
  apiserver-count: "3"
  ```
  5- Initialize the machine as a master node.
  ```
  $ sudo kubeadm init --config=config.yaml
  ```
  6- Copy the "kubeadm join" command line printed as the result of the previous command.
  
  ### Initializing the worker nodes
  #### Initializing the worker node 10.10.10.100/101/102
  1- SSH to the 10.10.100.100 machine.<br>
  2- Execute the "kubeadm join" command that you copied from the last step of the initialization of the masters.
  ```
  $ sudo kubeadm join 10.10.40.93:6443 --token [your_token] --discovery-token-ca-cert-hash sha256:[your_token_ca_cert_hash]
  ```
  Run same command on worker node 101 and 102
  
  #### Verifying that the workers joined the cluster
  1- SSH to one of the master node.<br>
  2- Get the list of the nodes.
  ```
  $ sudo kubectl --kubeconfig /etc/kubernetes/admin.conf get nodes
  ```
  
### Configuring kubectl on the client machine
1- SSH to one of the master node. 10.10.10.90 <br>
2- Add permissions to the admin.conf file.
```
$ sudo chmod +r /etc/kubernetes/admin.conf
```
3- From the client machine, copy the configuration file.
```
$ scp ubuntu@10.10.10.90:/etc/kubernetes/admin.conf .
```
4- Create and configure the kubectl configuration directory.
```
$ mkdir ~/.kube
$ mv admin.conf ~/.kube/config
$ chmod 600 ~/.kube/config
```
5- Go back to the SSH session on the master and change back the permissions of the configuration file.
```
$ sudo chmod 600 /etc/kubernetes/admin.conf
```
6- check that you can access the Kubernetes API from the client machine.
```
$ kubectl get nodes
```

### Deploying the overlay network
We are going to use Calico as the overlay network. You can also use static route or another overlay network tool like Weavenet or Flannel. <br>
1- Deploy the overlay network pods from the client machine.
```
$kubectl apply -f https://docs.projectcalico.org/v3.7/manifests/calico.yaml
```
2- Check that the pods are deployed properly.
```
$ kubectl get pods -n kube-system
```
3- Check that the nodes are in Ready state.
```
$ kubectl get nodes
```


## Contributor

- [Apurva Bhandari](https://www.linkedin.com/in/apurvabhandari-linux/)
