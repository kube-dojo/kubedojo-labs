#!/bin/bash
# Solution: List cgroup controllers
if [ -f /sys/fs/cgroup/cgroup.controllers ]; then
  cat /sys/fs/cgroup/cgroup.controllers > "$HOME"/cgroup-controllers.txt
else
  ls /sys/fs/cgroup/ > "$HOME"/cgroup-controllers.txt
fi
cat "$HOME"/cgroup-controllers.txt
