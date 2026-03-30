#!/bin/bash
if kubectl get crd backups.kubedojo.io 2>/dev/null; then
  echo "PASS: CRD backups.kubedojo.io exists"
  exit 0
else
  echo "FAIL: CRD backups.kubedojo.io not found"
  exit 1
fi
