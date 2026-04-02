#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/image-policy.yaml ] || [ ! -s $USER_HOME/image-policy.yaml ]; then
  echo "FAIL: $USER_HOME/image-policy.yaml missing or empty"
  exit 1
fi
if [ ! -x $USER_HOME/check-images.sh ]; then
  echo "FAIL: $USER_HOME/check-images.sh not found or not executable"
  exit 1
fi
if [ ! -f $USER_HOME/image-compliance.txt ] || [ ! -s $USER_HOME/image-compliance.txt ]; then
  echo "FAIL: $USER_HOME/image-compliance.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/approved-registries.txt ] || [ ! -s $USER_HOME/approved-registries.txt ]; then
  echo "FAIL: $USER_HOME/approved-registries.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
