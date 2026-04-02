#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod pending-pod -n debug-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
if [ "$S" != "Running" ]; then
  echo "FAIL: pending-pod should be Running after fix"
  exit 1
fi
CPU=$(kubectl get pod pending-pod -n debug-lab -o jsonpath='{.spec.containers[0].resources.requests.cpu}' 2>/dev/null)
if [ "$CPU" = "100" ]; then
  echo "FAIL: CPU request should be reduced from 100"
  exit 1
fi
echo "PASS"
exit 0
