## Create StorageClasses

StorageClasses define "classes" of storage with different performance characteristics, provisioners, and parameters.

### Task

1. List existing StorageClasses in the cluster
2. Create a StorageClass named `fast-local` using the `rancher.io/local-path` provisioner with `reclaimPolicy: Delete` and `volumeBindingMode: WaitForFirstConsumer`
3. Create a StorageClass named `standard-local` using the same provisioner with `reclaimPolicy: Retain`

```bash
# Check existing StorageClasses
kubectl get storageclass

# After creating, verify
kubectl get sc
kubectl describe sc fast-local
```

<details>
<summary>Hint: StorageClass YAML</summary>

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast-local
provisioner: rancher.io/local-path
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
---
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard-local
provisioner: rancher.io/local-path
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
```
</details>
