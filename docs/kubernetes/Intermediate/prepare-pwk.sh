#!/bin/bash

## Creating Compose Namespace

echo "Creating Compose Namespace..."
kubectl create namespace compose

## Pulling Helm Installable


echo "Installing Helm..."
curl https://storage.googleapis.com/kubernetes-helm/helm-v2.12.1-linux-amd64.tar.gz -o helm-v2.12.1-linux-amd64.tar.gz``

## Unzip Helm

echo "Preparing Helm"
tar xvf helm-v2.12.1-linux-amd64.tar.gz

## Adding Helm to PATH 


export PATH=$PATH:/root/linux-amd64


echo "Creating tiller under kube-system namespace..."

kubectl -n kube-system create serviceaccount tiller


kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

./helm init --service-account tiller --upgrade
# wait until helm list works
./helm list
./helm install --name etcd-operator stable/etcd-operator --namespace compose

kubectl apply -f - << EOF
 apiVersion: "etcd.database.coreos.com/v1beta2"
 kind: "EtcdCluster"
 metadata:
   name: "compose-etcd"
   namespace: "compose"
 spec:
   size: 3
   version: "3.2.13"
EOF

## Cloning the Compose on Kubernetes Repository

echo "Cloning Compose on K8s Repo..."
git clone https://github.com/collabnix/compose-on-kubernetes
cd compose-on-kubernetes

## Download the installer

wget https://github.com/docker/compose-on-kubernetes/releases/download/v0.4.18/installer-linux
chmod +x installer-linux
./installer -namespace=compose -etcd-servers=http://compose-etcd-client:2379 -tag=v0.4.16 

## Verifying 

kubectl api-versions | grep compose

## Getting the Stack

kubectl get stacks
