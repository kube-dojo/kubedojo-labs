#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/mem-stats.txt ]; then
  echo "FAIL: $USER_HOME/mem-stats.txt not found"
  exit 1
fi

COUNT=$(grep -cE '[0-9]+' $USER_HOME/mem-stats.txt)
if [ "$COUNT" -ge 3 ]; then
  echo "PASS: mem-stats.txt has at least 3 values"
  exit 0
else
  echo "FAIL: Expected at least 3 numeric values, found $COUNT"
  exit 1
fi
