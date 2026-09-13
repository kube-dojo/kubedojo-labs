#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

_seed_k_bashrc() {
  local home line
  for home in /root /home/ubuntu; do
    [ -d "$home" ] || continue
    touch "$home/.bashrc"
    for line in "$@"; do
      grep -qxF "$line" "$home/.bashrc" 2>/dev/null || echo "$line" >> "$home/.bashrc"
    done
  done
}
_seed_k_bashrc \
  'alias k=kubectl' \
  'complete -o default -F __start_kubectl k'
kubectl create namespace ingress-lab

# Install NGINX Ingress Controller
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/baremetal/deploy.yaml 2>/dev/null || true

# Create backend services
kubectl create deployment frontend --image=nginx:1.25 --replicas=2 -n ingress-lab
kubectl create deployment backend --image=httpd:2.4 --replicas=2 -n ingress-lab
kubectl expose deployment frontend --port=80 -n ingress-lab
kubectl expose deployment backend --port=80 -n ingress-lab

echo "Cluster is ready!"


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
