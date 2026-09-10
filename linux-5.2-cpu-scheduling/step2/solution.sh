#!/bin/bash
# Solution: Pin process to CPU 0
taskset -c 0 sleep 300 &
echo $! > "$HOME"/affinity-pid.txt
echo "Process PID: $(cat "$HOME"/affinity-pid.txt)"
taskset -p $(cat "$HOME"/affinity-pid.txt)
