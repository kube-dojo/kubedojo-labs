#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: blue-app
  namespace: strategy-lab
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: blue
  template:
    metadata:
      labels:
        app: myapp
        version: blue
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: myapp-svc
  namespace: strategy-lab
spec:
  selector:
    app: myapp
    version: blue
  ports:
  - port: 80
    targetPort: 80
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: green-app
  namespace: strategy-lab
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      version: green
  template:
    metadata:
      labels:
        app: myapp
        version: green
    spec:
      containers:
      - name: nginx
        image: nginx:1.25
        ports:
        - containerPort: 80
YAML
kubectl rollout status deployment/blue-app -n strategy-lab --timeout=60s
kubectl rollout status deployment/green-app -n strategy-lab --timeout=60s
kubectl patch svc myapp-svc -n strategy-lab -p '{"spec":{"selector":{"version":"green"}}}'
kubectl get svc myapp-svc -n strategy-lab -o jsonpath='{.spec.selector.version}' > /root/active-version.txt
