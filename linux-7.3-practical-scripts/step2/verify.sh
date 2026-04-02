#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/healthcheck.sh ]; then
  echo "FAIL: $USER_HOME/healthcheck.sh not found"
  exit 1
fi

if [ ! -x $USER_HOME/healthcheck.sh ]; then
  echo "FAIL: $USER_HOME/healthcheck.sh is not executable"
  exit 1
fi

OUTPUT=$($USER_HOME/healthcheck.sh 2>&1)
CHECKS=$(echo "$OUTPUT" | grep -cE '\[(OK|WARN|CRITICAL)\]')

if [ "$CHECKS" -ge 4 ]; then
  echo "PASS: Health check produces $CHECKS status checks"
  exit 0
else
  echo "FAIL: Expected at least 4 status checks, got $CHECKS"
  exit 1
fi
