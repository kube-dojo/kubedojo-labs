#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: env-pod
  namespace: cm-lab
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sh", "-c", "env | sort; sleep 3600"]
    envFrom:
    - configMapRef:
        name: app-config
YAML
kubectl wait --for=condition=Ready pod/env-pod -n cm-lab --timeout=60s
kubectl exec env-pod -n cm-lab -- printenv APP_ENV > /root/app-env-value.txt
