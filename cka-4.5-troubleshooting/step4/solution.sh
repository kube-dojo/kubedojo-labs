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
# Wait for PVC to bind
for i in $(seq 1 30); do
  STATUS=$(kubectl get pvc broken-pvc-capacity -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Bound" ] && break
  sleep 2
done
kubectl get pvc broken-pvc-capacity -n practice
kubectl get pv
