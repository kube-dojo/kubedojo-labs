#!/bin/bash
# Setup script — runs before user starts

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

# Create practice namespace
kubectl create namespace practice --dry-run=client -o yaml | kubectl apply -f -

# Create a multi-container pod for log exercises
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: multi-log
  namespace: practice
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do echo \"$(date) [APP] Processing request\"; sleep 5; done"]
  - name: sidecar
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do echo \"$(date) [SIDECAR] Health check OK\"; sleep 10; done"]
EOF

# Create a pod that generates warning events
kubectl run event-generator --image=busybox:1.36 -n practice -- sh -c "echo 'Starting...'; sleep 3600"

# Create some activity for events
kubectl create deployment log-demo --image=nginx:1.25 --replicas=2 -n practice
kubectl scale deployment log-demo -n practice --replicas=4
kubectl scale deployment log-demo -n practice --replicas=2

# Wait for pods
kubectl wait --for=condition=Ready pod --all -n practice --timeout=60s 2>/dev/null

echo "Kubernetes cluster ready."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
