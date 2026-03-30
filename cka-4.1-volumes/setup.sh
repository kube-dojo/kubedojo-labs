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

# Create a ConfigMap and Secret for projected volume exercise
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=LOG_LEVEL=info -n practice
kubectl create secret generic app-secret --from-literal=DB_PASSWORD=s3cret123 -n practice

# Create host directory for hostPath exercise
mkdir -p /data/hostpath-test
echo "Hello from the host!" > /data/hostpath-test/index.html

echo "Kubernetes cluster ready."
