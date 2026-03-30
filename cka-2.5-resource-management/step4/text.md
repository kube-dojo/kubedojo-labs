## Test Quota Enforcement

Now test that the ResourceQuota actually prevents exceeding limits.

### Task

1. Create two pods in the `quota-test` namespace (they should succeed since the quota allows 2 pods):
   ```bash
   kubectl run quota-pod-1 --image=nginx:1.25 -n quota-test
   kubectl run quota-pod-2 --image=nginx:1.25 -n quota-test
   ```

2. Try to create a third pod:
   ```bash
   kubectl run quota-pod-3 --image=nginx:1.25 -n quota-test
   ```

   This should **fail** with a `forbidden: exceeded quota` error.

3. Verify only 2 pods exist:
   ```bash
   kubectl get pods -n quota-test
   ```

<details>
<summary>Hint: Why the third pod is rejected</summary>

The ResourceQuota `ns-quota` limits the namespace to 2 pods. When you try to create a third, the API server rejects the request because the quota would be exceeded. The LimitRange provides default resource requests, so the pods automatically get resources assigned even without specifying them explicitly.
</details>
