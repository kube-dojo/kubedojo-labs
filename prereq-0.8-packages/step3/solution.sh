#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
sudo apt remove -y wget
if which wget > "$USER_HOME/wget-check.txt"; then
  exit 1
else
  status=$?
  [ "$status" -eq 1 ]
fi
