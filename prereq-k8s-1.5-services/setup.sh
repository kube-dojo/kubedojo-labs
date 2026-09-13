#!/bin/bash
# Wait for the Kubernetes cluster to be ready
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q " Ready"; do
  sleep 2
done
echo "Cluster is ready!"

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
  'complete -o default -F __start_kubectl k'
# Create the "web" deployment with 2 replicas for the lab exercises
echo "Creating web deployment with 2 nginx replicas..."
kubectl create deployment web --image=nginx:1.25 --replicas=2
kubectl wait --for=condition=available deployment/web --timeout=120s

echo "Setup complete. Deployment 'web' is running with 2 replicas."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
