#!/bin/bash
# Solution: Check scheduling policy of PID 1
chrt -p 1 > "$HOME"/sched-policy.txt
cat "$HOME"/sched-policy.txt
