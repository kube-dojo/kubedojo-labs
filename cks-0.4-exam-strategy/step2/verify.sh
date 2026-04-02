#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get role pod-reader -n exam-practice &>/dev/null; then
  echo "FAIL: Role pod-reader not found"
  exit 1
fi
if ! kubectl get rolebinding exam-sa-binding -n exam-practice &>/dev/null; then
  echo "FAIL: RoleBinding exam-sa-binding not found"
  exit 1
fi
if ! kubectl get networkpolicy deny-all -n exam-practice &>/dev/null; then
  echo "FAIL: NetworkPolicy deny-all not found"
  exit 1
fi
if [ ! -f $USER_HOME/rbac-check.txt ] || [ ! -s $USER_HOME/rbac-check.txt ]; then
  echo "FAIL: $USER_HOME/rbac-check.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
