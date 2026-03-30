#!/bin/bash
# Verify /root/fhs-quiz.txt has entries for /etc, /var, /tmp
if [ ! -f /root/fhs-quiz.txt ]; then
  echo "/root/fhs-quiz.txt does not exist"
  exit 1
fi

missing=""
for dir in "/etc" "/var" "/tmp"; do
  if ! grep -q "$dir" /root/fhs-quiz.txt; then
    missing="$missing $dir"
  fi
done

if [ -z "$missing" ]; then
  echo "All required entries found!"
  exit 0
else
  echo "Missing entries for:$missing"
  exit 1
fi
