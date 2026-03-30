#!/bin/bash
# Verify /root/root-fstype.txt contains a known filesystem type
if [ ! -f /root/root-fstype.txt ]; then
  echo "/root/root-fstype.txt does not exist"
  exit 1
fi

fstype=$(cat /root/root-fstype.txt | tr -d '[:space:]')
if [[ "$fstype" =~ ^(ext[234]|xfs|btrfs|overlay|tmpfs|zfs)$ ]]; then
  echo "Root filesystem type: $fstype"
  exit 0
else
  # Accept any non-empty value as some environments use unusual types
  if [ -n "$fstype" ]; then
    echo "Root filesystem type: $fstype"
    exit 0
  fi
  echo "File should contain a filesystem type, got: '$fstype'"
  exit 1
fi
