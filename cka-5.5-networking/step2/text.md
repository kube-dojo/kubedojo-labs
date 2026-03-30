## Fix Unreachable Service

The service `backend-svc` in the `practice` namespace has no endpoints because its selector does not match any pods.

### Task

1. Diagnose why the service has no endpoints
2. Fix the service selector to match the `backend` pod

```bash
# Check service endpoints
kubectl get endpoints backend-svc -n practice
# Should show: <none>

# Check the service selector
kubectl get svc backend-svc -n practice -o jsonpath='{.spec.selector}'
# Shows: {"app":"wrong-label"}

# Check the pod labels
kubectl get pod backend -n practice --show-labels
# Shows: app=backend,version=v1
```

Fix the service selector to match `app=backend`.

<details>
<summary>Hint: Patch the selector</summary>

```bash
kubectl patch svc backend-svc -n practice -p '{"spec":{"selector":{"app":"backend"}}}'
```

Or edit directly:
```bash
kubectl edit svc backend-svc -n practice
# Change spec.selector.app from "wrong-label" to "backend"
```
</details>
