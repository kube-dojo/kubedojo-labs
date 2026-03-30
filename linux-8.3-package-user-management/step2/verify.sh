#!/bin/bash
ERRORS=0
for user in ops-alice ops-bob ops-charlie; do
  if ! id "$user" > /dev/null 2>&1; then
    echo "FAIL: User $user does not exist"
    ERRORS=$((ERRORS + 1))
  elif ! groups "$user" 2>/dev/null | grep -q "ops-team"; then
    echo "FAIL: User $user is not in ops-team group"
    ERRORS=$((ERRORS + 1))
  fi
done

if [ "$ERRORS" -eq 0 ]; then
  echo "PASS: All 3 users exist in ops-team group"
  exit 0
else
  echo "FAIL: $ERRORS issues found"
  exit 1
fi
