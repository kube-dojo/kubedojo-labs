#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod multi-secure -n secctx-lab &>/dev/null; then
  echo "FAIL: Pod multi-secure not found"
  exit 1
fi
CONTAINERS=$(kubectl get pod multi-secure -n secctx-lab -o jsonpath='{.spec.containers[*].name}')
if ! echo "$CONTAINERS" | grep -q "app" || ! echo "$CONTAINERS" | grep -q "sidecar"; then
  echo "FAIL: Pod should have containers named app and sidecar"
  exit 1
fi
for f in multi-ids.txt shared-volume-test.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
