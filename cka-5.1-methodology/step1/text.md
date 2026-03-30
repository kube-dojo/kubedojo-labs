## Systematic Troubleshooting with describe and events

The first step in any troubleshooting workflow is gathering information. `kubectl describe` and cluster events are your primary tools.

### Task

1. Identify why the pod `broken-app` in the `practice` namespace is not running
2. Fix the pod so it runs successfully
3. Save the original error message to `/root/diagnosis.txt`

```bash
# Step 1: Check pod status
kubectl get pods -n practice

# Step 2: Describe the pod for details
kubectl describe pod broken-app -n practice

# Step 3: Check recent events
kubectl get events -n practice --sort-by='.lastTimestamp'

# Step 4: Save diagnosis
kubectl describe pod broken-app -n practice | grep -A5 "Events:" > /root/diagnosis.txt
```

<details>
<summary>Hint: Common describe patterns</summary>

Look for these in `kubectl describe pod`:
- **Events section**: Shows scheduling, pulling, creation errors
- **State/Last State**: Shows container state and exit codes
- **Conditions**: Shows Ready, Initialized, ContainersReady status
- **Image**: Check for typos in image names

The pod has an image typo: `ngnix:latset` instead of `nginx:latest`.
</details>
