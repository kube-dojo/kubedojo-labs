#!/bin/bash
# Setup for CPU scheduling lab
apt-get update -qq
apt-get install -y -qq util-linux procps > /dev/null 2>&1
echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
