#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ip route show | grep -q "192.168.100.0"; then
  echo "PASS: Route for 192.168.100.0/24 exists"
  exit 0
else
  echo "FAIL: Route for 192.168.100.0/24 not found"
  exit 1
fi
