#!/bin/bash
NODE_NAME=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
kubectl label node "$NODE_NAME" disk=ssd --overwrite

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: ssd-pod
  namespace: practice
spec:
  nodeSelector:
    disk: ssd
  containers:
  - name: nginx
    image: nginx:1.25
EOF
kubectl wait --for=condition=Ready pod/ssd-pod -n practice --timeout=60s
