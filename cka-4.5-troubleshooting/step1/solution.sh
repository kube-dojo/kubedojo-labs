#!/bin/bash
kubectl delete pvc broken-pvc-class -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: fix-class-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data/fix-storage
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-class
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
EOF
sleep 5
kubectl get pvc broken-pvc-class -n practice
