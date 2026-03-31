#!/bin/bash
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-app
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: manual
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-shared
  namespace: practice
spec:
  accessModes:
  - ReadWriteMany
  resources:
    requests:
      storage: 8Gi
  storageClassName: manual
EOF
# Wait for PVCs to bind
for i in $(seq 1 30); do
  S1=$(kubectl get pvc pvc-app -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  S2=$(kubectl get pvc pvc-shared -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S1" = "Bound" ] && [ "$S2" = "Bound" ] && break
  sleep 2
done
kubectl get pvc -n practice
kubectl get pv
