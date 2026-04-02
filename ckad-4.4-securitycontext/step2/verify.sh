#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for i in $(seq 1 30); do
  S=$(kubectl get pod cap-pod -n security-lab -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$S" = "Running" ] && break
  sleep 2
done
DROP=$(kubectl get pod cap-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.capabilities.drop[0]}' 2>/dev/null)
if [ "$DROP" != "ALL" ]; then
  echo "FAIL: Should drop ALL capabilities"
  exit 1
fi
ADD=$(kubectl get pod cap-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.capabilities.add[0]}' 2>/dev/null)
if [ "$ADD" != "NET_BIND_SERVICE" ]; then
  echo "FAIL: Should add NET_BIND_SERVICE"
  exit 1
fi
RO=$(kubectl get pod cap-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}' 2>/dev/null)
if [ "$RO" != "true" ]; then
  echo "FAIL: readOnlyRootFilesystem should be true"
  exit 1
fi
if [ ! -f $USER_HOME/readonly-fs.txt ]; then
  echo "FAIL: $USER_HOME/readonly-fs.txt not found"
  exit 1
fi
echo "PASS"
exit 0
