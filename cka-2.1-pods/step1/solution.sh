#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: sidecar-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: shared-data
      mountPath: /usr/share/nginx/html
  - name: sidecar
    image: busybox:1.36
    command: ["/bin/sh", "-c", "while true; do date > /data/index.html; sleep 5; done"]
    volumeMounts:
    - name: shared-data
      mountPath: /data
  volumes:
  - name: shared-data
    emptyDir: {}
EOF
kubectl wait --for=condition=Ready pod/sidecar-pod -n practice --timeout=60s
