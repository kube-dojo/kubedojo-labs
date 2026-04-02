#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
if which wget >/dev/null 2>&1; then
  echo "FAIL: wget still exists at $(which wget)"
  exit 1
fi
echo "PASS"
exit 0
