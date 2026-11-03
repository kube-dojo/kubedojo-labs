#!/bin/bash
# expect-exit: 0
kubectl get pods

# expect-exit: 0
kubectl get pods -n kube-system

# expect-exit: 0
kubectl get pods -A

# expect-exit: 0
kubectl get svc

# expect-exit: 0
kubectl get pods,svc,nodes

# expect-exit: 0
kubectl get pods -n kube-system > "$HOME"/kube-system-pods.txt
