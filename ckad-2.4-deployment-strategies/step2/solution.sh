#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: recreate-app
  namespace: strategy-lab
spec:
  replicas: 3
  strategy:
    type: Recreate
  selector:
    matchLabels:
      app: recreate-app
  template:
    metadata:
      labels:
        app: recreate-app
    spec:
      containers:
      - name: httpd
        image: httpd:2.4.58
YAML
kubectl rollout status deployment/recreate-app -n strategy-lab --timeout=60s
kubectl set image deployment/recreate-app httpd=httpd:2.4.59 -n strategy-lab
kubectl rollout status deployment/recreate-app -n strategy-lab --timeout=60s
kubectl get deployment recreate-app -n strategy-lab -o jsonpath='{.spec.strategy.type}' > /root/recreate-strategy.txt
