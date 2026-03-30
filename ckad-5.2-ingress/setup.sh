#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace ingress-lab

# Install NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/baremetal/deploy.yaml 2>/dev/null || true

# Create backend services
kubectl create deployment frontend --image=nginx:1.25 --replicas=2 -n ingress-lab
kubectl create deployment backend --image=httpd:2.4 --replicas=2 -n ingress-lab
kubectl expose deployment frontend --port=80 -n ingress-lab
kubectl expose deployment backend --port=80 -n ingress-lab

echo "Cluster is ready!"
