## Install Snapshot CRDs and Controller

VolumeSnapshots are not built into Kubernetes core. You need to install the CRDs and a snapshot controller separately.

### Task

1. Install the VolumeSnapshot CRDs from the official repository
2. Verify the CRDs are installed
3. Create a VolumeSnapshotClass named `csi-snapclass` with driver `hostpath.csi.k8s.io` and `deletionPolicy: Delete`

```bash
# Install VolumeSnapshot CRDs
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v8.2.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshotclasses.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v8.2.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshotcontents.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-csi/external-snapshotter/v8.2.0/client/config/crd/snapshot.storage.k8s.io_volumesnapshots.yaml

# Verify CRDs
kubectl get crd | grep volumesnapshot
```

<details>
<summary>Hint: VolumeSnapshotClass YAML</summary>

```yaml
apiVersion: snapshot.storage.k8s.io/v1
kind: VolumeSnapshotClass
metadata:
  name: csi-snapclass
driver: hostpath.csi.k8s.io
deletionPolicy: Delete
```
</details>
