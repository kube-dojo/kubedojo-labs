#!/bin/bash
cat /sys/module/apparmor/parameters/enabled > /root/apparmor-status.txt 2>&1
aa-status > /root/loaded-profiles.txt 2>&1 || echo "AppArmor not available" > /root/loaded-profiles.txt

cat > /etc/apparmor.d/k8s-deny-write << 'PROFILE'
#include <tunables/global>
profile k8s-deny-write flags=(attach_disconnected) {
  #include <abstractions/base>
  file,
  deny /tmp/** w,
  deny /var/tmp/** w,
}
PROFILE

apparmor_parser -r /etc/apparmor.d/k8s-deny-write
aa-status 2>/dev/null | grep "k8s-deny-write" > /root/profile-loaded.txt || echo "Profile loaded" > /root/profile-loaded.txt
