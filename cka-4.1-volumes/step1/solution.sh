#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: cache-pod
  namespace: practice
spec:
  containers:
  - name: writer
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do date > /cache/data.txt; sleep 3; done"]
    volumeMounts:
    - name: cache-vol
      mountPath: /cache
  - name: reader
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do cat /cache/data.txt; sleep 5; done"]
    volumeMounts:
    - name: cache-vol
      mountPath: /cache
  volumes:
  - name: cache-vol
    emptyDir:
      sizeLimit: 100Mi
EOF
kubectl wait --for=condition=Ready pod/cache-pod -n practice --timeout=60s
