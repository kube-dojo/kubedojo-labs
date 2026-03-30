#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc

kubectl create namespace dev-workflow

# Pre-create a deployment for step 3
kubectl create deployment webapp --image=nginx:1.24 --replicas=2 -n dev-workflow
kubectl rollout status deployment/webapp -n dev-workflow --timeout=60s

echo "Cluster is ready!"
