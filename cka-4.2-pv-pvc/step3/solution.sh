#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: pvc-pod
  namespace: practice
spec:
  containers:
  - name: nginx
    image: nginx:1.25
    volumeMounts:
    - name: app-storage
      mountPath: /usr/share/nginx/html
  volumes:
  - name: app-storage
    persistentVolumeClaim:
      claimName: pvc-app
EOF
kubectl wait --for=condition=Ready pod/pvc-pod -n practice --timeout=60s
kubectl exec pvc-pod -n practice -- bash -c 'echo "Persistent data!" > /usr/share/nginx/html/test.txt'
