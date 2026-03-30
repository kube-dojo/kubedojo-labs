#!/bin/bash
if [ ! -f /root/apparmor-status.txt ] || [ ! -s /root/apparmor-status.txt ]; then
  echo "FAIL: /root/apparmor-status.txt missing or empty"
  exit 1
fi
if [ ! -f /root/loaded-profiles.txt ] || [ ! -s /root/loaded-profiles.txt ]; then
  echo "FAIL: /root/loaded-profiles.txt missing or empty"
  exit 1
fi
if [ ! -f /etc/apparmor.d/k8s-deny-write ]; then
  echo "FAIL: AppArmor profile /etc/apparmor.d/k8s-deny-write not found"
  exit 1
fi
if ! aa-status 2>/dev/null | grep -q "k8s-deny-write"; then
  echo "FAIL: k8s-deny-write profile not loaded"
  exit 1
fi
if [ ! -f /root/profile-loaded.txt ] || [ ! -s /root/profile-loaded.txt ]; then
  echo "FAIL: /root/profile-loaded.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
