## Fix PVC Stuck in Pending — Wrong StorageClass

The PVC `broken-pvc-class` is stuck in Pending because it references a StorageClass that does not exist.

### Task

1. Diagnose why `broken-pvc-class` is Pending
2. Fix the issue by deleting the broken PVC and recreating it with `storageClassName: manual`
3. Create a matching PV so the PVC can bind

```bash
# Diagnose
kubectl get pvc broken-pvc-class -n practice
kubectl describe pvc broken-pvc-class -n practice
# Look at the Events — "storageclass.storage.k8s.io "nonexistent-class" not found"
```

<details>
<summary>Hint: Fixing the StorageClass issue</summary>

You cannot change the storageClassName of an existing PVC. Delete and recreate it:

```bash
kubectl delete pvc broken-pvc-class -n practice

# Create matching PV and PVC
cat <<'EOF' | kubectl apply -f -
apiVersion: v1
kind: PersistentVolume
metadata:
  name: fix-class-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
  - ReadWriteOnce
  storageClassName: manual
  hostPath:
    path: /mnt/data/fix-storage
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: broken-pvc-class
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: manual
EOF
```
</details>
