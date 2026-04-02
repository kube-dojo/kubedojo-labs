#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/pipeline.sh ]; then
  echo "FAIL: $USER_HOME/pipeline.sh not found"
  exit 1
fi

if [ ! -x $USER_HOME/pipeline.sh ]; then
  echo "FAIL: $USER_HOME/pipeline.sh is not executable"
  exit 1
fi

OUTPUT=$($USER_HOME/pipeline.sh 2>&1)
STAGES=0
for stage in "BUILD" "TEST" "DEPLOY"; do
  if echo "$OUTPUT" | grep -qi "$stage"; then
    STAGES=$((STAGES + 1))
  fi
done

if [ "$STAGES" -eq 3 ]; then
  echo "PASS: Pipeline runs all 3 stages successfully"
  exit 0
else
  echo "FAIL: Expected 3 pipeline stages, found $STAGES"
  exit 1
fi
