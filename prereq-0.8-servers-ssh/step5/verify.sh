#!/bin/bash
# Verify: the constructed command has program, port, key and target correct.
F=/tmp/kd-ssh/constructed-command.txt
if [ ! -s "$F" ] || [ "$(grep -c . "$F")" -ne 1 ]; then
  echo "FAIL: $F must contain exactly one command line"
  exit 1
fi
line=$(grep -m1 . "$F")
if [ "$(printf '%s\n' "$line" | awk '{print $1}')" != "ssh" ]; then
  echo "FAIL: the command must start with the ssh client program"
  exit 1
fi
if ! printf '%s\n' "$line" | grep -Eq '(^| )-p[ ]+2222( |$)'; then
  echo "FAIL: the server listens on a non-default port — connect with -p 2222"
  exit 1
fi
if ! printf '%s\n' "$line" | grep -Eq '(^| )-i[ ]+[^ ]*\.ssh/work_key( |$)'; then
  echo "FAIL: point SSH at the specific key file with -i ~/.ssh/work_key"
  exit 1
fi
if ! printf '%s\n' "$line" | grep -Eq '(^| )admin@10\.0\.0\.5( |$)'; then
  echo "FAIL: the target must be admin@10.0.0.5 — account before the @, host after"
  exit 1
fi
echo "PASS: command constructed correctly — user, host, port, and key all verified before use"
exit 0
