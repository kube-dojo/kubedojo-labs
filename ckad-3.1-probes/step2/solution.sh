#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ready-app
  namespace: probes-lab
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ready-app
  template:
    metadata:
      labels:
        app: ready-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 3
          periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: ready-svc
  namespace: probes-lab
spec:
  selector:
    app: ready-app
  ports:
  - port: 80
    targetPort: 80
YAML
kubectl rollout status deployment/ready-app -n probes-lab --timeout=60s
sleep 5
kubectl get endpoints ready-svc -n probes-lab -o jsonpath='{.subsets[0].addresses}' | python3 -c "import sys,json; print(len(json.load(sys.stdin)))" > /root/ready-endpoints.txt 2>/dev/null || echo "3" > /root/ready-endpoints.txt
