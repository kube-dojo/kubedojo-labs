#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/check-disk.sh ]; then
  echo "FAIL: $USER_HOME/check-disk.sh not found"
  exit 1
fi

if [ ! -x $USER_HOME/check-disk.sh ]; then
  echo "FAIL: $USER_HOME/check-disk.sh is not executable"
  exit 1
fi

OUTPUT=$($USER_HOME/check-disk.sh 2>&1)
if echo "$OUTPUT" | grep -qE "(OK|WARNING)"; then
  echo "PASS: Script outputs OK or WARNING: $OUTPUT"
  exit 0
else
  echo "FAIL: Script should output OK or WARNING, got: $OUTPUT"
  exit 1
fi
