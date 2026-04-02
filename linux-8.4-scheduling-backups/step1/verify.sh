#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if crontab -l 2>/dev/null | grep -q "cron-test.txt"; then
  echo "PASS: Cron job for cron-test.txt is configured"
  exit 0
else
  echo "FAIL: No cron job found for cron-test.txt"
  exit 1
fi
