#!/bin/bash
set -o pipefail
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/pod-spec.yaml"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
if kubectl create --dry-run=client --validate=false -f "$FILE" -o json 2>/dev/null |
  python3 -c 'import json, sys
try:
    pod = json.load(sys.stdin)
    valid = pod.get("kind") == "Pod" and any(c.get("image") == "nginx:1.25" for c in pod.get("spec", {}).get("containers", []))
except (ValueError, AttributeError, TypeError):
    valid = False
sys.exit(not valid)'; then
  echo "PASS: Pod spec generated!"
  exit 0
else
  echo "FAIL: $FILE does not appear to be a valid Pod spec. Use 'kubectl explain pod --recursive'."
  exit 1
fi
