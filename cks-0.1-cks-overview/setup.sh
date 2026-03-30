#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
kubectl wait --for=condition=Ready node --all --timeout=120s

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'alias kn="kubectl -n"' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc

# Create practice namespaces
kubectl create namespace cks-practice
kubectl create namespace security-test

# Deploy an intentionally insecure workload for triage exercise
kubectl run insecure-pod --image=nginx --namespace=security-test \
  --overrides='{"spec":{"containers":[{"name":"insecure-pod","image":"nginx","securityContext":{"privileged":true,"runAsUser":0}}]}}'

kubectl run safe-pod --image=nginx --namespace=security-test \
  --overrides='{"spec":{"containers":[{"name":"safe-pod","image":"nginx","securityContext":{"runAsNonRoot":true,"runAsUser":1000,"readOnlyRootFilesystem":true,"allowPrivilegeEscalation":false}}]}}'

echo "Setup complete."
