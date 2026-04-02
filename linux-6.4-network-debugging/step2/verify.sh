#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/dns-debug.txt ]; then
  echo "FAIL: $USER_HOME/dns-debug.txt not found"
  exit 1
fi

if [ -s $USER_HOME/dns-debug.txt ]; then
  echo "PASS: dns-debug.txt has content"
  exit 0
else
  echo "FAIL: dns-debug.txt is empty"
  exit 1
fi
