#!/bin/bash
# Solution: Capture memory and disk info
free -m > /root/memory.txt
df -h / | tail -1 > /root/disk.txt
echo "Memory:"
cat /root/memory.txt
echo ""
echo "Disk:"
cat /root/disk.txt
