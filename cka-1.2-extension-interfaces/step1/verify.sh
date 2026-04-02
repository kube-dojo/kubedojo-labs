#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/container-runtime.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr '[:upper:]' '[:lower:]')
if echo "$CONTENT" | grep -qE "containerd|cri-o|crio"; then
  echo "PASS: File identifies a container runtime"
  exit 0
else
  echo "FAIL: File should contain 'containerd' or 'cri-o', got: '$CONTENT'"
  exit 1
fi