#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod sysctl-pod -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod sysctl-pod not found"
  exit 1
fi
for f in safe-sysctls.txt unsafe-sysctls.txt node-sysctls.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
