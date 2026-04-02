#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get pod restricted-ok -n psa-restricted &>/dev/null; then
  echo "FAIL: Pod restricted-ok not found"
  exit 1
fi
for f in restricted-ok.txt restricted-fail.txt restricted-requirements.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
