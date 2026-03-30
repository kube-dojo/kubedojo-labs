#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: low-priority
value: 100
globalDefault: false
description: "Low priority workloads"
---
apiVersion: scheduling.k8s.io/v1
kind: PriorityClass
metadata:
  name: critical-priority
value: 1000000
globalDefault: false
description: "Critical workloads"
EOF

cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: low-pod
  namespace: practice
spec:
  priorityClassName: low-priority
  containers:
  - name: nginx
    image: nginx:1.25
---
apiVersion: v1
kind: Pod
metadata:
  name: critical-pod
  namespace: practice
spec:
  priorityClassName: critical-priority
  containers:
  - name: nginx
    image: nginx:1.25
EOF
kubectl wait --for=condition=Ready pod/critical-pod -n practice --timeout=60s
