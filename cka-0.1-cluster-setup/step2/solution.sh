#!/bin/bash
kubectl get pods -n kube-system
kubectl get pods -n kube-system --no-headers | grep kube-apiserver | awk '{print $1}' > "$HOME"/apiserver-pod.txt
echo "API server pod name saved:"
cat "$HOME"/apiserver-pod.txt
