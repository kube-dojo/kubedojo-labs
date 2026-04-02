#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/k8s-version.txt ] || [ ! -s $USER_HOME/k8s-version.txt ]; then
  echo "FAIL: $USER_HOME/k8s-version.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/namespaces.txt ] || [ ! -s $USER_HOME/namespaces.txt ]; then
  echo "FAIL: $USER_HOME/namespaces.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/admission-plugins.txt ] || [ ! -s $USER_HOME/admission-plugins.txt ]; then
  echo "FAIL: $USER_HOME/admission-plugins.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
