#!/bin/bash
# Solution: Capture memory and disk info
free -m > "$HOME"/memory.txt
df -h / | tail -1 > "$HOME"/disk.txt
echo "Memory:"
cat "$HOME"/memory.txt
echo ""
echo "Disk:"
cat "$HOME"/disk.txt
