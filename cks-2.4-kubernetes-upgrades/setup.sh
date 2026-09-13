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
kubectl create namespace upgrade-test
kubectl run test-app --image=nginx -n upgrade-test
kubectl wait --for=condition=Ready pod/test-app -n upgrade-test --timeout=60s
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
