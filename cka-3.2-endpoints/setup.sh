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

# Deploy a simple nginx deployment with 3 replicas
kubectl create deployment web --image=nginx:1.25 --replicas=3 -n practice
kubectl expose deployment web -n practice --port=80

# Wait for pods to be ready
kubectl wait --for=condition=Ready pod -l app=web -n practice --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready."
