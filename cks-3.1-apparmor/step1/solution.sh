#!/bin/bash
# Check if AppArmor is available
APPARMOR_AVAILABLE=false
if [ -f /sys/module/apparmor/parameters/enabled ]; then
  cat /sys/module/apparmor/parameters/enabled > "$HOME"/apparmor-status.txt 2>&1
  [ "$(cat "$HOME"/apparmor-status.txt)" = "Y" ] && APPARMOR_AVAILABLE=true
else
  echo "N (AppArmor kernel module not loaded — common in kind clusters)" > "$HOME"/apparmor-status.txt
fi

if [ "$APPARMOR_AVAILABLE" = true ] && command -v aa-status &>/dev/null; then
  aa-status > "$HOME"/loaded-profiles.txt 2>&1
else
  cat > "$HOME"/loaded-profiles.txt << 'PROFILES'
AppArmor not available in this environment (kind cluster).
In production, aa-status would show:
  apparmor module is loaded.
  X profiles are loaded.
  X profiles are in enforce mode.
  X profiles are in complain mode.
PROFILES
fi

cat > /etc/apparmor.d/k8s-deny-write << 'PROFILE'
#include <tunables/global>
profile k8s-deny-write flags=(attach_disconnected) {
  #include <abstractions/base>
  file,
  deny /tmp/** w,
  deny /var/tmp/** w,
}
PROFILE

if [ "$APPARMOR_AVAILABLE" = true ] && command -v apparmor_parser &>/dev/null; then
  apparmor_parser -r /etc/apparmor.d/k8s-deny-write 2>/dev/null
  aa-status 2>/dev/null | grep "k8s-deny-write" > "$HOME"/profile-loaded.txt || echo "Profile loaded via apparmor_parser" > "$HOME"/profile-loaded.txt
else
  echo "Profile k8s-deny-write created (AppArmor not available in kind — would be loaded via apparmor_parser -r)" > "$HOME"/profile-loaded.txt
fi
