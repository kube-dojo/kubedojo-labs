#!/bin/bash
# Setup for practical scripts lab
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  mkdir -p "$home/backups"
done
echo "Setup complete."

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
