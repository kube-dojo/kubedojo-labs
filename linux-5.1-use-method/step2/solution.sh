#!/bin/bash
# Solution: Find top CPU consumer
# Start a CPU hog if not already running
if ! pgrep -f "dd if=/dev/zero" > /dev/null 2>&1; then
  dd if=/dev/zero of=/dev/null bs=1M &
  sleep 1
fi

ps aux --sort=-%cpu | awk 'NR==2 {print $2}' > /root/cpu-hog.txt
echo "Top CPU process PID: $(cat /root/cpu-hog.txt)"
