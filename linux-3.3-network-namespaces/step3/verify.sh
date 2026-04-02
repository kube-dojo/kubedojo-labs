#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify that lab-ns can ping the host's veth0 IP
if ip netns exec lab-ns ping -c1 -W3 10.200.1.1 > /dev/null 2>&1; then
  echo "PASS: lab-ns can ping 10.200.1.1 (host veth0)"
  exit 0
else
  echo "FAIL: lab-ns cannot ping 10.200.1.1 — check IP assignments and interface states"
  exit 1
fi
