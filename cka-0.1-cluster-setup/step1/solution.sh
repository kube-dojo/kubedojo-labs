#!/bin/bash
kubectl cluster-info
kubectl get nodes
kubectl get nodes --no-headers | wc -l | tr -d ' ' > "$HOME"/node-count.txt
echo "Node count saved:"
cat "$HOME"/node-count.txt
