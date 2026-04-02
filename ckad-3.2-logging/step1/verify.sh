#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/app-logs.txt ]; then
  echo "FAIL: $USER_HOME/app-logs.txt not found"
  exit 1
fi
LINES=$(wc -l < $USER_HOME/app-logs.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: app-logs.txt should have at least 5 lines"
  exit 1
fi
if [ ! -f $USER_HOME/log-line-count.txt ]; then
  echo "FAIL: $USER_HOME/log-line-count.txt not found"
  exit 1
fi
echo "PASS"
exit 0
