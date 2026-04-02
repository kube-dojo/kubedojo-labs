#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/kube-bench-results.txt ] || [ ! -s $USER_HOME/kube-bench-results.txt ]; then
  echo "FAIL: $USER_HOME/kube-bench-results.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/kube-bench-fails.txt ] || [ ! -s $USER_HOME/kube-bench-fails.txt ]; then
  echo "FAIL: $USER_HOME/kube-bench-fails.txt missing or empty"
  exit 1
fi
if [ ! -f $USER_HOME/kube-bench-passes.txt ] || [ ! -s $USER_HOME/kube-bench-passes.txt ]; then
  echo "FAIL: $USER_HOME/kube-bench-passes.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
