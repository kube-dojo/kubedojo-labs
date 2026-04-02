#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod isolated-pod -n host-lab &>/dev/null; then
  echo "FAIL: Pod isolated-pod not found"
  exit 1
fi
if ! kubectl get pod hostnet-pod -n host-lab &>/dev/null; then
  echo "FAIL: Pod hostnet-pod not found"
  exit 1
fi
HOSTNET=$(kubectl get pod hostnet-pod -n host-lab -o jsonpath='{.spec.hostNetwork}')
if [ "$HOSTNET" != "true" ]; then
  echo "FAIL: hostnet-pod should have hostNetwork=true"
  exit 1
fi
for f in host-namespace-risks.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
