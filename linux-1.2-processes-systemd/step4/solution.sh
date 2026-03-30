#!/bin/bash
# Solution: List cgroup controllers
if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
  cat /sys/fs/cgroup/cgroup.controllers > /root/cgroup-controllers.txt
else
  ls /sys/fs/cgroup/ > /root/cgroup-controllers.txt
fi
cat /root/cgroup-controllers.txt
