#!/bin/bash
# Setup script — runs before user starts

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

# Create namespaces
kubectl create namespace frontend --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace backend --dry-run=client -o yaml | kubectl apply -f -

# Deploy services in different namespaces
kubectl run web --image=nginx:1.25 -n frontend --labels="app=web" --port=80
kubectl expose pod web -n frontend --port=80
kubectl run api --image=nginx:1.25 -n backend --labels="app=api" --port=80
kubectl expose pod api -n backend --port=80

# Wait for pods to be ready
kubectl wait --for=condition=Ready pod --all -n frontend --timeout=60s 2>/dev/null
kubectl wait --for=condition=Ready pod --all -n backend --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
