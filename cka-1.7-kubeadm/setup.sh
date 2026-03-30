#!/bin/bash
# Wait for Kubernetes cluster to be ready
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc

echo "Cluster is ready!"
