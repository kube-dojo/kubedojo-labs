#!/bin/bash
# Setup script for seccomp lab

apt-get update -qq
apt-get install -y -qq jq > /dev/null 2>&1

echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
