#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/insecure-pod.txt ]; then
  echo "FAIL: $USER_HOME/insecure-pod.txt not found"
  exit 1
fi
if ! grep -q "insecure-pod" $USER_HOME/insecure-pod.txt; then
  echo "FAIL: insecure-pod not correctly identified"
  exit 1
fi
if [ ! -f $USER_HOME/secure-pod.txt ]; then
  echo "FAIL: $USER_HOME/secure-pod.txt not found"
  exit 1
fi
if ! grep -q "safe-pod" $USER_HOME/secure-pod.txt; then
  echo "FAIL: safe-pod not correctly identified"
  exit 1
fi
if [ ! -f $USER_HOME/security-fixes.txt ]; then
  echo "FAIL: $USER_HOME/security-fixes.txt not found"
  exit 1
fi
LINES=$(wc -l < $USER_HOME/security-fixes.txt | tr -d ' ')
if [ "$LINES" -lt 3 ]; then
  echo "FAIL: Expected at least 3 security fixes"
  exit 1
fi
echo "PASS"
exit 0
