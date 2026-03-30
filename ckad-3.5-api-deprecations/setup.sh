#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace api-lab

# Create a sample manifest with old-style patterns
cat > /root/old-manifest.yaml << 'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: legacy-app
  namespace: api-lab
spec:
  replicas: 2
  selector:
    matchLabels:
      app: legacy
  template:
    metadata:
      labels:
        app: legacy
    spec:
      containers:
      - name: app
        image: nginx:1.25
YAML

echo "Cluster is ready!"
