# One-Time Scheduling with at

While cron handles recurring tasks, `at` runs a command once at a specific time.

## Using at

```bash
# Schedule for a specific time
echo "echo 'Job done' >> ~/at-result.txt" | at now + 1 minute

# Schedule for a specific date/time
echo "echo 'hello'" | at 10:00 PM

# List pending jobs
atq

# Remove a job
atrm <job-number>
```

## at Time Formats

| Format | Example |
|--------|---------|
| `now + N minutes` | `now + 5 minutes` |
| `now + N hours` | `now + 2 hours` |
| `HH:MM` | `14:30` |
| `teatime` | `4:00 PM` |
| `midnight` | `12:00 AM` |

## Your Task

1. Schedule a command to run in 1 minute using `at`:
   ```bash
   echo "date >> ~/at-result.txt" | at now + 1 minute
   ```
2. Save the job ID to `~/at-job.txt`

**Hint:**
```bash
JOB=$(echo "date >> ~/at-result.txt" | at now + 1 minute 2>&1 | grep -oP 'job \K\d+')
echo "$JOB" > ~/at-job.txt
```
