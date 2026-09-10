#!/bin/bash
# Verify: live LSM stack recorded and the AppArmor conclusion matches reality.
LSM=/tmp/kd-caps/lsm.txt
AA=/tmp/kd-caps/aa-status.txt
CONCL=/tmp/kd-caps/apparmor-active.txt
if [ ! -r /sys/kernel/security/lsm ]; then
  echo "FAIL: /sys/kernel/security/lsm is not readable — securityfs is unavailable in this environment, so the LSM stack cannot be diagnosed here"
  exit 1
fi
live=$(cat /sys/kernel/security/lsm)
if [ ! -s "$LSM" ] || [ ! -s "$AA" ] || [ ! -s "$CONCL" ]; then
  echo "FAIL: evidence files missing — record lsm.txt, aa-status.txt and apparmor-active.txt"
  exit 1
fi
recorded=$(head -n1 "$LSM" | tr -d '[:space:]')
if [ "$recorded" != "$(printf '%s' "$live" | tr -d '[:space:]')" ]; then
  echo "FAIL: lsm.txt ('$recorded') does not match the live kernel LSM list ('$live')"
  exit 1
fi
concl=$(head -n1 "$CONCL" | tr -d '[:space:]')
if printf '%s' "$live" | tr ',' '\n' | grep -qx apparmor; then expected=yes; else expected=no; fi
if [ "$concl" != "$expected" ]; then
  echo "FAIL: apparmor-active.txt says '$concl' but the live LSM list says '$expected' — conclude from the kernel's answer"
  exit 1
fi
echo "PASS: LSM stack diagnosed from live kernel state (apparmor: $expected)"
exit 0
