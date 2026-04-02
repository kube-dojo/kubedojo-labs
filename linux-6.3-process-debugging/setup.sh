#!/bin/bash
# Setup for process debugging lab
apt-get update -qq
apt-get install -y -qq strace ltrace lsof procps > /dev/null 2>&1

# Start a background process we can inspect
sleep 600 &
echo $! > /root/target-pid.txt

echo "Setup complete. Target process PID saved to /root/target-pid.txt"

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
