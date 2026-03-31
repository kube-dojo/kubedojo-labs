#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: liveness-http
  namespace: probes-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    livenessProbe:
      httpGet:
        path: /
        port: 80
      initialDelaySeconds: 5
      periodSeconds: 10
---
apiVersion: v1
kind: Pod
metadata:
  name: liveness-exec
  namespace: probes-lab
spec:
  containers:
  - name: busybox
    image: busybox:1.36
    command: ["sh", "-c", "touch /tmp/healthy; sleep 3600"]
    livenessProbe:
      exec:
        command:
        - cat
        - /tmp/healthy
      initialDelaySeconds: 5
      periodSeconds: 5
YAML
kubectl wait --for=condition=Ready pod/liveness-http -n probes-lab --timeout=120s 2>/dev/null || true
kubectl wait --for=condition=Ready pod/liveness-exec -n probes-lab --timeout=120s 2>/dev/null || true
