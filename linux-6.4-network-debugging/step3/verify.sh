#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/port-scan.txt ]; then
  echo "FAIL: $USER_HOME/port-scan.txt not found"
  exit 1
fi

if grep -q "80" $USER_HOME/port-scan.txt; then
  echo "PASS: port-scan.txt shows port 80"
  exit 0
else
  echo "FAIL: port-scan.txt should contain port 80 (nginx)"
  exit 1
fi
