#!/bin/bash
sudo mkdir -p /sys/fs/cgroup/kd-lab
echo 67108864 | sudo tee /sys/fs/cgroup/kd-lab/memory.max
cat /sys/fs/cgroup/kd-lab/memory.max > /tmp/kd-cg/memory-max.txt
cat /tmp/kd-cg/memory-max.txt
