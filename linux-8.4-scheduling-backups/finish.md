# Congratulations!

You have completed the Scheduling and Backup Strategies lab.

## What You Learned

- Creating cron jobs for recurring tasks
- One-time scheduling with `at`
- Implementing backup rotation to manage disk space

## Key Takeaways

1. **Cron** is for recurring tasks — monitoring, backups, cleanup
2. **at** is for one-time future execution — deployments, maintenance windows
3. **Always implement rotation** — backups without rotation will fill your disk
4. **Test cron jobs manually first** — debug before scheduling

## Next Steps

- Combine backup and rotation into a single cron job
- Add email notifications for backup success/failure
- Explore `systemd timers` as a modern alternative to cron
- Study tools like `restic` or `borgbackup` for production backup solutions
