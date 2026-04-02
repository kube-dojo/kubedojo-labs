#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that a DNAT rule exists in the nat table
if iptables -t nat -L -n | grep -q "DNAT.*tcp.*dpt:8080.*to:127.0.0.1:80"; then
  echo "PASS: DNAT rule forwarding 8080 -> 127.0.0.1:80 exists"
  exit 0
fi

# Also check with slightly different output format
if iptables -t nat -L -n | grep -qi "DNAT.*8080"; then
  echo "PASS: DNAT rule for port 8080 exists"
  exit 0
fi

echo "FAIL: No DNAT rule found for port 8080 in the nat table"
exit 1
