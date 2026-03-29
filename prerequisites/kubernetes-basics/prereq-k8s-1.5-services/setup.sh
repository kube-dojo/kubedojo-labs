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

# Create the "web" deployment with 2 replicas for the lab exercises
echo "Creating web deployment with 2 nginx replicas..."
kubectl create deployment web --image=nginx:1.25 --replicas=2
kubectl wait --for=condition=available deployment/web --timeout=120s

echo "Setup complete. Deployment 'web' is running with 2 replicas."
