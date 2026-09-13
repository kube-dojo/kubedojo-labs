#!/bin/bash
# Setup for scheduling and backups lab
apt-get update -qq
apt-get install -y -qq cron at > /dev/null 2>&1
service cron start 2>/dev/null || true
service atd start 2>/dev/null || true
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  mkdir -p "$home/backups"
done
echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
