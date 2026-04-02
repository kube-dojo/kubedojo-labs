#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in target-version.txt upgrade-commands.txt etcd-version.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! grep -qi "kubeadm upgrade apply" $USER_HOME/upgrade-commands.txt; then
  echo "FAIL: upgrade-commands.txt should contain kubeadm upgrade apply"
  exit 1
fi
echo "PASS"
exit 0
