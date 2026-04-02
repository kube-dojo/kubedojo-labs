#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/pod-spec-fields.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -q "KIND:       Pod" "$FILE" && grep -q "VERSION:    v1" "$FILE" && grep -q "containers" "$FILE"; then
  echo "PASS: File contains valid 'kubectl explain' output for pod.spec"
  exit 0
else
  echo "FAIL: File does not appear to be valid 'kubectl explain pod.spec' output"
  exit 1
fi