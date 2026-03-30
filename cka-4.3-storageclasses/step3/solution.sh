#!/bin/bash
kubectl annotate sc fast-local storageclass.kubernetes.io/is-default-class=true --overwrite
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: default-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
---
apiVersion: v1
kind: Pod
metadata:
  name: default-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: default-pvc
EOF
kubectl wait --for=condition=Ready pod/default-pod -n practice --timeout=120s
kubectl get sc
kubectl get pvc -n practice
