## Default StorageClass

A default StorageClass is used when a PVC does not specify a `storageClassName`. You set it with the annotation `storageclass.kubernetes.io/is-default-class: "true"`.

### Task

1. Mark `fast-local` as the default StorageClass
2. Create a PVC named `default-pvc` in the `practice` namespace requesting **500Mi** without specifying a storageClassName
3. Create a pod named `default-pod` using this PVC and verify it binds using `fast-local`

```bash
# Set fast-local as default
kubectl annotate sc fast-local storageclass.kubernetes.io/is-default-class=true

# Verify (default) marker
kubectl get sc

# Create PVC without storageClassName
# It should automatically use fast-local
```

<details>
<summary>Hint: Default StorageClass PVC</summary>

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: default-pvc
  namespace: practice
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 500Mi
  # No storageClassName — uses the default
---
apiVersion: v1
kind: Pod
metadata:
  name: default-pod
  namespace: practice
spec:
  containers:
  - name: app
    image: busybox:1.36
    command: ["sleep", "3600"]
    volumeMounts:
    - name: data
      mountPath: /data
  volumes:
  - name: data
    persistentVolumeClaim:
      claimName: default-pvc
```
</details>
