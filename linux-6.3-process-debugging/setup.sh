#!/bin/bash
# Setup for process debugging lab
apt-get update -qq
apt-get install -y -qq strace ltrace lsof procps > /dev/null 2>&1

# Start a background process we can inspect
sleep 600 &
_pid=$!
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  echo "$_pid" > "$home/target-pid.txt"
done

echo "Setup complete. Target process PID saved to $HOME/target-pid.txt"

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
