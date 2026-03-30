# Create PVs and PVCs

PersistentVolumes (PVs) represent storage in the cluster. PersistentVolumeClaims (PVCs) are requests for storage by users.

## Task

1. Create a PersistentVolume named `pv-data` with:
   - Capacity: `1Gi`
   - AccessMode: `ReadWriteOnce`
   - hostPath: `/data/pv-data`
   - storageClassName: `manual`

2. Create a PersistentVolumeClaim named `pvc-data` in `volumes-lab` with:
   - Request: `500Mi`
   - AccessMode: `ReadWriteOnce`
   - storageClassName: `manual`

3. Verify the PVC is Bound and save its status to `/root/pvc-status.txt`.

## Hint

PVCs bind to PVs when storageClassName, accessMode, and capacity match (PV capacity >= PVC request).
