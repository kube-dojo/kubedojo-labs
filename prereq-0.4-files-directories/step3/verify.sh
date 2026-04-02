#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
BASE="$USER_HOME/lab-workspace"

if [ -x "$BASE/important_script.sh" ] && [ -r "$BASE/secret_config.cfg" ]; then
  echo "PASS: Permissions verified!"
  exit 0
else
  echo "FAIL: Permissions are not set correctly."
  exit 1
fi
