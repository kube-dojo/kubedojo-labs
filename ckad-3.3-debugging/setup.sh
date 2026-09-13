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
kubectl create namespace debug-lab

# Crashing pod
kubectl run crasher --image=busybox:1.36 -n debug-lab -- sh -c "echo starting; exit 1"

# Pod with excessive resource request
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pending-pod
  namespace: debug-lab
spec:
  containers:
  - name: app
    image: nginx:1.25
    resources:
      requests:
        cpu: "100"
        memory: "1000Gi"
YAML

echo "Cluster is ready!"


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
