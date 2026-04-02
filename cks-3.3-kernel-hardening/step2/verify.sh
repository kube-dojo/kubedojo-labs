#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod no-caps -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod no-caps not found"
  exit 1
fi
if ! kubectl get pod net-caps -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod net-caps not found"
  exit 1
fi
CAPS=$(kubectl get pod no-caps -n kernel-lab -o jsonpath='{.spec.containers[0].securityContext.capabilities.drop[*]}')
if [[ "$CAPS" != *"ALL"* ]]; then
  echo "FAIL: no-caps should drop ALL capabilities"
  exit 1
fi
for f in default-caps.txt caps-comparison.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
