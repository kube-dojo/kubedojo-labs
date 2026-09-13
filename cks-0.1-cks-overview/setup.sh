#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
kubectl wait --for=condition=Ready node --all --timeout=120s

# Seed kubectl aliases into every present learner home (universal-user).
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
  'alias kn="kubectl -n"' \
  'complete -o default -F __start_kubectl k'

# Create practice namespaces
kubectl create namespace cks-practice
kubectl create namespace security-test

# Deploy an intentionally insecure workload for triage exercise
kubectl run insecure-pod --image=nginx --namespace=security-test \
  --overrides='{"spec":{"containers":[{"name":"insecure-pod","image":"nginx","securityContext":{"privileged":true,"runAsUser":0}}]}}'

kubectl run safe-pod --image=nginx --namespace=security-test \
  --overrides='{"spec":{"containers":[{"name":"safe-pod","image":"nginx","securityContext":{"runAsNonRoot":true,"runAsUser":1000,"readOnlyRootFilesystem":true,"allowPrivilegeEscalation":false}}]}}'

echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
