## Create PersistentVolumes

PersistentVolumes are cluster-level storage resources provisioned by administrators.

### Task

Create three PersistentVolumes:

1. `pv-small` — **1Gi**, accessModes: `ReadWriteOnce`, hostPath: `/mnt/data/pv-small`
2. `pv-medium` — **5Gi**, accessModes: `ReadWriteOnce`, hostPath: `/mnt/data/pv-medium`
3. `pv-large` — **10Gi**, accessModes: `ReadWriteMany`, hostPath: `/mnt/data/pv-large`

All should use `storageClassName: manual`.

```bash
# After creating PVs, verify they are Available
kubectl get pv
```

<details>
<summary>Hint: PV YAML</summary>

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-small
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: manual
  hostPath:
    path: /mnt/data/pv-small
```

Repeat for pv-medium (5Gi) and pv-large (10Gi, ReadWriteMany).
</details>
