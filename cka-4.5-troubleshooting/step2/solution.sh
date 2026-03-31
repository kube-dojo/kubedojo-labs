#!/bin/bash
kubectl delete pvc broken-pvc-access -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-access
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
  storageClassName: access-test
EOF
# Wait for PVC to bind
for i in $(seq 1 30); do
  STATUS=$(kubectl get pvc broken-pvc-access -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Bound" ] && break
  sleep 2
done
kubectl get pvc broken-pvc-access -n practice
