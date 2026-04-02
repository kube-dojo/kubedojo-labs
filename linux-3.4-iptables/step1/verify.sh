#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/iptables-rules.txt exists and contains chain info
if [ ! -f $USER_HOME/iptables-rules.txt ]; then
  echo "FAIL: $USER_HOME/iptables-rules.txt does not exist"
  exit 1
fi

if grep -qiE "Chain (INPUT|FORWARD|OUTPUT)" $USER_HOME/iptables-rules.txt; then
  echo "PASS: File contains iptables chain information"
  exit 0
else
  echo "FAIL: $USER_HOME/iptables-rules.txt does not contain expected chain information"
  exit 1
fi
