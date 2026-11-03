#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
BASE="$USER_HOME/lab-workspace"

SCRIPT_MODE=$(stat -c %a "$BASE/important_script.sh") || exit 1
CONFIG_MODE=$(stat -c %a "$BASE/secret_config.cfg") || exit 1
if (( (8#$SCRIPT_MODE & 0100) != 0 && (8#$CONFIG_MODE & 0400) != 0 )); then
  echo "PASS: Permissions verified!"
  exit 0
else
  echo "FAIL: Permissions are not set correctly."
  exit 1
fi
