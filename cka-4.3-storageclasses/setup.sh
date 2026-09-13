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

# Install local-path-provisioner for dynamic provisioning
kubectl apply -f https://raw.githubusercontent.com/rancher/local-path-provisioner/v0.0.30/deploy/local-path-storage.yaml 2>/dev/null || true
kubectl wait --for=condition=Ready pod -l app=local-path-provisioner -n local-path-storage --timeout=120s 2>/dev/null || true

echo "Kubernetes cluster ready."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
