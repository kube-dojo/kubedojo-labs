#!/bin/bash
if id "ubuntu" &>/dev/null; then USER_HOME="/home/ubuntu"; else USER_HOME="/root"; fi
STATUS=$(dpkg-query -W -f='${Status}' wget 2>/dev/null) || STATUS=''
if [ "$STATUS" = 'install ok installed' ]; then
  echo "FAIL: wget package is still installed."
  exit 1
fi
if which wget >/dev/null 2>&1; then status=0; else status=$?; fi
if [ "$status" -ne 1 ]; then
  echo "FAIL: which wget must return 1, got $status."
  exit 1
fi
if [ ! -f "$USER_HOME/wget-check.txt" ] || [ -s "$USER_HOME/wget-check.txt" ]; then
  echo "FAIL: ~/wget-check.txt must contain the empty output of which wget."
  exit 1
fi
echo "PASS"
exit 0
