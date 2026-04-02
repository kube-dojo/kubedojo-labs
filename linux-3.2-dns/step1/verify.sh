#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that myapp.local resolves via /etc/hosts (ping will resolve even if host is unreachable)
if ping -c1 -W2 myapp.local > /dev/null 2>&1; then
  echo "PASS: myapp.local resolves and is reachable"
  exit 0
fi

# Even if ping fails (unreachable), check that it resolved the name
if ping -c1 -W2 myapp.local 2>&1 | grep -q "10.0.0.99"; then
  echo "PASS: myapp.local resolves to 10.0.0.99"
  exit 0
fi

# Check /etc/hosts directly as fallback
if grep -q "10.0.0.99.*myapp.local" /etc/hosts; then
  echo "PASS: /etc/hosts contains the entry for myapp.local"
  exit 0
fi

echo "FAIL: myapp.local does not resolve to 10.0.0.99"
exit 1
