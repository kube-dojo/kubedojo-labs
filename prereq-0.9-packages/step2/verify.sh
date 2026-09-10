#!/bin/bash
# Verify: htop installed via apt and its version recorded.
if ! dpkg -s htop 2>/dev/null | grep -q '^Status:.*installed'; then
  echo "FAIL: htop is not installed — install it with 'sudo apt install htop'"
  exit 1
fi
FILE=/tmp/kd-pkg/htop-version.txt
if [ ! -s "$FILE" ]; then
  echo "FAIL: $FILE missing — record the version with 'htop --version > /tmp/kd-pkg/htop-version.txt'"
  exit 1
fi
if ! grep -qi 'htop' "$FILE"; then
  echo "FAIL: $FILE does not look like htop version output"
  exit 1
fi
echo "PASS: htop installed and version recorded"
exit 0
