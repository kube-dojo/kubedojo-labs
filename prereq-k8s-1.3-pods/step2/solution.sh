#!/bin/bash
cat <<EOF > /root/api-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: api
spec:
  containers:
  - name: api
    image: busybox
    command: ["sleep", "3600"]
EOF
kubectl apply -f /root/api-pod.yaml
kubectl wait --for=condition=Ready pod/api --timeout=120s
