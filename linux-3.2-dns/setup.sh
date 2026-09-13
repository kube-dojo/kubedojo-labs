#!/bin/bash
# Setup script for DNS Resolution and Troubleshooting lab

export DEBIAN_FRONTEND=noninteractive

# Unbounded apt-get update can hang the 420s harness lane (#94). Skip when
# dig/ping already exist (CI image); otherwise bound update+install.
if ! command -v dig >/dev/null 2>&1 || ! command -v ping >/dev/null 2>&1; then
  timeout 30 apt-get update -qq
  timeout 60 apt-get install -y -qq dnsutils iputils-ping >/dev/null 2>&1
fi

echo "Setup complete."


if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
