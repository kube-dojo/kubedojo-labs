#!/bin/bash
# Solution: Extract CPU model from /proc/cpuinfo
# Try "model name" first, fall back to other fields
if grep -q "model name" /proc/cpuinfo 2>/dev/null; then
  grep "model name" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //' > /root/cpu-model.txt
elif grep -q "Hardware" /proc/cpuinfo 2>/dev/null; then
  grep "Hardware" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //' > /root/cpu-model.txt
elif grep -q "cpu" /proc/cpuinfo 2>/dev/null; then
  grep "cpu" /proc/cpuinfo | head -1 | cut -d: -f2 | sed 's/^ //' > /root/cpu-model.txt
else
  # Last resort: just get the first non-empty value line
  head -5 /proc/cpuinfo | grep ":" | head -1 | cut -d: -f2 | sed 's/^ //' > /root/cpu-model.txt
fi
cat /root/cpu-model.txt
