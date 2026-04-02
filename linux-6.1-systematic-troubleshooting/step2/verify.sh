#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/failed-service.txt ]; then
  echo "FAIL: $USER_HOME/failed-service.txt not found"
  exit 1
fi

if [ -s $USER_HOME/failed-service.txt ]; then
  echo "PASS: failed-service.txt has content: $(cat $USER_HOME/failed-service.txt)"
  exit 0
else
  echo "FAIL: failed-service.txt is empty"
  exit 1
fi
