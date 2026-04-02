#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/kube-system-pods.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE not found."
  exit 1
fi
if grep -q "coredns" "$FILE"; then
  echo "PASS: kube-system pods listed and saved!"
  exit 0
else
  echo "FAIL: $FILE does not contain 'coredns'. Did you redirect the output of 'kubectl get pods -n kube-system'?"
  exit 1
fi
