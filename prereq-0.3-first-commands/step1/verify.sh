#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
if [ -f "$USER_HOME/code.txt" ] && grep -q "DOJO123" "$USER_HOME/code.txt"; then
  echo "PASS: Secret code verified!"
  exit 0
fi
echo "FAIL: Secret code (DOJO123) not found in ~/code.txt."
exit 1
