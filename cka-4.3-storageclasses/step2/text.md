## Dynamic Provisioning with PVCs

With dynamic provisioning, PVCs reference a StorageClass and the provisioner automatically creates PVs.

### Task

1. Create a PVC named `dynamic-pvc` in the `practice` namespace requesting **1Gi** with `storageClassName: fast-local`
2. Create a pod named `dynamic-pod` that uses this PVC
3. Verify a PV was automatically created and bound

```bash
# Create the PVC
# Note: with WaitForFirstConsumer, PVC stays Pending until a pod uses it

# Create a pod that uses the PVC, then check
kubectl get pvc -n practice
kubectl get pv
```

<details>
<summary>Hint: Dynamic provisioning</summary>

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: dynamic-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: fast-local
---
apiVersion: v1
kind: Pod
metadata:
  name: dynamic-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: nginx:1.25
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: dynamic-pvc
```
</details>
