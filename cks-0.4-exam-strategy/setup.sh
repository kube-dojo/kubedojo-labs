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
_seed_k_bashrc 'alias k=kubectl'

kubectl create namespace exam-practice
# Create pods needing fixes
kubectl run fix-me-1 --image=nginx -n exam-practice --overrides='{"spec":{"containers":[{"name":"fix-me-1","image":"nginx","securityContext":{"privileged":true}}]}}'
kubectl run fix-me-2 --image=nginx -n exam-practice --overrides='{"spec":{"containers":[{"name":"fix-me-2","image":"nginx","securityContext":{"runAsUser":0}}]}}'
kubectl create serviceaccount exam-sa -n exam-practice
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
