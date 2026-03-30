## Diagnose Node Conditions

Kubernetes tracks multiple conditions on each node that indicate its health status.

### Task

1. Check all node conditions and save them to `/root/node-conditions.txt`
2. Verify all conditions show healthy status
3. Check node allocatable resources

```bash
# View all node conditions
kubectl describe node | grep -A20 "Conditions:"

# Get conditions in JSON
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.conditions[*]}  {.type}={.status}{"\n"}{end}{end}'

# Save conditions
kubectl get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.conditions[*]}  {.type}={.status} - {.message}{"\n"}{end}{end}' > /root/node-conditions.txt

# Check allocatable resources
kubectl describe node | grep -A6 "Allocatable:"
```

<details>
<summary>Hint: Node condition meanings</summary>

- **Ready=True** — node is healthy and can accept pods
- **DiskPressure=False** — adequate disk space
- **MemoryPressure=False** — adequate memory
- **PIDPressure=False** — adequate process IDs
- **NetworkUnavailable=False** — network configured correctly

If Ready=False or Unknown, the node cannot accept new pods and existing pods may be evicted.
</details>
