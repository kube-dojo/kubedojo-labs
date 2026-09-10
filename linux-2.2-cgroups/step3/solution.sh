#!/bin/bash
sudo sh -c 'echo $$ > /sys/fs/cgroup/kd-lab/cgroup.procs
cat /proc/self/cgroup > /tmp/kd-cg/inner-path.txt
big=$(head -c 8388608 /dev/zero | tr "\0" "a")
cat /sys/fs/cgroup/kd-lab/memory.current > /tmp/kd-cg/memory-current.txt'
cat /tmp/kd-cg/inner-path.txt /tmp/kd-cg/memory-current.txt
