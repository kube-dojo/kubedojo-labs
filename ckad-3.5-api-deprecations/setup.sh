#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done

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
kubectl create namespace api-lab

# Create a sample manifest with old-style patterns (each learner home).
_OLD_MANIFEST=$(mktemp)
cat > "$_OLD_MANIFEST" << 'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: legacy-app
  namespace: api-lab
spec:
  replicas: 2
  selector:
    matchLabels:
      app: legacy
  template:
    metadata:
      labels:
        app: legacy
    spec:
      containers:
      - name: app
        image: nginx:1.25
YAML
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp "$_OLD_MANIFEST" "$home/old-manifest.yaml"
done
rm -f "$_OLD_MANIFEST"

echo "Cluster is ready!"


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
