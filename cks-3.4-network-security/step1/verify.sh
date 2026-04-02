#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in listening-ports.txt running-services.txt port-analysis.txt k8s-ports.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! grep -q "6443" $USER_HOME/k8s-ports.txt; then
  echo "FAIL: k8s-ports.txt should include 6443"
  exit 1
fi
echo "PASS"
exit 0
