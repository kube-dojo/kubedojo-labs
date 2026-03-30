## Fix Capacity Issues

The PVC `broken-pvc-capacity` requests 10Gi but the only available PV `small-pv` has 500Mi. The PVC cannot bind.

### Task

1. Diagnose the capacity mismatch
2. Fix by either:
   - Reducing the PVC request to match the PV, OR
   - Creating a larger PV to satisfy the PVC request
3. Ensure the PVC becomes Bound

```bash
# Diagnose
kubectl get pv small-pv
kubectl get pvc broken-pvc-capacity -n practice
kubectl describe pvc broken-pvc-capacity -n practice
```

<details>
<summary>Hint: Fix the capacity</summary>

Option A — reduce PVC request:
```bash
kubectl delete pvc broken-pvc-capacity -n practice
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-capacity
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
  storageClassName: capacity-test
EOF
```

Option B — create a larger PV:
```bash
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: PersistentVolume
metadata:
  name: large-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
  - ReadWriteOnce
  storageClassName: capacity-test
  hostPath:
    path: /mnt/data/fix-storage
EOF
```
</details>
