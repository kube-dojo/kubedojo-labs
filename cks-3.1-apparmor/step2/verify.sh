#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod apparmor-pod -n apparmor-lab &>/dev/null; then
  echo "FAIL: Pod apparmor-pod not found"
  exit 1
fi

# Check annotation exists (pod may not be Running if AppArmor profile not available)
ANNOT=$(kubectl get pod apparmor-pod -n apparmor-lab -o jsonpath='{.metadata.annotations}' 2>/dev/null)
if ! echo "$ANNOT" | grep -q "apparmor"; then
  echo "FAIL: Pod should have apparmor annotation"
  exit 1
fi

for f in write-test.txt pod-apparmor.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
