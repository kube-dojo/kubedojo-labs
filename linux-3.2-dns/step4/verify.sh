#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that $USER_HOME/k8s-io-ip.txt exists and contains an IP
if [ ! -f $USER_HOME/k8s-io-ip.txt ]; then
  echo "FAIL: $USER_HOME/k8s-io-ip.txt does not exist"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' $USER_HOME/k8s-io-ip.txt; then
  echo "PASS: File contains an IP address for kubernetes.io"
  exit 0
else
  echo "FAIL: $USER_HOME/k8s-io-ip.txt does not contain an IP address"
  exit 1
fi
