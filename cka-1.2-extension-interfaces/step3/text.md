# Container Storage Interface (CSI)

The CSI allows storage vendors to provide drivers for Kubernetes without modifying core code. Storage classes define how persistent volumes are provisioned.

**Key commands:**
- `kubectl get storageclass` (or `kubectl get sc`) — list storage classes
- `kubectl get csidrivers` — list installed CSI drivers
- `kubectl describe storageclass <name>` — show provisioner details

## Task

List all storage classes in the cluster and save the output to `/root/storage-classes.txt`.

If no storage classes exist, save the text "no storage classes found" to the file.

<details>
<summary>Hint</summary>

```bash
kubectl get storageclass > /root/storage-classes.txt
```
</details>