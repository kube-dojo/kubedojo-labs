#!/bin/bash
# Verify /root/sudo-rule.txt contains developer and apt
if [ ! -f /root/sudo-rule.txt ]; then
  echo "/root/sudo-rule.txt does not exist"
  exit 1
fi

content=$(cat /root/sudo-rule.txt)
if echo "$content" | grep -q "developer" && echo "$content" | grep -q "apt"; then
  echo "Sudo rule: $content"
  exit 0
else
  echo "File should contain 'developer' and 'apt', got: '$content'"
  exit 1
fi
