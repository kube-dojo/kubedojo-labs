#!/bin/bash
# Solution: Get PID 1 process name
ps -p 1 -o comm= > /root/init-name.txt
cat /root/init-name.txt
