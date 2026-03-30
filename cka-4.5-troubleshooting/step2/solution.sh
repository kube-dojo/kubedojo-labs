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
sleep 5
kubectl get pvc broken-pvc-access -n practice
