#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/security-flags.txt ]; then
  echo "FAIL: $USER_HOME/security-flags.txt not found"
  exit 1
fi
COUNT=$(wc -l < $USER_HOME/security-flags.txt | tr -d ' ')
if [ "$COUNT" -lt 3 ]; then
  echo "FAIL: Expected at least 3 security flags, got $COUNT"
  exit 1
fi
if [ ! -f $USER_HOME/auth-modes.txt ] || [ ! -s $USER_HOME/auth-modes.txt ]; then
  echo "FAIL: $USER_HOME/auth-modes.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/kubelet-auth.txt ] || [ ! -s $USER_HOME/kubelet-auth.txt ]; then
  echo "FAIL: $USER_HOME/kubelet-auth.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
