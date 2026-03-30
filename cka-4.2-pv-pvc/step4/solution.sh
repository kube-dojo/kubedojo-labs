#!/bin/bash
kubectl patch pv pv-small -p '{"spec":{"persistentVolumeReclaimPolicy":"Delete"}}'
sleep 2
kubectl get pv pv-small -o jsonpath='{.spec.persistentVolumeReclaimPolicy}'
echo ""
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: pvc-delete-test
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
kubectl delete pvc pvc-delete-test -n practice
sleep 3
kubectl get pv
