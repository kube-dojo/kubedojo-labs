#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
NR=$(kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.securityContext.runAsNonRoot}' 2>/dev/null)
if [ "$NR" != "true" ]; then
  echo "FAIL: runAsNonRoot should be true"
  exit 1
fi
PE=$(kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.allowPrivilegeEscalation}' 2>/dev/null)
if [ "$PE" != "false" ]; then
  echo "FAIL: allowPrivilegeEscalation should be false"
  exit 1
fi
if [ ! -f $USER_HOME/nonroot-value.txt ]; then
  echo "FAIL: $USER_HOME/nonroot-value.txt not found"
  exit 1
fi
if [ ! -f $USER_HOME/priv-escalation.txt ]; then
  echo "FAIL: $USER_HOME/priv-escalation.txt not found"
  exit 1
fi
echo "PASS"
exit 0
