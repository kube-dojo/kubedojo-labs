# Create and Manage CronJobs

CronJobs create Jobs on a repeating schedule using cron syntax.

## Task

1. Create a CronJob named `reporter` in `jobs-lab` with:
   - Image: `busybox:1.36`
   - Command: `sh -c "echo Report generated at $(date)"`
   - Schedule: `*/1 * * * *` (every minute)
   - `successfulJobsHistoryLimit: 3`
2. Save the schedule of the CronJob to `/root/cron-schedule.txt`.
3. Manually trigger the CronJob by creating a Job from it:
   ```
   kubectl create job reporter-manual --from=cronjob/reporter -n jobs-lab
   ```
4. Wait for the manual Job to complete.

## Hint

Use `kubectl create cronjob reporter --image=busybox:1.36 --schedule="*/1 * * * *" -n jobs-lab -- sh -c "echo Report generated at \$(date)"`.
