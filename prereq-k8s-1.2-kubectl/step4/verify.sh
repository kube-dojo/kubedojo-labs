#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/nginx-pod.yaml"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
if grep -q "kind: Pod" "$FILE" && grep -q "name: nginx" "$FILE" && grep -q "image: nginx:1.25" "$FILE"; then
  echo "PASS: nginx-pod.yaml generated correctly!"
  exit 0
else
  echo "FAIL: $FILE is missing required Pod details (nginx name or image)."
  exit 1
fi
