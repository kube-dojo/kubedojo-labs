## CronJob

A CronJob creates Jobs on a repeating schedule using cron syntax.

### Task

Create a CronJob named `heartbeat` in the `practice` namespace that:

- Runs **every minute** (`*/1 * * * *`)
- Image: `busybox:1.36`
- Command: `sh -c 'echo "Heartbeat at $(date)"'`

After creating it, wait about 60-90 seconds and verify it spawned at least one Job:

```bash
kubectl get cronjob heartbeat -n practice
kubectl get jobs -n practice -l job-name
```

<details>
<summary>Hint: CronJob imperative command</summary>

```bash
kubectl create cronjob heartbeat --image=busybox:1.36 \
  --schedule="*/1 * * * *" -n practice \
  -- sh -c 'echo "Heartbeat at $(date)"'
```

Or use the declarative YAML approach with `spec.schedule` and `spec.jobTemplate`.
</details>
