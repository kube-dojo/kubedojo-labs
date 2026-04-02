#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify audit rules
# Docker-compatible: checks file content, not live auditd state

if [ ! -f $USER_HOME/audit-rules.txt ]; then
  echo "FAIL: $USER_HOME/audit-rules.txt does not exist"
  exit 1
fi

# Check that the file has content (audit rules listed)
if [ ! -s $USER_HOME/audit-rules.txt ]; then
  echo "FAIL: $USER_HOME/audit-rules.txt is empty"
  exit 1
fi

# Check for the passwd watch rule in the file
if grep -q "/etc/passwd" $USER_HOME/audit-rules.txt; then
  echo "PASS: Audit rule for /etc/passwd found in rules file"
  exit 0
fi

echo "FAIL: $USER_HOME/audit-rules.txt does not contain a rule for /etc/passwd"
exit 1
