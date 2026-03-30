#!/bin/bash
# Verify /root/active-timers.txt exists and has content
if [ ! -f /root/active-timers.txt ]; then
  echo "/root/active-timers.txt does not exist"
  exit 1
fi

if [ ! -s /root/active-timers.txt ]; then
  echo "/root/active-timers.txt is empty"
  exit 1
fi

echo "Timer/scheduled task list captured!"
exit 0
