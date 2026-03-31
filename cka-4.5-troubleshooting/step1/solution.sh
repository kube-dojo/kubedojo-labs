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
# Wait for PVC to bind
for i in $(seq 1 30); do
  STATUS=$(kubectl get pvc broken-pvc-class -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Bound" ] && break
  sleep 2
done
kubectl get pvc broken-pvc-class -n practice
