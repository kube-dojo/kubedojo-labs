#!/bin/bash
RESULT=$(kubectl auth can-i get pods --as=system:serviceaccount:rbac-test:deploy-bot -n rbac-test 2>&1)
if [ "$RESULT" = "yes" ]; then
  echo "PASS: deploy-bot can get pods in rbac-test"
  exit 0
else
  echo "FAIL: deploy-bot should be able to get pods in rbac-test, got: $RESULT"
  exit 1
fi
