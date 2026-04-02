#!/bin/bash
if kubectl get namespace my-first-ns >/dev/null 2>&1; then
  echo "PASS: Namespace 'my-first-ns' exists!"
  exit 0
else
  echo "FAIL: Namespace 'my-first-ns' not found."
  exit 1
fi
