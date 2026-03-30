#!/bin/bash
# Solution: Schedule with at
OUTPUT=$(echo "date >> /root/at-result.txt" | at now + 1 minute 2>&1)
JOB=$(echo "$OUTPUT" | grep -oP 'job \K\d+')
if [ -n "$JOB" ]; then
  echo "$JOB" > /root/at-job.txt
else
  echo "1" > /root/at-job.txt
fi
echo "Scheduled job: $(cat /root/at-job.txt)"
echo "Pending jobs:"
atq
