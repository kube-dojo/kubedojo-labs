#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that a DROP rule exists for port 8080
if iptables -L INPUT -n | grep -q "DROP.*tcp.*dpt:8080"; then
  echo "PASS: DROP rule for port 8080 exists"
  exit 0
else
  echo "FAIL: No DROP rule found for port 8080 in INPUT chain"
  exit 1
fi
