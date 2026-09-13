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
curl -sSL https://github.com/controlplaneio/kubesec/releases/download/v2.14.0/kubesec_linux_amd64.tar.gz | tar xz -C /usr/local/bin kubesec 2>/dev/null || true
kubectl create namespace static-lab
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
