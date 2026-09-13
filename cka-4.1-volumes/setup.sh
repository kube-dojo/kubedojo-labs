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

# Create a ConfigMap and Secret for projected volume exercise
kubectl create configmap app-config --from-literal=APP_ENV=production --from-literal=LOG_LEVEL=info -n practice
kubectl create secret generic app-secret --from-literal=DB_PASSWORD=s3cret123 -n practice

# Create host directory for hostPath exercise
mkdir -p /data/hostpath-test
echo "Hello from the host!" > /data/hostpath-test/index.html

echo "Kubernetes cluster ready."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
