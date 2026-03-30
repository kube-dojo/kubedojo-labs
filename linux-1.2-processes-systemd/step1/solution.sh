#!/bin/bash
# Solution: List unique process states
ps -eo stat --no-headers | cut -c1 | sort -u > /root/process-states.txt
cat /root/process-states.txt
