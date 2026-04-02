#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if kubectl get pod secure-pod >/dev/null 2>&1; then
  echo "FAIL: Pod 'secure-pod' still exists."
  exit 1
else
  echo "PASS: Pod 'secure-pod' deleted!"
  exit 0
fi
