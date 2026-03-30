#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: rolling-app
  namespace: strategy-lab
spec:
  replicas: 4
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  selector:
    matchLabels:
      app: rolling-app
  template:
    metadata:
      labels:
        app: rolling-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
YAML
kubectl rollout status deployment/rolling-app -n strategy-lab --timeout=60s
kubectl set image deployment/rolling-app nginx=nginx:1.25 -n strategy-lab
kubectl rollout status deployment/rolling-app -n strategy-lab --timeout=60s
kubectl get deployment rolling-app -n strategy-lab -o jsonpath='{.spec.strategy.type}' > /root/strategy-type.txt
