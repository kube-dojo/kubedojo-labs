#!/bin/bash
# Verify myservice is running
if systemctl is-active --quiet myservice 2>/dev/null; then
  echo "myservice is running! Great job creating a systemd service."
  exit 0
fi

# Docker fallback: check if the service script is running as a process
if pgrep -f "/opt/myservice/run.sh" > /dev/null 2>&1; then
  echo "myservice is running! (detected via process)"
  exit 0
fi

echo "myservice is not active. Create the unit file and start it."
exit 1
