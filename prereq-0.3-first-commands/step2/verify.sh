#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
if [ -f "$USER_HOME/projects/lab-results/step2.txt" ] && grep -q "step 2 complete" "$USER_HOME/projects/lab-results/step2.txt"; then
  echo "PASS: Step 2 verified!"
  exit 0
fi
echo "FAIL: Required directory or file not found in ~/projects/lab-results/step2.txt"
exit 1
