#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
kubectl get crd backupjobs.stable.example.com > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "FAIL: CRD backupjobs.stable.example.com not found"
  exit 1
fi
if [ ! -f $USER_HOME/crd-name.txt ]; then
  echo "FAIL: $USER_HOME/crd-name.txt not found"
  exit 1
fi
echo "PASS"
exit 0
