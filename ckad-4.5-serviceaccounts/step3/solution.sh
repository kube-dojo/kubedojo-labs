#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: no-token-pod
  namespace: sa-lab
spec:
  serviceAccountName: app-sa
  automountServiceAccountToken: false
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
YAML
kubectl wait --for=condition=Ready pod/no-token-pod -n sa-lab --timeout=60s
echo "false" > /root/automount-value.txt
