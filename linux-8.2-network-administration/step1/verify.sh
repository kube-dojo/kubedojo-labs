#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check real interface or fallback file
if ip addr show dummy0 2>/dev/null | grep -q "10.10.10.1"; then
  echo "PASS: dummy0 has IP 10.10.10.1"
  exit 0
elif [ -f $USER_HOME/dummy0-ip.txt ] && grep -q "10.10.10.1" $USER_HOME/dummy0-ip.txt; then
  echo "PASS: dummy0 IP documented (Docker environment)"
  exit 0
else
  echo "FAIL: dummy0 does not have IP 10.10.10.1/24"
  exit 1
fi
