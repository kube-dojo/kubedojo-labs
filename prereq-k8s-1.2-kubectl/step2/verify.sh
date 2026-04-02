#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/pod-spec.yaml"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
if grep -q "kind: Pod" "$FILE" && grep -q "containers:" "$FILE"; then
  echo "PASS: Pod spec generated!"
  exit 0
else
  echo "FAIL: $FILE does not appear to be a valid Pod spec. Use 'kubectl explain pod --recursive'."
  exit 1
fi
