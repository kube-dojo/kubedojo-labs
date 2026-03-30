## Restore from a Snapshot

To restore from a snapshot, create a new PVC with a `dataSource` referencing the VolumeSnapshot.

### Task

Create a PVC named `restored-pvc` in the `practice` namespace that:

1. Restores from the `source-snapshot` VolumeSnapshot
2. Requests **1Gi** of storage
3. Uses `storageClassName: manual`

```bash
# After creating the restored PVC, verify it
kubectl get pvc -n practice
kubectl describe pvc restored-pvc -n practice
```

<details>
<summary>Hint: Restore PVC YAML</summary>

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: restored-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
  dataSource:
    name: source-snapshot
    kind: VolumeSnapshot
    apiGroup: snapshot.storage.k8s.io
```

The `dataSource` field tells Kubernetes to populate the PVC from the snapshot rather than creating an empty volume.
</details>
