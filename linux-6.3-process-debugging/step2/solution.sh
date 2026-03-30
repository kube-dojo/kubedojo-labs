#!/bin/bash
# Solution: List open files
PID=$(cat /root/target-pid.txt)
lsof -p "$PID" > /root/open-files.txt
cat /root/open-files.txt
