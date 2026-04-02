#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/trivy-version.txt ] || [ ! -s $USER_HOME/trivy-version.txt ]; then
  echo "FAIL: $USER_HOME/trivy-version.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/kubesec-version.txt ] || [ ! -s $USER_HOME/kubesec-version.txt ]; then
  echo "FAIL: $USER_HOME/kubesec-version.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
