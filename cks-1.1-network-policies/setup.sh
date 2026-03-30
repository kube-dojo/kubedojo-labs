#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s
echo 'alias k=kubectl' >> /root/.bashrc
source /root/.bashrc

kubectl create namespace netpol-lab
kubectl create namespace backend
kubectl create namespace frontend

# Deploy test workloads
kubectl run web --image=nginx --labels="app=web,tier=frontend" -n frontend
kubectl run api --image=nginx --labels="app=api,tier=backend" -n backend
kubectl run db --image=nginx --labels="app=db,tier=database" -n backend

kubectl wait --for=condition=Ready pod/web -n frontend --timeout=60s
kubectl wait --for=condition=Ready pod/api -n backend --timeout=60s
kubectl wait --for=condition=Ready pod/db -n backend --timeout=60s

# Expose services
kubectl expose pod web --port=80 -n frontend
kubectl expose pod api --port=80 -n backend
kubectl expose pod db --port=80 -n backend

echo "Setup complete."
