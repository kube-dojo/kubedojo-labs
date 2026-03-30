#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: user-pod
  namespace: security-lab
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "id; sleep 3600"]
YAML
kubectl wait --for=condition=Ready pod/user-pod -n security-lab --timeout=60s
kubectl logs user-pod -n security-lab > /root/user-id.txt
