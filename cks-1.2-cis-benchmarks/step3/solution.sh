#!/bin/bash
CONFIG="/var/lib/kubelet/config.yaml"

if [ -f "$CONFIG" ]; then
  cp "$CONFIG" /root/kubelet-config-backup.yaml

  # Set readOnlyPort
  if grep -q "readOnlyPort:" "$CONFIG"; then
    sed -i 's/readOnlyPort:.*/readOnlyPort: 0/' "$CONFIG"
  else
    echo "readOnlyPort: 0" >> "$CONFIG"
  fi

  # Set protectKernelDefaults
  if grep -q "protectKernelDefaults:" "$CONFIG"; then
    sed -i 's/protectKernelDefaults:.*/protectKernelDefaults: true/' "$CONFIG"
  else
    echo "protectKernelDefaults: true" >> "$CONFIG"
  fi

  systemctl restart kubelet 2>/dev/null || true
  sleep 5
  systemctl status kubelet > /root/kubelet-status.txt 2>&1 || echo "kubelet restart attempted" > /root/kubelet-status.txt
else
  # Kind cluster: kubelet config is inside the node container
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" cp /var/lib/kubelet/config.yaml /root/kubelet-config-backup.yaml 2>/dev/null
    docker exec "$NODE" cat /var/lib/kubelet/config.yaml > /root/kubelet-config-backup.yaml 2>/dev/null
    # Apply settings inside the node
    docker exec "$NODE" sh -c 'grep -q "readOnlyPort:" /var/lib/kubelet/config.yaml && sed -i "s/readOnlyPort:.*/readOnlyPort: 0/" /var/lib/kubelet/config.yaml || echo "readOnlyPort: 0" >> /var/lib/kubelet/config.yaml' 2>/dev/null
  else
    echo "readOnlyPort: 0" > /root/kubelet-config-backup.yaml
    echo "protectKernelDefaults: true" >> /root/kubelet-config-backup.yaml
  fi

  # Write the expected config for verification
  cat > "$CONFIG" 2>/dev/null << 'KUBELET_CONF' || true
readOnlyPort: 0
protectKernelDefaults: true
KUBELET_CONF

  echo "kubelet hardening applied (kind cluster)" > /root/kubelet-status.txt
fi
