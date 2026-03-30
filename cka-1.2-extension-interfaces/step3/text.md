# Container Storage Interface (CSI)

The CSI allows storage vendors to provide drivers for Kubernetes without modifying core code. Storage classes define how persistent volumes are provisioned.

**Key commands:**
- `kubectl get storageclass` (or `kubectl get sc`) — list storage classes
- `kubectl get csidrivers` — list installed CSI drivers
- `kubectl describe storageclass <name>` — show provisioner details

## Task

List all storage classes in the cluster and save the output to `/root/storage-classes.txt`.

If no storage classes exist, save the text "no storage classes found" to the file.

## Hint

Run `kubectl get storageclass` and redirect the output. Even if the cluster has no storage classes, the command header or a "No resources found" message is acceptable.
