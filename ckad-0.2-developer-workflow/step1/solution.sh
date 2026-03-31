#!/bin/bash
kubectl run frontend --image=nginx:1.25 --dry-run=client -o yaml > /root/frontend.yaml

# Add label and port
cat > /root/frontend.yaml << 'YAML'
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: frontend
    tier: frontend
  name: frontend
spec:
  containers:
  - image: nginx:1.25
    name: frontend
    ports:
    - containerPort: 80
YAML

kubectl apply -f /root/frontend.yaml -n dev-workflow
kubectl wait --for=condition=Ready pod/frontend -n dev-workflow --timeout=120s 2>/dev/null || true
