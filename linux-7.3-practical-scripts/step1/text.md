# Backup Script

A good backup script should:
- Create date-stamped archives
- Use compression
- Report success or failure

## Key Commands

```bash
# Date stamp
DATE=$(date +%Y%m%d)

# Create compressed archive
tar -czf ~/backups/etc-${DATE}.tar.gz /etc

# Check if it worked
if [ $? -eq 0 ]; then
  echo "Backup successful"
fi
```

## Your Task

Write `~/backup.sh` that:

1. Creates a compressed backup of `/etc` into `~/backups/`
2. Names it `etc-YYYYMMDD.tar.gz` using today's date
3. Prints the filename and size after creation
4. Make it executable and run it

The backup file should exist at `~/backups/etc-YYYYMMDD.tar.gz` after running.
