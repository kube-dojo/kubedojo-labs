#!/bin/bash
if apt-mark showhold | grep -q "nginx"; then
  echo "PASS: nginx is held"
  exit 0
else
  echo "FAIL: nginx is not in the hold list"
  exit 1
fi
