## Cluster Events

Events are short-lived records of what happened in the cluster. They are essential for understanding why pods fail, scale, or get rescheduled.

### Task

1. List all events in the `practice` namespace sorted by time
2. Filter events for warnings only
3. Save the event summary to `/root/events.txt`

```bash
# All events in practice namespace, sorted by time
kubectl get events -n practice --sort-by='.lastTimestamp'

# Warning events only
kubectl get events -n practice --field-selector=type=Warning

# Events for a specific pod
kubectl get events -n practice --field-selector=involvedObject.name=event-generator

# Events across all namespaces
kubectl get events --all-namespaces --sort-by='.lastTimestamp' | tail -20

# Save event summary
kubectl get events -n practice --sort-by='.lastTimestamp' -o wide > /root/events.txt
echo "---" >> /root/events.txt
echo "=== Warning Events ===" >> /root/events.txt
kubectl get events -n practice --field-selector=type=Warning >> /root/events.txt 2>&1
```

<details>
<summary>Hint: Event field selectors</summary>

```bash
# Filter by type
kubectl get events --field-selector=type=Warning
kubectl get events --field-selector=type=Normal

# Filter by reason
kubectl get events --field-selector=reason=Pulling
kubectl get events --field-selector=reason=Scheduled

# Filter by involved object
kubectl get events --field-selector=involvedObject.kind=Pod
kubectl get events --field-selector=involvedObject.kind=Deployment
```
</details>
