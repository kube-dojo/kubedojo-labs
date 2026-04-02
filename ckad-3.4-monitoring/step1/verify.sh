#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/node-metrics.txt ]; then
  echo "FAIL: $USER_HOME/node-metrics.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/pod-metrics.txt ]; then
  echo "FAIL: $USER_HOME/pod-metrics.txt not found"
  exit 1
fi
if ! grep -qi "cpu\|NAME" $USER_HOME/node-metrics.txt 2>/dev/null; then
  # Metrics might not have header
  if [ ! -s $USER_HOME/node-metrics.txt ]; then
    echo "FAIL: node-metrics.txt is empty"
    exit 1
  fi
fi
echo "PASS"
exit 0
