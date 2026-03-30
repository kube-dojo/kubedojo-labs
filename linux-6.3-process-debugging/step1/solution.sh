#!/bin/bash
# Solution: Trace ls command
strace ls /tmp 2> /root/strace-output.txt
cat /root/strace-output.txt | head -20
