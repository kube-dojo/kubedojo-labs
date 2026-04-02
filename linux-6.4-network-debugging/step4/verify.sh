#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/tcpdump-output.txt ]; then
  echo "FAIL: $USER_HOME/tcpdump-output.txt not found"
  exit 1
fi

if [ -s $USER_HOME/tcpdump-output.txt ]; then
  echo "PASS: tcpdump-output.txt has content"
  exit 0
else
  echo "FAIL: tcpdump-output.txt is empty"
  exit 1
fi
