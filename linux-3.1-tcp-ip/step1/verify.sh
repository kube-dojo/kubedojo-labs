#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/all-ips.txt exists and contains at least one IP address
if [ ! -f $USER_HOME/all-ips.txt ]; then
  echo "FAIL: $USER_HOME/all-ips.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' $USER_HOME/all-ips.txt; then
  echo "PASS: File contains IP address(es)"
  exit 0
else
  echo "FAIL: $USER_HOME/all-ips.txt does not contain any IP addresses"
  exit 1
fi
