#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: env-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    envFrom:
    - configMapRef:
        name: app-config
EOF
kubectl wait --for=condition=Ready pod/env-pod -n practice --timeout=60s
