#!/bin/bash
mkdir -p "$HOME"/kustomize/base

cat > "$HOME"/kustomize/base/deployment.yaml << 'YAML'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: nginx:1.25
        ports:
        - containerPort: 80
YAML

cat > "$HOME"/kustomize/base/service.yaml << 'YAML'
apiVersion: v1
kind: Service
metadata:
  name: myapp
spec:
  selector:
    app: myapp
  ports:
  - port: 80
    targetPort: 80
YAML

cat > "$HOME"/kustomize/base/kustomization.yaml << 'YAML'
resources:
- deployment.yaml
- service.yaml
YAML

kubectl kustomize "$HOME"/kustomize/base/ > "$HOME"/base-output.yaml
