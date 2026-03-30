#!/bin/bash
# Solution: Pin process to CPU 0
taskset -c 0 sleep 300 &
echo $! > /root/affinity-pid.txt
echo "Process PID: $(cat /root/affinity-pid.txt)"
taskset -p $(cat /root/affinity-pid.txt)
