#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
TARGET="$USER_HOME/projects/lab-results/stopped.txt"
if [ -f "$TARGET" ] && cmp -s "$TARGET" <(grep stopped "$USER_HOME/documents/services.txt"); then
  echo "PASS: Step 3 verified!"
  exit 0
fi
echo "FAIL: stopped.txt does not contain the correct filtered list."
exit 1
