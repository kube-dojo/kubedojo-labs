## Create a VolumeSnapshot

A VolumeSnapshot references a PVC and creates a point-in-time copy of the data.

### Task

Create a VolumeSnapshot named `source-snapshot` in the `practice` namespace that:

1. References the `source-pvc` PersistentVolumeClaim
2. Uses the `csi-snapclass` VolumeSnapshotClass

```bash
# After creating the snapshot, check its status
kubectl get volumesnapshot -n practice
kubectl describe volumesnapshot source-snapshot -n practice
```

Note: Without a CSI driver that supports snapshots, the snapshot will not become `readyToUse: true`. The resource creation pattern is what matters for the CKA exam.

<details>
<summary>Hint: VolumeSnapshot YAML</summary>

```yaml
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshot
metadata:
  name: source-snapshot
  namespace: practice
spec:
  volumeSnapshotClassName: csi-snapclass
  source:
    persistentVolumeClaimName: source-pvc
```
</details>
