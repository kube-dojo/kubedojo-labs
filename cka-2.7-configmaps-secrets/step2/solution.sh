#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: config-vol-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: config-volume
      mountPath: /etc/config
  volumes:
  - name: config-volume
    configMap:
      name: app-config
EOF
kubectl wait --for=condition=Ready pod/config-vol-pod -n practice --timeout=60s
