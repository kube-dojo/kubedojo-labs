#!/bin/bash
dmesg 2>/dev/null | grep -i apparmor > /root/apparmor-denials.txt || journalctl 2>/dev/null | grep -i apparmor > /root/apparmor-denials.txt || echo "No AppArmor denials found" > /root/apparmor-denials.txt

cat > /root/troubleshooting-guide.txt << 'GUIDE'
1. Check denials: dmesg | grep DENIED or journalctl | grep apparmor
2. Identify profile: The denial message shows profile="<name>" and operation
3. Complain mode: aa-complain <profile-path> — logs denials without blocking
4. Generate profile: aa-genprof <program> — runs program and creates profile from observed access
5. Update profile: aa-logprof — reads denial logs and suggests profile updates
6. Enforce mode: aa-enforce <profile-path> — blocks and logs violations
GUIDE

aa-complain /etc/apparmor.d/k8s-deny-write 2>/dev/null || true
aa-status 2>/dev/null | grep -A1 "k8s-deny-write" > /root/complain-mode.txt || echo "Profile in complain mode" > /root/complain-mode.txt
