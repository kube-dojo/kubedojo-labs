#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace svc-lab
kubectl create deployment web --image=nginx:1.25 --replicas=3 -n svc-lab
kubectl rollout status deployment/web -n svc-lab --timeout=60s
echo "Cluster is ready!"
