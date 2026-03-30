#!/bin/bash
if mount | grep -q "/mnt/ramdisk"; then
  echo "PASS: /mnt/ramdisk is mounted"
  exit 0
else
  echo "FAIL: /mnt/ramdisk is not mounted"
  exit 1
fi
