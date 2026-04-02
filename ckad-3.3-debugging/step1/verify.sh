#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod crasher -n debug-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: crasher should be Running after fix"
  exit 1
fi
if [ ! -f $USER_HOME/crash-reason.txt ]; then
  echo "FAIL: $USER_HOME/crash-reason.txt not found"
  exit 1
fi
echo "PASS"
exit 0
