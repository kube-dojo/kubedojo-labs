# Create a Custom Resource

Now that the CRD is registered, you can create instances of the `Backup` resource just like any built-in Kubernetes resource.

## Task

Create a Backup resource in the `default` namespace with:

- **Name:** `daily-backup`
- **spec.schedule:** `"0 2 * * *"`
- **spec.target:** `"etcd"`
- **spec.retention:** `7`

Apply it and verify with `kubectl get backups`.

## Hint

Create a YAML file with `apiVersion: kubedojo.io/v1`, `kind: Backup`, and the spec fields. Apply with `kubectl apply -f`.
