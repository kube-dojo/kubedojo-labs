#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/apiserver-pod.txt ]; then
  echo "FAIL: $USER_HOME/apiserver-pod.txt does not exist"
  exit 1
fi

CONTENT=$(cat $USER_HOME/apiserver-pod.txt | tr -d '[:space:]')
if echo "$CONTENT" | grep -q "kube-apiserver"; then
  echo "PASS: File contains kube-apiserver pod name"
  exit 0
else
  echo "FAIL: File should contain a pod name with 'kube-apiserver', got: $CONTENT"
  exit 1
fi
