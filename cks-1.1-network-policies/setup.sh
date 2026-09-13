#!/bin/bash
kubectl wait --for=condition=Ready node --all --timeout=120s

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
  'alias k=kubectl'
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


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
