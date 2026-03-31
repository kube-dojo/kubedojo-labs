#!/bin/bash
if command -v dmesg &>/dev/null; then
  dmesg 2>/dev/null | grep -i apparmor > /root/apparmor-denials.txt || true
fi
if [ ! -s /root/apparmor-denials.txt ] && command -v journalctl &>/dev/null; then
  journalctl 2>/dev/null | grep -i apparmor > /root/apparmor-denials.txt || true
fi
[ -s /root/apparmor-denials.txt ] || echo "No AppArmor denials found (AppArmor may not be available in kind)" > /root/apparmor-denials.txt

cat > /root/troubleshooting-guide.txt << 'GUIDE'
1. Check denials: dmesg | grep DENIED or journalctl | grep apparmor
2. Identify profile: The denial message shows profile="<name>" and operation
3. Complain mode: aa-complain <profile-path> — logs denials without blocking
4. Generate profile: aa-genprof <program> — runs program and creates profile from observed access
5. Update profile: aa-logprof — reads denial logs and suggests profile updates
6. Enforce mode: aa-enforce <profile-path> — blocks and logs violations
GUIDE

if command -v aa-complain &>/dev/null; then
  aa-complain /etc/apparmor.d/k8s-deny-write 2>/dev/null
  aa-status 2>/dev/null | grep -A1 "k8s-deny-write" > /root/complain-mode.txt || echo "Profile in complain mode" > /root/complain-mode.txt
else
  echo "Profile k8s-deny-write would be set to complain mode (aa-complain not available in kind)" > /root/complain-mode.txt
fi
