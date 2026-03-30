## Preemption and Priority

When cluster resources are scarce, higher-priority pods can preempt (evict) lower-priority pods to get scheduled.

### Task

1. Create two PriorityClasses:

   ```bash
   cat <<'EOF' | kubectl apply -f -
   apiVersion: scheduling.k8s.io/v1
   kind: PriorityClass
   metadata:
     name: low-priority
   value: 100
   globalDefault: false
   description: "Low priority workloads"
   ---
   apiVersion: scheduling.k8s.io/v1
   kind: PriorityClass
   metadata:
     name: critical-priority
   value: 1000000
   globalDefault: false
   description: "Critical workloads"
   EOF
   ```

2. Create a pod using the `low-priority` class:
   ```bash
   kubectl run low-pod --image=nginx:1.25 -n practice --dry-run=client -o yaml | \
     sed 's/spec:/spec:\n  priorityClassName: low-priority/' | kubectl apply -f -
   ```

3. Create a pod using the `critical-priority` class:
   ```bash
   kubectl run critical-pod --image=nginx:1.25 -n practice --dry-run=client -o yaml | \
     sed 's/spec:/spec:\n  priorityClassName: critical-priority/' | kubectl apply -f -
   ```

4. Verify the high-priority pod is Running:
   ```bash
   kubectl get pod critical-pod -n practice
   ```

<details>
<summary>Hint: Using priorityClassName</summary>

Add `priorityClassName` to the pod spec:

```yaml
spec:
  priorityClassName: critical-priority
  containers:
  - name: nginx
    image: nginx:1.25
```

Refer to: https://kubernetes.io/docs/concepts/scheduling-eviction/pod-priority-preemption/
</details>
