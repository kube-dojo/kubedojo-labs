#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
CONFIG="/var/lib/kubelet/config.yaml"
FOUND_READONLY=false

# Check locally or in kind node
if [ -f "$CONFIG" ]; then
  grep -q "readOnlyPort: 0" "$CONFIG" && FOUND_READONLY=true
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -q "readOnlyPort: 0" /var/lib/kubelet/config.yaml 2>/dev/null && FOUND_READONLY=true
  fi
fi

# Also accept backup file as evidence
if [ "$FOUND_READONLY" = false ] && [ -f $USER_HOME/kubelet-config-backup.yaml ]; then
  grep -q "readOnlyPort" $USER_HOME/kubelet-config-backup.yaml && FOUND_READONLY=true
fi

if [ "$FOUND_READONLY" = false ]; then
  echo "FAIL: readOnlyPort should be 0"
  exit 1
fi
if [ ! -f $USER_HOME/kubelet-status.txt ] || [ ! -s $USER_HOME/kubelet-status.txt ]; then
  echo "FAIL: $USER_HOME/kubelet-status.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
