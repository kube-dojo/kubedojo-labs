#!/bin/bash
# Wait for the Kubernetes cluster to be ready
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q " Ready"; do
  sleep 2
done
echo "Cluster is ready!"

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc

echo "Setup complete. Your cluster is ready for kubectl exploration."
