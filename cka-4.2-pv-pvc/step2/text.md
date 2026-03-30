## Create PersistentVolumeClaims

PVCs are namespace-scoped requests for storage. Kubernetes matches PVCs to available PVs based on size, access modes, and storage class.

### Task

Create two PVCs in the `practice` namespace:

1. `pvc-app` — requests **2Gi**, accessModes: `ReadWriteOnce`, storageClassName: `manual`
2. `pvc-shared` — requests **8Gi**, accessModes: `ReadWriteMany`, storageClassName: `manual`

```bash
# After creating PVCs, check binding status
kubectl get pvc -n practice
kubectl get pv
```

Observe how:
- `pvc-app` (2Gi, RWO) binds to `pv-medium` (5Gi, RWO) — the smallest PV that satisfies the request
- `pvc-shared` (8Gi, RWM) binds to `pv-large` (10Gi, RWM) — matches access mode and size

<details>
<summary>Hint: PVC YAML</summary>

```yaml
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
```
</details>
