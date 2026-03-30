#!/bin/bash
CONFIG="/var/lib/kubelet/config.yaml"
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

systemctl restart kubelet
sleep 5
systemctl status kubelet > /root/kubelet-status.txt 2>&1
