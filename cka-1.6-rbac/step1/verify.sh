#!/bin/bash
if kubectl get role pod-reader -n rbac-test 2>/dev/null; then
  echo "PASS: Role pod-reader exists in rbac-test namespace"
  exit 0
else
  echo "FAIL: Role pod-reader not found in rbac-test namespace"
  exit 1
fi
