## Container Logs

kubectl logs is the primary tool for viewing container output. It supports multi-container pods, following logs in real-time, and filtering by time.

### Task

1. View logs from both containers in the `multi-log` pod
2. Follow logs in real-time from the `app` container (briefly)
3. Get logs from the previous hour and save to `/root/app-logs.txt`

```bash
# View logs from specific container
kubectl logs multi-log -n practice -c app
kubectl logs multi-log -n practice -c sidecar

# Follow logs (Ctrl+C to stop)
kubectl logs multi-log -n practice -c app -f --tail=5

# Get recent logs with timestamps
kubectl logs multi-log -n practice -c app --since=1h --timestamps

# Save logs
kubectl logs multi-log -n practice -c app --since=1h --timestamps > /root/app-logs.txt

# View logs from all containers simultaneously
kubectl logs multi-log -n practice --all-containers=true --prefix=true | tail -20
```

<details>
<summary>Hint: Advanced log options</summary>

```bash
# Previous container logs (after restart)
kubectl logs <pod> --previous

# Last N lines
kubectl logs <pod> --tail=100

# Since timestamp
kubectl logs <pod> --since-time="2024-01-01T00:00:00Z"

# All pods in a deployment
kubectl logs deployment/log-demo -n practice

# All pods with a label
kubectl logs -l app=log-demo -n practice
```
</details>
