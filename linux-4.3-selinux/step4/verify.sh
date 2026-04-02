#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify SELinux workflow documentation

if [ ! -f $USER_HOME/selinux-workflow.txt ]; then
  echo "FAIL: $USER_HOME/selinux-workflow.txt does not exist"
  exit 1
fi

if [ ! -s $USER_HOME/selinux-workflow.txt ]; then
  echo "FAIL: $USER_HOME/selinux-workflow.txt is empty"
  exit 1
fi

# Check for mention of audit2allow (key troubleshooting tool)
if grep -qi "audit2allow" $USER_HOME/selinux-workflow.txt; then
  echo "PASS: SELinux troubleshooting workflow documented with audit2allow"
  exit 0
else
  echo "FAIL: $USER_HOME/selinux-workflow.txt should mention audit2allow"
  exit 1
fi
