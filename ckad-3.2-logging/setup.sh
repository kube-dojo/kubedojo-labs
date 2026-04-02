#!/bin/bash
echo "Waiting for Kubernetes cluster to be ready..."
until kubectl get nodes 2>/dev/null | grep -q "Ready"; do
  sleep 2
done
echo 'alias k=kubectl' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc
source /root/.bashrc
kubectl create namespace logging-lab

# Create a pod that generates logs
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: log-generator
  namespace: logging-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "i=0; while true; do echo \"$(date) INFO Log entry $i\"; i=$((i+1)); sleep 2; done"]
  - name: sidecar
    image: busybox:1.36
    command: ["sh", "-c", "while true; do echo \"$(date) SIDECAR health check ok\"; sleep 5; done"]
YAML

echo "Cluster is ready!"

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
