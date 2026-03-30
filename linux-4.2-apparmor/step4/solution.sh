#!/bin/bash
# Switch to complain mode
aa-complain /etc/apparmor.d/usr.bin.curl 2>/dev/null || true

# Run curl to generate potential log entries
curl --version > /dev/null 2>&1

# Collect logs
{
  echo "=== AppArmor Status ==="
  aa-status 2>/dev/null || echo "AppArmor not available in this environment"

  echo ""
  echo "=== Kernel Log (AppArmor entries) ==="
  dmesg 2>/dev/null | grep -i apparmor || echo "No AppArmor entries in dmesg (expected in Docker)"

  echo ""
  echo "=== Syslog (AppArmor entries) ==="
  grep -i apparmor /var/log/syslog 2>/dev/null | tail -20 || echo "No AppArmor entries in syslog"

  echo ""
  echo "=== Profile File ==="
  if [ -f /etc/apparmor.d/usr.bin.curl ]; then
    echo "Profile exists at /etc/apparmor.d/usr.bin.curl"
    cat /etc/apparmor.d/usr.bin.curl
  else
    echo "No profile file found"
  fi

  echo ""
  echo "=== Log Analysis Notes ==="
  echo "On a full system, AppArmor denials appear as:"
  echo '  apparmor="DENIED" operation="open" profile="/usr/bin/curl"'
  echo '  name="/some/path" pid=1234 comm="curl" requested_mask="r" denied_mask="r"'
  echo ""
  echo "In Docker, AppArmor kernel module may not be available."
  echo "The profile file above shows what would be enforced on a full system."
} > /root/apparmor-logs.txt
