# Cron Jobs

Cron runs scheduled commands at specified intervals.

## Cron Syntax

```
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7, Sun=0=7)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

## Examples

```bash
*/5 * * * *    # Every 5 minutes
0 * * * *      # Every hour
0 2 * * *      # Daily at 2 AM
0 0 * * 0      # Weekly on Sunday midnight
```

## Managing Crontab

```bash
# Edit current user's crontab
crontab -e

# List current cron jobs
crontab -l

# Add a job without interactive editor
(crontab -l 2>/dev/null; echo "*/5 * * * * date >> ~/cron-test.txt") | crontab -
```

## Your Task

Create a cron job that runs every 5 minutes, appending the current date to `~/cron-test.txt`.

```bash
(crontab -l 2>/dev/null; echo "*/5 * * * * date >> ~/cron-test.txt") | crontab -
```

Verify with `crontab -l`.
