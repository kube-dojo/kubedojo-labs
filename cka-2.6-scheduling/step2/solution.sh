#!/bin/bash
NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl taint node "$NODE_NAME" env=prod:NoSchedule --overwrite 2>/dev/null || true

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: tolerant-pod
  namespace: practice
spec:
  tolerations:
  - key: "env"
    operator: "Equal"
    value: "prod"
    effect: "NoSchedule"
  containers:
  - name: nginx
    image: nginx:1.25
EOF
kubectl wait --for=condition=Ready pod/tolerant-pod -n practice --timeout=60s

# Clean up taint
kubectl taint node "$NODE_NAME" env=prod:NoSchedule- 2>/dev/null || true
kubectl delete pod no-tolerate -n practice --ignore-not-found
