#!/bin/bash
# Setup script — pre-break things for troubleshooting

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

# Create a broken pod for describe exercise (wrong image)
kubectl run broken-app --image=ngnix:latset -n practice 2>/dev/null || true

# Create a running pod for debug exercise
kubectl run debug-target --image=nginx:1.25 -n practice
kubectl wait --for=condition=Ready pod/debug-target -n practice --timeout=60s 2>/dev/null

# Create broken deployment for comprehensive exercise
kubectl create deployment webapp --image=nginx:1.25 --replicas=3 -n practice
kubectl wait --for=condition=Available deployment/webapp -n practice --timeout=60s 2>/dev/null
# Now break it by setting wrong image
kubectl set image deployment/webapp nginx=nginx:nonexistent-tag -n practice 2>/dev/null

echo "Kubernetes cluster ready. Broken resources created for troubleshooting."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
