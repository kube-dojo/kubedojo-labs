#!/bin/bash
if [ ! -f /root/utils.sh ]; then
  echo "FAIL: /root/utils.sh not found"
  exit 1
fi

FUNCS=0
for func in log_info log_error check_command; do
  if grep -q "$func" /root/utils.sh; then
    FUNCS=$((FUNCS + 1))
  else
    echo "WARN: Missing function: $func"
  fi
done

if [ "$FUNCS" -eq 3 ] && grep -q "function" /root/utils.sh; then
  echo "PASS: utils.sh contains all 3 function definitions"
  exit 0
else
  echo "FAIL: Expected 3 functions (log_info, log_error, check_command), found $FUNCS"
  exit 1
fi
