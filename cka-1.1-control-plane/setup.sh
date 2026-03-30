#!/bin/bash
# Wait for Kubernetes cluster to be ready
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

# Wait for all kube-system pods to be running
echo "Waiting for control plane pods..."
until kubectl get pods -n kube-system 2>/dev/null | grep -q "etcd"; do
  sleep 2
done

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc

echo "Cluster is ready!"
