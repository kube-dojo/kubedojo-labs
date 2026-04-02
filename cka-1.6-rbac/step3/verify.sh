#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/can-i-result.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr -d '[:space:]' | tr '[:upper:]' '[:lower:]')
# For a fresh namespace, default SA should NOT have access
if [ "$CONTENT" = "no" ]; then
  echo "PASS: Correct access check recorded: no"
  exit 0
elif [ "$CONTENT" = "yes" ]; then
  echo "FAIL: Recorded 'yes', but default ServiceAccount should not have access"
  exit 1
else
  echo "FAIL: File should contain 'yes' or 'no', got: '$CONTENT'"
  exit 1
fi