#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/iptables-backup.txt exists and contains iptables rules
if [ ! -f $USER_HOME/iptables-backup.txt ]; then
  echo "FAIL: $USER_HOME/iptables-backup.txt does not exist"
  exit 1
fi

# Check for filter table content (either -A rules or *filter marker)
if grep -qE "(-A INPUT|\*filter)" $USER_HOME/iptables-backup.txt; then
  echo "PASS: File contains iptables rules"
  exit 0
else
  echo "FAIL: $USER_HOME/iptables-backup.txt does not contain expected iptables rules"
  exit 1
fi
