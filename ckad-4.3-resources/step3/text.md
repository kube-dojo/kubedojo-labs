# Create ResourceQuotas

ResourceQuotas limit total resource consumption in a namespace.

## Task

1. Create a ResourceQuota named `compute-quota` in `quota-lab`:
   - CPU requests: 1 (total)
   - Memory requests: 1Gi (total)
   - Pods: 5
2. Create a pod named `quota-pod` in `quota-lab` with CPU request `200m` and memory request `128Mi`.
3. Save the used CPU requests to `/root/used-cpu.txt`:
   ```
   kubectl get resourcequota compute-quota -n quota-lab -o jsonpath='{.status.used.requests\.cpu}'
   ```

## Hint

When a ResourceQuota exists, every pod must specify resource requests. Use `kubectl describe resourcequota` to see usage.
