#!/bin/bash
kubectl cluster-info
kubectl get nodes
kubectl get nodes --no-headers | wc -l | tr -d ' ' > /root/node-count.txt
echo "Node count saved:"
cat /root/node-count.txt
