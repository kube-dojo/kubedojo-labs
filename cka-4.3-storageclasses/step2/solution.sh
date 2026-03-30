#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: fast-local
---
apiVersion: v1
kind: Pod
metadata:
  name: dynamic-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: nginx:1.25
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: dynamic-pvc
EOF
kubectl wait --for=condition=Ready pod/dynamic-pod -n practice --timeout=120s
kubectl get pvc -n practice
kubectl get pv
