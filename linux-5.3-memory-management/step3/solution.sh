#!/bin/bash
# Solution: Find process with highest OOM score
for pid in /proc/[0-9]*; do
  p=$(basename $pid)
  score=$(cat $pid/oom_score 2>/dev/null)
  [ -n "$score" ] && echo "$score $p"
done | sort -rn | head -1 | awk '{printf "PID: %s\nScore: %s\n", $2, $1}' > /root/oom-candidate.txt
cat /root/oom-candidate.txt
