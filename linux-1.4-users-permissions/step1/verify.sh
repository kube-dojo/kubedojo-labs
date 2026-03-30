#!/bin/bash
# Verify user developer exists and is in devteam group
if ! id developer > /dev/null 2>&1; then
  echo "User 'developer' does not exist"
  exit 1
fi

if id developer 2>/dev/null | grep -q "devteam"; then
  echo "User 'developer' is in group 'devteam'. "
  exit 0
else
  echo "User 'developer' exists but is not in group 'devteam'"
  exit 1
fi
