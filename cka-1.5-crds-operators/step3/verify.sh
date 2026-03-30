#!/bin/bash
if kubectl get backups.kubedojo.io daily-backup 2>/dev/null; then
  echo "PASS: Backup resource 'daily-backup' exists"
  exit 0
else
  echo "FAIL: Backup resource 'daily-backup' not found"
  exit 1
fi
