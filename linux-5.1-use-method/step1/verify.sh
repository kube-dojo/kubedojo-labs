#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify load-avg.txt contains numbers
if [ ! -f $USER_HOME/load-avg.txt ]; then
  echo "FAIL: $USER_HOME/load-avg.txt not found"
  exit 1
fi

if grep -qE '[0-9]+\.[0-9]+' $USER_HOME/load-avg.txt; then
  echo "PASS: load-avg.txt contains load average numbers"
  exit 0
else
  echo "FAIL: $USER_HOME/load-avg.txt does not contain valid numbers"
  exit 1
fi
