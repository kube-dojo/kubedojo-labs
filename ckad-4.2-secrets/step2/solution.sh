#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: secret-env-pod
  namespace: secrets-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    env:
    - name: DB_USER
      valueFrom:
        secretKeyRef:
          name: db-creds
          key: username
    - name: DB_PASS
      valueFrom:
        secretKeyRef:
          name: db-creds
          key: password
YAML
kubectl wait --for=condition=Ready pod/secret-env-pod -n secrets-lab --timeout=60s
kubectl exec secret-env-pod -n secrets-lab -- printenv DB_USER > /root/db-user.txt
