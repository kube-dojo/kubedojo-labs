# Create a Custom Resource

Now that the CRD is registered, you can create instances of the `Backup` resource just like any built-in Kubernetes resource.

## Task

Create a Backup resource in the `default` namespace with:

- **Name:** `daily-backup`
- **spec.schedule:** `"0 2 * * *"`
- **spec.target:** `"etcd"`
- **spec.retention:** `7`

Apply it and verify with `kubectl get backups`.

<details>
<summary>Hint</summary>

```yaml
apiVersion: kubedojo.io/v1
kind: Backup
metadata:
  name: daily-backup
spec:
  schedule: "0 2 * * *"
  target: "etcd"
  retention: 7
```
</details>