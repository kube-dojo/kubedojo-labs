#!/bin/bash
# Create a larger PV to satisfy the 10Gi request
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: large-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: capacity-test
  hostPath:
    path: /mnt/data/fix-storage
EOF
sleep 5
kubectl get pvc broken-pvc-capacity -n practice
kubectl get pv
