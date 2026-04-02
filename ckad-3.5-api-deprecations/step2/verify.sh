#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get deployment legacy-app -n api-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: legacy-app deployment not found"
  exit 1
fi
if [ ! -f $USER_HOME/explain-output.txt ]; then
  echo "FAIL: $USER_HOME/explain-output.txt not found"
  exit 1
fi
echo "PASS"
exit 0
