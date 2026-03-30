#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: resource-pod
  namespace: practice
spec:
  containers:
  - name: resource-pod
    image: nginx:1.25
    resources:
      requests:
        cpu: "100m"
        memory: "64Mi"
      limits:
        cpu: "200m"
        memory: "128Mi"
EOF
kubectl wait --for=condition=Ready pod/resource-pod -n practice --timeout=60s
