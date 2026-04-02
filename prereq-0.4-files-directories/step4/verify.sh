#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
BASE="$USER_HOME/lab-workspace"

if [ -f "$BASE/backup/report.txt" ] && [ -f "$BASE/backup/notes.txt" ]; then
  echo "PASS: Step 4 verified!"
  exit 0
else
  echo "FAIL: backup/ is missing expected .txt files."
  exit 1
fi
