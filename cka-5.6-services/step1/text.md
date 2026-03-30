## Fix Missing Endpoints

The service `api-svc` has no endpoints because the selector version label does not match the pod's label.

### Task

1. Diagnose the selector mismatch
2. Fix the service selector to match the `api-server` pod labels

```bash
# Check endpoints — should be empty
kubectl get endpoints api-svc -n practice

# Compare service selector with pod labels
kubectl get svc api-svc -n practice -o jsonpath='{.spec.selector}' && echo ""
kubectl get pod api-server -n practice --show-labels

# The service selects version=v1 but the pod has version=v2
```

<details>
<summary>Hint: Fix the version selector</summary>

```bash
kubectl patch svc api-svc -n practice -p '{"spec":{"selector":{"app":"api","version":"v2"}}}'
```
</details>
