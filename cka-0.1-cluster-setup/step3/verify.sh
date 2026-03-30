#!/bin/bash
CURRENT=$(kubectl config current-context 2>/dev/null)
if [ "$CURRENT" = "cka-practice" ]; then
  echo "PASS: Current context is cka-practice"
  exit 0
else
  echo "FAIL: Current context should be 'cka-practice', got: $CURRENT"
  exit 1
fi
