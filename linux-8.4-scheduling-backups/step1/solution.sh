#!/bin/bash
# Solution: Create cron job
(crontab -l 2>/dev/null; echo "*/5 * * * * date >> /root/cron-test.txt") | crontab -
echo "Current crontab:"
crontab -l
