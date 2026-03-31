#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vuln-app
  namespace: security-lab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: vuln-app
  template:
    metadata:
      labels:
        app: vuln-app
    spec:
      containers:
      - name: nginx
        image: nginx:1.19
        securityContext:
          privileged: true
          runAsUser: 0
YAML

cat <<YAML | kubectl apply -f -
apiVersion: apps/v1
kind: Deployment
metadata:
  name: hardened-app
  namespace: security-lab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: hardened-app
  template:
    metadata:
      labels:
        app: hardened-app
    spec:
      containers:
      - name: nginx
        image: nginx:latest
        securityContext:
          runAsNonRoot: true
          runAsUser: 101
          readOnlyRootFilesystem: true
          allowPrivilegeEscalation: false
          capabilities:
            drop: ["ALL"]
            add: ["NET_BIND_SERVICE"]
        volumeMounts:
        - name: cache
          mountPath: /var/cache/nginx
        - name: run
          mountPath: /var/run
        - name: tmp
          mountPath: /tmp
      volumes:
      - name: cache
        emptyDir: {}
      - name: run
        emptyDir: {}
      - name: tmp
        emptyDir: {}
YAML

kubectl wait --for=condition=Available deployment/vuln-app -n security-lab --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Available deployment/hardened-app -n security-lab --timeout=120s 2>/dev/null || true
