#!/bin/bash
# Setup script — pre-break things for troubleshooting

# Wait for cluster to be ready
kubectl wait --for=condition=Ready node --all --timeout=120s 2>/dev/null

# Set up aliases
echo 'alias k=kubectl' >> /root/.bashrc
echo 'source <(kubectl completion bash)' >> /root/.bashrc
echo 'complete -o default -F __start_kubectl k' >> /root/.bashrc

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
