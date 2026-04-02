#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod no-token-pod -n sa-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
AM=$(kubectl get pod no-token-pod -n sa-lab -o jsonpath='{.spec.automountServiceAccountToken}' 2>/dev/null)
if [ "$AM" != "false" ]; then
  echo "FAIL: automountServiceAccountToken should be false"
  exit 1
fi
if [ ! -f $USER_HOME/automount-value.txt ]; then
  echo "FAIL: $USER_HOME/automount-value.txt not found"
  exit 1
fi
echo "PASS"
exit 0
