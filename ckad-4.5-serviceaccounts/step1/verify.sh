#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get serviceaccount app-sa -n sa-lab > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: ServiceAccount app-sa not found"
  exit 1
fi
if [ ! -f $USER_HOME/sa-name.txt ]; then
  echo "FAIL: $USER_HOME/sa-name.txt not found"
  exit 1
fi
echo "PASS"
exit 0
