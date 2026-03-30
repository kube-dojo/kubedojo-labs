#!/bin/bash
# Verify: cni-plugin.txt exists and contains a valid plugin name
if [ -f /root/cni-plugin.txt ]; then
  PLUGIN=$(cat /root/cni-plugin.txt | tr -d '[:space:]')
  echo "$PLUGIN" | grep -qiE "calico|flannel|weave|cilium|kindnet|bridge" && exit 0
fi
exit 1
