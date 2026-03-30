## Pod Troubleshooting

A broken pod named `broken-pod` has been created in the `practice` namespace but it is not running.

### Task

1. Investigate why `broken-pod` is not running:
   ```bash
   kubectl get pod broken-pod -n practice
   kubectl describe pod broken-pod -n practice
   ```
2. Identify the problem (hint: check the image name)
3. Fix the pod by updating the image to `nginx:1.25`
4. Verify the pod reaches `Running` state

```bash
# Useful troubleshooting commands
kubectl get events -n practice --sort-by='.lastTimestamp'
kubectl logs broken-pod -n practice
```

<details>
<summary>Hint: How to fix the image</summary>

You cannot directly edit the image of a running pod. Delete and recreate it, or use:

```bash
kubectl get pod broken-pod -n practice -o yaml > /tmp/fix.yaml
# Edit the image in fix.yaml
kubectl delete pod broken-pod -n practice
kubectl apply -f /tmp/fix.yaml
```

Or use `kubectl set image` if it is managed by a controller (not applicable for standalone pods).
</details>
