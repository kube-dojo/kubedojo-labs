#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check if at-job.txt exists or if there's a pending/completed at job
if [ -f $USER_HOME/at-job.txt ]; then
  echo "PASS: at-job.txt exists"
  exit 0
elif atq 2>/dev/null | grep -q "[0-9]"; then
  echo "PASS: at job is queued"
  exit 0
elif [ -f $USER_HOME/at-result.txt ]; then
  echo "PASS: at job has already executed"
  exit 0
else
  echo "FAIL: No at job found"
  exit 1
fi
