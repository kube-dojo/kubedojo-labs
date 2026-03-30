#!/bin/bash
kubectl delete pod pending-pod -n debug-lab --grace-period=0 --force
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pending-pod
  namespace: debug-lab
spec:
  containers:
  - name: app
    image: nginx:1.25
    resources:
      requests:
        cpu: "100m"
        memory: "128Mi"
YAML
kubectl wait --for=condition=Ready pod/pending-pod -n debug-lab --timeout=60s
