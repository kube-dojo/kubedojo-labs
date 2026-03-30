#!/bin/bash
apt-get install -y -qq auditd > /dev/null 2>&1

# Try starting auditd and adding rules
if service auditd start 2>/dev/null && auditctl -w /etc/passwd -p wa -k passwd_monitor 2>/dev/null; then
  auditctl -l > /root/audit-rules.txt
else
  # Docker fallback: auditd can't run (no audit subsystem in container)
  # Write the rule specification to the output file
  {
    echo "# Audit rules (auditd not available in this environment)"
    echo "# These rules would be applied with auditctl on a full system:"
    echo "-w /etc/passwd -p wa -k passwd_monitor"
    echo ""
    echo "# Explanation:"
    echo "#   -w /etc/passwd  = watch this file"
    echo "#   -p wa           = trigger on write (w) or attribute change (a)"
    echo "#   -k passwd_monitor = tag events with this key for searching"
  } > /root/audit-rules.txt
  echo "Note: auditd cannot run in Docker. Wrote rule specification to /root/audit-rules.txt"
fi
