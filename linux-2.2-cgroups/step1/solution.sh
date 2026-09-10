#!/bin/bash
stat -fc %T /sys/fs/cgroup > /tmp/kd-cg/version.txt
cat /proc/self/cgroup > /tmp/kd-cg/self-path.txt
cat /tmp/kd-cg/version.txt /tmp/kd-cg/self-path.txt
