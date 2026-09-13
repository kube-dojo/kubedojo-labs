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
# Create namespaces with labels
kubectl create namespace frontend --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace backend --dry-run=client -o yaml | kubectl apply -f -
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
kubectl label namespace frontend purpose=frontend --overwrite
kubectl label namespace backend purpose=backend --overwrite
kubectl label namespace monitoring purpose=monitoring --overwrite

# Deploy pods in each namespace
kubectl run web --image=nginx:1.25 -n frontend --labels="app=web,role=frontend" --port=80
kubectl run api --image=nginx:1.25 -n backend --labels="app=api,role=backend" --port=80
kubectl run db --image=nginx:1.25 -n backend --labels="app=db,role=database" --port=80
kubectl run monitor --image=nginx:1.25 -n monitoring --labels="app=monitor,role=monitoring" --port=80

# Expose services
kubectl expose pod web -n frontend --port=80
kubectl expose pod api -n backend --port=80
kubectl expose pod db -n backend --port=80

# Wait for pods
kubectl wait --for=condition=Ready pod --all -n frontend --timeout=60s 2>/dev/null
kubectl wait --for=condition=Ready pod --all -n backend --timeout=60s 2>/dev/null
kubectl wait --for=condition=Ready pod --all -n monitoring --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
