#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod sa-pod -n sa-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
SA=$(kubectl get pod sa-pod -n sa-lab -o jsonpath='{.spec.serviceAccountName}' 2>/dev/null)
if [ "$SA" != "app-sa" ]; then
  echo "FAIL: Pod should use app-sa ServiceAccount, got: $SA"
  exit 1
fi
if [ ! -f $USER_HOME/pod-sa.txt ]; then
  echo "FAIL: $USER_HOME/pod-sa.txt not found"
  exit 1
fi
echo "PASS"
exit 0
