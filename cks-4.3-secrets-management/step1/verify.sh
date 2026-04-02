#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for s in app-secret tls-secret registry-secret; do
  if ! kubectl get secret $s -n secrets-lab &>/dev/null; then
    echo "FAIL: Secret $s not found in secrets-lab"
    exit 1
  fi
done
if [ ! -f $USER_HOME/etcd-secret-raw.txt ] || [ ! -s $USER_HOME/etcd-secret-raw.txt ]; then
  echo "FAIL: $USER_HOME/etcd-secret-raw.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
