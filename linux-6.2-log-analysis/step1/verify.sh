#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/top-ips.txt ]; then
  echo "FAIL: $USER_HOME/top-ips.txt not found"
  exit 1
fi

LINES=$(wc -l < $USER_HOME/top-ips.txt)
if [ "$LINES" -eq 5 ]; then
  echo "PASS: top-ips.txt has exactly 5 lines"
  exit 0
else
  echo "FAIL: Expected 5 lines, got $LINES"
  exit 1
fi
