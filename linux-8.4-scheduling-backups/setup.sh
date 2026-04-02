#!/bin/bash
# Setup for scheduling and backups lab
apt-get update -qq
apt-get install -y -qq cron at > /dev/null 2>&1
service cron start 2>/dev/null || true
service atd start 2>/dev/null || true
mkdir -p /root/backups
echo "Setup complete."

# Seed /home/ubuntu if it exists
if [ -d /home/ubuntu ]; then
  cp -r /root/* /home/ubuntu/ 2>/dev/null || true
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
