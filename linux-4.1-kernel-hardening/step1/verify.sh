#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify sysctl hardening parameters
# Docker-compatible: checks config FILE content, not live kernel values

FAIL=0

# Check config file exists
if [ ! -f /etc/sysctl.d/99-hardening.conf ]; then
  echo "FAIL: /etc/sysctl.d/99-hardening.conf does not exist"
  exit 1
fi

# Check conf file contains the required settings with correct values
if grep -q "net.ipv4.ip_forward.*=.*0" /etc/sysctl.d/99-hardening.conf; then
  : # ok
else
  echo "FAIL: Config file missing 'net.ipv4.ip_forward = 0'"
  FAIL=1
fi

if grep -q "net.ipv4.tcp_syncookies.*=.*1" /etc/sysctl.d/99-hardening.conf; then
  : # ok
else
  echo "FAIL: Config file missing 'net.ipv4.tcp_syncookies = 1'"
  FAIL=1
fi

if [ "$FAIL" -eq 1 ]; then
  exit 1
fi

echo "PASS: Kernel hardening config file has correct parameters"
exit 0
