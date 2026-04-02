#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/events.txt ]; then
  echo "FAIL: $USER_HOME/events.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/warning-events.txt ]; then
  echo "FAIL: $USER_HOME/warning-events.txt not found"
  exit 1
fi
echo "PASS"
exit 0
