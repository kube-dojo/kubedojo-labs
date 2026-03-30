#!/bin/bash
DATE=$(date +%Y%m%d)
BACKUP="/root/backups/etc-${DATE}.tar.gz"

if [ -f "$BACKUP" ]; then
  SIZE=$(ls -lh "$BACKUP" | awk '{print $5}')
  echo "PASS: Backup exists at $BACKUP ($SIZE)"
  exit 0
else
  # Check for any backup file
  if ls /root/backups/etc-*.tar.gz > /dev/null 2>&1; then
    echo "PASS: Backup file found in /root/backups/"
    exit 0
  fi
  echo "FAIL: No backup file found at $BACKUP"
  exit 1
fi
