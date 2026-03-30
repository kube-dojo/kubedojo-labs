# Backup Rotation

Without rotation, backups eventually fill up disk space. A rotation strategy keeps the most recent N backups and deletes older ones.

## Rotation Strategy

Keep only the last 5 backups:

```bash
# List backups sorted by date (oldest first)
ls -1t /root/backups/backup-*.tar.gz

# Count backups
ls -1 /root/backups/backup-*.tar.gz | wc -l

# Delete oldest, keeping last 5
ls -1t /root/backups/backup-*.tar.gz | tail -n +6 | xargs rm -f
```

## Your Task

Write `/root/rotate-backups.sh` that:

1. Creates a new backup (can be a simple dummy file for testing)
2. Keeps only the last 5 backups in `/root/backups/`
3. Deletes any older backups

To test it, first create some dummy backups:
```bash
for i in $(seq 1 8); do
  touch /root/backups/backup-2026030${i}.tar.gz
  sleep 1
done
```

Then write and run your rotation script. After running, there should be at most 5 backup files.

Make the script executable.
