#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/disk-usage.txt ]; then
  echo "FAIL: $USER_HOME/disk-usage.txt not found"
  exit 1
fi

LINES=$(wc -l < $USER_HOME/disk-usage.txt)
if [ "$LINES" -ge 10 ]; then
  echo "PASS: disk-usage.txt has $LINES lines"
  exit 0
else
  echo "FAIL: Expected at least 10 lines, got $LINES"
  exit 1
fi
