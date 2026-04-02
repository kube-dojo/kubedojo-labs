#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/api-check.sh ]; then
  echo "FAIL: $USER_HOME/api-check.sh not found"
  exit 1
fi

if [ ! -x $USER_HOME/api-check.sh ]; then
  echo "FAIL: $USER_HOME/api-check.sh is not executable"
  exit 1
fi

OUTPUT=$($USER_HOME/api-check.sh 2>&1)
if echo "$OUTPUT" | grep -qi "status\|version\|healthy"; then
  echo "PASS: Script produces parsed API output"
  exit 0
else
  echo "FAIL: Script should produce parsed API output, got: $OUTPUT"
  exit 1
fi
