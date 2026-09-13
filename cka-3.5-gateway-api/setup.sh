#!/bin/bash
# Setup script — runs before user starts

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null


# Set up aliases
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
  'source <(kubectl completion bash)' \
  'complete -o default -F __start_kubectl k'
# Create practice namespace
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -

# Deploy two versions of an application
kubectl create deployment app-v1 --image=nginx:1.25 --replicas=2 -n practice
kubectl create deployment app-v2 --image=httpd:2.4 --replicas=2 -n practice
kubectl expose deployment app-v1 -n practice --port=80
kubectl expose deployment app-v2 -n practice --port=80

# Wait for pods
kubectl wait --for=condition=Ready pod --all -n practice --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
