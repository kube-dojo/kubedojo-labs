#!/bin/bash
# Wait for Kubernetes cluster to be ready
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

# Create the rbac-test namespace
kubectl create namespace rbac-test

echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc

echo "Cluster is ready!"
