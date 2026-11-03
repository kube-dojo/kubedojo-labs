#!/bin/bash
# expect-exit: 0
kubectl get namespaces

# expect-exit: 0
kubectl create namespace demo

# expect-exit: 0
kubectl get namespace demo

# expect-exit: 0
kubectl get pods -n demo

# expect-exit: 0
kubectl delete namespace demo --wait=true --timeout=120s

# expect-exit: 0
kubectl create namespace my-first-ns
