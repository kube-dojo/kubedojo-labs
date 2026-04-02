#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace netpol-lab

# Create test pods
kubectl run web --image=nginx:1.25 --labels="app=web,tier=frontend" -n netpol-lab
kubectl run api --image=nginx:1.25 --labels="app=api,tier=backend" -n netpol-lab
kubectl run db --image=nginx:1.25 --labels="app=db,tier=database" -n netpol-lab

# Expose as services
kubectl expose pod web --port=80 -n netpol-lab
kubectl expose pod api --port=80 -n netpol-lab
kubectl expose pod db --port=80 -n netpol-lab

# Wait for all pods
kubectl wait --for=condition=Ready pod/web pod/api pod/db -n netpol-lab --timeout=60s

echo "Cluster is ready!"

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
