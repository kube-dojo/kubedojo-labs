#!/bin/bash
# Solution: Schedule with at
OUTPUT=$(echo "date >> "$HOME"/at-result.txt" | at now + 1 minute 2>&1)
JOB=$(echo "$OUTPUT" | grep -oP 'job \K\d+')
if [ -n "$JOB" ]; then
  echo "$JOB" > "$HOME"/at-job.txt
else
  echo "1" > "$HOME"/at-job.txt
fi
echo "Scheduled job: $(cat "$HOME"/at-job.txt)"
echo "Pending jobs:"
atq
