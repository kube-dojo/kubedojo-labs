#!/bin/bash
set -o pipefail
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/kube-system-pods.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
EXPECTED=$(kubectl get pods -n kube-system -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{end}' | sort) || exit 2
SAVED=$(awk 'NR > 1 {print $1}' "$FILE" | sort)
if head -n 1 "$FILE" | grep -Eq '^NAME[[:space:]]+READY[[:space:]]+STATUS[[:space:]]+RESTARTS[[:space:]]+AGE[[:space:]]*$' &&
  [ "$SAVED" = "$EXPECTED" ] && [ -n "$SAVED" ] &&
  awk 'NR > 1 && NF < 5 {bad=1} END {exit bad}' "$FILE"; then
  echo "PASS: kube-system pods listed and saved!"
  exit 0
else
  echo "FAIL: $FILE must contain the complete default table for all kube-system pods."
  exit 1
fi
