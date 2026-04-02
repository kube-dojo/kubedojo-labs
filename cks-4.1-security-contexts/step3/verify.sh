#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod no-escalation -n secctx-lab &>/dev/null; then
  echo "FAIL: Pod no-escalation not found"
  exit 1
fi
APE=$(kubectl get pod no-escalation -n secctx-lab -o jsonpath='{.spec.containers[0].securityContext.allowPrivilegeEscalation}')
if [ "$APE" != "false" ]; then
  echo "FAIL: allowPrivilegeEscalation should be false"
  exit 1
fi
for f in pod-caps.txt escalation-risks.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
