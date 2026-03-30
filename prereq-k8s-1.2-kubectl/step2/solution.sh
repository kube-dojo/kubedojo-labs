#!/bin/bash
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl describe node "$NODE" | grep "Kubelet Version:" | awk '{print $3}' > /root/kubelet-version.txt
