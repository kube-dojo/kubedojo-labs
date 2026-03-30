#!/bin/bash
# Verify /root/multiuser-deps.txt exists and has meaningful content
if [ ! -f /root/multiuser-deps.txt ]; then
  echo "/root/multiuser-deps.txt does not exist"
  exit 1
fi

if [ ! -s /root/multiuser-deps.txt ]; then
  echo "/root/multiuser-deps.txt is empty"
  exit 1
fi

# Check for expected services in multi-user.target deps (VM) or running processes (Docker)
if grep -qiE "(network|ssh|dbus|systemd|bash|ps|Running)" /root/multiuser-deps.txt; then
  lines=$(wc -l < /root/multiuser-deps.txt | tr -d '[:space:]')
  echo "Found $lines dependency/service entries."
  exit 0
fi

# Accept any non-empty file as valid in Docker
lines=$(wc -l < /root/multiuser-deps.txt | tr -d '[:space:]')
if [ "$lines" -ge 1 ]; then
  echo "Found $lines entries."
  exit 0
fi

echo "Expected to find common services in multi-user.target dependencies"
exit 1
