#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/gateway.txt exists and contains an IP address
if [ ! -f $USER_HOME/gateway.txt ]; then
  echo "FAIL: $USER_HOME/gateway.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' $USER_HOME/gateway.txt; then
  echo "PASS: File contains a gateway IP"
  exit 0
else
  echo "FAIL: $USER_HOME/gateway.txt does not contain an IP address"
  exit 1
fi
