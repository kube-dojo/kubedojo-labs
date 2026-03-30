#!/bin/bash
# Create headless service if not exists
kubectl create service clusterip sts-svc --clusterip="None" --tcp=80:80 -n practice 2>/dev/null || true

cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: web-sts
  namespace: practice
spec:
  serviceName: "sts-svc"
  replicas: 3
  selector:
    matchLabels:
      app: web-sts
  template:
    metadata:
      labels:
        app: web-sts
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
EOF

kubectl rollout status statefulset/web-sts -n practice --timeout=120s
