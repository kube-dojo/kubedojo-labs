#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/sidecar-logs.txt ]; then
  echo "FAIL: $USER_HOME/sidecar-logs.txt not found"
  exit 1
fi
if ! grep -qi "sidecar\|health" $USER_HOME/sidecar-logs.txt 2>/dev/null; then
  # May just have date output
  if [ ! -s $USER_HOME/sidecar-logs.txt ]; then
    echo "FAIL: sidecar-logs.txt is empty"
    exit 1
  fi
fi
if [ ! -f $USER_HOME/container-names.txt ]; then
  echo "FAIL: $USER_HOME/container-names.txt not found"
  exit 1
fi
NAMES=$(cat $USER_HOME/container-names.txt)
if [[ "$NAMES" != *"app"* ]] || [[ "$NAMES" != *"sidecar"* ]]; then
  echo "FAIL: container-names.txt should contain app and sidecar"
  exit 1
fi
echo "PASS"
exit 0
