#!/bin/bash
curl -L https://git.io/getLatestIstio | sh -
export PATH=$PWD/bin:$PATH
cd istio-1.0.0
kubectl apply -f install/kubernetes/helm/istio/templates/crds.yaml
kubectl apply -f install/kubernetes/istio-demo.yaml
kubectl get svc -n istio-system
kubectl get pods -n istio-system
