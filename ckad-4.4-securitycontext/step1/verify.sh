#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod user-pod -n security-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
UID_VAL=$(kubectl get pod user-pod -n security-lab -o jsonpath='{.spec.securityContext.runAsUser}' 2>/dev/null)
if [ "$UID_VAL" != "1000" ]; then
  echo "FAIL: runAsUser should be 1000"
  exit 1
fi
GID_VAL=$(kubectl get pod user-pod -n security-lab -o jsonpath='{.spec.securityContext.runAsGroup}' 2>/dev/null)
if [ "$GID_VAL" != "3000" ]; then
  echo "FAIL: runAsGroup should be 3000"
  exit 1
fi
if [ ! -f $USER_HOME/user-id.txt ]; then
  echo "FAIL: $USER_HOME/user-id.txt not found"
  exit 1
fi
echo "PASS"
exit 0
