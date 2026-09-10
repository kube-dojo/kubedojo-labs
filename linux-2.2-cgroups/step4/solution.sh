#!/bin/bash
sudo sh -c 'echo $$ > /sys/fs/cgroup/kd-lab/cgroup.procs; exec tail /dev/zero'
echo $? > /tmp/kd-cg/oom-exit.txt
grep '^oom_kill ' /sys/fs/cgroup/kd-lab/memory.events > /tmp/kd-cg/oom-events.txt
cat /tmp/kd-cg/oom-exit.txt /tmp/kd-cg/oom-events.txt
