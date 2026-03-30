#!/bin/bash
# Solution: Check scheduling policy of PID 1
chrt -p 1 > /root/sched-policy.txt
cat /root/sched-policy.txt
