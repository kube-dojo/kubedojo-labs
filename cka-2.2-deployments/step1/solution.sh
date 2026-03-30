#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-deploy
  namespace: practice
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: web-deploy
  template:
    metadata:
      labels:
        app: web-deploy
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
EOF
kubectl rollout status deployment/web-deploy -n practice --timeout=120s
kubectl set image deployment/web-deploy nginx=nginx:1.25 -n practice
kubectl rollout status deployment/web-deploy -n practice --timeout=120s
