#!/bin/bash
# Try aa-status to get enforce count
COUNT=$(aa-status 2>/dev/null | grep "profiles are in enforce mode" | awk '{print $1}')

if [ -n "$COUNT" ]; then
  echo "$COUNT" > /root/enforce-count.txt
else
  # Docker fallback: AppArmor kernel module not available
  echo "0" > /root/enforce-count.txt
  echo "Note: AppArmor is not active in this environment. Wrote 0 as enforce count."
fi
