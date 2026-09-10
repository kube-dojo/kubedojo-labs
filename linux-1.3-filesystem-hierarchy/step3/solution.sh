#!/bin/bash
# Solution: Get root filesystem type
if command -v findmnt > /dev/null 2>&1; then
  findmnt -n -o FSTYPE / > "$HOME"/root-fstype.txt 2>/dev/null
fi
# Fallback if findmnt not available or produced empty output
if [ ! -s "$HOME"/root-fstype.txt ]; then
  df -T / 2>/dev/null | tail -1 | awk '{print $2}' > "$HOME"/root-fstype.txt
fi
# Last resort: check /proc/mounts
if [ ! -s "$HOME"/root-fstype.txt ]; then
  grep ' / ' /proc/mounts 2>/dev/null | head -1 | awk '{print $3}' > "$HOME"/root-fstype.txt
fi
cat "$HOME"/root-fstype.txt
