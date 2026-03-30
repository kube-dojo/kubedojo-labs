# Explore Existing CRDs

Even a fresh Kubernetes cluster may have CRDs installed (e.g., from the CNI plugin or other components).

**Key commands:**
```bash
kubectl get crd                       # List all CRDs
kubectl describe crd <name>           # Show CRD details
kubectl explain <resource>            # Explore custom resource fields
```

## Task

List all CRDs in the cluster and save the count (number of CRDs) to `/root/crd-count.txt`.

If there are no CRDs, save `0`.

## Hint

Use `kubectl get crd --no-headers 2>/dev/null | wc -l` to count CRDs. If the command returns "No resources found", the count is 0.
