#!/bin/bash
# Setup script — runs before user starts

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

# Create practice namespace
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -

# Get the node name for reference
NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
echo "export NODE_NAME=$NODE_NAME" >> /root/.bashrc
echo "Node name: $NODE_NAME"

echo "Kubernetes cluster ready."
