#!/bin/bash
echo "20000 100000" | sudo tee /sys/fs/cgroup/kd-lab/cpu.max
sudo sh -c 'echo $$ > /sys/fs/cgroup/kd-lab/cgroup.procs; timeout 3 sh -c "while :; do :; done"' || true
cat /sys/fs/cgroup/kd-lab/cpu.max > /tmp/kd-cg/cpu-max.txt
grep -E '^(nr_throttled|throttled_usec) ' /sys/fs/cgroup/kd-lab/cpu.stat > /tmp/kd-cg/cpu-throttle.txt
cat /tmp/kd-cg/cpu-max.txt /tmp/kd-cg/cpu-throttle.txt
