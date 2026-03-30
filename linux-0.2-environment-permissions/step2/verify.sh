#!/bin/bash
# Verify /root/umask-test.txt exists with permissions 640
if [ ! -f /root/umask-test.txt ]; then
  echo "/root/umask-test.txt does not exist"
  exit 1
fi

perms=$(stat -c '%a' /root/umask-test.txt)
if [ "$perms" = "640" ]; then
  echo "Permissions are 640. Perfect!"
  exit 0
else
  echo "Expected permissions 640, got $perms"
  exit 1
fi
