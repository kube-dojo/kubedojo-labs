#!/bin/bash
# Verify /root/cgroup-controllers.txt exists and mentions cpu or memory
if [ ! -f /root/cgroup-controllers.txt ]; then
  echo "/root/cgroup-controllers.txt does not exist"
  exit 1
fi

if grep -qiE "(cpu|memory)" /root/cgroup-controllers.txt; then
  echo "Cgroup controllers: $(cat /root/cgroup-controllers.txt)"
  exit 0
else
  echo "Expected to find 'cpu' or 'memory' in cgroup controllers"
  exit 1
fi
