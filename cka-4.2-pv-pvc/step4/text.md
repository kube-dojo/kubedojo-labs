## Reclaim Policies

The reclaim policy determines what happens to the PV when the PVC is deleted: `Retain` keeps the data, `Delete` removes the PV and its data.

### Task

1. Change the reclaim policy of `pv-small` from `Retain` to `Delete`
2. Verify the policy change
3. Create a PVC named `pvc-delete-test` (1Gi, RWO, manual) to bind to `pv-small`, then delete the PVC and observe the PV status

```bash
# Patch the reclaim policy
kubectl patch pv pv-small -p '{"spec":{"persistentVolumeReclaimPolicy":"Delete"}}'

# Verify
kubectl get pv pv-small -o jsonpath='{.spec.persistentVolumeReclaimPolicy}'

# Create a PVC, then delete it
# Observe: with Delete policy, the PV is also removed
# With Retain policy (pv-medium), the PV enters Released state
```

<details>
<summary>Hint: Reclaim policy behavior</summary>

```bash
# Create PVC to bind to pv-small
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

# Wait for binding, then delete PVC
sleep 5
kubectl delete pvc pvc-delete-test -n practice

# Check PV status — with Delete policy, pv-small may be gone
kubectl get pv
```
</details>
