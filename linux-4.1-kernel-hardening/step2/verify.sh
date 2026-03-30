#!/bin/bash
# Verify modprobe blacklist

if [ ! -f /etc/modprobe.d/blacklist-custom.conf ]; then
  echo "FAIL: /etc/modprobe.d/blacklist-custom.conf does not exist"
  exit 1
fi

if grep -q "blacklist usb-storage" /etc/modprobe.d/blacklist-custom.conf; then
  echo "PASS: usb-storage module is blacklisted"
  exit 0
else
  echo "FAIL: File does not contain 'blacklist usb-storage'"
  exit 1
fi
