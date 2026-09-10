#!/bin/bash
# Solution: Find I/O scheduler for root disk
DEVICE=$(lsblk -dno NAME | head -1)
SCHED=$(cat /sys/block/$DEVICE/queue/scheduler 2>/dev/null | grep -oP '\[\K[^\]]+')
if [ -z "$SCHED" ]; then
  SCHED=$(cat /sys/block/$DEVICE/queue/scheduler 2>/dev/null)
fi
echo "$SCHED" > "$HOME"/io-scheduler.txt
echo "I/O scheduler: $(cat "$HOME"/io-scheduler.txt)"
