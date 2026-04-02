#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
TARGET="$USER_HOME/projects/lab-results/stopped.txt"
if [ -f "$TARGET" ] && grep -q "postgres" "$TARGET" && grep -q "worker" "$TARGET" && ! grep -q "nginx" "$TARGET"; then
  echo "PASS: Step 3 verified!"
  exit 0
fi
echo "FAIL: stopped.txt does not contain the correct filtered list."
exit 1
