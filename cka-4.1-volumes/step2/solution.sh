#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: host-data
      mountPath: /usr/share/nginx/html
  volumes:
  - name: host-data
    hostPath:
      path: /data/hostpath-test
      type: DirectoryOrCreate
EOF
kubectl wait --for=condition=Ready pod/hostpath-pod -n practice --timeout=60s
kubectl exec hostpath-pod -n practice -- cat /usr/share/nginx/html/index.html
