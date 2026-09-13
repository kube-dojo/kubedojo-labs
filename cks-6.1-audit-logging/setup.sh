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
kubectl create namespace audit-lab
mkdir -p /var/log/kubernetes/audit
mkdir -p /etc/kubernetes/audit
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp /etc/kubernetes/manifests/kube-apiserver.yaml "$home/kube-apiserver-backup.yaml"
done
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
