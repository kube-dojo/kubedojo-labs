#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in test-pod.yaml kubesec-results.json secure-pod.yaml kubesec-secure.json; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! grep -q "runAsNonRoot" $USER_HOME/secure-pod.yaml; then
  echo "FAIL: secure-pod.yaml missing runAsNonRoot"
  exit 1
fi
if ! grep -q "readOnlyRootFilesystem" $USER_HOME/secure-pod.yaml; then
  echo "FAIL: secure-pod.yaml missing readOnlyRootFilesystem"
  exit 1
fi
echo "PASS"
exit 0
