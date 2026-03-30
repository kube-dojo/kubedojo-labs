## Fix Access Mode Mismatch

The PVC `broken-pvc-access` requests `ReadWriteMany` but the PV `access-mode-pv` only supports `ReadWriteOnce`.

### Task

1. Diagnose the mismatch between the PV and PVC
2. Fix the issue by deleting the PVC and recreating it with the correct access mode (`ReadWriteOnce`)

```bash
# Diagnose
kubectl get pv access-mode-pv
kubectl get pvc broken-pvc-access -n practice
# Compare access modes — PV is RWO, PVC is RWX
```

<details>
<summary>Hint: Access mode fix</summary>

```bash
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
```
</details>
