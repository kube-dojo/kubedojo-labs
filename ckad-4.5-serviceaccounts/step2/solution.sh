#!/bin/bash
cat <<YAML | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: sa-pod
  namespace: sa-lab
spec:
  serviceAccountName: app-sa
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
YAML
kubectl wait --for=condition=Ready pod/sa-pod -n sa-lab --timeout=60s
kubectl get pod sa-pod -n sa-lab -o jsonpath='{.spec.serviceAccountName}' > /root/pod-sa.txt
