#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: slow-start
  namespace: probes-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    ports:
    - containerPort: 80
    startupProbe:
      httpGet:
        path: /
        port: 80
      failureThreshold: 30
      periodSeconds: 2
    livenessProbe:
      httpGet:
        path: /
        port: 80
      periodSeconds: 10
---
apiVersion: v1
kind: Pod
metadata:
  name: failing-probe
  namespace: probes-lab
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    livenessProbe:
      httpGet:
        path: /nonexistent
        port: 80
      initialDelaySeconds: 1
      periodSeconds: 3
      failureThreshold: 3
YAML
sleep 15
kubectl get pod failing-probe -n probes-lab -o jsonpath='{.status.containerStatuses[0].restartCount}' > /root/restart-count.txt
