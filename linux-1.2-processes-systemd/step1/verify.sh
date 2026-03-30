#!/bin/bash
# Verify /root/process-states.txt exists and contains S (sleeping)
if [ ! -f /root/process-states.txt ]; then
  echo "/root/process-states.txt does not exist"
  exit 1
fi

if grep -q "S" /root/process-states.txt; then
  echo "Process states found: $(cat /root/process-states.txt | tr '\n' ' ')"
  exit 0
else
  echo "Expected to find state 'S' (sleeping) — most systems have sleeping processes"
  exit 1
fi
