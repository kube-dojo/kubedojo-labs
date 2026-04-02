#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for ns in psa-privileged psa-baseline psa-restricted; do
  if ! kubectl get namespace $ns &>/dev/null; then
    echo "FAIL: Namespace $ns not found"
    exit 1
  fi
done
LABEL=$(kubectl get namespace psa-restricted -o jsonpath='{.metadata.labels.pod-security\.kubernetes\.io/enforce}')
if [ "$LABEL" != "restricted" ]; then
  echo "FAIL: psa-restricted should have enforce=restricted label"
  exit 1
fi
for f in psa-labels.txt psa-deployment-test.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
