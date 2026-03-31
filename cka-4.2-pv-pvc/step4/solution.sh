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
# Wait for PVC to bind
for i in $(seq 1 30); do
  STATUS=$(kubectl get pvc pvc-delete-test -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Bound" ] && break
  sleep 2
done
kubectl delete pvc pvc-delete-test -n practice
sleep 3
kubectl get pv
