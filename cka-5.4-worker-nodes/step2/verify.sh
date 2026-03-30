#!/bin/bash
# Verify: kubelet is active and config file saved
KUBELET_ACTIVE=$(systemctl is-active kubelet)
[ "$KUBELET_ACTIVE" = "active" ] && [ -f /root/kubelet-config.txt ] && [ -s /root/kubelet-config.txt ] && exit 0 || exit 1
