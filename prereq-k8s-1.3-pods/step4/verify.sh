#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
PODS=$(kubectl get pods -n default -o name) || exit 2
if grep -qxF 'pod/secure-pod' <<< "$PODS"; then
  echo "FAIL: Pod 'secure-pod' still exists."
  exit 1
else
  echo "PASS: Pod 'secure-pod' deleted!"
  exit 0
fi
