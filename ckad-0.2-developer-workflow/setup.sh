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

kubectl create namespace dev-workflow

# Pre-create a deployment for step 3
kubectl create deployment webapp --image=nginx:1.24 --replicas=2 -n dev-workflow
kubectl rollout status deployment/webapp -n dev-workflow --timeout=60s

echo "Cluster is ready!"

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
